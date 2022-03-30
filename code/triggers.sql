create trigger hero_del_trig
    after delete
    on heroes
    for each row
execute procedure remove_statistics();

create trigger item_del_trig
    after delete
    on items
    for each row
execute procedure remove_statistics();

create or replace function remove_statistics() returns trigger
    language plpgsql as
$$
BEGIN
    delete from statistics where statistics_id = OLD.statistics_id;

    RETURN NEW;
end;
$$;