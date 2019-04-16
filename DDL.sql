-- Creando la tabla para la relacion de Producto
CREATE TABLE producto (
    codigo_barras NUMBER(20),
    precio NUMBER(10),
    presentacion VARCHAR(100),
    cantidad NUMBER(10),
    es_refrigerado NUMBER(1),
    marca VARCHAR(100)
);

ALTER TABLE producto 
    ADD CONSTRAINT pk_producto
    PRIMARY KEY (codigo_barras);
    
-- Creando tabla para la relacón de Medicamento
CREATE TABLE medicamento (
    id_prod NUMBER(10),
    nombre VARCHAR(100),
    laboratorio VARCHAR(100),
    dosis NUMBER(10),
    esControlado NUMBER(1)
);
    
ALTER TABLE medicamento
    ADD CONSTRAINT pk_medicamento
    PRIMARY KEY (nombre, laboratorio);
    
ALTER TABLE medicamento
    ADD CONSTRAINT fk_producto
    FOREIGN KEY (id_prod)
    REFERENCES producto(codigo_barras);
    
-- Creando tabla para la relación Compuestos
CREATE TABLE compuestos (
    sustancia VARCHAR(100),
    nombre VARCHAR(100),
    laboratorio VARCHAR(100)
);

ALTER TABLE compuestos 
    ADD CONSTRAINT fk_medicamento
    FOREIGN KEY (nombre, laboratorio)
    REFERENCES medicamento(nombre, laboratorio);
    
-- Creando la tabla para la relación de Lote
CREATE TABLE lote (
    codigo_barras NUMBER(20),
    id_produccion NUMBER(10),
    fecha_cad DATE
);

ALTER TABLE lote
    ADD CONSTRAINT fk_cod_barr
    FOREIGN KEY (codigo_barras)
    REFERENCES producto(codigo_barras);
    
ALTER TABLE lote
    ADD CONSTRAINT pk_lote
    PRIMARY KEY (id_produccion);
    
-- Creando tabla para la relación de Tipo Departamento
CREATE TABLE tipo_departamento (
    tipo VARCHAR(100),
    descripcion VARCHAR(500)
);

ALTER TABLE tipo_departamento
    ADD CONSTRAINT pk_tipo_dep
    PRIMARY KEY (tipo);
    
-- Creando la tabla para la relación de Sucursal
CREATE TABLE sucursal (
    id_sucursal NUMBER(10),
    fecha_func DATE,
    calle VARCHAR(100),
    numero NUMBER(10),
    cp NUMBER(5),
    estado VARCHAR(15)
);

ALTER TABLE sucursal  
    ADD CONSTRAINT pk_sucursal
    PRIMARY KEY (id_sucursal);
    
-- Creando tabla para teléfono de sucursales
CREATE TABLE telefono_sucursal (
    num_tel NUMBER(10),
    id_sucursal NUMBER(10)
);

ALTER TABLE telefono_sucursal
    ADD CONSTRAINT fk_sucursal
    FOREIGN KEY (id_sucursal)
    REFERENCES sucursal(id_sucursal);
    
-- Creando tabla para la relación de Tener Departamento
CREATE TABLE tener_departamento (
    id_suc NUMBER(10),
    id_tipo VARCHAR(100)
);

ALTER TABLE tener_departamento 
    ADD CONSTRAINT ck_tener_departamento
    UNIQUE (id_suc, id_tipo);

ALTER TABLE tener_departamento
    ADD CONSTRAINT fk_suc
    FOREIGN KEY (id_suc)
    REFERENCES sucursal(id_sucursal);
    
ALTER TABLE tener_departamento
    ADD CONSTRAINT fk_tipo_dep
    FOREIGN KEY (id_tipo)
    REFERENCES tipo_departamento(tipo);
    
-- Creando la tabla para la relacion de Persona
CREATE TABLE persona (
    curp VARCHAR(18),
    nombre VARCHAR(100),
    apellido_p VARCHAR(100),
    apellido_m VARCHAR(100),
    fecha_nac DATE
);

