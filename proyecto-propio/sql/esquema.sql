-- Creación de entidades fuertes sin claves foráneas
CREATE TABLE CATEGORIA (
    ID_Categoria INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Nivel_Prioridad INT NOT NULL
);

CREATE TABLE EMPLEADO (
    ID_Empleado INT PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Turno VARCHAR(50) NOT NULL,
    Certificacion_Montacargas BOOLEAN NOT NULL
);

CREATE TABLE UBICACION (
    ID_Ubicacion INT PRIMARY KEY,
    Zona VARCHAR(20) NOT NULL,
    Pasillo VARCHAR(20) NOT NULL,
    Rack VARCHAR(20) NOT NULL,
    Nivel VARCHAR(20) NOT NULL,
    Capacidad_Peso_Kg NUMERIC(10, 2) NOT NULL,
    Tipo_Almacenaje VARCHAR(50) NOT NULL
);

-- Creación del supertipo PRODUCTO
CREATE TABLE PRODUCTO (
    SKU VARCHAR(50) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Largo_cm NUMERIC(8, 2) NOT NULL,
    Ancho_cm NUMERIC(8, 2) NOT NULL,
    Alto_cm NUMERIC(8, 2) NOT NULL,
    Peso_Kg NUMERIC(8, 2) NOT NULL,
    ID_Categoria INT NOT NULL,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (ID_Categoria)
        REFERENCES CATEGORIA(ID_Categoria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Creación de subtipos
CREATE TABLE PIEZA_SOLIDA (
    SKU VARCHAR(50) PRIMARY KEY,
    Material_Fabricacion VARCHAR(100) NOT NULL,
    Fragil BOOLEAN NOT NULL,
    CONSTRAINT fk_pieza_producto FOREIGN KEY (SKU)
        REFERENCES PRODUCTO(SKU)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE FLUIDO_QUIMICO (
    SKU VARCHAR(50) PRIMARY KEY,
    Volumen_Mililitros NUMERIC(10, 2) NOT NULL,
    Nivel_Inflamabilidad INT NOT NULL,
    Requiere_Refrigeracion BOOLEAN NOT NULL,
    CONSTRAINT fk_fluido_producto FOREIGN KEY (SKU)
        REFERENCES PRODUCTO(SKU)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Creación de entidades con dependencias y relaciones
CREATE TABLE ORDEN_SALIDA (
    ID_Orden INT PRIMARY KEY,
    Fecha_Emision TIMESTAMP NOT NULL,
    Estatus VARCHAR(50) NOT NULL,
    ID_Empleado INT NOT NULL,
    CONSTRAINT fk_orden_empleado FOREIGN KEY (ID_Empleado)
        REFERENCES EMPLEADO(ID_Empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE DETALLE_ORDEN (
    ID_Orden INT NOT NULL,
    Numero_Linea INT NOT NULL,
    SKU VARCHAR(50) NOT NULL,
    Cantidad_Pedida INT NOT NULL,
    PRIMARY KEY (ID_Orden, Numero_Linea),
    CONSTRAINT fk_detalle_orden FOREIGN KEY (ID_Orden)
        REFERENCES ORDEN_SALIDA(ID_Orden)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (SKU)
        REFERENCES PRODUCTO(SKU)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE INVENTARIO_FISICO (
    SKU VARCHAR(50) NOT NULL,
    ID_Ubicacion INT NOT NULL,
    ID_Inventario INT NOT NULL,
    Cantidad INT NOT NULL,
    Fecha_Ingreso DATE NOT NULL,
    PRIMARY KEY (SKU, ID_Inventario),
    CONSTRAINT fk_inventario_producto FOREIGN KEY (SKU)
        REFERENCES PRODUCTO(SKU)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_inventario_ubicacion FOREIGN KEY (ID_Ubicacion)
        REFERENCES UBICACION(ID_Ubicacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);