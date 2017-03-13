package edu.gslis.main;

import edu.gslis.docscoring.support.IndexBackedCollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.indexes.IndexWrapperIndriImpl;
import edu.gslis.qpp.analysis.FeedbackLMComparator;
import edu.gslis.queries.GQueries;
import edu.gslis.queries.GQueriesJsonImpl;
import edu.gslis.queries.GQuery;
import edu.gslis.utils.Stopper;
import edu.gslis.utils.config.Configuration;
import edu.gslis.utils.config.SimpleConfiguration;

public class RunFeedbackLMComparison {

	public static void main(String[] args) {
		Configuration config = new SimpleConfiguration();
		config.read(args[0]);
		
		IndexWrapper target = new IndexWrapperIndriImpl(config.get(Configuration.INDEX_PATH));
		IndexWrapper external = new IndexWrapperIndriImpl(config.get("wiki-index"));
		
		IndexBackedCollectionStats targetBackground = new IndexBackedCollectionStats();
		targetBackground.setStatSource(target);

		IndexBackedCollectionStats externalBackground = new IndexBackedCollectionStats();
		externalBackground.setStatSource(external);

		GQueries queries = new GQueriesJsonImpl();
		queries.read(config.get(Configuration.QUERIES_PATH));
		
		Stopper stopper = new Stopper(config.get(Configuration.STOPLIST_PATH));
		
		for (GQuery query : queries) {
			System.out.println(query.getTitle() + "\t" + FeedbackLMComparator.compare(target, targetBackground, external, externalBackground, query, stopper, 50));
		}

	}

}
