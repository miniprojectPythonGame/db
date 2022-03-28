create procedure add_item(IN name_ character varying, IN price_ integer, IN description_ character varying,
                                     IN only_treasure_ smallint, IN item_type_id_ integer, IN min_lvl_ integer,
                                     IN strength_ integer, IN intelligence_ integer, IN dexterity_ integer,
                                     IN constitution_ integer, IN luck_ integer, IN protection_ integer, IN hp_ integer,
                                     IN persuasion_ integer, IN trade_ integer, IN leadership_ integer)
    language plpgsql
as
$$
declare
    statistic_id_ int;
begin
    statistic_id_ := add_statistics(strength_, intelligence_, dexterity_,
                                    constitution_, luck_, protection_, hp_,
                                    persuasion_, trade_, leadership_);

    insert into items (name, price, description, only_treasure, statistics_id, item_type_id, min_lvl)
    values (name_, price_, description_, only_treasure_, statistic_id_, item_type_id_, min_lvl_);
end;
$$;

create procedure add_Hero(
    IN name_ character varying,
    IN player_id_ integer,
    IN hero_class_ character,
    IN strength_ integer, IN intelligence_ integer, IN dexterity_ integer,
    IN constitution_ integer, IN luck_ integer, IN protection_ integer, IN hp_ integer,
    IN persuasion_ integer, IN trade_ integer, IN leadership_ integer)
    language plpgsql
as
$$
declare
    statistic_id_ int;
begin
    statistic_id_ := add_statistics(strength_, intelligence_, dexterity_,
                                    constitution_, luck_, protection_, hp_,
                                    persuasion_, trade_, leadership_);

    insert into heroes (name, player_id, gold, level_id, exp, hero_class, statistics_id, guild_id)
    VALUES (name_, player_id_, 0, 1, 100, hero_class_, statistic_id_, NULL);
end;
$$;

create procedure add_player(IN nick_ character varying, IN email_ character varying, IN sex_ character, IN age_ integer,IN player_id_ character varying)
    language plpgsql
as
$$
begin
    insert into players (nick, email, sex, age,player_id) values (nick_, email_, sex_, age_,player_id_);
end;
$$;

create procedure remove_player(IN player_id_ character varying)
    language plpgsql
as
$$
BEGIN
    delete from players where player_id = player_id_;
end;
$$;

CREATE PROCEDURE remove_hero(IN hero_id_ integer) AS
$$
BEGIN
    delete from heroes where hero_id = hero_id_;
end;
$$ language plpgsql;
