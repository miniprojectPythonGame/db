# miniprojectDB
- Tomasz Ostafin
- Piotr Witek
- Jędrzej Ziebura
## SQL Database for DB course on semester 4 year 2 at Computer Science UST
## Technologies:
- Backend: Python
- Frontend: Pygame
- Database dialect: PostgreSQL

## DB schema
![alt text](https://github.com/miniprojectPythonGame/db/blob/master/docs/db_diagram.svg?raw=true)  

## Database guidebook  

### Authentication  
- API authentication :arrow_right: [here](https://github.com/miniprojectPythonGame/merged/blob/master/api/web/user.py)
- Storing user login info :arrow_right: Table *logs* line 334 [here](https://github.com/miniprojectPythonGame/db/blob/master/code/creating_tables.sql)
- Storing blocked users :arrow_right: Table *blocked_users* line 359 [here](https://github.com/miniprojectPythonGame/db/blob/master/code/creating_tables.sql)
- Names of procedures & functions & triggers
  - trigger_block_user
  - add_log
  
### Market
- All procedures code :arrow_right: [here](https://github.com/miniprojectPythonGame/db/blob/master/code/routines.sql)
- API Market handling :arrow_right: [here](https://github.com/miniprojectPythonGame/merged/blob/master/api/game_classes/objects/buildings/market.py)
- *API market tests* :arrow_right: [here](https://github.com/miniprojectPythonGame/db/tree/master/tests/BUYING_FROM_NPC.md)

#### Auctions 
- Names of procedures & functions & triggers
  - place_bet
  - resolve_auction
  - add_new_item_on_sale
  - add_finalizing_auction  
 
 *Auctions market tests* :arrow_right: [here](https://github.com/miniprojectPythonGame/db/tree/master/tests/MARKET_BACKEND_API_TESTS.md)
  
#### Buy now
- Names of procedures & functions & triggers
  - add_new_item_on_sale
  - buy_now

#### Buy orders 
- Names of procedures & functions & triggers
  - create_new_buy_now_order
  - check_buy_orders  
  
  *Buy now market tests* :arrow_right: [here](https://github.com/miniprojectPythonGame/db/tree/master/tests/BUY_NOW.md)
  
#### Filtering 
- Names of procedures & functions & triggers
  - filter_items  
 
 *Filtering tests* :arrow_right: [here](https://github.com/miniprojectPythonGame/db/tree/master/tests/FILTERING.md)

### Auxiliary functions
- Names of procedures & functions & triggers
  - add_new_cron_job  
 

### NPC shops
- Names of procedures & functions & triggers
  - sell_item_from_armour_shop
  - sell_item_from_magic_shop
  - sell_item_from_steed_shop
  - sell_item_from_weapon_shop
  - trigger_refresh_all_shops
  - remove_from_storage
  - add_to_storage
  - refresh_all_shops_for_hero  
  
 *NPC Armour shop tests* :arrow_right: [here](https://github.com/miniprojectPythonGame/db/tree/master/tests/BUYING_FROM_NPC.md)
