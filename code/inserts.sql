INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (9, 'PrimaryWeapon');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (10, 'SecondaryWeapon');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (12, 'PotionPermanent');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (11, 'PotionPeriod');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (5, 'LuckyItem');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (8, 'Steed');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (1, 'Boots');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (0, 'Belt');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (3, 'Gloves');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (2, 'Breastplate');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (4, 'Headgear');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (7, 'Ring');
INSERT INTO public.itemtypes (item_type_id, type_name) VALUES (6, 'Necklace');

insert into levels (exp)
values (100);
insert into levels (exp)
values (220);
insert into levels (exp)
values (506);
insert into levels (exp)
values (1214);
insert into levels (exp)
values (3036);
insert into levels (exp)
values (7893);
insert into levels (exp)
values (21312);
insert into levels (exp)
values (59675);
insert into levels (exp)
values (173059);
insert into levels (exp)
values (519177);
insert into levels (exp)
values (1609451);
insert into levels (exp)
values (5150244);
insert into levels (exp)
values (16995806);
insert into levels (exp)
values (57785741);
insert into levels (exp)
values (202250096);
insert into levels (exp)
values (728100346);
insert into levels (exp)
values (2693971280);
insert into levels (exp)
values (10237090866);
insert into levels (exp)
values (39924654379);
insert into levels (exp)
values (159698617517);

INSERT INTO public.players (nick, email, sex, age, player_id) VALUES ('Viciooo', 'konto@gmail.com', 'm', 21, '3DYC5w8HwpchalTfSYmAtOWLWO33');

INSERT INTO public.statistics (statistics_id, strength, intelligence, dexterity, constitution, luck, persuasion, trade, leadership, protection, initiative) VALUES (25, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
INSERT INTO public.statistics (statistics_id, strength, intelligence, dexterity, constitution, luck, persuasion, trade, leadership, protection, initiative) VALUES (26, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO public.statistics (statistics_id, strength, intelligence, dexterity, constitution, luck, persuasion, trade, leadership, protection, initiative) VALUES (31, 5, 0, 0, 0, 5, 0, 0, 0, 30, 0);
INSERT INTO public.statistics (statistics_id, strength, intelligence, dexterity, constitution, luck, persuasion, trade, leadership, protection, initiative) VALUES (33, 0, 0, 10, 0, 5, 0, 0, 0, 0, 0);

INSERT INTO public.heroes (name, player_id, hero_id, gold, level_id, exp, hero_class, statistics_id, guild_id, free_development_pts, exp_next_lvl,avatar_id) VALUES ('testx', '3DYC5w8HwpchalTfSYmAtOWLWO33', 20, 0, 1, 100, 'w', 26, null, 4, 220,1);
INSERT INTO public.heroes (name, player_id, hero_id, gold, level_id, exp, hero_class, statistics_id, guild_id, free_development_pts, exp_next_lvl,avatar_id) VALUES ('test5', '3DYC5w8HwpchalTfSYmAtOWLWO33', 19, 0, 4, 1754, 'w', 25, null, 16, 3036,1);

INSERT INTO public.items (item_id, name, price, description, only_treasure, statistics_id, item_type_id, min_lvl, for_class,quality) VALUES (7, 'simple breastplate', 7, 'Nothing to fancy', 0, 31, 2, 1, null,1);
INSERT INTO public.items (item_id, name, price, description, only_treasure, statistics_id, item_type_id, min_lvl, for_class,quality) VALUES (9, 'simple bow', 5, 'Just a regular bow', 0, 33, 9, 1, 'a',1);

INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (1, null, 0, 0, 20, 4);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (3, null, 0, 0, 20, 6);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (4, null, 0, 0, 20, 7);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (5, null, 0, 0, 20, 8);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (6, null, 0, 0, 20, 9);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (8, null, 0, 0, 20, 11);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (10, null, 0, 0, 20, 13);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (13, null, 0, 0, 20, 16);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (14, null, 0, 0, 20, 17);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (16, null, 0, 0, 20, 19);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (17, null, 0, 0, 20, 20);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (19, null, 0, 0, 20, 22);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (21, null, 0, 0, 20, 24);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (22, null, 0, 0, 20, 25);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (23, null, 0, 0, 20, 26);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (24, null, 0, 0, 20, 27);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (25, null, 0, 0, 20, 28);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (26, null, 0, 0, 20, 29);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (27, null, 0, 0, 20, 30);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (28, null, 0, 0, 20, 31);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (29, null, 0, 0, 20, 32);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (30, null, 0, 0, 20, 33);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (0, null, 0, 0, 20, 3);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (7, null, 0, 0, 20, 12);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (20, null, 0, 0, 20, 21);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (18, null, 0, 0, 20, 23);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (15, null, 0, 0, 20, 18);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (9, null, 0, 0, 20, 5);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (12, 9, 1, 1, 20, 10);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (11, null, 0, 0, 20, 14);
INSERT INTO public.storage (item_slot_id, item_id, amount, available, hero_id, storage_id) VALUES (2, 7, 1, 1, 20, 15);
