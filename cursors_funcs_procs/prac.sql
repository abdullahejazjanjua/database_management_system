-- Cursors: To process each row from a query seperately, you attach a cursor to it

-- cursor_name cursor for <SQL statement>

-- Functions
-- CREATE OR REPLACE FUNCTION func_name(parma_list)
--  RETURNS return_type
-- LANGUAGE plpqsql
-- AS
-- $$
    -- DECLARE
        -- variables
    -- BEGIN
        -- logic
    -- RETURN something
-- END $$;

-- SELECT func_name(param list);


-- Procedures --> Does not return anything, supports transactions (?)
-- CREATE OR REPLACE PROCEDURE func_name(parma_list)
-- LANGUAGE plpqsql
-- AS
-- $$
    -- DECLARE
        -- variables
    -- BEGIN
        -- logic
-- END $$;

-- CALL func_name(param list);


-- Bounded cursor
DO $$
    DECLARE 
        movie_cursor cursor for SELECT title, release_year FROM movies;
        mov_title movies.title%type;
        mov_ry movies.release_year%type;
    BEGIN
        OPEN movie_cursor;
        LOOP
            FETCH movie_cursor INTO mov_title, mov_ry;
            if NOT found then
                exit;
            end if;

            RAISE NOTICE 'Title: %, Release Year: %', mov_title, mov_ry;
        END LOOP;
        close movie_cursor;

END $$

-- Unbounded CURSOR
DO $$
    DECLARE
        mov_cursor refcursor;
        mov_title movies.title%type;
        mov_ry movies.release_year%type;
    BEGIN
        OPEN mov_cursor FOR SELECT title, release_year FROM movies;
        LOOP 
            FETCH mov_cursor INTO mov_title, mov_ry;

            if NOT found then
                exit;
            end if;

            RAISE NOTICE 'Title: %, Release Year: %', mov_title, mov_ry;

        END LOOP;
        CLOSE mov_cursor;
END $$;

-- Parametrized Cursor
DO $$
DECLARE
    mov_cursor CURSOR(GEN movies.genre%type) FOR SELECT title, release_year FROM movies WHERE genre = GEN;
    mov_title movies.title%TYPE;
    mov_ry movies.release_year%TYPE;
BEGIN
    OPEN mov_cursor('Sci-Fi');
    LOOP 
        FETCH mov_cursor INTO mov_title, mov_ry;
        IF NOT FOUND THEN
            EXIT;
        END IF;
        RAISE NOTICE 'Title: %, Release Year: %', mov_title, mov_ry;
    END LOOP;
    CLOSE mov_cursor;
END
$$;


-- Functions
CREATE OR REPLACE FUNCTION get_count_by_genre(gen movies.genre%type)
RETURNS INTEGER
LANGUAGE PLPGSQL
AS $$
    DECLARE 
        mov_count INTEGER := 0;
    BEGIN
        SELECT COUNT(*) INTO mov_count
        FROM movies WHERE genre = gen;

        RETURN mov_count;

END $$;

SELECT get_count_by_genre('Sci-Fi');


-- Procedures

CREATE OR REPLACE PROCEDURE insert_data(title movies.title%type, ry movies.release_year%type, gen movies.genre%type)
LANGUAGE PLPGSQL
AS $$
    DECLARE
    BEGIN
        INSERT INTO movies (title, release_year, genre) VALUES
        (title, ry, gen);
END $$;

CALL insert_data('Napolean', 2024, 'Historical');

SELECT * FROM movies;


-- Tasks

-- Q1. Use a cursor to fetch and display all movies along with their actors.
DO $$
    DECLARE 
        det_cursor cursor FOR SELECT movies.title, actors.name FROM movie_actor
                    JOIN movies ON movie_actor.movie_id = movies.movie_id 
                    JOIN actors ON actors.actor_id = movie_actor.actor_id;
        actor_name actors.name%type;
        mov_title movies.title%type;
    BEGIN
        OPEN det_cursor;
        LOOP
            FETCH det_cursor INTO mov_title, actor_name;
            if NOT found THEN
                exit;
            end if;

            RAISE NOTICE 'Title: %, Actor: %', mov_title, actor_name;
        END LOOP;
        CLOSE det_cursor; 
END $$;

-- Q2. Create a function that returns the number of actors in a given movie.

CREATE OR REPLACE FUNCTION get_count_actor(mov_title movies.title%type)
RETURNS INTEGER
LANGUAGE PLPGSQL
AS $$
    DECLARE 
        count INTEGER := 0;
    BEGIN
        SELECT COUNT(*) INTO count FROM movie_actor
        JOIN movies ON movie_actor.movie_id = movies.movie_id 
        JOIN actors ON actors.actor_id = movie_actor.actor_id
        WHERE movies.title = mov_title;

        if count = 0 THEN
            RAISE NOTICE '% NOT found', mov_title;
        end if;

        RETURN count;
END $$;

DROP FUNCTION get_count_actor;
SELECT get_count_actor('Forrest Gump');

-- Q3. Create a procedure that updates the release year of a movie and logs the change.
CREATE OR REPLACE PROCEDURE update_ry(mov_name movies.title%type, ry movies.release_year%type)
LANGUAGE PLPGSQL
AS $$
    DECLARE
        old_year movies.release_year%type;
    BEGIN
        SELECT release_year INTO old_year FROM movies WHERE title = mov_name;
        UPDATE movies SET release_year = ry WHERE title = mov_name;
        RAISE NOTICE 'Updated release year FROM % TO % OF %', old_year, ry, mov_name;

END $$;

CALL update_ry('The Matrix', 2005);