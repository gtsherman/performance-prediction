package edu.gslis.main;

import java.io.IOException;

import edu.gslis.indexes.IndexWrapper;
import edu.gslis.indexes.IndexWrapperIndriImpl;
import edu.gslis.qpp.analysis.RetrievalScoreComparator;
import edu.gslis.queries.GQueries;
import edu.gslis.queries.GQueriesJsonImpl;
import edu.gslis.queries.GQuery;
import edu.gslis.utils.Stopper;
import edu.gslis.utils.config.Configuration;
import edu.gslis.utils.config.SimpleConfiguration;

public class RunRetrievalScoreComparison {

	public static void main(String[] args) throws IOException {
		Configuration config = new SimpleConfiguration();
		config.read(args[0]);
		
		IndexWrapper target = new IndexWrapperIndriImpl(config.get(Configuration.INDEX_PATH));
		IndexWrapper external = new IndexWrapperIndriImpl(config.get("wiki-index"));
		
		GQueries queries = new GQueriesJsonImpl();
		queries.read(config.get(Configuration.QUERIES_PATH));
		
		Stopper stopper = new Stopper(config.get(Configuration.STOPLIST_PATH));
		
		for (GQuery query : queries) {
			System.out.println(query.getTitle() + "\t" + RetrievalScoreComparator.compare(target, query, stopper, 10));
			System.err.println(query.getTitle() + "\t" + RetrievalScoreComparator.compare(external, query, stopper, 10));
		}
	}

}
