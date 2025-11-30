-- Notes uses a nested SELECT instead of a JOIN. Not sure why. 
SELECT m.movie_id, m.title, cube_distance(s.genre, m.genre) as dist
FROM movies m
JOIN movies s ON s.title = 'Alien'
WHERE s.title <> m.title AND cube_enlarge(s.genre, 3, 18) @> m.genre
ORDER BY dist;
