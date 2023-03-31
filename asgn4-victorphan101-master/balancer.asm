; Verifies the balance of string delimiters.
; CSC 225, Assignment 4
; Given code, Spring '22

            .ORIG x3000

MAIN        LEA R1, STACK   ; Initialize R1, the stack pointer
            ST R1, KEEP1
            AND R2, R2, #0
            AND R3, R3, #0
            
            LEA R0, KEY_PROMPT  ; Print the prompt.
            LD  R3, OFFSET
            PUTS
            
            AND R4, R4, #0
            ; TODO: Complete this program:
            ;       If an opening delimiter is typed, push it onto the stack.
            ;       If a closing delimiter is typed, pop an opening delimiter
            ;        off of the stack and ensure that they match.
            ;       When the expression ends, ensure that the stack is empty.
            
GETCHAR     LD  R3, OFFSET
            GETC                 ;get the character
            OUT
            ADD R2, R0, #0
            ADD R4, R0, R3
            BRz RESULT
            
            
            LD R5, OPENBRACKET
            ADD R5, R0, R5
            BRz STARTPUSH
                
            LD R5, OPENPAREN
            ADD R5, R0, R5
            BRz STARTPUSH
                
            LD R5, OPENBRACE
            ADD R5, R0, R5
            BRz STARTPUSH
            
            BRnzp CHECKSTACK

STARTPUSH   JSR PUSH
            BRnzp CONT
            
            ;JSR CHECKSTACK      ;go to sub to check on stack "])}" -> branch
CHECKSTACK  LD R5, CLOSEBRACKET
            AND R3, R3, #0
            ADD R3, R0, #0
            ADD R5, R3, R5
            BRnp NEXT1
            
            JSR PEEK
            LD R5, OPENBRACKET
            ADD R5, R2, R5
            BRnp BADRESULT
            JSR POP
            BRnzp CONT
            
                
NEXT1       LD R5, CLOSEPAREN
            ADD R5, R3, R5
            BRnp NEXT2
            
            JSR PEEK
            LD R5, OPENPAREN
            ADD R5, R2, R5
            BRnp BADRESULT
            JSR POP
            BRnzp CONT
                
NEXT2       LD R5, CLOSEBRACE
            ADD R5, R3, R5
            BRnp CONT
            
            JSR PEEK
            LD R5, OPENBRACE
            ADD R5, R2, R5
            BRnp BADRESULT
            JSR POP
            BRnzp CONT

CONT        AND R4, R4, #0
            BRnzp GETCHAR       ;loop back up until next char is zero
            
            
            ;if stack pointer is at original address, print a result prompts  
RESULT      NOT R1, R1
            ADD R1, R1, #1
            LD R5, KEEP1
            ADD R5, R1, R5
            BRnp NONEMPTY
            
            LEA R0, BALANCED
            PUTS
            HALT

BADRESULT   NOT R1, R1
            ADD R1, R1, #1
            LD R5, KEEP1
            ADD R5, R1, R5
            BRnp NONEMPTY
            
EMPTY       LD R5, CLOSEBRACKET
            ADD R5, R3, R5
            BRnp NEXT(
            
            LEA R0, NOTBALANCED
            PUTS
            LEA R0, LOOK[
            PUTS
            HALT

NEXT(       LD R5, CLOSEPAREN
            ADD R5, R3, R5
            BRnp NEXT{
            
            LEA R0, NOTBALANCED
            PUTS
            LEA R0, LOOK(
            PUTS
            HALT
            
NEXT{       LD R5, CLOSEBRACE
            ADD R5, R3, R5
            
            LEA R0, NOTBALANCED
            PUTS
            LEA R0, LOOK{
            PUTS
            HALT
            
            

NONEMPTY    NOT R1, R1
            ADD R1, R1, #1
            JSR PEEK
            LD R5, OPENBRACKET
            ADD R5, R2, R5
            BRnp NEXT)
            
            LEA R0, NOTBALANCED
            PUTS
            LEA R0, LOOK]
            PUTS
            HALT

NEXT)       LD R5, OPENPAREN
            ADD R5, R2, R5
            BRnp NEXT}
            
            LEA R0, NOTBALANCED
            PUTS
            LEA R0, LOOK)
            PUTS
            HALT
            
NEXT}       LEA R0, NOTBALANCED
            PUTS
            LEA R0, LOOK}
            PUTS
            HALT            ; Halt.

; Space for a stack with capacity 16:
            .BLKW #16
STACK       .FILL x00

; TODO: Add any additional required constants or subroutines below this point.
OFFSET          .FILL x-0A
KEEP1           .FILL x00
KEY_PROMPT      .STRINGZ "Enter a string: "
BALANCED        .STRINGZ "Delimiters are balanced."
NOTBALANCED     .STRINGZ "\nDelimiters are not balanced. Expected "
LOOK]           .STRINGZ "']'."
LOOK)           .STRINGZ "')'."
LOOK}           .STRINGZ "'}'."
LOOK[           .STRINGZ "'['."
LOOK(           .STRINGZ "'('."
LOOK{           .STRINGZ "'{'."
OPENPAREN       .FILL #-40
CLOSEPAREN      .FILL #-41
OPENBRACKET     .FILL #-91
CLOSEBRACKET    .FILL #-93
OPENBRACE       .FILL #-123
CLOSEBRACE      .FILL #-125



; NOTE: Do not alter the following lines. They allow the subroutines in other
;       files to be called without manually calculating their offsets.

PUSH        ST  R6, PUSHR6
            ST  R7, PUSHR7
            LDI R6, PUSHADDR
            JSRR R6
            LD  R7, PUSHR7
            LD  R6, PUSHR6
            RET

PUSHR6      .FILL x0000
PUSHR7      .FILL x0000
PUSHADDR    .FILL x4000

POP         ST  R6, POPR6
            ST  R7, POPR7
            LDI R6, POPADDR
            JSRR R6
            LD  R7, POPR7
            LD  R6, POPR6
            RET

POPR6       .FILL x0000
POPR7       .FILL x0000
POPADDR     .FILL x4001

PEEK        ST  R6, PEEKR6
            ST  R7, PEEKR7
            LDI R6, PEEKADDR
            JSRR R6
            LD  R7, PEEKR7
            LD  R6, PEEKR6
            RET

PEEKR6      .FILL x0000
PEEKR7      .FILL x0000
PEEKADDR    .FILL x4002


            .END
