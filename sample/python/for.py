# https://note.nkmk.me/python-for-usage/
l = ['Alice', 'Bob', 'Charlie']

for name in l:
    if name == 'Bob':
        print('!!BREAK!!')
        break
    print(name)
else:
    print('!!FINISH!!')
# Alice
# !!BREAK!!

for name in l:
    if name == 'Bob':
        print('!!SKIP!!')
        continue
    print(name)
else:
    print('!!FINISH!!')
# Alice
# !!SKIP!!
# Charlie
# !!FINISH!!

l = ['A', 'B', 'C', 'D', 'E', 'F', 'G']

for c in l[2:5]:
    print(c)
# C
# D
# E

for c in l[::2]:
    print(c)
# A
# C
# E
# G

for c in l[1::2]:
    print(c)
# B
# D
# F

for i in range(3):
    print(i)
# 0
# 1
# 2

print(list(range(3)))
# [0, 1, 2]

print(list(range(6)))
# [0, 1, 2, 3, 4, 5]

print(list(range(10, 13)))
# [10, 11, 12]

print(list(range(0, 10, 3)))
# [0, 3, 6, 9]

print(list(range(10, 0, -3)))
# [10, 7, 4, 1]

l = ['Alice', 'Bob', 'Charlie']

for name in l:
    print(name)
# Alice
# Bob
# Charlie

for i, name in enumerate(l):
    print(i, name)
# 0 Alice
# 1 Bob
# 2 Charlie


for i, name in enumerate(l, 1):
    print(i, name)
# 1 Alice
# 2 Bob
# 3 Charlie

for i, name in enumerate(l, 42):
    print(i, name)
# 42 Alice
# 43 Bob
# 44 Charlie

step = 3
for i, name in enumerate(l):
    print(i * step, name)
# 0 Alice
# 3 Bob
# 6 Charlie

names = ['Alice', 'Bob', 'Charlie']
ages = [24, 50, 18]

for name, age in zip(names, ages):
    print(name, age)
# Alice 24
# Bob 50
# Charlie 18

points = [100, 85, 90]

for name, age, point in zip(names, ages, points):
    print(name, age, point)
# Alice 24 100
# Bob 50 85
# Charlie 18 90


names = ['Alice', 'Bob', 'Charlie']
ages = [24, 50, 18]

for i, (name, age) in enumerate(zip(names, ages)):
    print(i, name, age)
# 0 Alice 24
# 1 Bob 50
# 2 Charlie 18


l = ['Alice', 'Bob', 'Charlie']

for name in reversed(l):
    print(name)
# Charlie
# Bob
# Alice


for i in reversed(range(3)):
    print(i)
# 2
# 1
# 0

for i in range(2, -1, -1):
    print(i)
# 2
# 1
# 0

# for i, name in reversed(enumerate(l)):
#     print(i, name)
# TypeError: 'enumerate' object is not reversible

for i, name in reversed(list(enumerate(l))):
    print(i, name)
# 2 Charlie
# 1 Bob
# 0 Alice


for i, name in enumerate(reversed(l)):
    print(i, name)
# 0 Charlie
# 1 Bob
# 2 Alice


l2 = [24, 50, 18]

# for name, age in reversed(zip(l, l2)):
#     print(name, age)
# TypeError: 'zip' object is not reversible

for name, age in reversed(list(zip(l, l2))):
    print(name, age)
# Charlie 18
# Bob 50
# Alice 24


l1 = [1, 2, 3]
l2 = [10, 20, 30]

for i in l1:
    for j in l2:
        print(i, j)
# 1 10
# 1 20
# 1 30
# 2 10
# 2 20
# 2 30
# 3 10
# 3 20
# 3 30


import itertools

l1 = [1, 2, 3]
l2 = [10, 20, 30]

for i, j in itertools.product(l1, l2):
    print(i, j)
# 1 10
# 1 20
# 1 30
# 2 10
# 2 20
# 2 30
# 3 10
# 3 20
# 3 30

d = {'key1': 1, 'key2': 2, 'key3': 3}

for k in d:
    print(k)
# key1
# key2
# key3


for v in d.values():
    print(v)
# 1
# 2
# 3


for k, v in d.items():
    print(k, v)
# key1 1
# key2 2
# key3 3


squares = [i**2 for i in range(5)]
print(squares)
# [0, 1, 4, 9, 16]

squares = []
for i in range(5):
    squares.append(i**2)

print(squares)
# [0, 1, 4, 9, 16]




