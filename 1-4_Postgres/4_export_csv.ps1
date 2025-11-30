Get-Content "$PSScriptRoot/4_export_csv.pgsql" | docker exec -i postgres psql -U admin -d movies 
New-Item -ItemType "Directory" -Path "$PSScriptRoot/../pssql_out/"
docker cp postgres:/tmp/genres.csv "$PSScriptRoot/../pssql_out/"
docker cp postgres:/tmp/actors.csv "$PSScriptRoot/../pssql_out/"
docker cp postgres:/tmp/movies.csv "$PSScriptRoot/../pssql_out/"
docker cp postgres:/tmp/movies_actors.csv "$PSScriptRoot/../pssql_out/"