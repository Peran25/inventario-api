CREATE TABLE usuarios (
    id            BIGSERIAL PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    email         VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(100) NOT NULL,
    rol           VARCHAR(10)  NOT NULL CHECK (rol IN ('ADMIN','USER')),
    activo        BOOLEAN      NOT NULL DEFAULT TRUE,
    creado_en     TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE categorias (
    id     BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE productos (
    id           BIGSERIAL PRIMARY KEY,
    sku          VARCHAR(40)   NOT NULL UNIQUE,
    nombre       VARCHAR(150)  NOT NULL,
    descripcion  TEXT,
    precio       NUMERIC(10,2) NOT NULL CHECK (precio >= 0),
    stock        INT           NOT NULL DEFAULT 0 CHECK (stock >= 0),
    stock_minimo INT           NOT NULL DEFAULT 5,
    categoria_id BIGINT        NOT NULL REFERENCES categorias(id),
    creado_en    TIMESTAMP     NOT NULL DEFAULT NOW()
);

CREATE TABLE movimientos_stock (
    id          BIGSERIAL PRIMARY KEY,
    producto_id BIGINT      NOT NULL REFERENCES productos(id),
    usuario_id  BIGINT      NOT NULL REFERENCES usuarios(id),
    tipo        VARCHAR(10) NOT NULL CHECK (tipo IN ('ENTRADA','SALIDA','AJUSTE')),
    cantidad    INT         NOT NULL CHECK (cantidad > 0),
    motivo      VARCHAR(200),
    fecha       TIMESTAMP   NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_productos_categoria ON productos(categoria_id);
CREATE INDEX idx_productos_nombre    ON productos(LOWER(nombre));
CREATE INDEX idx_mov_producto_fecha  ON movimientos_stock(producto_id, fecha);