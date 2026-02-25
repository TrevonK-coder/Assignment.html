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