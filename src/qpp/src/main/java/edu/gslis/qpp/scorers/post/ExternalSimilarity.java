package edu.gslis.qpp.scorers.post;

import edu.gslis.docscoring.support.IndexBackedCollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.queries.GQuery;
import edu.gslis.scoring.DirichletDocScorer;
import edu.gslis.scoring.expansion.RM1Builder;
import edu.gslis.scoring.expansion.StandardRM1Builder;
import edu.gslis.searchhits.SearchHit;
import edu.gslis.textrepresentation.FeatureVector;
import edu.gslis.utils.Stopper;

public class ExternalSimilarity {
	
	public static double score(GQuery query, IndexWrapper target, IndexWrapper external, Stopper stopper, int fbDocs, int fbTerms) {
		if (stopper != null) {
			query.applyStopper(stopper);
		}

		IndexBackedCollectionStats targetCollectionStats = new IndexBackedCollectionStats();
		targetCollectionStats.setStatSource(target);
		
		IndexBackedCollectionStats externalCollectionStats = new IndexBackedCollectionStats();
		externalCollectionStats.setStatSource(external);

		// Get query language model
		// Note: Uses Dirichlet smoothing, not J-M as in original QC paper
		RM1Builder rm1 = new StandardRM1Builder(fbDocs, fbTerms, externalCollectionStats);
		FeatureVector queryModel = rm1.buildRelevanceModel(
				query, external.runQuery(query, fbDocs), stopper);
		queryModel.normalize();
		
		DirichletDocScorer docScorer = new DirichletDocScorer(targetCollectionStats);
		
		double avgKL = 0.0;
		for (SearchHit targetDoc : target.runQuery(query, fbDocs)) {
			double docKL = 0.0;
			targetDoc.setFeatureVector(target.getDocVector(targetDoc.getDocno(), stopper));
			for (String term : queryModel) {
				double docProb = docScorer.scoreTerm(term, targetDoc);
				docKL += docProb * Math.log(docProb / queryModel.getFeatureWeight(term));
			}
			avgKL += docKL;
		}
		avgKL /= fbDocs;
		
		return avgKL;
	}

}
