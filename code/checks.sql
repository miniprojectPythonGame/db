alter table levels
    add check ( levels.exp > 0);

alter table players
    add check ( sex = 'm' or sex = 'f');

alter table players
add check ( players.email like '^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$' );

alter table players
add check ( age >= 16);

alter table quests
add check ( quests.min_lvl >= 1);

alter table quests
add check ( quests.gold_reward > 0);

alter table quests
add check ( quests.exp_reward > 0);

alter table storage
add check ( storage.amount >= 9);

alter table storage
add check ( storage.available > 0 and storage.available <= storage.amount);