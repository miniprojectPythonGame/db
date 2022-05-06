# Tomek

- [x] filtry
    - [x] search po nazwie
    - [x] checkbox na item_type
    - [x] min price
    - [x] max price
    - [x] for_class - dla jakich klas
- [x] procedura kup teraz
- [x] trigger na insert do buy_now_items sprawdzający:
- [x] walidacja (?)
- [x] przekazanie itemów
- [x] usunąć zlecenie kupna
- [x] usunąć wystawiony item z buy_now_items
- [x] wybieranie kupca na podstawie daty wystawienia zlecenia kupna (NIE na podstawie najwyższej kwoty zlecenia
      kupna)

# Piotrek

- [x] job (lub odpowiednik) na koniec licytacji
- [x] (?) dodanie licytacji
- [x] betowanie w licytacji
- [ ] testowanie 
- [ ] buy_now_orders
- [ ] buy_now

# Jędrzej

- [x] refresh sklepików dla gracza przy jego pierwszym logowaniu danego dnia - trigger na pierwszy insert do logów
- [x] dodanie tabeli logów uzytkowników
- [x] dodawanie do sprzedawanych
- [x] dodanie zlecenia kupna do buy_orders
- [x] widok - wyświetlanie dla każdego gracza jego sprzedawanych
- [x] tabela zawierająca informacje o zablokowanych użytkownikach blocked_users(player_id,block_start,block_end,reason)
- [x] trigger check_if_needs_block() - trigger na insert do logów, jeśli były 3 nieudane próby dodaje blocka do tabeli
  blocked_users()
- [x] add_log(player_id,login_status) dodawanie logów udanych bądź nieudanych

# New tasks:
- [ ] quality produktu przyjmuje tylko wartości 1,2,3 i trzeba to sprawdzać
- [ ] przetestować add_item (były zmiany w tabeli item - dodano quality)


