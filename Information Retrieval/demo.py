import collections
import csv
import importlib
import itertools
import os
import site
import tkinter
from collections import defaultdict


# Verify if the given package is installed, else install it
def install_package(package):
    import pkg_resources
    import subprocess
    import sys
    try:
        pkg_resources.get_distribution(package)
    except pkg_resources.DistributionNotFound:
        query = [sys.executable, '-m', 'pip', 'install', package]
        if not hasattr(sys, 'real_prefix'):
            query = query + ['--user']
        subprocess.call(query)


# Verify that prerequisite packages are installed. Else install them and reload the list of packages available for
# importing
install_package('beautifulsoup4')
install_package('nltk')
install_package('pandas')
install_package('pyparsing')
install_package('PySimpleGUI')
install_package('regex')
install_package('requests')
install_package('sklearn')
importlib.reload(site)
import nltk
import pandas
import regex

nltk.download('punkt')
nltk.download('stopwords')


def corpus_preprocessing():  # Module 1
    import requests
    from bs4 import BeautifulSoup

    print('Preprocessing corpus...')
    with open("corpus.txt", 'w', encoding='utf8', newline='') as corpus:
        output = csv.DictWriter(corpus, ['document_id', 'topic', 'title', 'description'])
        output.writeheader()

        def csi_collection():
            csi_catalogue_raw = requests.get('https://catalogue.uottawa.ca/en/courses/csi/')
            csi_catalogue_html = BeautifulSoup(csi_catalogue_raw.text, 'html.parser')

            global csi_collection_range, document_id

            document_id = 0
            for course in csi_catalogue_html.find_all('div', class_='courseblock'):
                title = course.find('p', class_=regex.compile('title')).get_text()
                description = course.find('p', class_=regex.compile('desc'))
                if regex.match(r'CSI\s\d[01234689]\d\d\s', title) is not None:  # filter French courses
                    if description is not None:
                        description = description.get_text().replace('\n', '')
                    output.writerow({'document_id': document_id, 'title': title, 'description': description})
                    document_id += 1
            csi_collection_range = range(0, document_id)

        def reuters_collection():
            import string
            global reuters_collection_range, document_id

            printable = set(string.printable)
            for directory, subdirectories, files in os.walk(os.getcwd()):
                for file in files:
                    if file.startswith('reut') and file.endswith('.sgm'):
                        with open(os.path.join(directory, file), 'rb') as file:
                            parser = BeautifulSoup(file, 'html.parser')
                        for document in parser.find_all('reuters'):
                            topic = document.find('topics').get_text()
                            try:
                                title = document.find('title').get_text()
                            except AttributeError:
                                title = ''
                            text = ''.join(filter(lambda character: character in printable,
                                                  document.find('text').get_text().replace('\n', ' ')))
                            output.writerow(
                                {'document_id': document_id, 'topic': topic, 'title': title,
                                 'description': text})
                            document_id += 1
            reuters_collection_range = range(len(csi_collection_range), document_id)

        csi_collection()
        reuters_collection()
    with open("ranges.txt", 'w', encoding='utf8', newline='') as ranges:
        ranges.write(str(csi_collection_range[-1]) + '\n')
        ranges.write(str(reuters_collection_range[-1]) + '\n')


def remove_stopwords(tokens):
    i = 0
    while i < len(tokens):
        if tokens[i] in nltk.corpus.stopwords.words('english'):
            del tokens[i]
        else:
            i = i + 1
    return tokens


def normalize(tokens):
    return list(
        filter(None, list(
            itertools.chain.from_iterable([regex.split(
                r'(?!(?<=\w)\.(?=\w))(?!(?<=\w)\*)[[!"#$%&\'+,\-*.\/:;<=>?@[^_`{|}~\]]',
                token.lower()) if token not in ['AND', 'AND_NOT', 'OR'] else [token] for token in tokens]))))


def stem(tokens):
    return [nltk.stem.porter.PorterStemmer().stem(token) if token not in ['AND', 'AND_NOT', 'OR'] else token for token
            in tokens]


