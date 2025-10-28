set SERVEROUTPUT ON
--scripts para crear las tablas e insertar datos, reusado de la anterior tarea de triggers, si ya tiene las tablas ignorar esta parte
CREATE TABLE Regions (
    region_id NUMBER NOT NULL,
    region_name VARCHAR2(25),
    CONSTRAINT pk_regions PRIMARY KEY (region_id)
);

CREATE TABLE Countries (
    country_id CHAR(2) NOT NULL,
    country_name VARCHAR2(40),
    region_id NUMBER,
    CONSTRAINT pk_countries PRIMARY KEY (country_id),
    CONSTRAINT fk_countries_region FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

CREATE TABLE Locations (
    location_id NUMBER(4) NOT NULL,
    street_address VARCHAR2(40),
    postal_code VARCHAR2(12),
    city VARCHAR2(30) NOT NULL,
    state_province VARCHAR2(25),
    country_id CHAR(2),
    CONSTRAINT pk_locations PRIMARY KEY (location_id),
    CONSTRAINT fk_locations_country FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

CREATE TABLE Departments (
    department_id NUMBER(4) NOT NULL,
    department_name VARCHAR2(30) NOT NULL,
    manager_id NUMBER(6),
    location_id NUMBER(4),
    CONSTRAINT pk_departments PRIMARY KEY (department_id),
    CONSTRAINT fk_departments_location FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

CREATE TABLE Jobs (
    job_id VARCHAR2(10) NOT NULL,
    job_title VARCHAR2(35) NOT NULL,
    min_salary NUMBER(6),
    max_salary NUMBER(6),
    CONSTRAINT pk_jobs PRIMARY KEY (job_id)
);

CREATE TABLE Employees (
    employee_id NUMBER(6) NOT NULL,
    first_name VARCHAR2(20),
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(25) NOT NULL,
    phone_number VARCHAR2(20),
    hire_date DATE NOT NULL,
    job_id VARCHAR2(10) NOT NULL,
    salary NUMBER(8,2),
    commission_pct NUMBER(2,2),
    manager_id NUMBER(6),
    department_id NUMBER(4),
    CONSTRAINT pk_employees PRIMARY KEY (employee_id),
    CONSTRAINT uk_employees_email UNIQUE (email),
    CONSTRAINT fk_employees_job FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
    CONSTRAINT fk_employees_dept FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    CONSTRAINT fk_employees_manager FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Job_History (
    employee_id NUMBER(6) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR2(10) NOT NULL,
    department_id NUMBER(4),
    CONSTRAINT pk_job_history PRIMARY KEY (employee_id, start_date),
    CONSTRAINT fk_job_history_emp FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    CONSTRAINT fk_job_history_job FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
    CONSTRAINT fk_job_history_dept FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    CONSTRAINT ck_job_history_dates CHECK (end_date > start_date)
);

INSERT INTO Regions VALUES (1, 'Europe');
INSERT INTO Regions VALUES (2, 'Americas');
INSERT INTO Regions VALUES (3, 'Asia');
INSERT INTO Regions VALUES (4, 'Middle East and Africa');

INSERT INTO Countries VALUES ('US', 'United States of America', 2);
INSERT INTO Countries VALUES ('CA', 'Canada', 2);
INSERT INTO Countries VALUES ('UK', 'United Kingdom', 1);
INSERT INTO Countries VALUES ('DE', 'Germany', 1);
INSERT INTO Countries VALUES ('BR', 'Brazil', 2);
INSERT INTO Countries VALUES ('IT', 'Italy', 1);
INSERT INTO Countries VALUES ('JP', 'Japan', 3);

INSERT INTO Locations VALUES (1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT');
INSERT INTO Locations VALUES (1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT');
INSERT INTO Locations VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');
INSERT INTO Locations VALUES (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP');
INSERT INTO Locations VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO Locations VALUES (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');

INSERT INTO Departments VALUES (10, 'Administration', 200, 1100);
INSERT INTO Departments VALUES (20, 'Marketing', 201, 1200);
INSERT INTO Departments VALUES (30, 'Purchasing', 114, 1400);
INSERT INTO Departments VALUES (40, 'Human Resources', 203, 1200);
INSERT INTO Departments VALUES (50, 'Shipping', 121, 1500);
INSERT INTO Departments VALUES (60, 'IT', 103, 1400);
INSERT INTO Departments VALUES (70, 'Public Relations', 204, 1500);
INSERT INTO Departments VALUES (80, 'Sales', 145, 1300);
INSERT INTO Departments VALUES (90, 'Executive', 100, 1000);
INSERT INTO Departments VALUES (100, 'Finance', 108, 1500);
INSERT INTO Departments VALUES (110, 'Accounting', 205, 1200);


INSERT INTO Jobs VALUES ('AD_PRES', 'President', 20000, 40000);
INSERT INTO Jobs VALUES ('AD_VP', 'Administration Vice President', 15000, 30000);
INSERT INTO Jobs VALUES ('AD_ASST', 'Administration Assistant', 3000, 6000);
INSERT INTO Jobs VALUES ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
INSERT INTO Jobs VALUES ('FI_MGR', 'Finance Manager', 8200, 16000);
INSERT INTO Jobs VALUES ('FI_ACCOUNT', 'Accountant', 4200, 9000);
INSERT INTO Jobs VALUES ('IT_PROG', 'Programmer', 4000, 10000);
INSERT INTO Jobs VALUES ('ST_CLERK', 'Stock Clerk', 2000, 5000);
INSERT INTO Jobs VALUES ('ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO Jobs VALUES ('HR_REP', 'Human Resources Representative', 4000, 9000);
INSERT INTO Jobs VALUES ('MK_REP', 'Marketing Representative', 4000, 9000);
INSERT INTO Jobs VALUES ('MK_MAN', 'Marketing Manager', 9000, 15000);
INSERT INTO Jobs VALUES ('AC_MGR', 'Accounting Manager', 8200, 16000);

INSERT INTO Employees VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', DATE '1987-06-17', 'AD_PRES', 24000, NULL, NULL, 90);
INSERT INTO Employees VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', DATE '1989-09-21', 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO Employees VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', DATE '1993-01-13', 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO Employees VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', DATE '1990-01-03', 'IT_PROG', 9000, NULL, 102, 60);
INSERT INTO Employees VALUES (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', DATE '1991-05-21', 'IT_PROG', 6000, NULL, 103, 60);
INSERT INTO Employees VALUES (114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', DATE '1994-12-07', 'ST_MAN', 11000, NULL, 100, 30);
INSERT INTO Employees VALUES (121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', DATE '1997-04-10', 'ST_MAN', 8200, NULL, 100, 50);
INSERT INTO Employees VALUES (122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', DATE '1995-05-01', 'ST_MAN', 7900, NULL, 114, 50);
INSERT INTO Employees VALUES (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', DATE '1987-09-17', 'AD_ASST', 4400, NULL, 101, 10);
INSERT INTO Employees VALUES (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', DATE '1996-02-17', 'MK_MAN', 13000, NULL, 100, 20);
INSERT INTO Employees VALUES (203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', DATE '1994-06-07', 'HR_REP', 6500, NULL, 101, 40);
INSERT INTO Employees VALUES (108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', DATE '1994-08-17', 'FI_MGR', 12000, NULL, 101, 100);
INSERT INTO Employees VALUES (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', DATE '1994-06-07', 'AC_MGR', 12000, NULL, 101, 110);
INSERT INTO Employees VALUES (210, 'Ray', 'Max', 'Email', '515.123.4560', DATE '1987-05-20', 'AD_PRES', 24000, NULL, NULL, 80);

INSERT INTO Job_History VALUES (101, DATE '1989-09-21', DATE '1993-10-27', 'AC_ACCOUNT', 110);
INSERT INTO Job_History VALUES (101, DATE '1993-10-28', DATE '1997-03-15', 'AC_MGR', 110);
INSERT INTO Job_History VALUES (102, DATE '1993-01-13', DATE '1998-07-24', 'IT_PROG', 60);
INSERT INTO Job_History VALUES (114, DATE '1998-03-24', DATE '1999-12-31', 'ST_CLERK', 50);
INSERT INTO Job_History VALUES (122, DATE '1999-01-01', DATE '1999-12-31', 'ST_CLERK', 50);
INSERT INTO Job_History VALUES (200, DATE '1987-09-17', DATE '1993-06-17', 'AD_ASST', 90);
INSERT INTO Job_History VALUES (200, DATE '1994-07-01', DATE '1998-12-31', 'AC_ACCOUNT', 100);


--Ejercicio 1 – Control básico de transacciones
SELECT employee_id, first_name, salary FROM employees
WHERE department_id = 90;

UPDATE employees
set salary = salary*1.1
WHERE department_id = 90;
SAVEPOINT punto1;

UPDATE employees
set salary = salary*1.05
WHERE department_id = 60;

ROLLBACK TO punto1;

COMMIT;
/*Preguntas
a. ¿Qué departamento mantuvo los cambios?
Solo el departamento 90 mantuvo los cambios
b. ¿Qué efecto tuvo el ROLLBACK parcial?
El Rollback parcial deshizo el aumento del 5% al departamento 60
c. ¿Qué ocurriría si se ejecutara ROLLBACK sin especificar SAVEPOINT?
Desharía todos los cambios desde el último COMMIT
*/

--2. Ejercicio 2 – Bloqueos entre sesiones
--primera sesion
UPDATE employees
SET salary = salary + 500
WHERE employee_id = 103;
-- segunda sesion
/*UPDATE employees
SET salary = salary + 150
WHERE employee_id = 103;*/

ROLLBACK;

SELECT * FROM employees where employee_id = 103;

/*
Preguntas:
a. ¿Por qué la segunda sesión quedó bloqueada?
La segunda sesión se bloqueó porque la primera tenía un bloqueo exclusivo
b. ¿Qué comando libera los bloqueos?
El commit y el rollback
c. ¿Qué vistas del diccionario permiten verificar sesiones bloqueadas?
Las vistas V$LOCK y V$SESSION
*/

--3. Ejercicio 3 – Transacción controlada con bloque PL/SQL
DECLARE
    v_old_dept NUMBER;
    v_old_job VARCHAR2(10);
    v_hire_date DATE;
BEGIN
    SELECT department_id, job_id, hire_date 
    INTO v_old_dept, v_old_job, v_hire_date
    FROM employees 
    WHERE employee_id = 104;

    UPDATE employees 
    SET department_id = 110 
    WHERE employee_id = 104;
    
    INSERT INTO job_history (
        employee_id, start_date, end_date, job_id, department_id
    ) VALUES (
        104, v_hire_date, SYSDATE, v_old_job, v_old_dept
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transferencia completada exitosamente');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Empleado no encontrado');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error general');
END;
/ 

SELECT * FROM employees where employee_id = 104;
SELECT * FROM job_history;
/*
Preguntas:
a. ¿Por qué se debe garantizar la atomicidad entre las dos operaciones?
Para garantizar que ambas operaciones se completen o ninguna y no se guarden cambios parciales que perjudiquen la integridad y consistencia de los datos 
b. ¿Qué pasaría si se produce un error antes del COMMIT?
El Rollback desharía todos los cambios manteniendo la consistencia
c. ¿Cómo se asegura la integridad entre EMPLOYEES y JOB_HISTORY?
Con transacciones atómicas y manejo de excepciones
*/
-- Ejercicio 4 – SAVEPOINT y reversión parcial
DECLARE
BEGIN
    UPDATE employees 
    SET salary = salary * 1.08 
    WHERE department_id = 100;
    
    SAVEPOINT A;
    
    UPDATE employees 
    SET salary = salary * 1.05 
    WHERE department_id = 80;
    
    SAVEPOINT B;

    DELETE FROM employees 
    WHERE department_id = 50;

    ROLLBACK TO B;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Transacción completada con reversión parcial');
END;
/
SELECT * FROM employees where department_id = 100;
SELECT * FROM employees where department_id = 80;
SELECT * FROM employees where department_id = 50;
/*
Preguntas:
a. ¿Qué cambios quedan persistentes?
Quedan persistentes los aumentos de departamentos 100 y 80
b. ¿Qué sucede con las filas eliminadas?
Las filas eliminadas se restauraron por el Rollback to B
c. ¿Cómo puedes verificar los cambios antes y después del COMMIT?
Consultando las tablas antes o durante la transacción o usando Select con Rollback
*/