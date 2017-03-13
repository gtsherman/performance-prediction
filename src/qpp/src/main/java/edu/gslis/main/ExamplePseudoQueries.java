package edu.gslis.main;

import java.util.concurrent.ThreadLocalRandom;

import edu.gslis.indexes.IndexWrapper;
import edu.gslis.indexes.IndexWrapperIndriImpl;
import edu.gslis.queries.GQueries;
import edu.gslis.queries.GQueriesJsonImpl;
import edu.gslis.queries.GQuery;
import edu.gslis.searchhits.SearchHit;
import edu.gslis.utils.Stopper;
import edu.gslis.utils.config.Configuration;
import edu.gslis.utils.config.SimpleConfiguration;

public class ExamplePseudoQueries {

	public static void main(String[] args) {
		Configuration config = new SimpleConfiguration();
		config.read(args[0]);
		
		IndexWrapper target = new IndexWrapperIndriImpl(config.get(Configuration.INDEX_PATH));
		
		GQueries queries = new GQueriesJsonImpl();
		queries.read(config.get(Configuration.QUERIES_PATH));
		
		Stopper stopper = new Stopper(config.get(Configuration.STOPLIST_PATH));

		GQuery query = queries.getIthQuery(ThreadLocalRandom.current().nextInt(1, 101));
		System.out.println(query.getText());
		query.applyStopper(stopper);
		
		for (SearchHit result : target.runQuery(query, 5)) {
			GQuery tmp = new GQuery();
			tmp.setFeatureVector(result.getFeatureVector());
			tmp.applyStopper(stopper);
			tmp.getFeatureVector().normalize();
			
			System.out.println(tmp.getFeatureVector().toString(5));
		}
		
	}

}
