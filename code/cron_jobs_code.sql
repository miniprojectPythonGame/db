-- examples
SELECT cron.schedule('nightly-vacuum', '0 10 * * *', 'VACUUM'); -- add new job
SELECT cron.unschedule(2); -- remove job with id
select * from cron.job; -- all running jobs
select * from cron.job_run_details; -- all finished jobs


--trash but might be useful

-- examples
SELECT cron.schedule('nightly-vacuum', '0 10 * * *', 'VACUUM'); -- add new job
SELECT cron.unschedule('7 ai_id'); -- remove job with id
select *
from cron.job; -- all running jobs
select *
from cron.job_run_details; -- all finished jobs


create or replace procedure add_new_cron_job(IN date timestamp, IN name varchar, IN procedure_call varchar)
    language plpgsql
as
$$
declare
    minute    int;
    hour      int;
    day_month int;
    month     int;
    cron_date varchar;
begin
    select extract(minute from date) into minute;
    select extract(hour from date) into hour;
    select extract(day from date) into day_month;
    select extract(month from date) into month;
    select concat(minute, ' ', hour, ' ', day_month, ' ', month, ' *') into cron_date;

    -- it is important that the procedure that is called runs :
    --     SELECT cron.unschedule(name); -- remove job with id

    PERFORM cron.schedule(name, cron_date, procedure_call); -- add new job
end;
$$;


create or replace procedure test_cron_job(IN name varchar)
    language plpgsql
as
$$
declare

begin
    insert into trainers (name, description, map_id) values ('', '', 0);
    PERFORM cron.unschedule(name); -- remove job with id
end;
$$;


create or replace procedure add_finalizing_auction(IN auctioned_item_id_ integer)
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


create or replace procedure resolve_auction(IN auctioned_item_id_ integer)
    language plpgsql
as
$$
declare
    seller_hero_id int;
    buyer_hero_id int;
    price int;
    item_id_ int;
begin
    select seller_id,current_leader_id,current_price,item_id from auctioned_items where auctioned_item_id = auctioned_item_id_ into seller_hero_id,buyer_hero_id,price,item_id_;

    update heroes set gold = gold - price where hero_id = buyer_hero_id;
    -- lets assume buyer has enough money - we will sort this out soon I promise
    update heroes set gold = gold + price where hero_id = seller_hero_id;
    call remove_from_storage(seller_hero_id,(select item_slot_id from storage where hero_id = seller_hero_id and item_id = item_id_));
    call add_to_storage(buyer_hero_id,item_id_,1);
    delete from auctioned_items where auctioned_item_id = auctioned_item_id_;

    PERFORM cron.unschedule(concat(auctioned_item_id_,' ai_id')); -- remove job with id
end
$$;

select extract(years from timestamp '2001-04-10');



CALL add_new_cron_job(timestamp '2022-04-24 19:15:32.765954 +00:00', 'TEST', concat('call test_cron_job(TEST);',3));



SELECT CURRENT_TIMESTAMP;

call add_to_storage(19,203,1);

call add_empty_storage(20,30);

SELECT count(*) from storage;

SELECT item_slot_id from storage where hero_id = 19 and item_slot_id > 10 and item_id is NULL order by item_slot_id limit 1;

call add_new_item_on_sale(203,17,19,1,1,'auction',timestamp '2022-04-24 20:20:06.948605');
select current_timestamp;


select place_bet(7,2,20);