ALTER TABLE persona
    ADD CONSTRAINT pk_persona
    PRIMARY KEY (curp);

-- Creando tabla para teléfono de personas
CREATE TABLE telefono_persona (
    num_tel NUMBER(10),
    curp VARCHAR(12)
);

ALTER TABLE telefono_persona 
    ADD CONSTRAINT fk_persona
    FOREIGN KEY (curp)
    REFERENCES persona(curp);
    
-- Creando table para la relacion Cliente
CREATE TABLE cliente (
    id_cliente NUMBER(10),
    calle VARCHAR(100),
    numero_ext VARCHAR(10),
    numero_int VARCHAR(10),
    cp NUMBER(5),
    curp VARCHAR(18)
);

ALTER TABLE cliente
    ADD CONSTRAINT pk_cliente
    PRIMARY KEY (id_cliente);
    
ALTER TABLE cliente
    ADD CONSTRAINT fk_persona_cl
    FOREIGN KEY (curp)
    REFERENCES persona(curp);

-- Creando tabla para Tarjeta
CREATE TABLE tarjeta (
    num_tarjeta NUMBER(10),
    id_cliente NUMBER(10)
);

ALTER TABLE tarjeta 
    ADD CONSTRAINT pk_tarjeta
    PRIMARY KEY (num_tarjeta);
    
ALTER TABLE tarjeta
    ADD CONSTRAINT fk_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente);
    
    
-- Creando tabla para E-mail de los clientes
CREATE TABLE email (
    id_cliente NUMBER(10),
    email VARCHAR(20)
);

ALTER TABLE email
    ADD CONSTRAINT fk_cliente_mail
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente);

-- Tabla para la relación Horario
CREATE TABLE horario (
    id_tipo_dep VARCHAR(100),
    puesto VARCHAR(80),
    hora_entrada NUMBER(10),
    hora_salida NUMBER(10)
);

ALTER TABLE horario
    ADD CONSTRAINT pk_horario
    PRIMARY KEY (id_tipo_dep, puesto);

ALTER TABLE horario
    ADD CONSTRAINT fk_id_tipo_dep_hor
    FOREIGN KEY (id_tipo_dep)
    REFERENCES tipo_departamento(tipo);


-- Creando tabla para la relación Sueldo
CREATE TABLE sueldo (
    id_tipo_dep VARCHAR(100),
    puesto VARCHAR(80),
    registro DATE,
    sueldo NUMBER(10)
);

ALTER TABLE sueldo
    ADD CONSTRAINT fk_tipo_dep_sueldo
    FOREIGN KEY (id_tipo_dep)
    REFERENCES tipo_departamento(tipo);

ALTER TABLE sueldo
    ADD CONSTRAINT fk_tipo_puesto
    FOREIGN KEY (id_tipo_dep, puesto)
    REFERENCES horario(id_tipo_dep, puesto);
    
ALTER TABLE sueldo
    ADD CONSTRAINT pk_sueldo
    PRIMARY KEY (id_tipo_dep, puesto, registro);

    
-- Creando la tabla para la relacion de Empleado
CREATE TABLE empleado (
    id_empleado NUMBER(10),
    curp VARCHAR(18),
    tipo_dep VARCHAR(100),
    puesto VARCHAR(80),
    registro DATE
);

ALTER TABLE empleado
    ADD CONSTRAINT pk_empleado
    PRIMARY KEY (id_empleado);

ALTER TABLE empleado
    ADD CONSTRAINT fk_persona_empl
    FOREIGN KEY (curp)
    REFERENCES persona(curp);

ALTER TABLE empleado
    ADD CONSTRAINT fk_tipo_dep_empl
    FOREIGN KEY (tipo_dep)
    REFERENCES tipo_departamento(tipo);

