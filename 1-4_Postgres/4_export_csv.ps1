Write-Output "`n`t`Exporting genres, actors, movies, movie_actors to ./neo4j_import/.csv:`n"

Get-Content "$PSScriptRoot/4_export_csv.pgsql" | docker exec -i postgres psql -U admin -d movies 
New-Item -ItemType "Directory" -Path "$PSScriptRoot/../neo4j_import/"
docker cp postgres:/tmp/genres.csv "$PSScriptRoot/../neo4j_import/"
docker cp postgres:/tmp/actors.csv "$PSScriptRoot/../neo4j_import/"
docker cp postgres:/tmp/movies.csv "$PSScriptRoot/../neo4j_import/"
docker cp postgres:/tmp/movies_actors.csv "$PSScriptRoot/../neo4j_import/"