from math import floor


def item_gen(name, for_class, item_type_id, amount):
    for i in range(0, amount):
        print("call add_item(" + name + ",0,''," + for_class + ",0::SMALLINT," + str(
            item_type_id) + ",0,0,0,0,0,0,0,0,0,0,0);")


def all_item_types_gen():
    items = [
        ("\"Belt\"", 0),
        ("\"Boots\"", 1),
        ("\"Breastplate\"", 2),
        ("\"Gloves\"", 3),
        ("\"Headgear\"", 4),
        ("\"LuckyItem\"", 5),
        ("\"Necklace\"", 6),
        ("\"Ring\"", 7),
        ("\"Steed\"", 8),
        ("\"PrimaryWeapon\"", 9),
        ("\"SecondaryWeapon\"", 10),
        ("\"PotionPeriod\"", 11),
        ("\"PotionPermanent\"", 12)
    ]

    for pair in items:
        item_gen(pair[0],"NULL",pair[1],15)


def lvl_gen():
    exp = 100
    x = 1.2
    y = 0.1
    for i in range(1, 21):
        print("insert into levels (exp) values (", floor(exp), ");")
        exp += exp * x
        x += y


if __name__ == '__main__':
    all_item_types_gen()
