CREATE TABLE products (
    id          BIGSERIAL       PRIMARY KEY,
    name        VARCHAR(255)    NOT NULL,
    description VARCHAR(2000),
    category    VARCHAR(100),
    unit_price  DECIMAL(10, 2)  NOT NULL,
    stock       INTEGER         NOT NULL,
    created_at  TIMESTAMP       NOT NULL,
    updated_at  TIMESTAMP       NOT NULL
);

CREATE INDEX idx_products_category ON products (category);
