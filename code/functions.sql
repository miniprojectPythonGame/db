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