# Inspired by https://pysimplegui.readthedocs.io/cookbook/
def user_interface():  # Module 2
    import PySimpleGUI

    window = PySimpleGUI.Window('elgoog', return_keyboard_events=True, use_default_focus=False)
    window.TKroot = tkinter.Tk()
    width, height = tuple(int(dimension / 8) for dimension in window.GetScreenDimensions())
    window.TKroot.destroy()

    layout = [
        [PySimpleGUI.Radio('Boolean', 'model', key='boolean'),
         PySimpleGUI.Radio('Vector Space', 'model', key='vector space', default=True)],
        [PySimpleGUI.InputText(key='query', do_not_clear=True, size=(width, 1))],
        [PySimpleGUI.Radio('CSI', 'collection', key='csi', default=True),
         PySimpleGUI.Radio('Reuters', 'collection', key='reuters', change_submits=True),
         PySimpleGUI.InputCombo(['all'] + sorted(list(set(categorized_documents['topic'].values.tolist()))),
                                key='topic', auto_size_text=True, change_submits=True, readonly=True, visible=False)],
        [PySimpleGUI.Submit(bind_return_key=True)],
        [PySimpleGUI.Listbox([], key='output', size=(width, 20), enable_events=True,
                             select_mode=PySimpleGUI.LISTBOX_SELECT_MODE_BROWSE)]
    ]

    window.Layout(layout)

    while True:
        event, values = window.Read()
        if event is None or event == 'Exit':
            break
        if event == 'output':
            try:
                document = list(corpus_access([int(regex.search('[0-9]+', values['output'][0]).group())]).values())[0]
                PySimpleGUI.PopupScrolled(document['description'], title=document['title'], size=(int(width / 2), 10))
            except AttributeError:
                window.FindElement('query').Update(values['query'] + values['output'][0])
                window.FindElement('output').Update([])
            except IndexError:
                continue
            continue

        if event != '\r' and 'Mouse' not in event:
            window.FindElement('output').Update([])

        if event == 'csi':
            window.FindElement('topic').Update(visible=False)
            continue

        if event == 'reuters':
            window.FindElement('topic').Update(visible=True)
            continue

        if not values['query']:
            continue

        if event == ' ':
            window.FindElement('output').Update(query_completion_module(values['query']))
            continue

        if event == 'topic':
            event = 'Submit'

        if event == 'Submit':
            collection = None
            if values['csi']:
                collection = csi_collection_range
            elif values['reuters']:
                collection = reuters_collection_range

            query = normalize(remove_stopwords(nltk.word_tokenize(values['query'])))
            documents = []
            if values['boolean']:
                try:
                    documents = boolean_retrieval_model(' '.join(query), collection)
                except SyntaxError as error:
                    window.FindElement('output').Update([error])
                    continue
                documents = sorted(documents)
            elif values['vector space']:
                # query = global_query_expansion(query)
                documents = vector_space_model(query, collection)

            output = {k: v for k, v in corpus_access(documents).items() if
                      values['topic'] == 'all' or values['topic'] == v['topic']}  # Module 10b

            if output:
                display = []
                for index, line in output.items():
                    excerpt = line['description'][:100] + ' ... '
                    if not values['boolean']:
                        excerpt += str(round(documents[index], 4))
                    display.append(str(index) + '. ' + line['title'] + ': ' + excerpt)
                window.FindElement('output').Update(display)
            else:
                suggestions = edit_distance(normalize(remove_stopwords(nltk.word_tokenize(values['query']))))[:5]
                if suggestions[0] != ' '.join(normalize(remove_stopwords(nltk.word_tokenize(values['query'])))):
                    PySimpleGUI.Popup('Did you mean: ' + ', '.join(suggestions) + '?', title='Did you mean?',
                                      button_type=PySimpleGUI.POPUP_BUTTONS_NO_BUTTONS, keep_on_top=True)

    window.Close()


def dictionary_building(stopword_removal=True, stemming=False, normalization=True):  # Module 3
    with open("corpus.txt", 'r', encoding='utf8', newline='') as corpus:

        global dictionary
        tokenized_documents = []

        with open("tokenized.txt", 'w', encoding='utf8', newline='') as tokenized_txt:
            tokenized_output = csv.writer(tokenized_txt)
            for document in csv.DictReader(corpus):
                tokens = nltk.word_tokenize(document['title'] + '. ' + document['description'])

                if normalization:
                    tokens = normalize(tokens)

                if stopword_removal:
                    tokens = remove_stopwords(tokens)

                dictionary |= set(tokens)

                if stemming:
                    tokens = stem(tokens)

                tokenized_documents.append(tokens)
                tokenized_output.writerow(tokens)
        with open("dictionary.txt", 'w', encoding='utf8', newline='') as dictionary_txt:
            csv.writer(dictionary_txt).writerow(dictionary)

    return tokenized_documents