ALTER TABLE empleado
    ADD CONSTRAINT fk_puesto_reg_empl
    FOREIGN KEY (tipo_dep, puesto, registro)
    REFERENCES sueldo(id_tipo_dep, puesto, registro);

-- Creando la tabla para la relación de Trabajar
CREATE TABLE trabajar (
    id_suc NUMBER(10),
    id_empleado NUMBER(10)
);

ALTER TABLE trabajar
    ADD CONSTRAINT fk_suc_trabajar
    FOREIGN KEY (id_suc)
    REFERENCES sucursal(id_sucursal);
    
ALTER TABLE trabajar
    ADD CONSTRAINT fk_empleado_trabajar
    FOREIGN KEY (id_empleado)
    REFERENCES empleado(id_empleado);
   
-- Creando la tabla para la relación de Dirigir sucursal
CREATE TABLE dirigir (
    id_suc NUMBER(10),
    id_empleado NUMBER(10)
);

ALTER TABLE dirigir
    ADD CONSTRAINT fk_suc_dirigir
    FOREIGN KEY (id_suc)
    REFERENCES sucursal(id_sucursal);
    
ALTER TABLE dirigir
    ADD CONSTRAINT fk_empleado_dirigir
    FOREIGN KEY (id_empleado)
    REFERENCES empleado(id_empleado);
    
-- Creando la tabla para la relación de Supervisar
CREATE TABLE supervisar (
    id_empleado NUMBER(10),
    id_suc NUMBER(10),
    id_tipo_dep VARCHAR(100)
);

ALTER TABLE supervisar 
    ADD CONSTRAINT fk_empleado_supervisar
    FOREIGN KEY (id_empleado)
    REFERENCES empleado (id_empleado);
    
ALTER TABLE supervisar
    ADD CONSTRAINT fk_dep_supervisar
    FOREIGN KEY (id_suc, id_tipo_dep)
    REFERENCES tener_departamento(id_suc, id_tipo);
    
-- Creando tabla para Venta
CREATE TABLE venta (
    id_venta NUMBER(10),
    fecha DATE,
    num_tarjeta NUMBER(10),
    id_empleado NUMBER(10)
);

ALTER TABLE venta
    ADD CONSTRAINT pk_venta
    PRIMARY KEY (id_venta);
    
ALTER TABLE venta
    ADD CONSTRAINT fk_empleado_venta
    FOREIGN KEY (id_empleado)
    REFERENCES empleado(id_empleado);
    
ALTER TABLE venta
    ADD CONSTRAINT fk_tarj_venta
    FOREIGN KEY (num_tarjeta)
    REFERENCES tarjeta(num_tarjeta);

-- Creando la tabla para la relación de Tipo de Pago
CREATE TABLE tipo_pago (
    num_transac NUMBER(10),
    id_venta NUMBER(10)
);

ALTER TABLE tipo_pago
    ADD CONSTRAINT fk_venta_pago
    FOREIGN KEY (id_venta)
    REFERENCES venta(id_venta);

ALTER TABLE tipo_pago
    ADD CONSTRAINT pk_tipo_pago
    PRIMARY KEY (num_transac);

-- Creando la tabla para la relación de Método de Pago
CREATE TABLE metodo_pago (
    importe NUMBER(10),
    medio NUMBER(10),
    num_transac NUMBER(10),
    num_tarjeta NUMBER(10)
);

ALTER TABLE metodo_pago
    ADD CONSTRAINT fk_trans
    FOREIGN KEY (num_transac)
    REFERENCES tipo_pago(num_transac);
    
ALTER TABLE metodo_pago
    ADD CONSTRAINT fk_tarj_met_pago
    FOREIGN KEY (num_tarjeta)
    REFERENCES tarjeta(num_tarjeta);
    
-- Creando la tabla para Ticket
CREATE TABLE ticket (
    id_ticket NUMBER(10),
    id_venta NUMBER(10)
);

