; Decrypts a string using a Caesar cipher.
; CSC 225, Assignment 3
; Given code, Spring '22

            .ORIG x3000
            AND R3, R3, #0
            AND R5, R5, #0
            
            LEA R0, STR_PROMPT  ; Load the prompt.
            LD  R1, NEW_OFFSET  ; Load a "negative newline" into R1.
            LEA R2, STRING      ; Load the address of the string into R2.
            PUTS                ; Print the prompt.

            ; Get and encrypt the string.
LOOP        GETC                ; While the user types characters...
            OUT                 ; ...echo the character...
            ADD R4, R0, R1      ; ...and the character...
            BRz DONE            ; ...is not the newline...

            ;JSR addR0           ;need one to increment address and one to increment key
            STR R0, R2, #0      ; ...store the character...
            ADD R5, R5, #1
            ADD R2, R2, #1      ; ...increment the address...
            BRnzp LOOP          ; ...loop back.
            
            
DONE        AND R4, R4, #0      ; Get the null char.
            STR R4, R2, #0      ; Store the null char.
            LEA R0, RES_PROMPT0  ; Load the prompt.
            PUTS
            LEA R0, ZERO
            PUTS                ; Print the prompt.
            LEA R0, STRING     ; Load the string.
            PUTS
            

            ; Print the result.
            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS
            LEA R0, ONE
            PUTS                ; Print the prompt.
            JSR UPDATE
            LEA R0, STRING2       ; Load the string.
            PUTS                ; Print the string.'
            

            ; Print the result.
            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS
            LEA R0, TWO
            PUTS                ; Print the prompt.
            JSR UPDATE
            LEA R0, STRING2       ; Load the string.
            PUTS                ; Print the string.'


            ; Print the result.
            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS
            LEA R0, THREE
            PUTS                ; Print the prompt.
            JSR UPDATE
            LEA R0, STRING2       ; Load the string.
            PUTS                ; Print the string.'

            JSR UPDATE

            ; Print the result.
            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS
            LEA R0, FOUR
            PUTS                ; Print the prompt.
            LEA R0, STRING2       ; Load the string.
            PUTS                ; Print the string.'
            
            JSR UPDATE

            ; Print the result.
            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS
            LEA R0, FIVE
            PUTS                ; Print the prompt.
            LEA R0, STRING2       ; Load the string.
            PUTS                ; Print the string.'

            JSR UPDATE

            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS
            LEA R0, SIX
            PUTS                ; Print the prompt.
            LEA R0, STRING2       ; Load the string.
            PUTS                ; Print the string.'

            JSR UPDATE

            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS
            LEA R0, SEVEN
            PUTS                ; Print the prompt.
            LEA R0, STRING2       ; Load the string.
            PUTS                ; Print the string.'

            JSR UPDATE
            
            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS
            LEA R0, EIGHT
            PUTS                ; Print the prompt.
            LEA R0, STRING2       ; Load the string.
            PUTS                ; Print the string.'

            JSR UPDATE

            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS
            LEA R0, NINE
            PUTS                ; Print the prompt.
            LEA R0, STRING2       ; Load the string.
            PUTS                ; Print the string.'
            
            
            HALT                ; Halt.
            
        
UPDATE      ADD R4, R5, #0
            AND R0, R0, #0
            LEA R2, STRING      ; Load the address of the string into R2.
            LEA R1, STRING2
            ADD R3, R3, #-1
LOOP1       LDR R0, R2, #0
            BRz LEAVE          ; ...is not the newline...
            
            AND R6, R6, #0
            ADD R6, R0, R3  ;use R6 to check
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            BRn UNPRINT
            
            AND R6, R6, #0
            ADD R6, R0, R3  ;use R6 to check
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-14
            BRp UNPRINT
            
            AND R6, R6, #0
            ADD R6, R0, R3  ;use R6 to check
            ADD R0, R6, #0
            
            BRnzp EXIT
            
UNPRINT     AND R6, R6, #0
            ADD R6, R6, #15
            ADD R6, R6, #15
            ADD R6, R6, #15
            ADD R6, R6, #15
            ADD R0, R6, #3
            
EXIT        AND R6, R6, #0
            STR R0, R1, #0      ; ...store the character...
            ADD R4, R4, #-1            
            ADD R2, R2, #1      ; ...increment the address... 
            ADD R1, R1, #1 
            BRnzp LOOP1          ; ...loop back.
LEAVE       AND R4, R4, #0      ; Get the null char.
            STR R4, R1, #0      ; Store the null char.
            LEA R1, STRING2
            ;STR R4, R2, #0      ; Store the null char.
            RET
            
            
            
        
            ; TODO: Add any additional required constants below this point.

NEW_OFFSET   .FILL x-0A
STRING       .BLKW #33
STRING2      .BLKW #33
STR_PROMPT   .STRINGZ "Encrypted string: "
RES_PROMPT0  .STRINGZ "Decryption key"
RES_PROMPT  .STRINGZ "\nDecryption key"
ZERO .STRINGZ " 0: "
ONE  .STRINGZ " 1: "
TWO  .STRINGZ " 2: "
THREE  .STRINGZ " 3: "
FOUR  .STRINGZ " 4: "
FIVE  .STRINGZ " 5: "
SIX  .STRINGZ " 6: "
SEVEN  .STRINGZ " 7: "
EIGHT  .STRINGZ " 8: "
NINE  .STRINGZ " 9: "

            .END
