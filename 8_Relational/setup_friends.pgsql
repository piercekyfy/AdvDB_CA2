CREATE TABLE people (
    id SERIAL PRIMARY KEY,
    name text
);

CREATE TABLE friendships (
    person1_id integer REFERENCES people(id) NOT NULL CHECK(person1_id != person2_id),
    person2_id integer REFERENCES people(id) NOT NULL CHECK(person2_id != person1_id)
);

CREATE TABLE movie_ratings (
    person_id integer REFERENCES people NOT NULL,
    movie_id integer REFERENCES movies NOT NULL,
    rating integer CHECK(rating >= 0 AND rating <= 5)
);

INSERT INTO people (id, name)
VALUES
    (1, 'Joe'),
    (2, 'Jack'),
    (3, 'John'),
    (4, 'Jill'),
    (5, 'Jane'),
    (6, 'Janice');

INSERT INTO friendships (person1_id, person2_id)
VALUES
    (1,4),
    (4,5),
    (1,2),
    (2,6);

INSERT INTO movie_ratings (person_id, movie_id, rating)
VALUES
    (2, 1, 3),
    (2, 2, 5),
    (2, 3, 3),
    (4, 4, 4),
    (4, 5, 5),
    (4, 6, 5);

-- Relational implementation of 9.c
SELECT DISTINCT fr.name AS Friend, m.title as Movie, r.rating as Rating
FROM people p
JOIN friendships f ON p.id = f.person1_id OR p.id = f.person2_id
JOIN people fr ON fr.id = CASE WHEN f.person1_id = p.id THEN f.person2_id ELSE f.person1_id END
JOIN movie_ratings r ON fr.id = r.person_id
JOIN movies m ON r.movie_id = m.movie_id
WHERE p.name = 'Joe'; -- todo : discuss query optimization

