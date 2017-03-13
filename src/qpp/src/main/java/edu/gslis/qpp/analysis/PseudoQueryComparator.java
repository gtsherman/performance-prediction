package edu.gslis.qpp.analysis;

import java.util.HashMap;
import java.util.Map;

import edu.gslis.docscoring.support.IndexBackedCollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.queries.GQuery;
import edu.gslis.searchhits.SearchHit;
import edu.gslis.searchhits.SearchHits;
import edu.gslis.textrepresentation.FeatureVector;
import edu.gslis.utils.Stopper;

public class PseudoQueryComparator {
	
	public static double compare(IndexWrapper target, GQuery query, Stopper stopper, int fbDocs) {
		IndexBackedCollectionStats cs = new IndexBackedCollectionStats();
		cs.setStatSource(target);

		SearchHits topDocs = target.runQuery(query, fbDocs);
		
		// Clip to pesudo-query length
		//topDocs.hits().stream().parallel().forEach(doc -> doc.getFeatureVector().clip(20));

		Map<String, FeatureVector> compareDocToThis = new HashMap<String, FeatureVector>();
		for (SearchHit doc : topDocs) {
			FeatureVector combined = new FeatureVector(null);
			for (SearchHit otherdoc : topDocs) {
				if (otherdoc.getDocno().equals(doc.getDocno())) {
					continue;
				}
				for (String term : otherdoc.getFeatureVector()) {
					combined.addTerm(term, otherdoc.getFeatureVector().getFeatureWeight(term));
				}
			}
			compareDocToThis.put(doc.getDocno(), combined);
		}
		
		// Score each doc agains the other docs
		double total = topDocs.hits().stream().parallel()
			.mapToDouble(doc -> FeedbackLMComparator.kl(doc.getFeatureVector(), compareDocToThis.get(doc.getDocno()), cs))
			.sum();
		return total / topDocs.size();
	}

}
