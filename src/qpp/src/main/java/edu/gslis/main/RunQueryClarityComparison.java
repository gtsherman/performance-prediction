package edu.gslis.main;

import edu.gslis.docscoring.support.IndexBackedCollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.indexes.IndexWrapperIndriImpl;
import edu.gslis.qpp.scorers.post.QueryClarity;
import edu.gslis.queries.GQueries;
import edu.gslis.queries.GQueriesJsonImpl;
import edu.gslis.queries.GQuery;
import edu.gslis.searchhits.SearchHits;
import edu.gslis.utils.Stopper;
import edu.gslis.utils.config.Configuration;
import edu.gslis.utils.config.SimpleConfiguration;

public class RunQueryClarityComparison {

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
		
		int fbDocs = 50;
		
		for (GQuery query : queries) {
			query.applyStopper(stopper);
			
			//SearchHits initialResults = target.runQuery(query, fbDocs);
			//System.out.println(query.getTitle() + "\t" + QueryClarity.score(query, initialResults, targetBackground, target, stopper, fbDocs));
			
			SearchHits initialResults = external.runQuery(query, fbDocs);
			System.out.println(query.getTitle() + "\t" + QueryClarity.score(query, initialResults, externalBackground, external, stopper, fbDocs));
		}

	}

}
