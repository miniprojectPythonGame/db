create table guilds
(
    guild_id       serial
        constraint guilds_pk
            primary key,
    name           varchar(50)  not null,
    gold           integer      not null,
    description    varchar(500) not null,
    leader_id      integer      not null,
    vice_leader_id integer      not null
);

alter table guilds
    owner to avnadmin;

create table itemtypes
(
    item_type_id serial
        constraint itemtypes_pk
            primary key,
    type_name    varchar(50) not null
);

alter table itemtypes
    owner to avnadmin;

create table levels
(
    level_id serial
        constraint levels_pk
            primary key,
    exp      bigint not null
        constraint levels_exp_check
            check (exp > 0)
);

alter table levels
    owner to avnadmin;

create table players
(
    nick      varchar(50) not null,
    email     varchar(50) not null
        constraint players_email_check
            check ((email)::text ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text),
    sex       char
        constraint players_sex_check
            check ((sex = 'm'::bpchar) OR (sex = 'f'::bpchar)),
    age       integer     not null
        constraint players_age_check
            check (age >= 16),
    player_id varchar(50) not null
        constraint players_pk
            primary key
);

alter table players
    owner to avnadmin;

create trigger player_del_trig
    after delete
    on players
    for each row
execute procedure remove_all_heroes();

create table quests
(
    quest_id    serial
        constraint quests_pk
            primary key,
    name        varchar(50)  not null,
    description varchar(500) not null,
    min_lvl     integer      not null
        constraint quests_min_lvl_check
            check (min_lvl >= 1),
    gold_reward integer      not null
        constraint quests_gold_reward_check
            check (gold_reward > 0),
    exp_reward  integer      not null
        constraint quests_exp_reward_check
            check (exp_reward > 0)
);

alter table quests
    owner to avnadmin;

create table statistics
(
    statistics_id serial
        constraint statistics_pk
            primary key,
    strength      integer not null,
    intelligence  integer not null,
    dexterity     integer not null,
    constitution  integer not null,
    luck          integer not null,
    persuasion    integer not null,
    trade         integer not null,
    leadership    integer not null,
    protection    integer not null,
    initiative    integer not null
);

alter table statistics
    owner to avnadmin;

create table bots
(
    bot_id        serial
        constraint bots_pk
            primary key,
    name          varchar(50) not null,
    lvl           integer     not null
        constraint lvl_check
            check (lvl >= 0),
    bot_class     char        not null
        constraint bot_class
            check ((bot_class = 'w'::bpchar) OR (bot_class = 'a'::bpchar) OR (bot_class = 'm'::bpchar)),
    is_friendly   smallint    not null
        constraint friendliness
            check ((is_friendly = 0) OR (is_friendly = 1)),
    statistics_id integer     not null
        constraint bots_ak_1
            unique
        constraint fk_statistics
            references statistics
);

alter table bots
    owner to avnadmin;

create table heroes
(
    name                 varchar(50) not null,
    player_id            varchar(50) not null,
    hero_id              serial
        constraint heroes_pk
            primary key,
    gold                 integer     not null,
    level_id             integer     not null
        constraint levels_heroes
            references levels,
    exp                  integer     not null,
    hero_class           char        not null,
    statistics_id        integer     not null
        constraint heroes_creaturestatistics
            references statistics,
    guild_id             integer
        constraint guild_heroes
            references guilds,
    free_development_pts integer     not null,
    exp_next_lvl         integer     not null
);

alter table heroes
    owner to avnadmin;

create trigger hero_del_trig
    after delete
    on heroes
    for each row
execute procedure remove_statistics();

create table items
(
    item_id       serial
        constraint items_pk
            primary key,
    name          varchar(50)  not null,
    price         integer      not null,
    description   varchar(500) not null,
    only_treasure smallint     not null,
    statistics_id integer      not null
        constraint items_statistics
            references statistics,
    item_type_id  integer      not null
        constraint items_itemtypes
            references itemtypes,
    min_lvl       integer      not null,
    for_class     char,
    owner_id      integer
);

