MATCH(a:Actor {name: "Sigourney Weaver"})-[:ACTED_IN]->(m:Movie)
RETURN m.title;

MATCH(a:Actor {name: "Sigourney Weaver"})-[:ACTED_IN]->(m:Movie)-[:HAS_GENRE]->(g:Genre)
RETURN m.title, collect(g.name);

MATCH(p:Person {name: "Joe"})-[:FRIENDS_WITH]-(f:Person)-[l:LIKES]->(m:Movie)
RETURN f.name, collect({title: m.title, rating: l.rating});

CALL gds.graph.drop('friendshipGraph', false);
CALL gds.graph.project(
  'friendshipGraph',
  'Person',
  'FRIENDS_WITH'
);

CALL gds.degree.stream('friendshipGraph') 
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name as name, score AS friends
ORDER BY friends DESC, name ASC;


MATCH (source:Actor {name: 'Sigourney Weaver'}), (destination:Actor {name: 'Sandy Dennis'})
CALL apoc.algo.dijkstra(source, destination, 'ACTED_IN', '1')
YIELD path, weight
RETURN (length(path)/2) -1 AS seperation; // TODO: SQL version

// How might you include recommendations in Neo4j?