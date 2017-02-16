package edu.gslis.main;

import edu.gslis.indexes.IndexWrapper;
import edu.gslis.indexes.IndexWrapperIndriImpl;
import edu.gslis.qpp.scorers.post.QueryClarity;
import edu.gslis.queries.GQueries;
import edu.gslis.queries.GQueriesJsonImpl;
import edu.gslis.queries.GQuery;
import edu.gslis.utils.Stopper;
import edu.gslis.utils.config.Configuration;
import edu.gslis.utils.config.SimpleConfiguration;

public class RunQueryClarity {

	public static void main(String[] args) {
		Configuration config = new SimpleConfiguration();
		config.read(args[0]);
		
		IndexWrapper index = new IndexWrapperIndriImpl(config.get(Configuration.INDEX_PATH));
		Stopper stopper = new Stopper(config.get(Configuration.STOPLIST_PATH));
		GQueries queries = new GQueriesJsonImpl();
		queries.read(config.get(Configuration.QUERIES_PATH));
		
		for (GQuery query : queries) {
			System.out.println(query.getTitle() + "\t" + QueryClarity.score(query, index, stopper));
		}
	}

}
