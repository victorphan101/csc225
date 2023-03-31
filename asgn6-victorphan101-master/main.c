/*
 * Recursively computes greatest common divisors.
 * CSC 225, Assignment 6
 * Given code, Spring '21
 * TODO: Complete this file.
 */

#include <stdio.h>
#include "gcd.h"

int main(void) {
    int a, b, c;
    printf("Enter two positive integers: ");


    scanf("%d %d", &a, &b);

    c = gcd(a,b);
    printf("gcd(%d", a);
    printf(", %d) ", b);
    printf(" = %d\n", c);

    return 0;


}
