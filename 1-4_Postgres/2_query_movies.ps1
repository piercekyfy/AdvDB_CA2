Write-Output "`n`t`Query movies with genre similarity to 'Alien' within bounding box of 3:`n"

Get-Content "$PSScriptRoot/2_query_movies.pgsql" | docker exec -i postgres psql -U admin -d movies 