create procedure add_item(IN name_ character varying, IN price_ integer, IN description_ character varying, IN only_treasure_ smallint, IN item_type_id_ integer, IN min_lvl_ integer, IN strength_ integer, IN intelligence_ integer, IN dexterity_ integer, IN constitution_ integer, IN luck_ integer, IN protection_ integer, IN hp_ integer, IN persuasion_ integer, IN trade_ integer, IN leadership_ integer)
    language plpgsql
as
$$
declare
    statistic_id_ int;
begin
    insert into statistics (strength, intelligence, dexterity, constitution, luck, protection, hp, persuasion, trade,
                            leadership)
    values (strength_, intelligence_, dexterity_, constitution_, luck_, protection_, hp_, persuasion_, trade_,
            leadership_)
    returning statistics_id into statistic_id_;

    insert into items (name, price, description, only_treasure, statistics_id, item_type_id, min_lvl)
    values (name_, price_, description_, only_treasure_, statistic_id_, item_type_id_, min_lvl_);
end;
$$;

alter procedure add_item(varchar, integer, varchar, smallint, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer) owner to avnadmin;

