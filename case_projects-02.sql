-- Case 4-2: Working with More Movie Rentals
-- Because business is growing and the movie stock is increasing at More Movie Rentals, the
-- manager wants to do more inventory evaluations. One item of interest is any movie with a total
-- stock value of $75 or more. The manager wants to focus on the revenue these movies are
-- generating to make sure the stock level is warranted. To make these stock queries more
-- efficient, the application team decides to add a column named STK_FLAG to the MM_MOVIE
-- table that stores an asterisk (*) if the stock value is $75 or more. Otherwise, the value should
-- be NULL. Add the column and create an anonymous block containing a CURSOR FOR loop to
-- perform this task. The company plans to run this program monthly to update the STK_FLAG
-- column before the inventory evaluation.
-- Add the STK_FLAG column to the MM_MOVIE table
ALTER TABLE mm_movie ADD STK_FLAG VARCHAR(1);

-- Create an anonymous PL/SQL block to update the STK_FLAG column
DECLARE
  v_movie_id    mm_movie.movie_id%TYPE;
  v_movie_value mm_movie.movie_value%TYPE;
BEGIN
 -- Cursor to fetch movie_id and movie_value
  FOR movie_rec IN (
    SELECT
      movie_id,
      movie_value
    FROM
      mm_movie
  ) LOOP
    v_movie_id := movie_rec.movie_id;
    v_movie_value := movie_rec.movie_value;
 -- Update STK_FLAG based on the condition
    IF v_movie_value >= 75 THEN
      UPDATE mm_movie
      SET
        STK_FLAG = '*'
      WHERE
        movie_id = v_movie_id;
    ELSE
      UPDATE mm_movie
      SET
        STK_FLAG = NULL
      WHERE
        movie_id = v_movie_id;
    END IF;
  END LOOP;

  COMMIT; -- Commit the changes
END;
/
