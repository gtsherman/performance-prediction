package edu.gslis.qpp.analysis;

import java.util.HashMap;
import java.util.Map;

import edu.gslis.docscoring.support.CollectionStats;
import edu.gslis.docscoring.support.IndexBackedCollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.queries.GQuery;
import edu.gslis.searchhits.SearchHit;
import edu.gslis.searchhits.SearchHits;
import edu.gslis.textrepresentation.FeatureVector;
import edu.gslis.utils.Stopper;

public class SilhouetteComparator {
	
	public static double compare(IndexWrapper target, IndexWrapper external, GQuery query, Stopper stopper, int fbDocs) {
		if (stopper != null) {
			query.applyStopper(stopper);
		}
		
		SearchHits topDocsTarget = target.runQuery(query, fbDocs);
		// Clip to pesudo-query length
		//topDocsTarget.hits().stream().parallel().forEach(doc -> doc.getFeatureVector().clip(20));

		SearchHits topDocsExternal = external.runQuery(query, fbDocs);
		// Clip to pesudo-query length
		//topDocsExternal.hits().stream().parallel().forEach(doc -> doc.getFeatureVector().clip(20));

		IndexBackedCollectionStats targetCS = new IndexBackedCollectionStats();
		targetCS.setStatSource(target);

		IndexBackedCollectionStats externalCS = new IndexBackedCollectionStats();
		externalCS.setStatSource(external);

		Map<String, FeatureVector> notThisDocTarget = getOtherDocs(topDocsTarget, fbDocs);
		
		FeatureVector externalPseudoDoc = new FeatureVector(null);
		for (SearchHit doc : topDocsExternal) {
			for (String term : doc.getFeatureVector()) {
				externalPseudoDoc.addTerm(term, doc.getFeatureVector().getFeatureWeight(term));
			}
		}
		
		double silhouette = topDocsTarget.hits().stream().parallel().mapToDouble(hit -> silhouette(hit, notThisDocTarget, targetCS, externalPseudoDoc, externalCS)).sum() / fbDocs;
		return silhouette;
	}
	
	public static double silhouette(SearchHit doc, Map<String, FeatureVector> notThisDocTarget, CollectionStats targetCS, 
			FeatureVector externalPseudoDoc, CollectionStats externalCS) {
		double a = FeedbackLMComparator.kl(doc.getFeatureVector(), notThisDocTarget.get(doc.getDocno()), targetCS);
		double b = FeedbackLMComparator.kl(doc.getFeatureVector(), externalPseudoDoc, externalCS);
		return (b-a)/Math.max(a, b);
	}
	
	private static Map<String, FeatureVector> getOtherDocs(SearchHits topDocs, int fbDocs) {
		Map<String, FeatureVector> compareDocToThisTarget = new HashMap<String, FeatureVector>();
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
			compareDocToThisTarget.put(doc.getDocno(), combined);
		}
		
		return compareDocToThisTarget;
	}

}
