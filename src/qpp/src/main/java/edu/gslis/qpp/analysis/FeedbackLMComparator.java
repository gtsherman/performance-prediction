package edu.gslis.qpp.analysis;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import edu.gslis.docscoring.support.CollectionStats;
import edu.gslis.docscoring.support.IndexBackedCollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.queries.GQueries;
import edu.gslis.queries.GQuery;
import edu.gslis.scoring.expansion.RM1Builder;
import edu.gslis.scoring.expansion.StandardRM1Builder;
import edu.gslis.textrepresentation.FeatureVector;
import edu.gslis.utils.Stopper;

public class FeedbackLMComparator {
	
	public static double averageCompare(IndexWrapper target, IndexWrapper external, GQueries queries, Stopper stopper, int fbDocs) {
		IndexBackedCollectionStats targetBackground = new IndexBackedCollectionStats();
		targetBackground.setStatSource(target);

		IndexBackedCollectionStats externalBackground = new IndexBackedCollectionStats();
		externalBackground.setStatSource(external);

		double average = 0.0;
		for (GQuery query : queries) {
			average += compare(target, targetBackground, external, externalBackground, query, stopper, fbDocs);
		}
		return average /= queries.numQueries();
	}

	public static double compare(IndexWrapper target, CollectionStats targetBackground,
			IndexWrapper external, CollectionStats externalBackground,
			GQuery query, Stopper stopper, int fbDocs) {
		if (stopper != null) {
			query.applyStopper(stopper);
		}
		
		RM1Builder rm1 = new StandardRM1Builder(fbDocs, 20, targetBackground);
		FeatureVector targetModel = rm1.buildRelevanceModel(
				query, target.runQuery(query, fbDocs), stopper);

		rm1 = new StandardRM1Builder(fbDocs, 20, externalBackground);
		FeatureVector externalModel = rm1.buildRelevanceModel(
				query, external.runQuery(query, fbDocs), stopper);
		
		return cosine(targetModel, externalModel);
	}
	
	public static double kl(FeatureVector doc, FeatureVector otherdoc, CollectionStats otherdocBackground) {
		double score = 0;
		
		Iterator<String> termIt = doc.iterator();
		while (termIt.hasNext()) {
			String term = termIt.next();
			
			double background = (otherdocBackground.termCount(term) + 1) / otherdocBackground.getTokCount();
			
			double pwd = doc.getFeatureWeight(term) / doc.getLength();
			double pwc = (otherdoc.getFeatureWeight(term) + 0.00001) / (otherdoc.getLength() + 0.00001*doc.getLength());
			
			if (pwd == 0) {
				continue;
			} else {
				score += pwd * Math.log(pwd / pwc);
			}
		}
		
		return score;
	}
	
	public static double cosine(FeatureVector doc, FeatureVector otherdoc) {
		double num = 0.0;
		double denomX = 0.0;
		double denomY = 0.0;
		
		Set<String> vocab = new HashSet<String>();
		vocab.addAll(doc.getFeatures());
		vocab.addAll(otherdoc.getFeatures());

		Iterator<String> termIt = vocab.iterator();
		String term;
		while (termIt.hasNext()) {
			term = termIt.next();
			
			double docWeight = doc.getFeatureWeight(term);
			double otherdocWeight = otherdoc.getFeatureWeight(term); 
			
			num += docWeight * otherdocWeight;
			denomX += Math.pow(docWeight, 2);
			denomY += Math.pow(otherdocWeight, 2);
		}
		double denom = Math.sqrt(denomX)*Math.sqrt(denomY);
		if (denom == 0) denom = 1;  // should be unnecessary...
		return num/denom;
	}

}
