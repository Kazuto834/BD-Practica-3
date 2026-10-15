-- 1. Falla por violar la restricción NOT NULL (Falta nombre de categoría)
INSERT INTO CATEGORIA (ID_Categoria, Nivel_Prioridad) VALUES (1, 5);

-- 2. Falla por violar la integridad referencial (FK) (Categoría inexistente)
INSERT INTO PRODUCTO (SKU, Nombre, Largo_cm, Ancho_cm, Alto_cm, Peso_Kg, ID_Categoria) 
VALUES ('SKU001', 'Motor de Arranque', 15.0, 10.0, 10.0, 5.5, 999);

-- 3. Falla por violar la clave primaria (Duplicidad de PK)
INSERT INTO EMPLEADO (ID_Empleado, Nombre, Turno, Certificacion_Montacargas) 
VALUES (1, 'Juan Perez', 'Matutino', TRUE);
INSERT INTO EMPLEADO (ID_Empleado, Nombre, Turno, Certificacion_Montacargas) 
VALUES (1, 'Maria Lopez', 'Vespertino', FALSE);