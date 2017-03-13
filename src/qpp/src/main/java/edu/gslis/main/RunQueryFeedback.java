package edu.gslis.main;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import edu.gslis.indexes.IndexWrapper;
import edu.gslis.indexes.IndexWrapperIndriImpl;
import edu.gslis.qpp.scorers.post.QueryFeedback;
import edu.gslis.queries.GQueries;
import edu.gslis.queries.GQueriesJsonImpl;
import edu.gslis.queries.GQuery;
import edu.gslis.utils.Stopper;
import edu.gslis.utils.config.Configuration;
import edu.gslis.utils.config.SimpleConfiguration;

public class RunQueryFeedback {

	public static void main(String[] args) throws IOException {
		Configuration config = new SimpleConfiguration();
		config.read(args[0]);
		
		IndexWrapper index = new IndexWrapperIndriImpl(config.get(Configuration.INDEX_PATH));
		Stopper stopper = new Stopper(config.get(Configuration.STOPLIST_PATH));
		GQueries queries = new GQueriesJsonImpl();
		queries.read(config.get(Configuration.QUERIES_PATH));
		
		for (int docs : new int[] {1, 10, 20, 50, 75, 100, 500}) {
			for (int terms : new int[] {1, 3, 5, 10, 15, 20}) {
				FileWriter out = new FileWriter(new File("d" + docs + ".t" + terms));
				for (GQuery query : queries) {
					out.write(query.getTitle() + "\t" + QueryFeedback.score(query, index, stopper, docs, terms) + "\n");
				}
				out.close();
			}
		}
	}

}
