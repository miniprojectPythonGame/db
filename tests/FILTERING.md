## Testing filtering items used in the Market
### Lets check what is on the Market
```postgresql
select *
from buy_now_items;
```
![alt text](https://github.com/miniprojectPythonGame/db/blob/master/docs/tests/filtering_tests/items_on_market.png?raw=true)

### Invoking the filtering function
#### Search for items starting with 'Belt' (case insensitive)
```postgresql
select i.item_id, i.name
from items i
         join filter_items('Belt'::varchar, array [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 0, 56,
                           array ['w', 'a']::"char"[]) f_i on f_i.item_id = i.item_id;
```
![alt text](https://github.com/miniprojectPythonGame/db/blob/master/docs/tests/filtering_tests/name_belt.png?raw=true)

#### Search for items starting with 'B' or 'b'
```postgresql
select i.item_id, i.name
from items i
         join filter_items('B'::varchar, array [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 24, 56,
                           array ['w', 'a']::"char"[]) f_i on f_i.item_id = i.item_id;
```
![alt text](https://github.com/miniprojectPythonGame/db/blob/master/docs/tests/filtering_tests/name_b.png?raw=true)

#### Search for items starting with 'G' or 'g'
```postgresql
select i.item_id, i.name
from items i
         join filter_items('g'::varchar, array [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 24, 56,
                           array ['w', 'a']::"char"[]) f_i on f_i.item_id = i.item_id;
```
![alt text](https://github.com/miniprojectPythonGame/db/blob/master/docs/tests/filtering_tests/name_g.png?raw=true)

#### Search for items with type 0
```postgresql
select i.item_id, i.name, i.item_type_id
from items i
         join filter_items(''::varchar, array [0], 24, 56, array ['w', 'a']::"char"[]) f_i on f_i.item_id = i.item_id;
```
![alt text](https://github.com/miniprojectPythonGame/db/blob/master/docs/tests/filtering_tests/type_0.png?raw=true)

#### Search for items with type 0 or 1
```postgresql
select i.item_id, i.name, i.item_type_id
from items i
         join filter_items(''::varchar, array [0, 1], 24, 56, array ['w', 'a']::"char"[]) f_i
              on f_i.item_id = i.item_id;
```
![alt text](https://github.com/miniprojectPythonGame/db/blob/master/docs/tests/filtering_tests/type_0_1.png?raw=true)

#### Search for items with selling price in range [30, 42]
```postgresql
select i.item_id, i.name, bni.selling_price
from items i
         join filter_items(''::varchar, array [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 30, 42,
                           array ['w', 'a']::"char"[]) f_i on f_i.item_id = i.item_id
         join buy_now_items bni on i.item_id = bni.item_id;
```
![alt text](https://github.com/miniprojectPythonGame/db/blob/master/docs/tests/filtering_tests/price_range_30_42.png?raw=true)

#### Search for items for archers
```postgresql
select i.item_id, i.name, i.for_class
from items i
         join filter_items(''::varchar, array [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 24, 56,
                           array ['a']::"char"[]) f_i on f_i.item_id = i.item_id;
```
![alt text](https://github.com/miniprojectPythonGame/db/blob/master/docs/tests/filtering_tests/type_a.png?raw=true)
