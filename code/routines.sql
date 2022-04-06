create or replace procedure add_player(IN nick_ character varying, IN email_ character varying, IN sex_ character, IN age_ integer, IN player_id_ character varying)
    language plpgsql
as
$$
begin
    insert into players (nick, email, sex, age,player_id) values (nick_, email_, sex_, age_,player_id_);
end;
$$;

alter procedure add_player(varchar, varchar, char, integer, varchar) owner to avnadmin;

create or replace procedure remove_player(IN player_id_ character varying)
    language plpgsql
as
$$
BEGIN
    delete from players where player_id = player_id_;
end;
$$;

alter procedure remove_player(varchar) owner to avnadmin;

create or replace function add_statistics(strength_ integer, intelligence_ integer, dexterity_ integer, constitution_ integer, luck_ integer, persuasion_ integer, trade_ integer, leadership_ integer, protection_ integer, initiative_ integer) returns integer
    language plpgsql
as
$$
declare
    statistic_id_ int;
begin
    insert into statistics (strength, intelligence, dexterity, constitution, luck, persuasion, trade,
                            leadership, protection, initiative)

    values (strength_, intelligence_, dexterity_, constitution_, luck_, persuasion_, trade_,
            leadership_, protection_, initiative_)

    returning statistics_id into statistic_id_;

    return statistic_id_;
end;
$$;

alter function add_statistics(integer, integer, integer, integer, integer, integer, integer, integer, integer, integer) owner to avnadmin;

create or replace function remove_statistics() returns trigger
    language plpgsql
as
$$
BEGIN
    delete from statistics where statistics_id = OLD.statistics_id;

    RETURN NEW;
end;
$$;

alter function remove_statistics() owner to avnadmin;

create or replace procedure remove_hero(IN hero_id_ integer)
    language plpgsql
as
$$
BEGIN
    delete from storage where hero_id = hero_id_;
    delete from heroes where hero_id = hero_id_;
end;
$$;

alter procedure remove_hero(integer) owner to avnadmin;

create or replace function remove_all_heroes() returns trigger
    language plpgsql
as
$$
BEGIN
    delete from heroes where player_id = OLD.player_id;
    RETURN NEW;
end;
$$;

alter function remove_all_heroes() owner to avnadmin;

create or replace function add_hero(name_ character varying, player_id_ character varying, hero_class_ character, strength_ integer, intelligence_ integer, dexterity_ integer, constitution_ integer, luck_ integer, persuasion_ integer, trade_ integer, leadership_ integer, protection_ integer, initiative_ integer) returns integer
    language plpgsql
as
$$
declare
    statistic_id_ int;
    hero_id_ int;
    exp_next_lvl int;
begin
    statistic_id_ := add_statistics(strength_, intelligence_, dexterity_, constitution_, luck_, persuasion_, trade_,
                                    leadership_, protection_, initiative_);
    select exp into exp_next_lvl from levels where level_id = 2;

    insert into heroes (name, player_id, gold, level_id, exp, hero_class, statistics_id, guild_id,free_development_pts,exp_next_lvl)
    VALUES (name_, player_id_, 0, 1, 100, hero_class_, statistic_id_, NULL,4,exp_next_lvl) returning hero_id into hero_id_;

    call add_empty_storage(hero_id_,30);
    return hero_id_;
end;
$$;

alter function add_hero(varchar, varchar, char, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer) owner to avnadmin;

create or replace procedure use_dev_pts(IN hero_id_ integer)
    language plpgsql
as
$$
begin
    update heroes
    set free_development_pts = free_development_pts - 1
    where hero_id = hero_id_ and free_development_pts > 0;
end;
$$;

alter procedure use_dev_pts(integer) owner to avnadmin;

create or replace procedure add_exp(IN hero_id_ integer, IN exp_to_add integer)
    language plpgsql
as
$$
begin
    update heroes
    set exp = exp + exp_to_add
    where hero_id = hero_id_;

    if (select exp from heroes where hero_id = hero_id_)+exp_to_add  >=
       (select exp_next_lvl from heroes where hero_id = hero_id_) then

        update heroes
        set free_development_pts = free_development_pts + 4
        where hero_id = hero_id_;

         update heroes
        set level_id = level_id + 1
        where hero_id = hero_id_;

        update heroes
        set exp_next_lvl = (select exp from levels where levels.level_id = heroes.level_id + 1)
        where hero_id = hero_id_;
    end if;

end;
$$;

alter procedure add_exp(integer, integer) owner to avnadmin;

create or replace procedure add_empty_storage(IN hero_id_ integer, IN empty_slots_amt integer)
    language plpgsql
as
$$
declare curr_slots_amt int;
BEGIN
    SELECT count(*) into curr_slots_amt from storage where hero_id = hero_id_;
    for r in curr_slots_amt..curr_slots_amt+empty_slots_amt-1 loop
        insert into storage (item_slot_id, item_id, amount, available, hero_id) values (r,NULL,0,0,hero_id_);
        end loop;
