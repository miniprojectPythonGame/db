create function add_statistics(IN strength_ integer, IN intelligence_ integer, IN dexterity_ integer,
                               IN constitution_ integer, IN luck_ integer, IN protection_ integer, IN hp_ integer,
                               IN persuasion_ integer, IN trade_ integer, IN leadership_ integer)
    returns integer as
$$
declare
    statistic_id_ int;
begin
    insert into statistics (strength, intelligence, dexterity, constitution, luck, protection, hp, persuasion, trade,
                            leadership)
    values (strength_, intelligence_, dexterity_, constitution_, luck_, protection_, hp_, persuasion_, trade_,
            leadership_)
    returning statistics_id into statistic_id_;

    return statistic_id_;
end;
$$ LANGUAGE plpgsql;