; File......: IAMIDLE.ASM
; Author....: Ted Means
; CIS ID....: 73067,3332

; This is an original work by Ted Means and is placed in the
; public domain.
;
; Modification history:
; ---------------------
;
;     Rev 1.0   01 Jan 1995 03:01:00   TED
;  Nanforum Toolkit
;

;  $DOC$
;  $FUNCNAME$
;     FT_IAmIdle()
;  $CATEGORY$
;     DOS/BIOS
;  $ONELINER$
;     Inform the operating system that the application is idle.
;  $SYNTAX$
;     FT_IAmIdle() -> lSuccess
;  $ARGUMENTS$
;     None
;  $RETURNS$
;     .T. if supported, .F. otherwise.
;  $DESCRIPTION$
;     Some multitasking operating environments (e.g. Windows or OS/2) can
;     function more efficiently when applications release the CPU during
;     idle states.  This function allows you "announce" to the operating
;     system that your application is idle.
;
;     Note that if you use this function in conjunction with FT_OnIdle(),
;     you can cause Clipper to automatically release the CPU whenever
;     Clipper itself detects an idle state.
;  $EXAMPLES$
;     while inkey() != K_ESC
;        FT_IAmIdle()         // Wait for ESC and announce idleness
;     end
;
;     * Here's another way to do it:
;
;     FT_OnIdle( {|| FT_IAmIdle()} )
;
;     Inkey( 0 )              // Automatically reports idleness until key
;                             // is pressed!
;  $SEEALSO$
;     FT_OnIdle()
;  $END$
;

IDEAL
P286

Public    FT_IAmIdle

Extrn     __ParL:Far
Extrn     __RetL:Far
Extrn     __ParNI:Far

Extrn     cpmiIsProtected:Far

Extrn     __bset:Far

Intensity EQU       Word BP - 2
dpmiAX    EQU       [Word BP - 18]
dpmiRegs  EQU       [BP - 34h]

Segment   _NanFor   Word      Public    "CODE"
          Assume    CS:_NanFor

Proc      FT_IAmIdle          Far

          Push      BP                            ; Set up stack frame
          Mov       BP,SP                         ; and allocate memory
          Sub       SP,34h                        ; for local use

          Mov       AX,1                          ; Specify first param
          Push      AX                            ; Place request on stack
          Call      __ParNI                       ; Get value from Clipper
          Add       SP,2                          ; Realign stack
          Or        AX,AX                         ; See if intensity is zero
          JNZ       @@Set                         ; If not, okay
          Inc       AX                            ; If zero, default to 1

@@Set:    Mov       [Intensity],AX                ; Store intensity

          Mov       AX,2                          ; Specify 2nd param
          Push      AX                            ; Place request on stack
          Call      __ParL                        ; Get value from Clipper
          Add       SP,2                          ; Realign stack
          Push      AX                            ; Save value for later
          Call      cpmiIsProtected               ; Get CPU mode
          Pop       DX                            ; Get ForceReal back
          And       AX,DX                         ; ForceReal .and. ProtMode?
          JZ        @@NoDPMI                      ; If not both, ignore param

@@DPMI:   Push      DI                            ; Save DI for Clipper
          LEA       DI,dpmiRegs                   ; Get offset of regs
          Push      32h                           ; Length of regs
          Push      0                             ; Value to fill
          Push      SS                            ; Pointer to regs
          Push      DI
          Call      __bset                        ; Init to nulls
          Add       SP,8                          ; Realign stack

@@Real:   Mov       dpmiAX,1680h                  ; Load regs with AX value

          Mov       AX,300h                       ; DPMI -- real mode int
          Mov       BX,2Fh                        ; Interrupt to call
          Xor       CX,CX                         ; No stack copy
          Push      SS                            ; Pointer to regs
          Pop       ES
          LEA       DI,dpmiRegs
          Int       31h                           ; Call DPMI
          Dec       [Intensity]                   ; Decrement counter
          JNZ       @@Real                        ; Stop when we hit zero
          Pop       DI                            ; Restore DI for Clipper
          Mov       AX,dpmiAX                     ; Get AX value from regs
          Jmp       Short @@Return                ; Done

@@NoDPMI: Mov       AX,1680h                      ; Release timeslice
          Int       2Fh                           ; Invoke interrupt
          Dec       [Intensity]                   ; Decrement counter
          JNZ       @@NoDPMI                      ; Stop when we hit zero

@@Return: Mov       DX,1                          ; Assume return value .T.
          Or        AL,AL                         ; Is AL zero?
          JZ        @@Done                        ; If so, call is supported
          Dec       DX                            ; Otherwise, return .F.

@@Done:   Push      DX                            ; Put return value on stack
          Call      __RetL                        ; Return it

          Mov       SP,BP                         ; Kill stack frame
          Pop       BP
          RetF
Endp      FT_IAmIdle
Ends      _NanFor
End