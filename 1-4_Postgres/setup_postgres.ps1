Get-Content "$PSScriptRoot/setup_postgres.pgsql" | docker exec -i postgres psql -U admin
Get-Content "$PSScriptRoot/create_movies.pgsql" | docker exec -i postgres psql -U admin -d movies 
Get-Content "$PSScriptRoot/movies_data.pgsql" | docker exec -i postgres psql -U admin -d movies 