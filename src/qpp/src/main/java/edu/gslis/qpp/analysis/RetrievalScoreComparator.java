package edu.gslis.qpp.analysis;

import edu.gslis.indexes.IndexWrapper;
import edu.gslis.queries.GQuery;
import edu.gslis.searchhits.SearchHits;
import edu.gslis.utils.Stopper;

public class RetrievalScoreComparator {
	
	public static double compare(IndexWrapper target, GQuery query, Stopper stopper, int fbDocs) {
		if (stopper != null) {
			query.applyStopper(stopper);
		}
		
		SearchHits targetHits = target.runQuery(query, fbDocs);
		double avgTarget = targetHits.hits().stream().parallel().mapToDouble(hit -> Math.exp(hit.getScore())).sum() / fbDocs;
		
		return avgTarget;
	}

}
