package edu.gslis.main;

import edu.gslis.indexes.IndexWrapper;
import edu.gslis.indexes.IndexWrapperIndriImpl;
import edu.gslis.qpp.scorers.post.ExternalSimilarity;
import edu.gslis.queries.GQueries;
import edu.gslis.queries.GQueriesJsonImpl;
import edu.gslis.queries.GQuery;
import edu.gslis.utils.Stopper;
import edu.gslis.utils.config.Configuration;
import edu.gslis.utils.config.SimpleConfiguration;

public class RunExternalSimilarity {

	public static void main(String[] args) {
		Configuration config = new SimpleConfiguration();
		config.read(args[0]);
		
		IndexWrapper target = new IndexWrapperIndriImpl(config.get(Configuration.INDEX_PATH));
		IndexWrapper external = new IndexWrapperIndriImpl(config.get("wiki-index"));
		Stopper stopper = new Stopper(config.get(Configuration.STOPLIST_PATH));
		GQueries queries = new GQueriesJsonImpl();
		queries.read(config.get(Configuration.QUERIES_PATH));
		
		for (GQuery query : queries) {
			System.out.println(query.getTitle() + "\t" + ExternalSimilarity.score(query, target, external, stopper, 10, 20));
		}
	}

}
