package edu.gslis.qpp.scorers.post;

import java.util.Set;
import java.util.stream.Collectors;

import edu.gslis.docscoring.support.IndexBackedCollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.queries.GQuery;
import edu.gslis.scoring.DirichletDocScorer;
import edu.gslis.scoring.DocScorer;
import edu.gslis.searchhits.SearchHit;
import edu.gslis.searchhits.SearchHits;
import edu.gslis.textrepresentation.FeatureVector;
import edu.gslis.utils.Stopper;

public class QueryFeedback {
	
	/**
	 * See http://maroo.cs.umass.edu/pdf/IR-573.pdf
	 * @param query The query
	 * @param index The index
	 * @param stopper The stoplist
	 * @param resultCutoff The top k results to include in the ranked lists
	 * @param termCutoff The top n terms to include in the compressed query
	 * @return The query feedback score
	 */
	public static double score(GQuery query, IndexWrapper index, Stopper stopper, int resultCutoff, int termCutoff) {
		if (stopper != null) {
			query.applyStopper(stopper);
		}
		
		IndexBackedCollectionStats cs = new IndexBackedCollectionStats();
		cs.setStatSource(index);

		// Get P(w|L), the probability of each term in the results list
		DocScorer docScorer = new DirichletDocScorer(cs);
		FeatureVector originalTermWeights = new FeatureVector(null);
		SearchHits origResults = index.runQuery(query, resultCutoff);
		for (SearchHit doc : origResults) {
			doc.setFeatureVector(index.getDocVector(doc.getDocID(), stopper));
			for (String term : doc.getFeatureVector()) {
				double docWeight = docScorer.scoreTerm(term, doc);
				originalTermWeights.addTerm(term, docWeight);
			}
		}
		
		// Rank all w by KL-divergence with collection and clip
		FeatureVector newTermWeights = new FeatureVector(null);
		for (String term : originalTermWeights.getFeatures()) {
			double colProb = cs.termCount(term) / cs.getTokCount();
			double kl = originalTermWeights.getFeatureWeight(term) * Math.log(originalTermWeights.getFeatureWeight(term) / colProb);
			newTermWeights.addTerm(term, kl);
		}
		newTermWeights.clip(termCutoff);
		
		// Get results for new query
		/*SearchHits newResults = index.runQuery(query, 1000);
		for (SearchHit doc : newResults) {
			double docScore = 0.0;
			for (String term : newTermWeights.getFeatures()) {
				docScore += Math.pow(docScorer.scoreTerm(term, doc), newTermWeights.getFeatureWeight(term));
			}
			doc.setScore(docScore);
		}
		newResults.rank();*/
		GQuery newQuery = new GQuery();
		newQuery.setFeatureVector(newTermWeights);
		SearchHits newResults = index.runQuery(newQuery, resultCutoff);
		
		// Compute and return overlap
		Set<String> newDocnos = newResults.hits().stream().map(hit -> hit.getDocno()).collect(Collectors.toSet());
		Set<SearchHit> overlap = origResults.hits().stream().filter(hit -> newDocnos.contains(hit.getDocno())).collect(Collectors.toSet());
		return overlap.size() / (double) resultCutoff;
	}
	
}
