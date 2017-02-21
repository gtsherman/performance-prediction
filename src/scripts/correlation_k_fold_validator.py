import sys

from correlation import correlate
from cross_validation.cross_validation import KFoldValidator
from scipy.stats import pearsonr, kendalltau


class CorrelationKFoldValidator(KFoldValidator):

    def __init__(self, results, num_folds=10, correlation='pearson'):
        """
        :param results: A dict of query->score for the actual retrieval results
        :param num_folds:
        :param correlation: One of 'pearson' or 'kendall'
        """
        self.results = results
        self.num_folds = num_folds

        correlation = correlation.lower()
        if correlation == 'pearson':
            self.correlation_function = pearsonr
        elif correlation == 'kendall':
            self.correlation_function = kendalltau
        else:
            sys.stderr.write('Unrecognized correlation type: {}. Defaulting to pearson.\n'.format(correlation))
            self.correlation_function = pearsonr

    def summarize(self, items):
        # Subset the full results set to only include items in this fold
        results_subset = {k: self.results[k] for k in items}

        # Make sure to return the absolute value of the correlation, since -0.8 is more highly correlated than 0.3
        return abs(correlate(results_subset, items, self.correlation_function))
