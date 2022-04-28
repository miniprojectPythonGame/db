create procedure add_player(IN nick_ character varying, IN email_ character varying, IN sex_ character, IN age_ integer, IN player_id_ character varying)
    language plpgsql
as
$$
begin
    insert into players (nick, email, sex, age,player_id) values (nick_, email_, sex_, age_,player_id_);
end;
$$;

alter procedure add_player(varchar, varchar, char, integer, varchar) owner to avnadmin;

create procedure remove_player(IN player_id_ character varying)
    language plpgsql
as
$$
BEGIN
    delete from players where player_id = player_id_;
end;
$$;

alter procedure remove_player(varchar) owner to avnadmin;

create function add_statistics(strength_ integer, intelligence_ integer, dexterity_ integer, constitution_ integer, luck_ integer, persuasion_ integer, trade_ integer, leadership_ integer, protection_ integer, initiative_ integer) returns integer
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

create function remove_statistics() returns trigger
    language plpgsql
as
$$
BEGIN
    delete from statistics where statistics_id = OLD.statistics_id;

    RETURN NEW;
end;
$$;

alter function remove_statistics() owner to avnadmin;

create procedure remove_hero(IN hero_id_ integer)
    language plpgsql
as
$$
BEGIN
    delete from storage where hero_id = hero_id_;
    delete from heroes where hero_id = hero_id_;
end;
$$;

alter procedure remove_hero(integer) owner to avnadmin;

create function remove_all_heroes() returns trigger
    language plpgsql
as
$$
BEGIN
    delete from heroes where player_id = OLD.player_id;
    RETURN NEW;
end;
$$;

alter function remove_all_heroes() owner to avnadmin;

create function add_hero(name_ character varying, player_id_ character varying, hero_class_ character, strength_ integer, intelligence_ integer, dexterity_ integer, constitution_ integer, luck_ integer, persuasion_ integer, trade_ integer, leadership_ integer, protection_ integer, initiative_ integer) returns integer
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

create procedure use_dev_pts(IN hero_id_ integer)
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

create procedure add_exp(IN hero_id_ integer, IN exp_to_add integer)
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

create procedure add_empty_storage(IN hero_id_ integer, IN empty_slots_amt integer)
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

create procedure add_item(IN name_ character varying, IN price_ integer, IN description_ character varying, IN for_class_ character, IN only_treasure_ smallint, IN item_type_id_ integer, IN min_lvl_ integer, IN strength_ integer, IN intelligence_ integer, IN dexterity_ integer, IN constitution_ integer, IN luck_ integer, IN persuasion_ integer, IN trade_ integer, IN leadership_ integer, IN protection_ integer, IN initiative_ integer)
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

create procedure add_to_storage(IN hero_id_ integer, IN item_id_ integer, IN amount_ integer)
    language plpgsql
as
$$
declare
    smallest_item_slot_id int;
BEGIN
    SELECT item_slot_id into smallest_item_slot_id from storage where hero_id = hero_id_ and item_slot_id > 10 and item_id is NULL order by item_slot_id limit 1;
    update storage set item_id = item_id_ where item_slot_id = smallest_item_slot_id and hero_id = hero_id_;
    update storage set amount = amount_ where item_slot_id = smallest_item_slot_id and hero_id = hero_id_;
    update storage set available = 1 where item_slot_id = smallest_item_slot_id and hero_id = hero_id_;
    update items set owner_id = hero_id_ where item_id = item_id_;
end;
$$;

alter procedure add_to_storage(integer, integer, integer) owner to avnadmin;

create procedure move_in_storage(IN hero_id_ integer, IN curr_item_slot_id integer, IN future_item_slot_id integer)
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

create function get_item(item_id_ integer)
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

create procedure remove_from_storage(IN hero_id_ integer, IN item_slot_id_ integer)
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

create procedure add_empty_shops_for_hero(IN hero_id_ integer)
    language plpgsql
as
$$
begin
    for i in 0..19 loop
            insert into steed_shop (item_id, hero_id,item_slot_id) values (NULL,hero_id_,i);
            insert into weapon_shop (item_id, hero_id,item_slot_id) values (NULL,hero_id_,i);
            insert into magic_shop (item_id, hero_id,item_slot_id) values (NULL,hero_id_,i);
            insert into armour_shop (item_id, hero_id,item_slot_id) values (NULL,hero_id_,i);
        end loop;
end;
$$;

alter procedure add_empty_shops_for_hero(integer) owner to avnadmin;

