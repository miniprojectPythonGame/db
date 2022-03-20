-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-03-18 10:46:12.311

-- tables
-- Table: AuctionedItems
CREATE TABLE AuctionedItems
(
    auctioned_item_id  serial,
    item_id            int       NOT NULL,
    current_price      int       NOT NULL,
    amount             int       NOT NULL,
    start_price        int       NOT NULL,
    seller_id          int       NOT NULL,
    auction_end_date   timestamp NOT NULL,
    auction_start_date timestamp NOT NULL,
    storage_id         int       NOT NULL,
    CONSTRAINT AuctionedItems_pk PRIMARY KEY (auctioned_item_id)
);

-- Table: Bots
CREATE TABLE Bots
(
    bot_id        serial,
    name          varchar(50) NOT NULL,
    lvl           int         NOT NULL,
    bot_class     char(1)     NOT NULL,
    is_friendly   smallint    NOT NULL,
    statistics_id int         NOT NULL,
    CONSTRAINT Bots_ak_1 UNIQUE (statistics_id) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT Bots_pk PRIMARY KEY (bot_id)
);

-- Table: BuyNowItems
CREATE TABLE BuyNowItems
(
    buy_now_item_id serial,
    item_id         int       NOT NULL,
    selling_price   int       NOT NULL,
    amount          int       NOT NULL,
    seller_id       int       NOT NULL,
    post_date       timestamp NOT NULL,
    storage_id      int       NOT NULL,
    CONSTRAINT BuyNowItems_pk PRIMARY KEY (buy_now_item_id)
);

-- Table: BuyOrders
CREATE TABLE BuyOrders
(
    buy_order_id      serial,
    buyer_id          int       NOT NULL,
    amount            int       NOT NULL,
    item_id           int       NOT NULL,
    target_unit_price int       NOT NULL,
    order_date        timestamp NOT NULL,
    CONSTRAINT BuyOrders_pk PRIMARY KEY (buy_order_id)
);

-- Table: Guilds
CREATE TABLE Guilds
(
    guild_id       serial,
    name           varchar(50)  NOT NULL,
    gold           int          NOT NULL,
    description    varchar(500) NOT NULL,
    leader_id      int          NOT NULL,
    vice_leader_id int          NOT NULL,
    CONSTRAINT Guilds_pk PRIMARY KEY (guild_id)
);

-- Table: Heroes
CREATE TABLE Heroes
(
    name          varchar(50) NOT NULL,
    player_id     int         NOT NULL,
    hero_id       serial,
    gold          int         NOT NULL,
    level_id      int         NOT NULL,
    exp           int         NOT NULL,
    hero_class    char(1)     NOT NULL,
    statistics_id int         NOT NULL,
    guild_id      int         NOT NULL,
    CONSTRAINT Heroes_ak_1 UNIQUE (player_id) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT Heroes_pk PRIMARY KEY (hero_id)
);

-- Table: ItemTypes
CREATE TABLE ItemTypes
(
    item_type_id serial,
    type_name    varchar(50)  NOT NULL,
    description  varchar(128) NOT NULL,
    CONSTRAINT ItemTypes_pk PRIMARY KEY (item_type_id)
);

-- Table: Items
CREATE TABLE Items
(
    item_id       serial,
    name          varchar(50)  NOT NULL,
    price         int          NOT NULL,
    description   varchar(128) NOT NULL,
    only_treasure smallint     NOT NULL,
    statistics_id int          NOT NULL,
    item_type_id  int          NOT NULL,
    min_lvl       int          NOT NULL,
    CONSTRAINT Items_pk PRIMARY KEY (item_id)
);

-- Table: Levels
CREATE TABLE Levels
(
    level_id serial,
    exp      int NOT NULL,
    CONSTRAINT Levels_pk PRIMARY KEY (level_id)
);

-- Table: Maps
CREATE TABLE Maps
(
    map_id           serial,
    background_image bytea        NOT NULL,
    name             varchar(50)  NOT NULL,
    description      varchar(128) NOT NULL,
    CONSTRAINT Maps_pk PRIMARY KEY (map_id)
);

-- Table: Players
CREATE TABLE Players
(
    nick      varchar(50) NOT NULL,
    email     varchar(50) NOT NULL,
    sex       char(1)     NULL,
    age       int         NOT NULL,
    player_id serial,
    CONSTRAINT Players_pk PRIMARY KEY (player_id)
);

-- Table: Quests
CREATE TABLE Quests
(
    quest_id    serial,
    name        varchar(50)  NOT NULL,
    description varchar(500) NOT NULL,
    min_lvl     int          NOT NULL,
    gold_reward int          NOT NULL,
    exp_reward  int          NOT NULL,
    CONSTRAINT Quests_pk PRIMARY KEY (quest_id)
);

-- Table: Statistics
CREATE TABLE Statistics
(
    statistics_id serial,
    strength      int NOT NULL,
    intelligence  int NOT NULL,
    dexterity     int NOT NULL,
    constitution  int NOT NULL,
    luck          int NOT NULL,
    protection    int NOT NULL,
    hp            int NOT NULL,
    persuasion    int NOT NULL,
    trade         int NOT NULL,
    leadership    int NOT NULL,
    Bots_bot_id   int NOT NULL,
    CONSTRAINT Statistics_pk PRIMARY KEY (statistics_id)
);

