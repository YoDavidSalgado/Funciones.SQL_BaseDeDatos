CREATE DATABASE Funciones;
USE Funciones;

CREATE TABLE Empleados (
	cedula int PRIMARY KEY,
    nombre varchar(100),
    salario_basico decimal(20, 2),
    subsidio decimal(10, 2),
    salud decimal(10, 2),
    pension decimal(10, 2),
    bono decimal(10, 2),
    salario_integral decimal(10, 2)
);

INSERT INTO Empleados (cedula, nombre, salario_basico, subsidio, salud, pension, bono, salario_integral)
VALUES
	  (1020435678, 'David Salgado', 6540.14, 140.08, 30.34, 45.23, 123.45, 3244.45),
    (1020435680, 'Brayan Salgado', 4567.14, 150.08, 35.34, 47.23, 321.45, 5432.45),
    (1020435656, 'Dayana Salgado', 3241.14, 160.08, 34.34, 48.23, 432.45, 6543.45);
    
SELECT * FROM Empleados;

DROP PROCEDURE IF EXISTS CalcularSubsidioTransporte;

DELIMITER //
CREATE PROCEDURE CalcularSubsidioTransporte(IN salario_basico DECIMAL(10, 2))
BEGIN
    DECLARE subsidio DECIMAL(10, 2);
    SET subsidio = salario_basico * 0.07;
    SELECT subsidio;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CalcularSalud(IN salario_basico DECIMAL(10, 2))
BEGIN
	DECLARE salud DECIMAL(10, 2);
	SET salud = salario_basico * 0.04;
	SELECT salud;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CalcularPension(IN salario_basico DECIMAL(10, 2))
BEGIN
	DECLARE pension DECIMAL(10, 2);
	SET pension = salario_basico * 0.04;
	SELECT pension;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CalcularBono(IN salario_basico DECIMAL(10, 2))
BEGIN
	DECLARE bono DECIMAL(10, 2);
	SET bono = salario_basico * 0.08;
	SELECT bono;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS CalcularSalarioIntegral;

DELIMITER //
CREATE PROCEDURE CalcularSalarioIntegral(IN salario_basico DECIMAL(10, 2))
BEGIN
	  DECLARE subsidio_transporte DECIMAL(10, 2);
    DECLARE salud DECIMAL(10, 2);
    DECLARE pension DECIMAL(10, 2);
    DECLARE bono DECIMAL(10, 2);
    DECLARE salario_integral DECIMAL(10, 2);
    
	  SET subsidio_transporte = salario_basico * 0.07;
    SET salud = salario_basico * 0.04;
    SET pension = salario_basico * 0.04;
    SET bono = salario_basico * 0.08;
    
	  SET salario_integral = salario_basico - salud - pension + bono + subsidio_transporte;
    
    SELECT subsidio_transporte, salud, pension, bono, salario_integral;
END//
DELIMITER ;

CALL CalcularSubsidioTransporte(100000);
CALL CalcularSalud(100000);
CALL CalcularPension(100000);
CALL CalcularBono(100000);
CALL CalcularSalarioIntegral(100000);

DROP FUNCTION IF EXISTS CalcularSubsidioTransporte;

DELIMITER //
CREATE FUNCTION CalcularSubsidioTransporte(salario_basico DECIMAL(10, 2)) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE subsidio DECIMAL(10, 2);
    SET subsidio = salario_basico * 0.07;
    RETURN subsidio;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS CalcularSalud;

DELIMITER //
CREATE FUNCTION CalcularSalud(salario_basico DECIMAL(10, 2)) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE salud DECIMAL(10, 2);
    SET salud = salario_basico * 0.04;
    RETURN salud;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS CalcularPension;

DELIMITER //
CREATE FUNCTION CalcularPension(salario_basico DECIMAL(10, 2)) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE pension DECIMAL(10, 2);
    SET pension = salario_basico * 0.04;
    RETURN pension;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS CalcularBono;

DELIMITER //
CREATE FUNCTION CalcularBono(salario_basico DECIMAL(10, 2)) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE bono DECIMAL(10, 2);
    SET bono = salario_basico * 0.08;
    RETURN bono;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS CalcularSalarioIntegral;

DELIMITER //
CREATE FUNCTION CalcularSalarioIntegral(salario_basico DECIMAL(10, 2)) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE subsidio_transporte DECIMAL(10, 2);
    DECLARE salud DECIMAL(10, 2);
    DECLARE pension DECIMAL(10, 2);
    DECLARE bono DECIMAL(10, 2);
    DECLARE salario_integral DECIMAL(10, 2);
    
    SET subsidio_transporte = salario_basico * 0.07;
    SET salud = salario_basico * 0.04;
    SET pension = salario_basico * 0.04;
    SET bono = salario_basico * 0.08;
    
    SET salario_integral = salario_basico - salud - pension + bono + subsidio_transporte;
    
    RETURN salario_integral;
END//
DELIMITER ;

SELECT CalcularSubsidioTransporte(100000);
SELECT CalcularSalud(100000);
SELECT CalcularPension(100000);
SELECT CalcularBono(100000);
SELECT CalcularSalarioIntegral(100000);
