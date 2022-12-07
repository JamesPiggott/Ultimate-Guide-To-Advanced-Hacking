#!/usr/bin/env python3
print("This app creates one sequence of all values possible with digits between between 0 and 5")
space = input("Input a value to apply a space between every X characters: ")
low = 0
high = 5

complete_number = ""
for a in range(low,high):
    for b in range(low,high):
        for c in range(low,high):
            for d in range(low,high):
                for e in range(low,high):
                    number = str(a) + str(b) + str(c) + str(d) + str(e)

                    if number not in complete_number:
                        complete_number+=number

new_number = ""
if (space > 0):
    start = 1
    for character in complete_number:
        new_number+= character
        if start == space:
            new_number+=" "
            start = 0
        start+=1

print(new_number)