# Modified from https://codereview.stackexchange.com/questions/188918/creating-an-inverted-index-in-python
def inverted_index_construction(corpus):  # Module 4
    inverted_index = defaultdict(dict)
    for index, text in enumerate(corpus):
        for word in text:
            if not inverted_index[word].get(index):
                inverted_index[word].update({index: 1})
            else:
                inverted_index[word][index] += 1
    return inverted_index


def corpus_access(documents):  # Module 5
    with open("corpus.txt", 'r', encoding='utf8', newline='') as corpus:
        corpus = tuple(csv.DictReader(corpus))
    return {int(corpus[document]['document_id']): {'title': corpus[document]['title'],
                                                   'description': corpus[document]['description'],
                                                   'topic': corpus[document]['topic']} for document in documents}


def boolean_retrieval_model(query, collection):  # Module 6
    import pyparsing

    def retrieval(term):
        try:
            return {document for document in inverted_index.get(term) if document in collection}
        except TypeError:
            return set()

    # As seen in https://www.geeksforgeeks.org/check-for-balanced-parentheses-in-python/
    parentheses = []
    for character in query:
        if character == '(':
            parentheses.append(character)
        elif character == ')':
            if (len(parentheses) > 0) and ('(' == parentheses[-1]):
                parentheses.pop()
            else:
                raise SyntaxError("Unbalanced parentheses")
    if parentheses:
        raise SyntaxError("Unbalanced parentheses")

    def evaluate(query):
        if isinstance(query, str):
            if query[-1] == '*':
                expansions = [stem([word])[0] for word in dictionary if word.startswith(query[:-1])]
                if expansions:
                    query = expansions[0]
                    for i in range(1, len(expansions)):
                        query = [query, 'OR', expansions[i]]
                    return evaluate(query)
            return retrieval(query)
        elif len(query) == 1:
            return evaluate(query[0])
        elif len(query) == 3:
            if 'AND' == query[1]:
                documents = evaluate(query[0]).intersection(evaluate(query[2]))
            elif 'OR' == query[1]:
                documents = evaluate(query[0]).union(evaluate(query[2]))
            elif 'AND_NOT' == query[1]:
                documents = evaluate(query[0]).difference(evaluate(query[2]))
            else:
                raise SyntaxError("Malformed boolean")
        else:
            raise SyntaxError("Malformed query")
        return documents

    return evaluate(pyparsing.nestedExpr().parseString("(%s)" % query)[0])


def vector_space_model(query, collection):  # Module 7
    def weight_calculation():  # Module 7a
        import math
        query_vector = []
        documents_vectors = defaultdict(list)
        for term in query:
            documents = retrieval(term)
            if not documents:
                continue
            max_frequency = collections.Counter(query).most_common()[0][1]
            idf = math.log10(len(collection)) / len(documents)
            query_tf = query.count(term) / max_frequency
            try:
                query_tfidf = query_tf * idf * term[1]
            except (TypeError, IndexError):
                query_tfidf = query_tf * idf
            query_vector.append(query_tfidf)
            for document, frequency in documents.items():
                document_tf = frequency / len(tokenized_documents[document])
                document_tfidf = document_tf * idf
                documents_vectors[document].append(document_tfidf)
        query_norm = math.sqrt(sum(i * i for i in query_vector))
        normalized_query_vector = [i / query_norm for i in query_vector]
        output = defaultdict(list)
        for document, document_vector in documents_vectors.items():
            document_norm = math.sqrt(sum(i * i for i in document_vector))
            normalized_document_vector = [i / document_norm for i in document_vector]
            output[document] = (sum([normalized_query_vector[i] * normalized_document_vector[i] for i in
                                     range(len(normalized_document_vector))]))

        return dict(sorted(output.items(), key=lambda entry: entry[1], reverse=True))

    def retrieval(term):  # Module 7b
        try:
            return {document: weight for document, weight in inverted_index.get(term).items() if document in collection}
        except (AttributeError, TypeError):
            return {}

    return weight_calculation()