create function system_rows(internal) returns tsm_handler
    strict
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function system_rows(internal) owner to postgres;

create procedure refresh_armour_shop_for_hero(IN hero_id_ integer)
    language plpgsql
as
$$
declare
    item_id_ int;
    item_slot_id_ int = 0;
begin

    for item_id_ in
        select item_id from items where owner_id is null AND item_type_id IN (0, 1, 2, 3, 4) ORDER BY random() LIMIT 20
        loop
            update armour_shop set item_id = item_id_ where hero_id = hero_id_ and item_slot_id = item_slot_id_;
            item_slot_id_ = item_slot_id_ + 1;
        end loop;
end;
$$;

alter procedure refresh_armour_shop_for_hero(integer) owner to avnadmin;

create procedure refresh_magic_shop_for_hero(IN hero_id_ integer)
    language plpgsql
as
$$
declare
    item_id_ int;
    item_slot_id_ int = 0;
begin

    for item_id_ in
        select item_id from items where owner_id is null AND item_type_id IN (5, 6, 7, 11, 12) ORDER BY random() LIMIT 20
        loop
            update magic_shop set item_id = item_id_ where hero_id = hero_id_ and item_slot_id = item_slot_id_;
            item_slot_id_ = item_slot_id_ + 1;
        end loop;
end;
$$;

alter procedure refresh_magic_shop_for_hero(integer) owner to avnadmin;

create procedure refresh_weapon_shop_for_hero(IN hero_id_ integer)
    language plpgsql
as
$$
declare
    item_id_ int;
    item_slot_id_ int = 0;
begin

    for item_id_ in
        select item_id from items where owner_id is null AND item_type_id IN (9,10) ORDER BY random() LIMIT 20
        loop
            update weapon_shop set item_id = item_id_ where hero_id = hero_id_ and item_slot_id = item_slot_id_;
            item_slot_id_ = item_slot_id_ + 1;
        end loop;
end;
$$;

alter procedure refresh_weapon_shop_for_hero(integer) owner to avnadmin;

create procedure refresh_steed_shop_for_hero(IN hero_id_ integer)
    language plpgsql
as
$$
declare
    item_id_ int;
    item_slot_id_ int = 0;
begin

    for item_id_ in
        select item_id from items where owner_id is null AND item_type_id = 8 ORDER BY random() LIMIT 20
        loop
            update steed_shop set item_id = item_id_ where hero_id = hero_id_ and item_slot_id = item_slot_id_;
            item_slot_id_ = item_slot_id_ + 1;
        end loop;
end;
$$;

alter procedure refresh_steed_shop_for_hero(integer) owner to avnadmin;

create procedure refresh_all_shops_for_hero(IN hero_id_ integer)
    language plpgsql
as
$$
begin
    call refresh_armour_shop_for_hero(hero_id_);
    call refresh_magic_shop_for_hero(hero_id_);
    call refresh_steed_shop_for_hero(hero_id_);
    call refresh_weapon_shop_for_hero(hero_id_);
end;
$$;

alter procedure refresh_all_shops_for_hero(integer) owner to avnadmin;

create procedure sell_item_from_armour_shop(IN hero_id_ integer, IN item_id_ integer)
    language plpgsql
as
$$
begin
    update heroes
    set gold = gold - (select price
                       from items
                       where item_id = item_id_)
    where hero_id = hero_id_;

    call add_to_storage(hero_id_,item_id_,1);

    update armour_shop
    set item_id = (select item_id
                   from items
                   where owner_id is null
                     AND item_type_id IN (0, 1, 2, 3, 4)
                   ORDER BY random()
                   LIMIT 1
    )
    where hero_id = hero_id_
      and item_id = item_id_;
end;
$$;

alter procedure sell_item_from_armour_shop(integer, integer) owner to avnadmin;

create procedure sell_item_from_magic_shop(IN hero_id_ integer, IN item_id_ integer)
    language plpgsql
as
$$
begin
    update heroes
    set gold = gold - (select price
                       from items
                       where item_id = item_id_)
    where hero_id = hero_id_;

    call add_to_storage(hero_id_,item_id_,1);

    update magic_shop
    set item_id = (select item_id
                   from items
                   where owner_id is null
                     AND item_type_id IN (0, 1, 2, 3, 4)
                   ORDER BY random()
                   LIMIT 1
    )
    where hero_id = hero_id_
      and item_id = item_id_;
end;
$$;

alter procedure sell_item_from_magic_shop(integer, integer) owner to avnadmin;

