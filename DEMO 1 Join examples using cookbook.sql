
USE cookbook;

/* -----------------------------------------------------------
	INNER JOIN Author to Recipe,
	note Author fields are listed first.
	Which table's fields are listed first? - that's the table on the "left" */
SELECT * 
	FROM author AS a 
		INNER JOIN recipe AS r ON r.authorId = a.authorId
	ORDER BY a.authorId, r.recipeId;


/*	INNER JOIN reverse Recipe to Author,
	note recipe fields are listed first.
	Which table's fields are listed first? - that's the table on the "left" */
SELECT * 
	FROM recipe AS r 
		INNER JOIN author AS a ON a.authorId = r.authorId
	ORDER BY r.recipeId, a.authorId;

/*	"Old way" INNER JOIN Author to Recipe */
SELECT * 
	FROM author AS a ,
		recipe AS r 
	WHERE r.authorId = a.authorId;

/* -----------------------------------------------------------
	CROSS JOIN example
	# authors X # recipes = MANY rows returned - repetative data */

SELECT *
	FROM [dbo].[author] AS a
		CROSS JOIN [dbo].[recipe] AS r;

/*	"old way" = prone to errors */
SELECT *
	FROM [dbo].[author] AS a, 
		[dbo].[recipe] AS r;

/* -----------------------------------------------------------
	Multiple table joins 
	join author to recipe to see which authors wrote about cake */
SELECT a.firstname, r.recipeName
	FROM author AS a
		INNER JOIN recipe AS r ON r.authorId = a.authorId
	WHERE r.recipeName LIKE '%cake%';

/* -----------------------------------------------------------
	Multiple table joins 
	join author to recipe to ingredients 
	in order to see which authors used an ingredient with eggs
	There is no direct relationship between author and ingredient 
	  so we have to go through Recipe. */
SELECT a.firstname, r.recipeName, i.ingredient
	FROM author AS a
		INNER JOIN recipe AS r ON r.authorId = a.authorId
		INNER JOIN ingredient AS i ON i.recipeId = r.recipeId
	WHERE i.ingredient LIKE '%egg%';

/* -----------------------------------------------------------
	LEFT JOIN recipe to multimedia 
	multimedia has none, 1, many records per recipe.
	Notice that the multimedia columns are NULL where there are no matches to recipes */
SELECT *
	FROM recipe AS r
		LEFT JOIN multimedia AS m ON m.recipeId = r.recipeId;

/* LEFT JOIN Author to "bad" table of recipes 
   (because not all people have recipes and there is an orphaned recipe record - no author!)
	Notice that the bad recipe table columns are NULL where there are no matches to recipes
	all Authors are represented 
	the orphan recipe is not showing */
SELECT *
	FROM Author AS a
		LEFT JOIN bad AS Recipe ON Recipe.authorID = a.authorID;

/* RIGHT JOIN Author to bad recipe table
	bad recipe table has none or 1 record per author.
	Notice that the author table columns are NULL where there are no matches to a bad recipe record.
	There are only record for the bad recipe table rows... 
	not all the authors are represented */
SELECT *
	FROM Author AS a
		RIGHT JOIN bad AS recipe ON Recipe.authorID = a.authorID;

/* FULL JOIN recipe 
	All recipe records are represented 
	AND all bad table records are represented (have no matching recipe).
	NULLs on both "sides". */
SELECT *
	FROM Author AS a
		FULL JOIN bad AS recipe ON Recipe.authorID = a.authorID;

/* CROSS JOIN of recipe and bad 
	just to see the difference between CROSS JOIN and FULL JOIN */
SELECT * 
	FROM Author AS a
		CROSS JOIN bad AS recipe;

/* -----------------------------------------------------------
	Which recipes are represented in the multimedia table? 
	efficient way */
SELECT *
	FROM recipe AS r
		INNER JOIN multimedia as m ON m.recipeId = r.recipeId; -- could have just used "JOIN"
		
/* Which recipes are represented in the multimedia table? 
	inefficient way using LEFT JOIN and a WHERE of NULL */
SELECT *
	FROM recipe AS r
		LEFT JOIN multimedia as m ON m.recipeId = r.recipeId
	WHERE m.recipeId IS NOT NULL;

/* Which recipes do not have multimedia files? */
SELECT r.recipeID, r.authorID, r.categoryId, r.recipeName, r.instructions
	, r.createdDate, m.multimediaId, m.recipeId AS Expr1, m.[StoredAsFilename]
	, Author.firstName, author.lastName
	FROM Recipe AS r INNER JOIN
		Author ON r.authorID = Author.authorID LEFT OUTER JOIN
		multimedia AS m ON m.recipeId = r.recipeID
	WHERE (m.[StoredAsFilename] IS NULL)

/* So which recipes are not represented in the multimedia table? 
	"different" way - nested select.
	Using a NOT IN where the list of items for the NOT IN is a table! */
SELECT *
	FROM recipe AS r
	WHERE r.recipeId NOT IN (
			SELECT recipeId
			FROM multimedia);

