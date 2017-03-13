import math
import sys

from correlation import correlate
from cross_validation.cross_validation import KFoldValidator
from scipy.stats import pearsonr, kendalltau


class CorrelationKFoldValidator(KFoldValidator):

    def __init__(self, results, correlation='pearson', verbose=False):
        """
        :param results: A dict of query->score for the actual retrieval results
        :param correlation: One of 'pearson' or 'kendall'
        """
        self.results = results

        correlation = correlation.lower()
        if correlation == 'pearson':
            self.correlation_function = pearsonr
        elif correlation == 'kendall':
            self.correlation_function = kendalltau
        else:
            self.stderr('Unrecognized correlation type: {}. Defaulting to pearson.\n'.format(correlation))
            self.correlation_function = pearsonr

        self.stderr = KFoldValidator.verbose_stderr if verbose else KFoldValidator.silent_stderr

    def partition(self, *scoreds):
        num_training = int(math.ceil(0.5*len(scoreds)))

        folds = [scoreds[:num_training]] + [scoreds[num_training:]]

        self.stderr('Items in training set: {}'.format(str(len(folds[0]))))
        self.stderr('Items in test set: {}'.format(str(len(folds[1]))))

        return folds

    def train_then_test(self, folds, concatenate):
        best_parameters, best_score = self.train(folds[0])

        self.stderr('Best params for training fold (n={}): {} ({})'.format(str(len(folds[0])), str(best_parameters),
                                                                           str(best_score)))

        # Store scores for those parameters from test fold
        test_scores = self.test(folds[1], best_parameters)
        return test_scores

    def summarize(self, items):
        # Make sure to return the absolute value of the correlation, since -0.8 is more highly correlated than 0.3
        return abs(correlate(self.results, items, self.correlation_function))