create procedure sell_item_from_steed_shop(IN hero_id_ integer, IN item_id_ integer)
    language plpgsql
as
$$
begin
    update heroes
    set gold = gold - (select price
                       from items
                       where item_id = item_id_)
    where hero_id = hero_id_;

    call add_to_storage(hero_id_,item_id_,1);

    update steed_shop
    set item_id = (select item_id
                   from items
                   where owner_id is null
                     AND item_type_id IN (0, 1, 2, 3, 4)
                   ORDER BY random()
                   LIMIT 1
    )
    where hero_id = hero_id_
      and item_id = item_id_;
end;
$$;

alter procedure sell_item_from_steed_shop(integer, integer) owner to avnadmin;

create procedure sell_item_from_weapon_shop(IN hero_id_ integer, IN item_id_ integer)
    language plpgsql
as
$$
begin
    update heroes
    set gold = gold - (select price
                       from items
                       where item_id = item_id_)
    where hero_id = hero_id_;

    call add_to_storage(hero_id_,item_id_,1);

    update steed_shop
    set item_id = (select item_id
                   from items
                   where owner_id is null
                     AND item_type_id IN (0, 1, 2, 3, 4)
                   ORDER BY random()
                   LIMIT 1
    )
    where hero_id = hero_id_
      and item_id = item_id_;
end;
$$;

alter procedure sell_item_from_weapon_shop(integer, integer) owner to avnadmin;

create function trigger_refresh_all_shops() returns trigger
    language plpgsql
as
$$
DECLARE last_login_time timestamp;
    BEGIN
       SELECT login_time FROM logs WHERE player_id = NEW.player_id ORDER BY login_time DESC LIMIT 1 INTO last_login_time;
        IF date_part('day',NEW.login_time - last_login_time) >= 1 THEN --assumming that refresh comes after new login every day not every 24 hours
            EXECUTE refresh_all_shops_for_hero(NEW.hero_id);
        END IF;
    END;
$$;

alter function trigger_refresh_all_shops() owner to avnadmin;

create procedure create_new_buy_now_order(IN proc_buyer_id integer, IN proc_amount integer, IN proc_item_id integer, IN proc_target_unit_price integer)
    language plpgsql
as
$$
DECLARE
    hero_exists integer;
    item_exists integer;
    hero_money integer;
BEGIN
    SELECT Count(*) FROM items WHERE item_id = proc_item_id GROUP BY item_id INTO item_exists;

    SELECT Count(*) FROM heroes WHERE hero_id = proc_buyer_id GROUP BY  hero_id INTO hero_exists;

    SELECT gold FROM heroes where hero_id = proc_buyer_id INTO hero_money;

    IF hero_exists = 1 AND item_exists = 1 AND proc_target_unit_price*proc_amount <= hero_money THEN
        INSERT INTO buy_orders (buyer_id, amount, item_id, target_unit_price, order_date)
        VALUES (proc_buyer_id,proc_amount,proc_item_id,proc_target_unit_price, CURRENT_DATE);
    ELSE
        RAISE NOTICE 'New buy now order cannot be created';
        END IF;
END;
$$;

alter procedure create_new_buy_now_order(integer, integer, integer, integer) owner to avnadmin;

create function place_bet(auctioned_item_id_ integer, bet integer, hero_id_ integer) returns character varying
    language plpgsql
as
$$
DECLARE
BEGIN
    if (select hero_id from heroes where hero_id = hero_id_) is NULL THEN
        return 'No match for hero with that hero_id';
    end if;
    if (select gold from heroes where hero_id = hero_id_) < bet then
        return 'Not enough coins brother';
    end if;
    if (select auction_end_date from auctioned_items where auctioned_item_id = auctioned_item_id_) is NULL THEN
        return 'No match for item with that auctioned_item_id';
    end if;
    if bet <= 0 then
        return 'Bet <= 0 - not sure about that';
    end if;
    if bet <= (select current_price from auctioned_items where auctioned_item_id = auctioned_item_id_) then
        return 'Your bet is to low brother';
    end if;

    UPDATE auctioned_items SET current_price = bet where auctioned_item_id = auctioned_item_id_;
    UPDATE auctioned_items SET current_leader_id = hero_id_ where auctioned_item_id = auctioned_item_id_;
    return 'SUCCESS';
END ;
$$;

alter function place_bet(integer, integer, integer) owner to avnadmin;

create procedure add_new_cron_job(IN date timestamp without time zone, IN name character varying, IN procedure_call character varying)
    language plpgsql
