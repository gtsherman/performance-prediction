package edu.gslis.main;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;

import edu.gslis.docscoring.support.IndexBackedCollectionStats;
import edu.gslis.indexes.IndexWrapper;
import edu.gslis.indexes.IndexWrapperIndriImpl;
import edu.gslis.qpp.scorers.post.QueryClarity;
import edu.gslis.queries.GQueries;
import edu.gslis.queries.GQueriesJsonImpl;
import edu.gslis.queries.GQuery;
import edu.gslis.searchhits.SearchHit;
import edu.gslis.searchhits.SearchHits;
import edu.gslis.searchhits.SearchHitsBatch;
import edu.gslis.utils.Stopper;
import edu.gslis.utils.config.Configuration;
import edu.gslis.utils.config.SimpleConfiguration;

public class RunQueryClarity {

	public static void main(String[] args) throws IOException {
		Configuration config = new SimpleConfiguration();
		config.read(args[0]);
		
		IndexWrapper targetIndex = new IndexWrapperIndriImpl(config.get(Configuration.INDEX_PATH));
		IndexWrapper externalIndex = new IndexWrapperIndriImpl(config.get("wiki-index"));
		IndexBackedCollectionStats backgroundModel = new IndexBackedCollectionStats();
		backgroundModel.setStatSource(externalIndex);
		Stopper stopper = new Stopper(config.get(Configuration.STOPLIST_PATH));
		GQueries queries = new GQueriesJsonImpl();
		queries.read(config.get(Configuration.QUERIES_PATH));
		
		SearchHitsBatch baseHitsBatch = new SearchHitsBatch();
		for (GQuery query : queries) {
			query.applyStopper(stopper);
			baseHitsBatch.setSearchHits(query, externalIndex.runQuery(query, 1000));
		}
		
		for (int docs : new int[] {10, 50, 100, 250, 500, 750, 1000}) {
			//for (int terms : new int[] {5, 10, 20, 50, 75, 100, 200, 500, 1000}) {
				FileWriter out = new FileWriter(new File("d" + docs));
				for (GQuery query : queries) {
					SearchHits reducedHits = new SearchHits();
					Iterator<SearchHit> hitit = baseHitsBatch.getSearchHits(query).iterator();
					while (hitit.hasNext() && reducedHits.size() < docs) {
						// Copy search hit so we don't ruin the original set
						SearchHit orig = hitit.next();
						SearchHit copy = new SearchHit();
						copy.setDocID(orig.getDocID());
						copy.setDocno(orig.getDocno());
						copy.setScore(orig.getScore());
						copy.setFeatureVector(orig.getFeatureVector());

						reducedHits.add(copy);
					}
					out.write(query.getTitle() + "\t" + QueryClarity.score(query, reducedHits, backgroundModel, targetIndex, stopper, docs) + "\n");
				}
				out.close();
			//}
		}
	}

}