ALTER TABLE ticket
    ADD CONSTRAINT pk_ticket
    PRIMARY KEY (id_ticket);
    
ALTER TABLE ticket
    ADD CONSTRAINT fk_venta_ticket
    FOREIGN  KEY (id_venta)
    REFERENCES venta(id_venta);

-- Creando tabla para la relación de canjear ticket
CREATE TABLE canjear_ticket (
    fecha DATE,
    id_ticket NUMBER(10),
    id_cliente NUMBER(10)
);

ALTER TABLE canjear_ticket
    ADD CONSTRAINT fk_ticket
    FOREIGN KEY (id_ticket)
    REFERENCES ticket(id_ticket);
    
ALTER TABLE canjear_ticket
    ADD CONSTRAINT fk_cliente_canjear
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente);
   
-- Creando tabla para la relación de Instancia Producto
CREATE TABLE instancia_producto (
    id_producto NUMBER(10),
    codigo_barras NUMBER(20),
    id_produccion NUMBER(10),
    id_departamento VARCHAR(100),
    id_venta NUMBER(10),
    descripcion VARCHAR(100)
);

ALTER TABLE instancia_producto
    ADD CONSTRAINT pk_inst_prod
    PRIMARY KEY (id_producto);
    
ALTER TABLE instancia_producto
    ADD CONSTRAINT fk_cod_barr_inst_prod
    FOREIGN KEY (codigo_barras)
    REFERENCES producto(codigo_barras);
    
ALTER TABLE instancia_producto
    ADD CONSTRAINT fk_id_produc_inst_prod
    FOREIGN KEY (id_produccion)
    REFERENCES lote(id_produccion);
    
ALTER TABLE instancia_producto
    ADD CONSTRAINT fk_id_dep_inst_prod
    FOREIGN KEY (id_departamento)
    REFERENCES tipo_departamento(tipo);
    
ALTER TABLE instancia_producto
    ADD CONSTRAINT fk_venta
    FOREIGN KEY (id_venta)
    REFERENCES venta(id_venta);
    -- Creando la tabla para la relacion de Producto
CREATE TABLE producto (
    codigo_barras NUMBER(20),
    precio NUMBER(10),
    presentacion VARCHAR(100),
    cantidad NUMBER(10),
    es_refrigerado NUMBER(1),
    marca VARCHAR(100)
);

ALTER TABLE producto 
    ADD CONSTRAINT pk_producto
    PRIMARY KEY (codigo_barras);
    
-- Creando tabla para la relacón de Medicamento
CREATE TABLE medicamento (
    id_prod NUMBER(10),
    nombre VARCHAR(100),
    laboratorio VARCHAR(100),
    dosis NUMBER(10),
    esControlado NUMBER(1)
);
    
ALTER TABLE medicamento
    ADD CONSTRAINT pk_medicamento
    PRIMARY KEY (nombre, laboratorio);
    
ALTER TABLE medicamento
    ADD CONSTRAINT fk_producto
    FOREIGN KEY (id_prod)
    REFERENCES producto(codigo_barras);
    
-- Creando tabla para la relación Compuestos
CREATE TABLE compuestos (
    sustancia VARCHAR(100),
    nombre VARCHAR(100),
    laboratorio VARCHAR(100)
);

ALTER TABLE compuestos 
    ADD CONSTRAINT fk_medicamento
    FOREIGN KEY (nombre, laboratorio)
    REFERENCES medicamento(nombre, laboratorio);
    
-- Creando la tabla para la relación de Lote
CREATE TABLE lote (
    codigo_barras NUMBER(20),
    id_produccion NUMBER(10),
    fecha_cad DATE
);

ALTER TABLE lote
    ADD CONSTRAINT fk_cod_barr
    FOREIGN KEY (codigo_barras)
    REFERENCES producto(codigo_barras);
    
ALTER TABLE lote
    ADD CONSTRAINT pk_lote
    PRIMARY KEY (id_produccion);
    
