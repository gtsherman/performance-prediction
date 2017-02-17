package edu.gslis.qpp.scorers.post;

import edu.gslis.docscoring.support.IndexBackedCollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.queries.GQuery;
import edu.gslis.scoring.expansion.RM1Builder;
import edu.gslis.scoring.expansion.StandardRM1Builder;
import edu.gslis.textrepresentation.FeatureVector;
import edu.gslis.utils.Stopper;

public class QueryClarity {
	
	public static double score(GQuery query, IndexWrapper index, Stopper stopper) {
		return QueryClarity.score(query, index, stopper, 500);
	}

	public static double score(GQuery query, IndexWrapper index, Stopper stopper, int fbDocs) {
		return QueryClarity.score(query, index, stopper, fbDocs, Integer.MAX_VALUE);
	}
	
	public static double score(GQuery query, IndexWrapper index, Stopper stopper, int fbDocs, int fbTerms) {
		if (stopper != null) {
			query.applyStopper(stopper);
		}

		IndexBackedCollectionStats collectionStats = new IndexBackedCollectionStats();
		collectionStats.setStatSource(index);
		
		// Get query language model
		// Note: Uses Dirichlet smoothing, not J-M as in original QC paper
		RM1Builder rm1 = new StandardRM1Builder(fbDocs, fbTerms, collectionStats);
		FeatureVector queryModel = rm1.buildRelevanceModel(
				query, index.runQuery(query, fbDocs), stopper);
		
		return queryModel.clarity(index);
	}

}
