docker cp "$PSScriptRoot/../neo4j_import/." 'neo4j:/var/lib/neo4j/import'

Get-Content "$PSScriptRoot/5_import_csv.cql" | docker exec -i neo4j cypher-shell -u neo4j -p admin