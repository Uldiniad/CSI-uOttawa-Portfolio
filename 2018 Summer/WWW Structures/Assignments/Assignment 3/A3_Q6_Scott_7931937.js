function process(string) {
    let words = string.split(' ');
    for (let i = 0; i < words.length; i++) {
        document.getElementById('output').innerHTML += printLatinWord(words[i]) + " ";
    }
    document.getElementById('output').innerHTML += "\n";
}

function printLatinWord(word) {
    let suffix = word.charAt(0) + "ay";
    return word.substring(1) + suffix;
}