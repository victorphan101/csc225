; Defines functions for computing greatest common divisors.
; CSC 225, Assignment 6
; Given code, Spring '21
; TODO: Complete this file.

            .ORIG x4000

; int gcd(int, int)
GCDFN   ADD R6, R6, #-1       ;save spot for return value
        
        ADD R6, R6, #-1
        STR R7, R6, #0
        
        ADD R6, R6, #-1       ;push dynamic link
        STR R5, R6, #0
        
        ADD R5, R6, #-1       ;new frame pter
        
        ADD R6, R6, #-1
        
        LDR R2, R5, #4        ;load the variables
        LDR R3, R5, #5
        
        AND R4, R4, #0
        ADD R4, R3, #0
        NOT R4, R4
        ADD R4, R4, #1
    
        ADD R4, R2, R4
        BRz EXITZERO
        BRp CHANGEA
        BRnzp CHANGEB
        ;BRz for negating one variable and adding to another, if true -> go to result
        
        ;negate first var and add vars
CHANGEA AND R0, R0, #0  ;caller setup
        ADD R0, R3, #0
        ADD R6, R6, #-1
        STR R0, R6, #0

        AND R0, R0, #0
        ADD R0, R4, #0
        ADD R6, R6, #-1
        STR R0, R6, #0  ;BRp  first var is smaller, add negated first with second and change second variabel into that 
        
        JSR GCDFN
        ;caller teardown
        LDR R0, R6, #0
        STR R0, R5, #0
        ADD R6, R6, #1
        ADD R6, R6, #2
        
        BRnzp EXIT
        
CHANGEB NOT R4, R4  ;BRn  second var is smaller, add negated second with first and change first variabel into that 
        ADD R4, R4, #1
        
        AND R0, R0, #0  ;caller setup
        ADD R0, R4, #0
        ADD R6, R6, #-1
        STR R0, R6, #0
        
        AND R0, R0, #0
        ADD R0, R2, #0
        ADD R6, R6, #-1
        STR R0, R6, #0
            
        JSR GCDFN
        ;caller teardown
        LDR R0, R6, #0
        STR R0, R5, #0
        ADD R6, R6, #1
        ADD R6, R6, #2
        BRnzp EXIT
        
EXITZERO STR R3, R5, #0
        
        
EXIT    LDR R0, R5, #0                ;callee teardown
        STR R0, R5, #3
        ADD R6, R5, #1                  ;pop local
        LDR R5, R6, #0                  ;pop dynamic
        ADD R6, R6, #1
        LDR R7, R6, #0
        ADD R6, R6, #1
        RET
        ;HALT


PROMPT  .STRINGZ "Enter two positive integers: "
RESULT1 .STRINGZ "gcd( "
RESULT2 .STRINGZ ") = "
            .END