end;
$$;

alter procedure add_empty_storage(integer, integer) owner to avnadmin;

create or replace procedure add_item(IN name_ character varying, IN price_ integer, IN description_ character varying, IN for_class_ character, IN only_treasure_ smallint, IN item_type_id_ integer, IN min_lvl_ integer, IN strength_ integer, IN intelligence_ integer, IN dexterity_ integer, IN constitution_ integer, IN luck_ integer, IN persuasion_ integer, IN trade_ integer, IN leadership_ integer, IN protection_ integer, IN initiative_ integer)
    language plpgsql
as
$$
declare
    statistic_id_ int;
begin
    statistic_id_ := add_statistics(strength_, intelligence_, dexterity_, constitution_, luck_, persuasion_, trade_,
                                    leadership_, protection_, initiative_);

    insert into items (name, price, description, only_treasure, statistics_id, item_type_id, min_lvl, for_class)
    values (name_, price_, description_, only_treasure_, statistic_id_, item_type_id_, min_lvl_,for_class_);
end;
$$;

alter procedure add_item(varchar, integer, varchar, char, smallint, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer) owner to avnadmin;

create or replace procedure add_to_storage(IN hero_id_ integer, IN item_id_ integer, IN amount_ integer)
    language plpgsql
as
$$
declare
    smallest_item_slot_id int;
BEGIN
    SELECT item_slot_id into smallest_item_slot_id from storage where hero_id = hero_id_ and item_slot_id > 10 and item_id is NULL  limit 1;
    update storage set item_id = item_id_ where item_slot_id = smallest_item_slot_id;
    update storage set amount = amount_ where item_slot_id = smallest_item_slot_id;
    update storage set available = 1 where item_slot_id = smallest_item_slot_id;
    update items set owner_id = hero_id_ where item_id = item_id_;
end;
$$;

alter procedure add_to_storage(integer, integer, integer) owner to avnadmin;

create or replace procedure move_in_storage(IN hero_id_ integer, IN curr_item_slot_id integer, IN future_item_slot_id integer)
    language plpgsql
as
$$
BEGIN
    update storage set item_slot_id = -1 where hero_id = hero_id_ and item_slot_id = future_item_slot_id;
    update storage set item_slot_id = future_item_slot_id where hero_id = hero_id_ and item_slot_id = curr_item_slot_id;
    update storage set item_slot_id = curr_item_slot_id where hero_id = hero_id_ and item_slot_id = -1;
end;
$$;

alter procedure move_in_storage(integer, integer, integer) owner to avnadmin;

create or replace function get_item(item_id_ integer)
    returns TABLE(name character varying, price integer, description character varying, only_treasure smallint, item_type_id integer, min_lvl integer, for_class character, strength integer, intelligence integer, dexterity integer, constitution integer, luck integer, persuasion integer, trade integer, leadership integer, protection integer, initiative integer)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT I.name,
               I.price,
               I.description,
               I.only_treasure,
               I.item_type_id,
               I.min_lvl,
               I.for_class,
               s.strength,
               s.intelligence,
               s.dexterity,
               s.constitution,
               s.luck,
               s.persuasion,
               s.trade,
               s.leadership,
               s.protection,
               s.initiative
        FROM items I
                 JOIN statistics s on s.statistics_id = I.statistics_id
        WHERE I.item_id = item_id_;
end;
$$;

alter function get_item(integer) owner to avnadmin;

create or replace procedure remove_from_storage(IN hero_id_ integer, IN item_slot_id_ integer)
    language plpgsql
as
$$
declare
        item_id_ int;
BEGIN
    select item_id into item_id_ from storage where hero_id = hero_id_ and item_slot_id = item_slot_id_;
    update storage set item_id = NULL where hero_id = hero_id_ and item_slot_id = item_slot_id_;
    update storage set amount = 0 where hero_id = hero_id_ and item_slot_id = item_slot_id_;
    update storage set available = 0 where hero_id = hero_id_ and item_slot_id = item_slot_id_;
    update items set owner_id = NULL where item_id = item_id_;
end;
$$;

alter procedure remove_from_storage(integer, integer) owner to avnadmin;

create or replace procedure add_empty_shops_for_hero(IN hero_id_ integer)
    language plpgsql
as
$$
begin
    for _ in 1..20 loop
            insert into stable_shop (item_id, hero_id) values (NULL,hero_id_);
            insert into weapon_shop (item_id, hero_id) values (NULL,hero_id_);
            insert into magic_shop (item_id, hero_id) values (NULL,hero_id_);
            insert into armour_shop (item_id, hero_id) values (NULL,hero_id_);
        end loop;
end;
$$;

alter procedure add_empty_shops_for_hero(integer) owner to avnadmin;

