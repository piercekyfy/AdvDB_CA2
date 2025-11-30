\COPY genres TO '/tmp/genres.csv' WITH (FORMAT CSV, HEADER);
\COPY actors TO '/tmp/actors.csv' WITH (FORMAT CSV, HEADER);
\COPY movies TO '/tmp/movies.csv' WITH (FORMAT CSV, HEADER);
\COPY movies_actors TO '/tmp/movies_actors.csv' WITH (FORMAT CSV, HEADER);