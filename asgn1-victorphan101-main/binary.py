# Implements operations on binary numbers.
# CSC 225, Assignment 1
# Given code, Spring '22


def add(addend_a, addend_b):
    """
    Add two 16-bit, two's complement numbers; ignore carries/overflows.
    TODO: Implement this function. Do *not* convert the numbers to decimal.

    :param addend_a: A bitstring representing the first number
    :param addend_b: A bitstring representing the second number
    :return: A bitstring representing the sum
    """
    carry = '0'
    res = ""

    a, b = list(addend_a), list(addend_b)
    for i in range(max(len(a), len(b))):
        if a[len(a) - 1 - i] == '1' and b[len(b) - 1 - i] == '1':
            if carry == '1':
                res = '1' + res
            else:
                carry = '1'
                res = '0' + res
        elif a[len(a) - 1 - i] == '0' and b[len(b) - 1 - i] == '1' or a[len(a) - 1 - i] == '1' and b[
            len(b) - 1 - i] == '0':
            if carry == '1':
                res = '0' + res
            else:
                res = '1' + res
        else:
            if carry == '1':
                res = '1' + res
                carry = '0'
            else:
                res = '0' + res

    if carry == '1':
        res = '1' + res

    #cannot be negative zero
    if res[0] == '1' and '1' not in res[1:]:
        return res[1:]

    return res


def negate(number):
    """
    Negate a 16-bit, two's complement number.
    TODO: Implement this function. Do *not* convert the number to decimal.

    :param number: A bitstring representing the number to negate
    :return: A bistring representing the negated number
    """
    res = ""
    for i in range(len(number)):
        if number[i] == '0':
            res += '1'
        else:
            res += '0'

    res = add(res, '0000000000000001')

    return res


def subtract(minuend, subtrahend):
    """
    Subtract one 16-bit, two's complement number from another.
    TODO: Implement this function. Do *not* convert the numbers to decimal.

    :param minuend: A bitstring representing the number from which to subtract
    :param subtrahend: A bitstring representing the number to subtract
    :return: A bitstring representing the difference
    """

    b = negate(subtrahend)
    res = add(minuend, b)

    if res[0] == '1':
        return res[1:]
    return res

def multiply(multiplicand_a, multiplicand_b):
    """
    Multiply two 16-bit, two's complement numbers; ignore carries/overflows.
    TODO: Implement this function. Do *not* convert the numbers to decimal.

    :param multiplicand_a: A bitstring representing the first number
    :param multiplicand_b: A bitstring representing the second number
    :return: A bitstring representing the product
    """
    res = ''
    for i in range(len(multiplicand_b)-1):
        if multiplicand_b[len(multiplicand_b)-1-i] == '1':
            if len(res) == 0:
                res = multiplicand_a
            else:
                res = add('0'+res, multiplicand_a)
        multiplicand_a += '0'

    #trim down into 16 bits
    res = res[len(res)-16:]

    #if nothing happens to res
    if len(res) == 0:
        return '0000000000000000'

    return res


def binary_to_decimal(number):
    """
    Convert a 16-bit, two's complement number to decimal.
    TODO: Implement this function.

    :param number: A bitstring representing the number to convert
    :return: An integer, the converted number
    """
    res = 0
    for i in range(len(number)):
        if number[len(number) - 1 - i] == '1':
            res += pow(2, i)

    if number[0] == "1":
        res = res-pow(2, len(number))
    return res

    pass


def decimal_to_binary(number):
    """
    Convert a decimal number to 16-bit, two's complement binary.
    TODO: Implement this function.

    :param number: An integer, the number to convert
    :return: A bitstring representing the converted number
    :raise OverflowError: If the number cannot be represented with 8 bits
    """

    """highest number for 16-bit is 65,535"""
    if number < -32767 or number > 32767:
        raise OverflowError

    bit = 15
    res = ""

    while bit >= 0:
        if pow(2, bit) <= number:
            number -= pow(2, bit)
            res += "1"
        else:
            res += "0"
        bit -= 1
    return res
