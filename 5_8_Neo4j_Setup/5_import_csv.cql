// Create indexes BEFORE importing data!
CREATE INDEX actor_id_index IF NOT EXISTS FOR (a:Actor) ON (a.id);
CREATE INDEX movie_id_index IF NOT EXISTS FOR (m:Movie) ON (m.id);

LOAD CSV WITH HEADERS FROM "file:///genres.csv" AS row
MERGE (g:Genre { name: row.name }) // Merge to avoid duplicates.
SET g.position = toInteger(row.position);

LOAD CSV WITH HEADERS
FROM "file:///actors.csv" AS row
MERGE (a:Actor { id: toInteger(row.actor_id) })
SET a.name = row.name;

LOAD CSV WITH HEADERS FROM "file:///movies.csv" AS row
WITH row, replace(replace(row.genre, "(", "["), ")", "]") as genre_formatted
MERGE (m:Movie { id: toInteger(row.movie_id) })
SET m.title = row.title, m.genre = apoc.convert.fromJsonList(genre_formatted);

LOAD CSV WITH HEADERS FROM "file:///movies_actors.csv"  AS row
MATCH (a:Actor {id: toInteger(row.actor_id)})
MATCH (m:Movie {id: toInteger(row.movie_id)})
MERGE (a)-[:ACTED_IN]->(m);

MATCH(m:Movie)
UNWIND RANGE(0, SIZE(m.genre) - 1) as genrePosition
WITH m, genrePosition, m.genre[genrePosition] as genreStrength
WHERE genreStrength <> 0
MATCH (g:Genre {position: genrePosition + 1})
MERGE (m)-[r:HAS_GENRE ]->(g)
SET r.strength = genreStrength;

MERGE (p:Person {id: 1})
SET p.name = "Joe";
MERGE (p:Person {id: 2})
SET p.name = "Jack";
MERGE (p:Person {id: 3})
SET p.name = "John";
MERGE (p:Person {id: 4})
SET p.name = "Jill";
MERGE (p:Person {id: 5})
SET p.name = "Jane";
MERGE (p:Person {id: 6})
SET p.name = "Janice";

MATCH (p1:Person {name: "Joe"})
MATCH (p2:Person {name: "Jill"})
MERGE (p1)-[:FRIENDS_WITH]-(p2);

MATCH (p1:Person {name: "Jill"})
MATCH (p2:Person {name: "Jane"})
MERGE (p1)-[:FRIENDS_WITH]-(p2);

MATCH (p1:Person {name: "Joe"})
MATCH (p2:Person {name: "Jack"})
MERGE (p1)-[:FRIENDS_WITH]-(p2);

MATCH (p1:Person {name: "Jack"})
MATCH (p2:Person {name: "Janice"})
MERGE (p1)-[:FRIENDS_WITH]-(p2);

MATCH (p:Person {name: "Jack"})
MATCH (m:Movie {title: "Star Wars"})
MERGE (p)-[r:LIKES]->(m)
SET r.rating = 3;

MATCH (p:Person {name: "Jack"})
MATCH (m:Movie {title: "Forrest Gump"})
MERGE (p)-[r:LIKES]->(m)
SET r.rating = 5;

MATCH (p:Person {name: "Jack"})
MATCH (m:Movie {title: "American Beauty"})
MERGE (p)-[r:LIKES]->(m)
SET r.rating = 3;

MATCH (p:Person {name: "Jill"})
MATCH (m:Movie {title: "Citizen Kane"})
MERGE (p)-[r:LIKES]->(m)
SET r.rating = 4;

MATCH (p:Person {name: "Jill"})
MATCH (m:Movie {title: "The Dark"})
MERGE (p)-[r:LIKES]->(m)
SET r.rating = 5;

MATCH (p:Person {name: "Jill"})
MATCH (m:Movie {title: "The Fifth Element"})
MERGE (p)-[r:LIKES]->(m)
SET r.rating = 5;