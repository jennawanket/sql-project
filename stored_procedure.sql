/*
 * STORED PROCEDURE
 */

DELIMITER $$

DROP PROCEDURE IF EXISTS employee_age_status$$

CREATE PROCEDURE employee_age_status(in_name INT, OUT out_employee_age_status INT)

BEGIN 
	
	SET @employee_first_name := in_name;
	SET @age := NULL;

	PREPARE age_selection FROM
	'	SELECT age INTO @age
		FROM employees
		WHERE first_name=?
	';
	
	EXECUTE age_selection USING @employee_first_name;
	DEALLOCATE PREPARE age_selection;
	SELECT @age
	
	CASE @age
		WHEN < 40 THEN 
			SET out_employee_age_status := 1;
		WHEN = 40 THEN
			SET out_employee_age_status := 0;
		WHEN > 40 THEN
			SET out_employee_age_status := 0;
	END CASE;

END$$

DELIMITER ;

CALL employee_age_status('Tyler', @is_under_40_years_old);
SELECT @is_under_40_years_old;


CALL employee_age_status('Anna', @is_under_40_years_old);
SELECT @is_under_40_years_old;





