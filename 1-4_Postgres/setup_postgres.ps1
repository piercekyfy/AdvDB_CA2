Write-Output "`n`t`Creating database:`n"
Get-Content "$PSScriptRoot/setup_postgres.pgsql" | docker exec -i postgres psql -U admin

Write-Output "`n`t`Creating tables and indexes:`n"
Get-Content "$PSScriptRoot/create_movies.pgsql" | docker exec -i postgres psql -U admin -d movies 

Write-Output "`n`t`Populating tables with sample data:`n"
Get-Content "$PSScriptRoot/movies_data.pgsql" | docker exec -i postgres psql -U admin -d movies 