alter table items
    owner to avnadmin;

create trigger item_del_trig
    after delete
    on items
    for each row
execute procedure remove_statistics();

create table buyorders
(
    buy_order_id      serial
        constraint buyorders_pk
            primary key,
    buyer_id          integer   not null
        constraint heroes_buyorders
            references heroes,
    amount            integer   not null,
    item_id           integer   not null
        constraint buyorders_items
            references items,
    target_unit_price integer   not null,
    order_date        timestamp not null
);

alter table buyorders
    owner to avnadmin;

create table storage
(
    item_slot_id integer,
    item_id      integer
        constraint storage_items
            references items,
    amount       integer  not null,
    available    smallint not null,
    hero_id      integer  not null
        constraint heroes_storage
            references heroes,
    storage_id   serial
        constraint storage_pk
            primary key
);

alter table storage
    owner to avnadmin;

create unique index storage_item_slot_id_uindex
    on storage (item_slot_id);

create table auctioneditems
(
    auctioned_item_id  serial
        constraint auctioneditems_pk
            primary key,
    item_id            integer   not null,
    current_price      integer   not null
        constraint positive_curr_price
            check (current_price > 0),
    amount             integer   not null,
    start_price        integer   not null
        constraint positive_start_price
            check (start_price > 0),
    seller_id          integer   not null,
    auction_end_date   timestamp not null,
    auction_start_date timestamp not null,
    storage_id         integer   not null
        constraint auctioneditems_storage
            references storage
);

alter table auctioneditems
    owner to avnadmin;

create table buynowitems
(
    buy_now_item_id serial
        constraint buynowitems_pk
            primary key,
    item_id         integer   not null,
    selling_price   integer   not null
        constraint positive_selling_price
            check (selling_price > 0),
    amount          integer   not null
        constraint positive_amount
            check (amount > 0),
    seller_id       integer   not null,
    post_date       timestamp not null
        constraint post_date
            check (post_date <= CURRENT_DATE),
    storage_id      integer   not null
        constraint storage_buynowitems
            references storage
);

alter table buynowitems
    owner to avnadmin;

create table trainers
(
    trainer_id  serial
        constraint trainers_pk
            primary key,
    name        varchar(50)  not null,
    description varchar(500) not null,
    map_id      integer      not null
        constraint map_id
            unique
);

alter table trainers
    owner to avnadmin;

create table maps
(
    map_id           serial
        constraint maps_pk
            primary key
        constraint trainer_maps
            references trainers (map_id),
    background_image bytea        not null,
    name             varchar(50)  not null,
    description      varchar(128) not null
);

alter table maps
    owner to avnadmin;

create table armour_shop
(
    item_id      integer,
    hero_id      integer not null,
    id           serial
        constraint armour_shop_pk
            primary key,
    item_slot_id integer not null
);

alter table armour_shop
    owner to avnadmin;

create unique index armour_shop_id_uindex
    on armour_shop (id);

create table magic_shop
(
    id           serial
        constraint magic_shop_pk
            primary key,
    item_id      integer,
    hero_id      integer not null,
    item_slot_id integer not null
);

alter table magic_shop
    owner to avnadmin;

create unique index magic_shop_id_uindex
    on magic_shop (id);

create table weapon_shop
(
    id           serial
        constraint weapon_shop_pk
            primary key,
    hero_id      integer not null,
    item_id      integer,
    item_slot_id integer not null
);

alter table weapon_shop
    owner to avnadmin;

create unique index weapon_shop_id_uindex
    on weapon_shop (id);

create table steed_shop
(
    id           integer default nextval('stable_shop_id_seq'::regclass) not null
        constraint stable_shop_pk
            primary key,
    hero_id      integer                                                 not null,
    item_id      integer,
    item_slot_id integer                                                 not null
);

alter table steed_shop
    owner to avnadmin;

create unique index stable_shop_id_uindex
    on steed_shop (id);

