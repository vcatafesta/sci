;; Author....: Sz‚l Viktor <vector@mail.matav.hu>
;; This code is released to Public Domain

TRUE            EQU     1
FALSE           EQU     0

DGROUP          GROUP   DATA

DATA            SEGMENT PUBLIC 'DATA'

bChecked        DW      FALSE
bUseDPMI        DW      FALSE

DATA            ENDS

CODE            SEGMENT 'CODE'
                ASSUME CS:CODE, DS:DGROUP

.8086

_PMDIC_UseDPMI  PROC    NEAR

                cmp     bChecked, TRUE          ; Check flag
                je      _PMDIC_UseDPMI_Done

                mov     bChecked, TRUE          ; Set flag

                mov     AX, 4010h
                int     2Fh
                cmp     AX, 4010h
                jne     _PMDIC_UseDPMI_Done     ; return FALSE under OS/2

                push    SP                      ; Put SP on stack
                pop     BX                      ; Now get it back
                cmp     BX, SP                  ; If not ==, 8088/8086
                jne     _PMDIC_UseDPMI_Done     ; Return FALSE
.286p
                smsw    AX                      ; Get status word
                and     AX, 1                   ; Check for pmode bit
                jz      _PMDIC_UseDPMI_Done     ; Return FALSE if clear

                pushf                           ; Mov flag word . . .
                pop     BX                      ; . . . to BX
                and     BH, 11001111b           ; Set IOPL to zero
                push    BX                      ; Move BX . . .
                popf                            ; . . . back to flag word
                pushf                           ; Now move flags . . .
                pop     BX                      ; . . . back to BX
                test    BH, 110000b             ; Is IOPL still zero?

                mov     bUseDPMI, TRUE  ; ?
                jz      _PMDIC_UseDPMI_Done     ; If so, return TRUE

                push    DS
                push    ES
                push    SI
                push    DI

                mov     AX, 1686h               ; DPMI -- get CPU mode
                int     2Fh                     ; Call DPMI

                pop     DI
                pop     SI
                pop     ES
                pop     DS

                or      AX, AX
                mov     bUseDPMI, TRUE
                jz      _PMDIC_UseDPMI_Done
                mov     bUseDPMI, FALSE

_PMDIC_UseDPMI_Done:
                mov     AX, bUseDPMI
                ret

_PMDIC_UseDPMI  ENDP

;   $DOC$
;   $FUNCNAME$
;       OL_Yield()
;   $CATEGORY$
;       Functions
;   $ONELINER$
;       Return a time slice back to the operating system.
;   $SYNTAX$
;       OL_Yield()
;   $ARGUMENTS$
;       None.
;   $RETURNS$
;       Nothing.
;   $DESCRIPTION$
;       OL_Yield() can be used to return time slices back to operating
;       systems such as OS/2 and operating environments such as Windows.
;       By doing this your application will generate less CPU load and
;       make your whole machine run just a little smoother.
;
;       This function is best used in a wait state in your application
;       and should be called as many times as possible while it is waiting
;       for input.
;
;       It is safe to call this function even if you are not running your
;       application under OS/2 or Windows.
;   $EXAMPLES$
;       // When you may have done this:
;
;       nKey := InKey( 0 )
;
;       // It is now better to do this:
;
;       While nextkey() == 0
;          OL_Yield()
;       End
;       nKey := InKey()
;
;   $SEEALSO$
;
;   $END$
;

.286

PUBLIC          OL_YIELD
PUBLIC          _ol_yield

OL_YIELD        PROC    FAR
_ol_yield:
                enter   50, 0

                call    _PMDIC_UseDPMI
                cmp     AX, FALSE
                je      _PMDosIdleCall_Direct
.286p
_PMDosIdleCall_DPMI:
                push    DS
                push    SI
                push    DI
                push    BP

                push    SS
                pop     ES
                lea     DI, [BP-50]
                mov     AX, 0
                mov     CX, 50 / 2
                cld
                rep stosw

                mov     word ptr [BP-22], 1680h

                mov     AX, 0300h
                mov     BL, 2Fh
                mov     BH, 0
                xor     CX, CX
                push    SS
                pop     ES
                lea     DI, [BP-50]
                int     31h

                cld
                pop     BP
                pop     DI
                pop     SI
                pop     DS

                leave
                retf
.286
_PMDosIdleCall_Direct:
                mov     AX, 1680h
                int     2Fh

                leave
                retf

OL_YIELD        ENDP

CODE            ENDS

                END
