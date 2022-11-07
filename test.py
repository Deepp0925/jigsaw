# Implement a function that helps the police figures out your speeding fine 
# (name it whatever you want but following the name requirement). 
# This function will accept three parameter, the speed limit, 
# your speed and a birthday indicator. On your birthday, you can drive 5 miles 
# highers than the speed limit with no fine. This method will return your speeding fine 
# based on the three passed parameter. The fine is determined by:

# $25 for exceeding the speed limit by more than five but not more than 10 mph. 
# $100 for exceeding the speed limit by more than 10 but not more than 14 mph. 
# $125 for exceeding the speed limit by more than 14 but less than 19 mph. 
# $1000 for more than 19 or more.

# The function will return the fine amount or 0 if you are not speeding.


def speeding_fine(speed_limit, your_speed, birthday):
    if birthday:
        your_speed -= 5
    if your_speed <= speed_limit:
        return 0
    # You didn't have this part in the question
    elif speed_limit < your_speed <= speed_limit + 5:
        return 25
    elif speed_limit + 5 < your_speed <= speed_limit + 10:
        return 25
    elif speed_limit + 10 < your_speed < speed_limit + 15:
        return 100
    elif speed_limit + 15 <= your_speed < speed_limit + 19:
        return 125
    else:
        return 1000

# Implement a function named cumulativeSum that will accept a numerical list 
# as parameter and return a list of cumulative sum of the values. 
# For item indexed at i in the returned list, 
# it is the sum of the first i values in the parameter list. 
# For example, if list1=[1, 2, 3, 4, 5, 6] is 
# the passed parameter list, then [1, 3, 6, 10, 15, 21] should be the returned list. 

def cumulativeSum(list1):
    return [sum(list1[:i+1]) for i in range(len(list1))]

# Which command can be used to produce the following matrix? using numpy
# [[0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1],
# [0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2],
# [0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.3],
# [0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4],
# [0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49, 0.5],
# [0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.6],
# [0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.7],
# [0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.8],
# [0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89, 0.9],
# [0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99, 1.0]]

import numpy as np
np.arange(0.01, 1.01, 0.01).reshape(10, 10)


def dropBelowThreshold(df, colLabel, threshold):
    for x in df.index:
        if df.loc[x, colLabel] < threshold:
            df.drop(x, inplace=True)

df=pd.read_excel('tips.xlsx', 'sheet1')
dropBelowThreshold(df, 'tip', 5)
print(df)
