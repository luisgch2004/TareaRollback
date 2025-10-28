--SELECT * FROM employees where employee_id = 103;
--segunda sesion
UPDATE employees
SET salary = salary + 150
WHERE employee_id = 103;
--commit para desbloquear la primera sesion
COMMIT;