def bigram_language_model():  # Module 8a
    bigrams = []
    for document in tokenized_documents[reuters_collection_range[1]:reuters_collection_range[-1]]:
        bigrams += list(nltk.bigrams(document))
    return collections.Counter(bigrams).most_common()


def query_completion_module(query):  # Module 8b
    query = query.split()[-1].rstrip().lower()
    return [bigram[1] for bigram, count in bigrams if bigram[0].lower() == query]


# def automatic_thesaurus_construction():  # Module 9a
#     def jaccard_distance(word1, word2):
#         return len(word1.intersection(word2)) / len(word1.union(word2)) if (word1 or word2) else 1
#
#     thesaurus = pandas.DataFrame(columns=dictionary, index=dictionary, dtype=numpy.float16)
#     for i, word1 in enumerate(dictionary):
#         for word2 in list(dictionary)[i:]:
#             distance = jaccard_distance(set(inverted_index[word1].keys()), set(inverted_index[word2].keys()))
#             if distance:
#                 thesaurus.at[word1, word2] = distance
#     thesaurus.to_pickle("thesaurus.txt")
#     return thesaurus
#
#
# def global_query_expansion(query):  # Module 9b
#     expanded = []
#     for term in query:
#         try:
#             terms = thesaurus[term].dropna().append(thesaurus.loc[term].dropna()).drop_duplicates().nlargest(3, 'all')
#             expanded.extend(list(zip(terms.index, terms)))
#         except KeyError:
#             pass
#     return expanded


def knn_text_categorization():  # Module 10a
    from sklearn.neighbors import KNeighborsClassifier
    from sklearn.preprocessing import OneHotEncoder
    knn = KNeighborsClassifier(n_jobs=-1, metric='cosine', weights='distance')
    with open("corpus.txt", 'r', encoding='utf8', newline='') as corpus:
        corpus = pandas.read_csv(corpus)
    corpus = corpus[reuters_collection_range[1]:reuters_collection_range[-1]].drop('document_id', axis=1)
    training_set = corpus.dropna(subset=['topic', 'title'])
    test_set = corpus[~corpus.isin(training_set)].dropna(subset=['title'])
    prediction_target = training_set.pop('topic')
    test_set.pop('topic')
    encoder = OneHotEncoder(handle_unknown='ignore')
    knn.fit(encoder.fit_transform(training_set), prediction_target.values)
    test_set['topic'] = knn.predict(encoder.transform(test_set))
    training_set = training_set.assign(topic=prediction_target)
    return training_set.append(test_set).sort_index()


def edit_distance(query):  # Optional Module 1 (Vanilla System)
    from nltk.metrics.distance import edit_distance
    return [' '.join(tuple) for tuple in itertools.product(*[
        sorted([word for word in dictionary], key=lambda word: edit_distance(term, word))[
        :2] if term not in dictionary else [term] for term in query])]


try:
    with open("ranges.txt", 'r', encoding='utf8', newline='') as ranges:
        csi_collection_range = range(int(next(ranges)))
        reuters_collection_range = range(csi_collection_range[-1] + 1, int(next(ranges)))
except (FileNotFoundError, EOFError):
    corpus_preprocessing()

dictionary = {'AND', 'AND_NOT', 'OR'}
try:
    with open("tokenized.txt", 'r', encoding='utf8', newline='') as tokenized_txt:
        tokenized_documents = list(csv.reader(tokenized_txt))
    if not tokenized_documents:
        raise EOFError
    with open("dictionary.txt", 'r', encoding='utf8', newline='') as dictionary_txt:
        for tokens in csv.reader(dictionary_txt):
            dictionary |= set(tokens)
except (EOFError, FileNotFoundError):
    print('Building dictionary...')
    tokenized_documents = dictionary_building()

inverted_index = inverted_index_construction(tokenized_documents)
bigrams = bigram_language_model()
# try:
#     thesaurus = pandas.read_pickle("thesaurus.txt")
# except (EOFError, FileNotFoundError):
#     print('Building thesaurus...')
#     thesaurus = automatic_thesaurus_construction()
categorized_documents = knn_text_categorization()
user_interface()