-- Creando tabla para la relación de Tipo Departamento
CREATE TABLE tipo_departamento (
    tipo VARCHAR(100),
    descripcion VARCHAR(500)
);

ALTER TABLE tipo_departamento
    ADD CONSTRAINT pk_tipo_dep
    PRIMARY KEY (tipo);
    
-- Creando la tabla para la relación de Sucursal
CREATE TABLE sucursal (
    id_sucursal NUMBER(10),
    fecha_func DATE,
    calle VARCHAR(100),
    numero NUMBER(10),
    cp NUMBER(5),
    estado VARCHAR(15)
);

ALTER TABLE sucursal  
    ADD CONSTRAINT pk_sucursal
    PRIMARY KEY (id_sucursal);
    
-- Creando tabla para teléfono de sucursales
CREATE TABLE telefono_sucursal (
    num_tel NUMBER(10),
    id_sucursal NUMBER(10)
);

ALTER TABLE telefono_sucursal
    ADD CONSTRAINT fk_sucursal
    FOREIGN KEY (id_sucursal)
    REFERENCES sucursal(id_sucursal);
    
-- Creando tabla para la relación de Tener Departamento
CREATE TABLE tener_departamento (
    id_suc NUMBER(10),
    id_tipo VARCHAR(100)
);

ALTER TABLE tener_departamento 
    ADD CONSTRAINT ck_tener_departamento
    UNIQUE (id_suc, id_tipo);

ALTER TABLE tener_departamento
    ADD CONSTRAINT fk_suc
    FOREIGN KEY (id_suc)
    REFERENCES sucursal(id_sucursal);
    
ALTER TABLE tener_departamento
    ADD CONSTRAINT fk_tipo_dep
    FOREIGN KEY (id_tipo)
    REFERENCES tipo_departamento(tipo);
    
-- Creando la tabla para la relacion de Persona
CREATE TABLE persona (
    curp VARCHAR(18),
    nombre VARCHAR(100),
    apellido_p VARCHAR(100),
    apellido_m VARCHAR(100),
    fecha_nac DATE
);

ALTER TABLE persona
    ADD CONSTRAINT pk_persona
    PRIMARY KEY (curp);

-- Creando tabla para teléfono de personas
CREATE TABLE telefono_persona (
    num_tel NUMBER(10),
    curp VARCHAR(12)
);

ALTER TABLE telefono_persona 
    ADD CONSTRAINT fk_persona
    FOREIGN KEY (curp)
    REFERENCES persona(curp);
    
-- Creando table para la relacion Cliente
CREATE TABLE cliente (
    id_cliente NUMBER(10),
    calle VARCHAR(100),
    numero_ext VARCHAR(10),
    numero_int VARCHAR(10),
    cp NUMBER(5),
    curp VARCHAR(18)
);

ALTER TABLE cliente
    ADD CONSTRAINT pk_cliente
    PRIMARY KEY (id_cliente);
    
ALTER TABLE cliente
    ADD CONSTRAINT fk_persona_cl
    FOREIGN KEY (curp)
    REFERENCES persona(curp);

-- Creando tabla para Tarjeta
CREATE TABLE tarjeta (
    num_tarjeta NUMBER(10),
    id_cliente NUMBER(10)
);

ALTER TABLE tarjeta 
    ADD CONSTRAINT pk_tarjeta
    PRIMARY KEY (num_tarjeta);
    
ALTER TABLE tarjeta
    ADD CONSTRAINT fk_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente);
    
    
-- Creando tabla para E-mail de los clientes
CREATE TABLE email (
    id_cliente NUMBER(10),
    email VARCHAR(20)
);

ALTER TABLE email
    ADD CONSTRAINT fk_cliente_mail
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente);

-- Tabla para la relación Horario
CREATE TABLE horario (
    id_tipo_dep VARCHAR(100),
    puesto VARCHAR(80),
    hora_entrada NUMBER(10),
    hora_salida NUMBER(10)
);

