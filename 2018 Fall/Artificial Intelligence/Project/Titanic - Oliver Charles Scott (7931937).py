# Import native packages needed to verify if given packages are installed and install them if they are not
import importlib
import os
import site
import subprocess
import sys

import pkg_resources


# Verify if the given package is installed, else install it
def install_package(package):
    try:
        pkg_resources.get_distribution(package)
    except pkg_resources.DistributionNotFound:
        query = [sys.executable, '-m', 'pip', 'install', package]
        if not hasattr(sys, 'real_prefix'):
            query = query + ['--user']
        subprocess.call(query)


# Verify that prerequisite packages are installed. Else install them and reload the list of packages available for
# importing
install_package('pandas')
install_package('sklearn')
importlib.reload(site)

# Import prerequisite packages and modules
import pandas
from sklearn.impute import SimpleImputer
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import GridSearchCV
from sklearn.neural_network import MLPClassifier
from sklearn.pipeline import make_pipeline

# Read the training data provided by Kaggle. It will be used to fit the MLP and Logistic models. Note: Dropping cabin
# column because of the amount of missing categorical data and ticket column due to the difficulty of preprocessing and
# extracting valuable data from it
training_set = pandas.read_csv('./train.csv').drop(['Cabin', 'Ticket'], 1)
test_set = pandas.read_csv('./test.csv').drop(['Cabin', 'Ticket'], 1)


# Encode name by title (can indicate prestige, marital status, age and gender)
def encode_titles(title):
    if "Mrs." in title:
        return 0
    elif "Mme." in title:
        return 0
    elif "Miss." in title:
        return 1
    elif "Mlle." in title:
        return 1
    elif "Ms." in title:
        return 2
    elif "Lady." in title:
        return 3
    elif "Countess." in title:
        return 3
    elif "Mr." in title:
        return 4
    elif "Master." in title:
        return 5
    elif "Sir." in title:
        return 6
    elif "Don." in title:
        return 6
    elif "Dr." in title:
        return 6
    elif "Col." in title:
        return 6
    elif "Capt." in title:
        return 6
    elif "Major." in title:
        return 6
    elif "Rev." in title:
        return 6
    elif "Jonkheer." in title:
        return 6


def encode_port_of_embarkment(letter):
    if letter == 'C':
        return 0
    elif letter == 'S':
        return 1
    elif letter == 'Q':
        return 2


def encode_sex(gender):
    if gender == "male":
        return 0
    elif gender == "female":
        return 1


# Encodes categorical features (e.g. Name, Embarked and Sex) for the specified dataset by applying their respective
# encoding functions to each row
def encode_features(dataset):
    dataset['Name'] = dataset['Name'].apply(lambda row: encode_titles(row))
    dataset['Embarked'] = dataset['Embarked'].apply(lambda row: encode_port_of_embarkment(row))
    dataset['Sex'] = dataset['Sex'].apply(lambda row: encode_sex(row))


# Encode categorical features for the training and test sets
encode_features(training_set)
encode_features(test_set)

# Extract the column containing the survival data. The goal is to predict survival status
prediction_target = training_set.pop('Survived').values

# Initialize the pipelines for the models
# An Imputer is used first to fill missing values with the mean of the column. Then the models are initialized
logisticregression_pipeline = make_pipeline(SimpleImputer(), LogisticRegression())
mlpclassifier_pipeline = make_pipeline(SimpleImputer(), MLPClassifier())

# Build parameter grids which the GridSearchCV will use to determine the optimal set of parameters for the models
logisticregression_parameter_grid = [
    {'logisticregression__random_state': [1],
     'logisticregression__C': [0.01, 0.1, 1, 10, 100],
     'logisticregression__solver': ['liblinear'],
     'logisticregression__multi_class': ['auto'],
     'logisticregression__max_iter': [10000],
     'logisticregression__warm_start': [True]}]
mlpclassifier_parameter_grid = [
    {'mlpclassifier__random_state': [1],
     'mlpclassifier__hidden_layer_sizes': [(100,), (200,), (300,), (400,)],
     'mlpclassifier__activation': ['identity', 'logistic', 'tanh', 'relu'],
     'mlpclassifier__solver': ['adam'],
     'mlpclassifier__max_iter': [10000],
     'mlpclassifier__warm_start': [True]
     }]

# Build a grid search cross validator which will determine the optimal set of parameters for the given pipeline by
# testing all permutations of the parameter grid and 5-fold cross-validation. Scoring will be measured by
# prediction accuracy percentage
logisticregression_grid_search = GridSearchCV(logisticregression_pipeline, logisticregression_parameter_grid,
                                              scoring='accuracy', cv=5, n_jobs=-1)
mlpclassifier_grid_search = GridSearchCV(mlpclassifier_pipeline, mlpclassifier_parameter_grid, scoring='accuracy',
                                         cv=5, n_jobs=-1)


# Find the best parameters for both models and compute their respective best training scores
# Then, return the best of the two models
def run(dataset):
    logisticregression_grid_search.fit(dataset, prediction_target)
    mlpclassifier_grid_search.fit(dataset, prediction_target)

    print(logisticregression_grid_search.best_params_)
    print(mlpclassifier_grid_search.best_params_)

    logisticregression_grid_search_score = logisticregression_grid_search.score(dataset, prediction_target)
    mlpclassifier_grid_search_score = mlpclassifier_grid_search.score(dataset, prediction_target)

    print("Best logistic regression training score:",
          round(logisticregression_grid_search_score * 100, 3), '%')
    print("Best multilayer perceptron training score:",
          round(mlpclassifier_grid_search_score * 100, 3), '%')
    print()

    return max([(logisticregression_grid_search_score, logisticregression_grid_search),
                (mlpclassifier_grid_search_score, mlpclassifier_grid_search)], key=lambda pair: pair[0])


# Select features that I assume are most relevant for survival
select_features = ['Name', 'Age', 'Parch', 'SibSp', 'Pclass']
# Additionally, consider gender
more_features = select_features + ['Sex']

# Get the best model given a subset of features
max_select_features_run = run(training_set[select_features])
# Get the best model given additional features
max_more_features_run = run(training_set[more_features])

predictions = None
# Use the best model of the best of the runs to make predictions
if max_select_features_run[0] > max_more_features_run[0]:
    predictions = max_select_features_run[1].predict(test_set[more_features])
else:
    predictions = max_more_features_run[1].predict(test_set[more_features])

# Store the predictions using the submission format
output = pandas.DataFrame({'PassengerId': test_set.PassengerId, 'Survived': predictions})
# Store the output in a csv file for submission
output.to_csv('submission.csv', index=False)
