package edu.gslis.main;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

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

	public static void main(String[] args) throws IOException {
		Configuration config = new SimpleConfiguration();
		config.read(args[0]);
		
		IndexWrapper index = new IndexWrapperIndriImpl(config.get(Configuration.INDEX_PATH));
		Stopper stopper = new Stopper(config.get(Configuration.STOPLIST_PATH));
		GQueries queries = new GQueriesJsonImpl();
		queries.read(config.get(Configuration.QUERIES_PATH));
		
		for (int docs : new int[] {1, 5, 10, 20, 50, 75, 100, 250, 500, 1000}) {
			for (int terms : new int[] {5, 10, 20, 50, 75, 100, 200, 500, 1000}) {
				FileWriter out = new FileWriter(new File("d" + docs + ".t" + terms));
				for (GQuery query : queries) {
					out.write(query.getTitle() + "\t" + QueryClarity.score(query, index, stopper, docs, terms) + "\n");
				}
				out.close();
			}
		}
	}

}