ALTER TABLE horario
    ADD CONSTRAINT pk_horario
    PRIMARY KEY (id_tipo_dep, puesto);

ALTER TABLE horario
    ADD CONSTRAINT fk_id_tipo_dep_hor
    FOREIGN KEY (id_tipo_dep)
    REFERENCES tipo_departamento(tipo);


-- Creando tabla para la relación Sueldo
CREATE TABLE sueldo (
    id_tipo_dep VARCHAR(100),
    puesto VARCHAR(80),
    registro DATE,
    sueldo NUMBER(10)
);

ALTER TABLE sueldo
    ADD CONSTRAINT fk_tipo_dep_sueldo
    FOREIGN KEY (id_tipo_dep)
    REFERENCES tipo_departamento(tipo);

ALTER TABLE sueldo
    ADD CONSTRAINT fk_tipo_puesto
    FOREIGN KEY (id_tipo_dep, puesto)
    REFERENCES horario(id_tipo_dep, puesto);
    
ALTER TABLE sueldo
    ADD CONSTRAINT pk_sueldo
    PRIMARY KEY (id_tipo_dep, puesto, registro);

    
-- Creando la tabla para la relacion de Empleado
CREATE TABLE empleado (
    id_empleado NUMBER(10),
    curp VARCHAR(18),
    tipo_dep VARCHAR(100),
    puesto VARCHAR(80),
    registro DATE
);

ALTER TABLE empleado
    ADD CONSTRAINT pk_empleado
    PRIMARY KEY (id_empleado);

ALTER TABLE empleado
    ADD CONSTRAINT fk_persona_empl
    FOREIGN KEY (curp)
    REFERENCES persona(curp);

ALTER TABLE empleado
    ADD CONSTRAINT fk_tipo_dep_empl
    FOREIGN KEY (tipo_dep)
    REFERENCES tipo_departamento(tipo);

ALTER TABLE empleado
    ADD CONSTRAINT fk_puesto_reg_empl
    FOREIGN KEY (tipo_dep, puesto, registro)
    REFERENCES sueldo(id_tipo_dep, puesto, registro);

-- Creando la tabla para la relación de Trabajar
CREATE TABLE trabajar (
    id_suc NUMBER(10),
    id_empleado NUMBER(10)
);

ALTER TABLE trabajar
    ADD CONSTRAINT fk_suc_trabajar
    FOREIGN KEY (id_suc)
    REFERENCES sucursal(id_sucursal);
    
ALTER TABLE trabajar
    ADD CONSTRAINT fk_empleado_trabajar
    FOREIGN KEY (id_empleado)
    REFERENCES empleado(id_empleado);
   
-- Creando la tabla para la relación de Dirigir sucursal
CREATE TABLE dirigir (
    id_suc NUMBER(10),
    id_empleado NUMBER(10)
);

ALTER TABLE dirigir
    ADD CONSTRAINT fk_suc_dirigir
    FOREIGN KEY (id_suc)
    REFERENCES sucursal(id_sucursal);
    
ALTER TABLE dirigir
    ADD CONSTRAINT fk_empleado_dirigir
    FOREIGN KEY (id_empleado)
    REFERENCES empleado(id_empleado);
    
-- Creando la tabla para la relación de Supervisar
CREATE TABLE supervisar (
    id_empleado NUMBER(10),
    id_suc NUMBER(10),
    id_tipo_dep VARCHAR(100)
);

ALTER TABLE supervisar 
    ADD CONSTRAINT fk_empleado_supervisar
    FOREIGN KEY (id_empleado)
    REFERENCES empleado (id_empleado);
    
ALTER TABLE supervisar
    ADD CONSTRAINT fk_dep_supervisar
    FOREIGN KEY (id_suc, id_tipo_dep)
    REFERENCES tener_departamento(id_suc, id_tipo);
    
