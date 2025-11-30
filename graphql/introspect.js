import { toGraphQLTypeDefs } from "@neo4j/introspector";
import fs from "fs";
import neo4j from "neo4j-driver";

const driver = neo4j.driver(
    "neo4j://localhost:7687",
    neo4j.auth.basic("neo4j", "admin")
);

const sessionFactory = () => driver.session({ defaultAccessMode: neo4j.session.READ })

async function main() {
    const typeDefs = await toGraphQLTypeDefs(sessionFactory)
    fs.writeFileSync('schema.graphql', typeDefs)
    await driver.close();
}
main()