-- Table: Storage
CREATE TABLE Storage
(
    item_slot_id   int      NOT NULL,
    item_id        int      NOT NULL,
    amount         int      NOT NULL,
    available      smallint NOT NULL,
    hero_id        int      NOT NULL,
    Heroes_hero_id int      NOT NULL,
    Items_item_id  int      NOT NULL,
    storage_id     serial,
    CONSTRAINT Storage_pk PRIMARY KEY (storage_id)
);

-- Table: Trainers
CREATE TABLE Trainers
(
    trainer_id  serial,
    name        varchar(50)  NOT NULL,
    description varchar(500) NOT NULL,
    map_id      int          NOT NULL,
    CONSTRAINT map_id UNIQUE (map_id) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT Trainers_pk PRIMARY KEY (trainer_id)
);

-- foreign keys
-- Reference: AuctionedItems_Storage (table: AuctionedItems)
ALTER TABLE AuctionedItems
    ADD CONSTRAINT AuctionedItems_Storage
        FOREIGN KEY (storage_id)
            REFERENCES Storage (storage_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: BuyOrders_Items (table: BuyOrders)
ALTER TABLE BuyOrders
    ADD CONSTRAINT BuyOrders_Items
        FOREIGN KEY (item_id)
            REFERENCES Items (item_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Guild_Heroes (table: Heroes)
ALTER TABLE Heroes
    ADD CONSTRAINT Guild_Heroes
        FOREIGN KEY (guild_id)
            REFERENCES Guilds (guild_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Heroes_BuyOrders (table: BuyOrders)
ALTER TABLE BuyOrders
    ADD CONSTRAINT Heroes_BuyOrders
        FOREIGN KEY (buyer_id)
            REFERENCES Heroes (hero_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Heroes_CreatureStatistics (table: Heroes)
ALTER TABLE Heroes
    ADD CONSTRAINT Heroes_CreatureStatistics
        FOREIGN KEY (statistics_id)
            REFERENCES Statistics (statistics_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Heroes_Players (table: Heroes)
ALTER TABLE Heroes
    ADD CONSTRAINT Heroes_Players
        FOREIGN KEY (player_id)
            REFERENCES Players (player_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Heroes_Storage (table: Storage)
ALTER TABLE Storage
    ADD CONSTRAINT Heroes_Storage
        FOREIGN KEY (hero_id)
            REFERENCES Heroes (hero_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Items_ItemTypes (table: Items)
ALTER TABLE Items
    ADD CONSTRAINT Items_ItemTypes
        FOREIGN KEY (item_type_id)
            REFERENCES ItemTypes (item_type_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Items_Statistics (table: Items)
ALTER TABLE Items
    ADD CONSTRAINT Items_Statistics
        FOREIGN KEY (statistics_id)
            REFERENCES Statistics (statistics_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Levels_Heroes (table: Heroes)
ALTER TABLE Heroes
    ADD CONSTRAINT Levels_Heroes
        FOREIGN KEY (level_id)
            REFERENCES Levels (level_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Statistics_Bots (table: Statistics)
ALTER TABLE Statistics
    ADD CONSTRAINT Statistics_Bots
        FOREIGN KEY (statistics_id)
            REFERENCES Bots (statistics_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Storage_BuyNowItems (table: BuyNowItems)
ALTER TABLE BuyNowItems
    ADD CONSTRAINT Storage_BuyNowItems
        FOREIGN KEY (storage_id)
            REFERENCES Storage (storage_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Storage_Items (table: Storage)
ALTER TABLE Storage
    ADD CONSTRAINT Storage_Items
        FOREIGN KEY (item_id)
            REFERENCES Items (item_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- Reference: Trainer_Maps (table: Maps)
ALTER TABLE Maps
    ADD CONSTRAINT Trainer_Maps
        FOREIGN KEY (map_id)
            REFERENCES Trainers (map_id)
            NOT DEFERRABLE
                INITIALLY IMMEDIATE
;

-- sequences
-- Sequence: AuctionedItems_seq
CREATE SEQUENCE AuctionedItems_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Bots_seq
CREATE SEQUENCE Bots_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: BuyNowItems_seq
CREATE SEQUENCE BuyNowItems_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: BuyOrders_seq
CREATE SEQUENCE BuyOrders_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Guilds_seq
CREATE SEQUENCE Guilds_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Heroes_seq
CREATE SEQUENCE Heroes_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: ItemTypes_seq
CREATE SEQUENCE ItemTypes_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Items_seq
CREATE SEQUENCE Items_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Levels_seq
CREATE SEQUENCE Levels_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Maps_seq
CREATE SEQUENCE Maps_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Players_seq
CREATE SEQUENCE Players_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Quests_seq
CREATE SEQUENCE Quests_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Statistics_seq
CREATE SEQUENCE Statistics_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Storage_seq
CREATE SEQUENCE Storage_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- Sequence: Trainers_seq
CREATE SEQUENCE Trainers_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    START WITH 1
    NO CYCLE
;

-- End of file.

