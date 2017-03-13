package edu.gslis.qpp.scorers.post;

import edu.gslis.docscoring.support.CollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.queries.GQuery;
import edu.gslis.scoring.expansion.RM1Builder;
import edu.gslis.scoring.expansion.StandardRM1Builder;
import edu.gslis.searchhits.SearchHits;
import edu.gslis.textrepresentation.FeatureVector;
import edu.gslis.utils.Stopper;

public class QueryClarity {
	
	public static double score(GQuery query, SearchHits initialResults,
			CollectionStats backgroundModel, IndexWrapper targetIndex, Stopper stopper) {
		return QueryClarity.score(query, initialResults, backgroundModel, targetIndex, stopper, 500);
	}

	public static double score(GQuery query, SearchHits initialResults,
			CollectionStats backgroundModel, IndexWrapper targetIndex, Stopper stopper, int fbDocs) {
		if (stopper != null) {
			query.applyStopper(stopper);
		}

		// Get query language model
		// Note: Uses Dirichlet smoothing, not J-M as in original QC paper
		initialResults.crop(fbDocs);
		RM1Builder rm1 = new StandardRM1Builder(fbDocs, Integer.MAX_VALUE, backgroundModel);
		FeatureVector queryModel = rm1.buildRelevanceModel(
				query, initialResults, stopper);
		
		return queryModel.clarity(targetIndex);
	}

}