as
$$
declare
    minute   int;
    hour      int;
    day_month int;
    month     int;
    cron_date varchar;
begin
    select extract(minute from date) into minute;
    select extract(hour from date) into hour;
    select extract(day from date) into day_month;
    select extract(month from date) into month;
    select concat(minute,' ',hour,' ',day_month,' ',month,' *') into cron_date;

    -- it is important that the procedure that is called runs :
    --     SELECT cron.unschedule(name); -- remove job with id

    PERFORM cron.schedule(name,cron_date, procedure_call); -- add new job
end;
$$;

alter procedure add_new_cron_job(timestamp, varchar, varchar) owner to avnadmin;

create procedure add_finalizing_auction(IN auctioned_item_id_ integer)
    language plpgsql
as
$$
declare

begin
    call add_new_cron_job((select auction_end_date from auctioned_items where auctioned_item_id = auctioned_item_id_),
                          concat(auctioned_item_id_, ' ai_id'),
                          concat('call resolve_auction(''', auctioned_item_id_, ''');'));
end
$$;

alter procedure add_finalizing_auction(integer) owner to avnadmin;

create procedure resolve_auction(IN auctioned_item_id_ integer)
    language plpgsql
as
$$
declare
    seller_hero_id int;
    buyer_hero_id int;
    price int;
    item_id_ int;
    item_slot_id_ int;
begin
    select seller_id,current_leader_id,current_price,item_id into seller_hero_id,buyer_hero_id,price,item_id_ from auctioned_items where auctioned_item_id = auctioned_item_id_;
    select item_slot_id into item_slot_id_ from storage where hero_id = seller_hero_id and item_id = item_id_;
    update heroes set gold = gold - price where hero_id = buyer_hero_id;
    -- lets assume buyer has enough money - we will sort this out soon I promise
    update heroes set gold = gold + price where hero_id = seller_hero_id;
    call remove_from_storage(seller_hero_id,item_slot_id_);
    call add_to_storage(buyer_hero_id,item_id_,1);
    delete from auctioned_items where auctioned_item_id = auctioned_item_id_;

    PERFORM cron.unschedule(concat(auctioned_item_id_,' ai_id')); -- remove job with id
end
$$;

alter procedure resolve_auction(integer) owner to avnadmin;

create procedure add_new_item_on_sale(IN proc_item_id integer, IN proc_storage_id integer, IN proc_seller_id integer, IN proc_start_or_selling_price integer, IN proc_amount integer, IN proc_what_type character varying, IN proc_if_auction_end_date timestamp without time zone)
    language plpgsql
as
$$
DECLARE
    hero_exists              integer;
    item_exists              integer;
    items_available_for_sale integer;
    auctioned_item_id_       int;
BEGIN
    SELECT Count(*) FROM items WHERE item_id = proc_item_id GROUP BY item_id INTO item_exists;

    SELECT Count(*) FROM heroes WHERE hero_id = proc_seller_id GROUP BY hero_id INTO hero_exists;

    SELECT COUNT(*)
    FROM storage
    WHERE storage_id = proc_storage_id
      AND hero_id = proc_seller_id
      AND amount >= proc_amount
      AND available = 1
    INTO items_available_for_sale;

    IF hero_exists = 1 AND item_exists = 1 AND items_available_for_sale = 1 THEN
        IF proc_what_type = 'auction' THEN
            INSERT INTO auctioned_items(item_id, current_price, amount, start_price, seller_id, auction_end_date,
                                        auction_start_date, storage_id)
            VALUES (proc_item_id, proc_start_or_selling_price, proc_amount, proc_start_or_selling_price, proc_seller_id,
                    proc_if_auction_end_date, current_timestamp, proc_storage_id)
            returning auctioned_item_id into auctioned_item_id_;

            call add_new_cron_job(
                    proc_if_auction_end_date,
                    concat(auctioned_item_id_, ' ai_id'),
                    concat('call resolve_auction(''', auctioned_item_id_, ''');'));


        ELSEIF proc_what_type = 'buy_now' THEN
            INSERT INTO buy_now_items(item_id, selling_price, amount, seller_id, post_date, storage_id)
            VALUES (proc_item_id, proc_start_or_selling_price, proc_amount, proc_seller_id, current_date,
                    proc_storage_id);
        END IF;
    ELSE
        RAISE NOTICE 'New offer cannot be created';
    END IF;

END;
$$;

alter procedure add_new_item_on_sale(integer, integer, integer, integer, integer, varchar, timestamp) owner to avnadmin;

