# Implements operations on hexadecimal numbers.
# CSC 225, Assignment 1
# Given code, Winter '20


def binary_to_hex(number):
    """
    Convert a 16-bit binary number to hexadecimal.
    TODO: Implement this function. Do *not* convert the number to decimal.

    :param number: A bitstring representing the number to convert
    :return: A hexadecimal string, the converted number
    """

    # add 0x first
    res = '0x'
    chart = {'0000': '0',
             '0001': '1',
             '0010': '2',
             '0011': '3',
             '0100': '4',
             '0101': '5',
             '0110': '6',
             '0111': '7',
             '1000': '8',
             '1001': '9',
             '1010': 'A',
             '1011': 'B',
             '1100': 'C',
             '1101': 'D',
             '1110': 'E',
             '1111': 'F'
             }
    for i in range(0, 16, 4):
        res += chart[number[i: i+4]]

    return res


def hex_to_binary(number):
    """
    Convert a hexadecimal number to 16-bit binary.
    TODO: Implement this function. Do *not* convert the number to decimal.

    :param number: A hexadecimal string, the number to convert
    :return: A bitstring representing the converted number
    """

    res = ''
    chart = {'0': '0000',
             '1': '0001',
             '2': '0010',
             '3': '0011',
             '4': '0100',
             '5': '0101',
             '6': '0110',
             '7': '0111',
             '8': '1000',
             '9': '1001',
             'A': '1010',
             'B': '1011',
             'C': '1100',
             'D': '1101',
             'E': '1110',
             'F': '1111'
             }

    for i in range(2,len(number)):
        res += chart[number[i]]

    return res
