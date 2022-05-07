create view currently_on_auction(seller_id, item_id, name, current_price) as
SELECT a.seller_id,
       a.item_id,
       i.name,
       a.current_price
FROM auctioned_items a
         JOIN items i ON a.item_id = i.item_id;

alter table currently_on_auction
    owner to avnadmin;

create view currently_on_sell(seller_id, item_id, name, price) as
SELECT b.seller_id,
       b.item_id,
       i.name,
       i.price
FROM buy_now_items b
         JOIN items i ON b.item_id = i.item_id;

alter table currently_on_sell
    owner to avnadmin;

