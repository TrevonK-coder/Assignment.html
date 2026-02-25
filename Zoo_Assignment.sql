/* Zoo Database Assignment 1 
   Task: Compose a SELECT statement that returns all data in the habitat table.
*/

SELECT * FROM tbl_habitat;
/* Zoo Database Assignment 2 
   Task: Retrieve only the habitat_name and habitat_size from the habitat table.
*/
SELECT habitat_name, habitat_size FROM tbl_habitat;
/* Zoo Database Assignment 3 
   Task: Retrieve only the types from the column nutrition_type of the tbl_nutrition table 
   that have a nutrition_cost of 600.00 or less.
*/

SELECT nutrition_type 
FROM tbl_nutrition 
WHERE nutrition_cost <= 600.00;
/* Zoo Database Assignment 4 
   Task: Retrieve all species_names from tbl_species that have a 
   nutrition_id between 2202 and 2206 using an INNER JOIN with tbl_nutrition.
*/

SELECT tbl_species.species_name
FROM tbl_species
INNER JOIN tbl_nutrition ON tbl_species.species_nutrition = tbl_nutrition.nutrition_id
WHERE tbl_nutrition.nutrition_id BETWEEN 2202 AND 2206;