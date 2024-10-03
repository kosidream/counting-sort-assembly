Counting Sort and Statistical Analysis in Assembly

Overview

This assembly language program implements a Counting Sort algorithm to sort a list of numbers in ascending order. After sorting, the program calculates and displays the minimum, maximum, statistical median, sum, and average of the list. All outputs are presented in ASCII/Undecimal (base-11) format.

Author:
Kosisochukwu Nwambuonwor


Features

This program performs the following tasks:

Counting Sort:
Sorts an array of numbers in ascending order using the Counting Sort algorithm.
The algorithm counts the occurrences of each number and sorts based on those counts.
Statistical Analysis:
Minimum: The smallest number in the sorted list.
Maximum: The largest number in the sorted list.
Median: The middle value for an odd number of elements, or the average of the two middle values for an even number of elements.
Sum: The total of all numbers in the list.
Average: The sum divided by the number of elements.
Integer to ASCII/Undecimal Conversion:
Outputs all values (minimum, maximum, median, sum, and average) in base-11 format using the provided int2aUndec macro.
Debugger Script:
Includes a GDB debugger script to help trace the program and examine variables such as the list, length, minimum, median, maximum, sum, and average.
Program Structure

Sorting Algorithm:
The program uses the provided Counting Sort algorithm, which sorts an array of numbers from smallest to largest by counting their occurrences.
Statistical Calculations:
After sorting the array, the program computes the minimum, maximum, median, sum, and average from the sorted list.
Output:
Results are displayed in base-11 format, where numbers use digits 0-9 and X to represent the value 10.
