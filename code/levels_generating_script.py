from math import floor
if __name__ == '__main__':
    exp = 100
    x = 1.2
    y = 0.1
    for i in range(1, 21):
        print("insert into levels (exp) values (",floor(exp),");")
        exp += exp*x
        x += y
