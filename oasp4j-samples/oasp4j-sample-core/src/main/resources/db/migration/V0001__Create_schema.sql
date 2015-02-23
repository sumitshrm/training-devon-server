CREATE USER IF NOT EXISTS SA SALT '0f7d070a6a5f2b60' HASH 'cd3e105f0486a1a04aa8fffd2dc2afda0bec8c1832b5b95fab0a67d088ad1e0c' ADMIN;
CREATE SEQUENCE PUBLIC.HIBERNATE_SEQUENCE START WITH 1000000;
CREATE CACHED TABLE PUBLIC.BILL(
    id BIGINT NOT NULL,
    modificationCounter INTEGER NOT NULL,
    payed BOOLEAN NOT NULL,
    tip DECIMAL(19, 2),
    total DECIMAL(19, 2)
);
CREATE CACHED TABLE PUBLIC.BILL_ORDERPOSITION(
    bill_id BIGINT NOT NULL,
    orderpositions_id BIGINT NOT NULL
);
CREATE CACHED TABLE PUBLIC.OFFER(
    id BIGINT NOT NULL,
    modificationCounter INTEGER NOT NULL,
    description VARCHAR(255),
    name VARCHAR(255),
    price DECIMAL(19, 2),
    number BIGINT,
    state INTEGER,
    drink_id BIGINT,
    meal_id BIGINT,
    sideDish_id BIGINT
);
CREATE CACHED TABLE PUBLIC.ORDERPOSITION(
    id BIGINT NOT NULL,
    modificationCounter INTEGER NOT NULL,
    comment VARCHAR(255),
    cook_id BIGINT,
    offer_id BIGINT,
    offerName VARCHAR(255),
    price DECIMAL(19, 2),
    state INTEGER,
    order_id BIGINT
);
CREATE CACHED TABLE PUBLIC.PRODUCT(
    dtype VARCHAR(31) NOT NULL,
    id BIGINT NOT NULL,
    modificationCounter INTEGER NOT NULL,
    description VARCHAR(255),
    name VARCHAR(255),
    alcoholic BOOLEAN
);
CREATE CACHED TABLE PUBLIC.RESTAURANTTABLE(
    id BIGINT NOT NULL,
    modificationCounter INTEGER NOT NULL,
    number BIGINT NOT NULL CHECK (NUMBER >= 0),
    state INTEGER,
    waiter_id BIGINT
);
CREATE CACHED TABLE PUBLIC.STAFFMEMBER(
    id BIGINT NOT NULL,
    modificationCounter INTEGER NOT NULL,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    login VARCHAR(255),
    role INTEGER
);
CREATE CACHED TABLE PUBLIC.RESTAURANTORDER(
    id BIGINT NOT NULL,
    modificationCounter INTEGER NOT NULL,
    state INTEGER,
    table_id BIGINT NOT NULL
);
CREATE CACHED TABLE PUBLIC.PRODUCT_AUD(
    revtype TINYINT,
    description VARCHAR(255),
    name VARCHAR(255),
    pictureId BIGINT,
    alcoholic BOOLEAN,
    dtype VARCHAR(31) NOT NULL,
    id BIGINT NOT NULL,
    rev BIGINT NOT NULL
);
CREATE CACHED TABLE PUBLIC.REVINFO(
    id BIGINT NOT NULL generated by default as identity (start with 1),
    timestamp BIGINT NOT NULL,
    user VARCHAR(255)
);
ALTER TABLE PUBLIC.BILL ADD CONSTRAINT PUBLIC.PK_BILL PRIMARY KEY(id);
ALTER TABLE PUBLIC.OFFER ADD CONSTRAINT PUBLIC.PK_OFFER PRIMARY KEY(id);
ALTER TABLE PUBLIC.ORDERPOSITION ADD CONSTRAINT PUBLIC.PK_ORDERPOSITON PRIMARY KEY(id);
ALTER TABLE PUBLIC.PRODUCT ADD CONSTRAINT PUBLIC.PK_PRODUCT PRIMARY KEY(id);
ALTER TABLE PUBLIC.RESTAURANTTABLE ADD CONSTRAINT PUBLIC.PK_RESTAURANTTABLE PRIMARY KEY(id);
ALTER TABLE PUBLIC.STAFFMEMBER ADD CONSTRAINT PUBLIC.PK_STAFFMEMEBER PRIMARY KEY(id);
ALTER TABLE PUBLIC.RESTAURANTORDER ADD CONSTRAINT PUBLIC.PK_RESTAURANTORDER PRIMARY KEY(id);

ALTER TABLE PUBLIC.OFFER ADD CONSTRAINT PUBLIC.UC_OFFER_NAME UNIQUE(name);
ALTER TABLE PUBLIC.RESTAURANTTABLE ADD CONSTRAINT PUBLIC.UC_TABLE_NUMBER UNIQUE(number);
ALTER TABLE PUBLIC.OFFER ADD CONSTRAINT PUBLIC.UC_OFFER_NUMBER UNIQUE(number);
ALTER TABLE PUBLIC.STAFFMEMBER ADD CONSTRAINT PUBLIC.UC_STAFFMEMBER_LOGIN UNIQUE(login);

ALTER TABLE PUBLIC.ORDERPOSITION ADD CONSTRAINT PUBLIC.FK_ORDPOS2ORDER FOREIGN KEY(order_id) REFERENCES PUBLIC.RESTAURANTORDER(id) NOCHECK;
ALTER TABLE PUBLIC.ORDERPOSITION ADD CONSTRAINT PUBLIC.FK_ORDPOS2COOK FOREIGN KEY(cook_id) REFERENCES PUBLIC.STAFFMEMBER(id) NOCHECK;
ALTER TABLE PUBLIC.BILL_ORDERPOSITION ADD CONSTRAINT PUBLIC.FK_BILLORDPOS2BILL FOREIGN KEY(bill_id) REFERENCES PUBLIC.BILL(id) NOCHECK;
ALTER TABLE PUBLIC.BILL_ORDERPOSITION ADD CONSTRAINT PUBLIC.FK_BILLORDPOS2ORDPOS FOREIGN KEY(orderPositions_ID) REFERENCES PUBLIC.ORDERPOSITION(id) NOCHECK;
ALTER TABLE PUBLIC.OFFER ADD CONSTRAINT PUBLIC.FK_OFFER2SIDEDISH FOREIGN KEY(sideDish_id) REFERENCES PUBLIC.PRODUCT(id) NOCHECK;
ALTER TABLE PUBLIC.OFFER ADD CONSTRAINT PUBLIC.FK_OFFER2MEAL FOREIGN KEY(meal_id) REFERENCES PUBLIC.PRODUCT(id) NOCHECK;
ALTER TABLE PUBLIC.OFFER ADD CONSTRAINT PUBLIC.FK_OFFER2DRINK FOREIGN KEY(drink_id) REFERENCES PUBLIC.PRODUCT(id) NOCHECK;
