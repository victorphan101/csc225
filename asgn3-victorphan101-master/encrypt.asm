; Encrypts a string using a Caesar cipher.
; CSC 225, Assignment 3
; Given code, Spring '22

            .ORIG x3000

            ; Prompt for the key.
            LEA R0, KEY_PROMPT  ; Load the prompt.
            LD  R1, NEW_OFFSET  ; Load a "negative newline" into R1.
            PUTS                ; Print the prompt.

            AND R3, R3, #0      ;clear R3
            
             ; TODO: Read the encryption key from the keyboard, echo it, and
            ;       convert it into an integer. Save the encryption key in R3.
            
            ; Get and encrypt the string.
BACK        GETC                ; While the user types characters...
            OUT                 ; ...echo the character...
            ADD R4, R0, R1
            BRz NEXT
            ADD R3, R0, R3     
            BRnzp BACK
        

            ; Prompt for the string.
NEXT        JSR toINT
            AND R4, R4, #0      ;clear R4

            LEA R0, STR_PROMPT  ; Load the prompt.
            LD  R1, NEW_OFFSET  ; Load a "negative newline" into R1.
            LEA R2, STRING      ; Load the address of the string into R2.
            PUTS                ; Print the prompt.

            ; Get and encrypt the string.
LOOP        GETC                ; While the user types characters...
            OUT                 ; ...echo the character...
            ADD R4, R0, R1      ; ...and the character...
            BRz DONE            ; ...is not the newline...

            ; TODO: Apply the encryption key, which is in R3, to the character,
            ;       which is in R0. Replace unprintable characters with '?'.

            
            JSR addR0
            STR R0, R2, #0      ; ...store the character...
            ADD R2, R2, #1      ; ...increment the address...
            BRnzp LOOP          ; ...loop back.

            ; Print the result.
DONE        AND R4, R4, #0      ; Get the null char.
            STR R4, R2, #0      ; Store the null char.
            
            
            
            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS                ; Print the prompt.
            LEA R0, STRING      ; Load the string.
            PUTS                ; Print the string.
            HALT                ; Halt.
            
toINT       ADD R3, R3, #-16
            ADD R3, R3, #-16
            ADD R3, R3, #-16
            RET
            
addR0       ;check if out of bounds
            AND R6, R6, #0

            ADD R5, R0, R3  ;use R5 to check
            
            ADD R6, R5, #-16
            ADD R6, R6, #-16
            BRn UNPRINT
            
            AND R6, R6, #0

            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-16
            ADD R6, R6, #-14
            
            ADD R6, R5, R6
            BRp UNPRINT
      
            ADD R0, R5, #0
            BRnzp EXIT
            
UNPRINT     AND R0, R0, #0
            ADD R0, R0, #15
            ADD R0, R0, #15
            ADD R0, R0, #15
            ADD R0, R0, #15
            ADD R0, R0, #3
            BRnzp EXIT
            
EXIT        RET
            
            
            
            ; TODO: Add any additional required constants below this point.

NEW_OFFSET  .FILL x-0A
KEY_PROMPT  .STRINGZ "Encryption key (0-9): "
STR_PROMPT  .STRINGZ "Unencrypted string: "
RES_PROMPT  .STRINGZ "Encrypted string: "
STRING      .BLKW #33

            .END
