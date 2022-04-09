create sequence guilds_guild_id_seq
    as integer;

alter sequence guilds_guild_id_seq owner to avnadmin;

alter sequence guilds_guild_id_seq owned by guilds.guild_id;

create sequence itemtypes_item_type_id_seq
    as integer;

alter sequence itemtypes_item_type_id_seq owner to avnadmin;

alter sequence itemtypes_item_type_id_seq owned by itemtypes.item_type_id;

create sequence levels_level_id_seq
    as integer;

alter sequence levels_level_id_seq owner to avnadmin;

alter sequence levels_level_id_seq owned by levels.level_id;

create sequence quests_quest_id_seq
    as integer;

alter sequence quests_quest_id_seq owner to avnadmin;

alter sequence quests_quest_id_seq owned by quests.quest_id;

create sequence statistics_statistics_id_seq
    as integer;

alter sequence statistics_statistics_id_seq owner to avnadmin;

alter sequence statistics_statistics_id_seq owned by statistics.statistics_id;

create sequence bots_bot_id_seq
    as integer;

alter sequence bots_bot_id_seq owner to avnadmin;

alter sequence bots_bot_id_seq owned by bots.bot_id;

create sequence heroes_hero_id_seq
    as integer;

alter sequence heroes_hero_id_seq owner to avnadmin;

alter sequence heroes_hero_id_seq owned by heroes.hero_id;

create sequence items_item_id_seq
    as integer;

alter sequence items_item_id_seq owner to avnadmin;

alter sequence items_item_id_seq owned by items.item_id;

create sequence buyorders_buy_order_id_seq
    as integer;

alter sequence buyorders_buy_order_id_seq owner to avnadmin;

alter sequence buyorders_buy_order_id_seq owned by buy_orders.buy_order_id;

create sequence storage_storage_id_seq
    as integer;

alter sequence storage_storage_id_seq owner to avnadmin;

alter sequence storage_storage_id_seq owned by storage.storage_id;

create sequence auctioneditems_auctioned_item_id_seq
    as integer;

alter sequence auctioneditems_auctioned_item_id_seq owner to avnadmin;

alter sequence auctioneditems_auctioned_item_id_seq owned by auctioned_items.auctioned_item_id;

create sequence buynowitems_buy_now_item_id_seq
    as integer;

alter sequence buynowitems_buy_now_item_id_seq owner to avnadmin;

alter sequence buynowitems_buy_now_item_id_seq owned by buy_now_items.buy_now_item_id;

create sequence trainers_trainer_id_seq
    as integer;

alter sequence trainers_trainer_id_seq owner to avnadmin;

alter sequence trainers_trainer_id_seq owned by trainers.trainer_id;

create sequence maps_map_id_seq
    as integer;

alter sequence maps_map_id_seq owner to avnadmin;

alter sequence maps_map_id_seq owned by maps.map_id;

create sequence auctioneditems_seq;

alter sequence auctioneditems_seq owner to avnadmin;

create sequence bots_seq;

alter sequence bots_seq owner to avnadmin;

create sequence buynowitems_seq;

alter sequence buynowitems_seq owner to avnadmin;

create sequence buyorders_seq;

alter sequence buyorders_seq owner to avnadmin;

create sequence guilds_seq;

alter sequence guilds_seq owner to avnadmin;

create sequence heroes_seq;

alter sequence heroes_seq owner to avnadmin;

create sequence itemtypes_seq;

alter sequence itemtypes_seq owner to avnadmin;

create sequence items_seq;

alter sequence items_seq owner to avnadmin;

create sequence levels_seq;

alter sequence levels_seq owner to avnadmin;

create sequence maps_seq;

alter sequence maps_seq owner to avnadmin;

create sequence players_seq;

alter sequence players_seq owner to avnadmin;

create sequence quests_seq;

alter sequence quests_seq owner to avnadmin;

create sequence statistics_seq;

alter sequence statistics_seq owner to avnadmin;

create sequence storage_seq;

alter sequence storage_seq owner to avnadmin;

create sequence trainers_seq;

alter sequence trainers_seq owner to avnadmin;

create sequence armour_shop_id_seq
    as integer;

alter sequence armour_shop_id_seq owner to avnadmin;

alter sequence armour_shop_id_seq owned by armour_shop.id;

create sequence magic_shop_id_seq
    as integer;

alter sequence magic_shop_id_seq owner to avnadmin;

alter sequence magic_shop_id_seq owned by magic_shop.id;

create sequence weapon_shop_id_seq
    as integer;

alter sequence weapon_shop_id_seq owner to avnadmin;

alter sequence weapon_shop_id_seq owned by weapon_shop.id;

create sequence stable_shop_id_seq
    as integer;

alter sequence stable_shop_id_seq owner to avnadmin;

alter sequence stable_shop_id_seq owned by steed_shop.id;