-- Creando tabla para Venta
CREATE TABLE venta (
    id_venta NUMBER(10),
    fecha DATE,
    num_tarjeta NUMBER(10),
    id_empleado NUMBER(10)
);

ALTER TABLE venta
    ADD CONSTRAINT pk_venta
    PRIMARY KEY (id_venta);
    
ALTER TABLE venta
    ADD CONSTRAINT fk_empleado_venta
    FOREIGN KEY (id_empleado)
    REFERENCES empleado(id_empleado);
    
ALTER TABLE venta
    ADD CONSTRAINT fk_tarj_venta
    FOREIGN KEY (num_tarjeta)
    REFERENCES tarjeta(num_tarjeta);

-- Creando la tabla para la relación de Tipo de Pago
CREATE TABLE tipo_pago (
    num_transac NUMBER(10),
    id_venta NUMBER(10)
);

ALTER TABLE tipo_pago
    ADD CONSTRAINT fk_venta_pago
    FOREIGN KEY (id_venta)
    REFERENCES venta(id_venta);

ALTER TABLE tipo_pago
    ADD CONSTRAINT pk_tipo_pago
    PRIMARY KEY (num_transac);

-- Creando la tabla para la relación de Método de Pago
CREATE TABLE metodo_pago (
    importe NUMBER(10),
    medio NUMBER(10),
    num_transac NUMBER(10),
    num_tarjeta NUMBER(10)
);

ALTER TABLE metodo_pago
    ADD CONSTRAINT fk_trans
    FOREIGN KEY (num_transac)
    REFERENCES tipo_pago(num_transac);
    
ALTER TABLE metodo_pago
    ADD CONSTRAINT fk_tarj_met_pago
    FOREIGN KEY (num_tarjeta)
    REFERENCES tarjeta(num_tarjeta);
    
-- Creando la tabla para Ticket
CREATE TABLE ticket (
    id_ticket NUMBER(10),
    id_venta NUMBER(10)
);

ALTER TABLE ticket
    ADD CONSTRAINT pk_ticket
    PRIMARY KEY (id_ticket);
    
ALTER TABLE ticket
    ADD CONSTRAINT fk_venta_ticket
    FOREIGN  KEY (id_venta)
    REFERENCES venta(id_venta);

-- Creando tabla para la relación de canjear ticket
CREATE TABLE canjear_ticket (
    fecha DATE,
    id_ticket NUMBER(10),
    id_cliente NUMBER(10)
);

ALTER TABLE canjear_ticket
    ADD CONSTRAINT fk_ticket
    FOREIGN KEY (id_ticket)
    REFERENCES ticket(id_ticket);
    
ALTER TABLE canjear_ticket
    ADD CONSTRAINT fk_cliente_canjear
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente);
   
-- Creando tabla para la relación de Instancia Producto
CREATE TABLE instancia_producto (
    id_producto NUMBER(10),
    codigo_barras NUMBER(20),
    id_produccion NUMBER(10),
    id_departamento VARCHAR(100),
    id_venta NUMBER(10),
    descripcion VARCHAR(100)
);

ALTER TABLE instancia_producto
    ADD CONSTRAINT pk_inst_prod
    PRIMARY KEY (id_producto);
    
ALTER TABLE instancia_producto
    ADD CONSTRAINT fk_cod_barr_inst_prod
    FOREIGN KEY (codigo_barras)
    REFERENCES producto(codigo_barras);
    
ALTER TABLE instancia_producto
    ADD CONSTRAINT fk_id_produc_inst_prod
    FOREIGN KEY (id_produccion)
    REFERENCES lote(id_produccion);
    
ALTER TABLE instancia_producto
    ADD CONSTRAINT fk_id_dep_inst_prod
    FOREIGN KEY (id_departamento)
    REFERENCES tipo_departamento(tipo);
    
ALTER TABLE instancia_producto
    ADD CONSTRAINT fk_venta
    FOREIGN KEY (id_venta)
    REFERENCES venta(id_venta);
    
