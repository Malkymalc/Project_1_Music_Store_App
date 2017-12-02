DROP TABLE sales;
DROP TABLE transactions;
DROP TABLE products;
DROP TABLE albums;
DROP TABLE genres;
DROP TABLE artists;


CREATE TABLE artists
(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE genres
(
  id SERIAL8 PRIMARY KEY,
  genre VARCHAR(255)
);

CREATE TABLE albums
(
  id SERIAL8 PRIMARY KEY,
  artist_id INT8 REFERENCES artists(id),
  title VARCHAR(255),
  length INTERVAL,
  genre_id INT8 REFERENCES genres(id)
);

CREATE TABLE products
(
  id SERIAL8 PRIMARY KEY,
  product_id INT8 REFERENCES albums(id),
  url VARCHAR(255),
  alt VARCHAR(255),
  type VARCHAR(255),
  stock INT2,
  buy FLOAT,
  sell FLOAT
);

-- Payment method, transactor
CREATE TABLE transactions
(
  id SERIAL8 PRIMARY KEY,
  amount INT2,
  date_time TIMESTAMP,
  refund BOOLEAN
);

CREATE TABLE sales
(
  id SERIAL8 PRIMARY KEY,
  transaction_id INT8 REFERENCES transactions(id),
  item_id INT8 REFERENCES products(id),
  quantity INT2
);


-- CREATE TABLE staff
-- (
--   id SERIAL8 PRIMARY KEY,
--   email VARCHAR,
--   password VARCHAR,
--   first_name VARCHAR,
--   last_name VARCHAR,
--   manager BOOLEAN
-- );
--
--
--
-- CREATE TABLE customers
-- (
--   id SERIAL8 PRIMARY KEY,
--   email VARCHAR,
--   password VARCHAR,
--   first_name VARCHAR,
--   last_name VARCHAR,
--   customer BOOLEAN,
--   address VARCHAR,
--   phone INT2
-- );
