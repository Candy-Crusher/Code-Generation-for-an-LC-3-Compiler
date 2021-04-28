;---------------------------------------------------------------------------
; 
; WARNING!  This code was produced automatically using the ECE190 C compiler
; (MP5 in the Spring 2008 semester).  If you choose to modify it by hand,
; be aware that you WILL LOSE such changes when the code is recompiled.
;
; Student-generated code is marked as "STUDENT CODE."
;
;---------------------------------------------------------------------------

	.ORIG x3000

BOGUSFP
	LD	R4,GDPTR
	LEA	R5,BOGUSFP
	LD	R6,SPTR
	JSR	MAIN
	LEA	R0,OUTPREFIX
	PUTS
	LDR	R0,R6,#0
	ADD	R6,R6,#1
	LD	R1,PNPTR
	JSRR	R1
	AND	R0,R0,#0
	ADD	R0,R0,#10
	OUT
	HALT

GDPTR	.FILL GLOBDATA
SPTR	.FILL STACK
PNPTR	.FILL PRINT_NUM
OUTPREFIX	.STRINGZ "main returned "

MAIN	ADD	R6,R6,#-3
	STR	R5,R6,#0
	STR	R7,R6,#1
	ADD	R5,R6,#-1

;---------------------------------------------------------------------------
; local variable space allocation
;---------------------------------------------------------------------------

	ADD R6,R6,#-7

;---------------------------------------------------------------------------
; R0...R3 are callee-saved
;---------------------------------------------------------------------------

	ADD	R6,R6,#-4
	STR	R0,R6,#0	; save R0...R3
	STR	R1,R6,#1
	STR	R2,R6,#2
	STR	R3,R6,#3
	
;---------------------------------------------------------------------------
; STUDENT CODE STARTS HERE (after the symbol table)
;---------------------------------------------------------------------------

;                piles[3]        global          offset=+0
;                 seed           local to main   offset=+0
;                    i           local to main   offset=-1
;                    j           local to main   offset=-2
;                 done           local to main   offset=-3
;            choice_ok           local to main   offset=-4
;                 pnum           local to main   offset=-5
;                  amt           local to main   offset=-6
	LEA R0,LBL2
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL3
LBL2
	.STRINGZ "Please type a number: "
LBL3
	LD R0,LBL4
	JSRR R0
	BRnzp LBL5
LBL4
	.FILL PRINTF
LBL5
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	LD R0,LBL8
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL9
LBL8
	.FILL #1
LBL9
	ADD R0,R5,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R0,LBL10
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL11
LBL10
	.STRINGZ "%d"
LBL11
	LD R0,LBL12
	JSRR R0
	BRnzp LBL13
LBL12
	.FILL SCANF
LBL13
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#2
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRz LBL7
	ADD R2,R2,#1
LBL7
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL15
	LD R3,LBL14
	JMP R3
LBL14
	.FILL LBL6
LBL15
	LEA R0,LBL16
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL17
LBL16
	.STRINGZ "That's not a number!\n"
LBL17
	LD R0,LBL18
	JSRR R0
	BRnzp LBL19
LBL18
	.FILL PRINTF
LBL19
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	LD R0,LBL20
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL21
LBL20
	.FILL #3
LBL21
	LDR R0,R6,#0
	ADD R6,R6,#1
	STR R0,R5,#3
	;  LBL23
	LD R3,LBL22
	JMP R3
LBL22
	.FILL LBL1
LBL23
	;  LBL26
	LD R3,LBL25
	JMP R3
LBL25
	.FILL LBL24
LBL26
LBL6
LBL24
	LDR R0,R5,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LD R0,LBL27
	JSRR R0
	BRnzp LBL28
LBL27
	.FILL SRAND
LBL28
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	LD R0,LBL31
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL32
LBL31
	.FILL #0
LBL32
	ADD R0,R5,#-1
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
LBL29
	LD R0,LBL34
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL35
LBL34
	.FILL #3
LBL35
	LDR R0,R5,#-1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnz LBL33
	ADD R2,R2,#1
LBL33
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL37
	LD R3,LBL36
	JMP R3
LBL36
	.FILL LBL30
LBL37
	LD R0,LBL38
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL39
LBL38
	.FILL #0
LBL39
	LD R0,LBL40
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL41
LBL40
	.FILL #5
LBL41
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R5,#-1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R1
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
	ADD R0,R5,#-1
	LDR R1,R0,#0
	ADD R2,R1,#1
	STR R2,R0,#0
	ADD R6,R6,#-1
	STR R1,R6,#0
	ADD R6,R6,#1
	;  LBL43
	LD R3,LBL42
	JMP R3
LBL42
	.FILL LBL29
LBL43
LBL30
	LD R0,LBL46
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL47
LBL46
	.FILL #0
LBL47
	ADD R0,R5,#-3
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
LBL44
	LD R0,LBL49
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL50
LBL49
	.FILL #0
LBL50
	LDR R0,R5,#-3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL48
	ADD R2,R2,#1
LBL48
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL52
	LD R3,LBL51
	JMP R3
LBL51
	.FILL LBL45
LBL52
	LD R0,LBL55
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL56
LBL55
	.FILL #0
LBL56
	ADD R0,R5,#-1
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
LBL53
	LD R0,LBL58
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL59
LBL58
	.FILL #3
LBL59
	LDR R0,R5,#-1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnz LBL57
	ADD R2,R2,#1
LBL57
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL61
	LD R3,LBL60
	JMP R3
LBL60
	.FILL LBL54
LBL61
	LD R0,LBL62
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL63
LBL62
	.FILL #0
LBL63
	LD R0,LBL64
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL65
LBL64
	.FILL #1
LBL65
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R0,LBL66
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL67
LBL66
	.STRINGZ "Pile %d: "
LBL67
	LD R0,LBL68
	JSRR R0
	BRnzp LBL69
LBL68
	.FILL PRINTF
LBL69
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#2
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	LD R0,LBL72
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL73
LBL72
	.FILL #0
LBL73
	ADD R0,R5,#-2
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
LBL70
	LDR R0,R5,#-1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R5,#-2
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnz LBL74
	ADD R2,R2,#1
LBL74
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL76
	LD R3,LBL75
	JMP R3
LBL75
	.FILL LBL71
LBL76
	LEA R0,LBL77
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL78
LBL77
	.STRINGZ "*"
LBL78
	LD R0,LBL79
	JSRR R0
	BRnzp LBL80
LBL79
	.FILL PRINTF
LBL80
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R5,#-2
	LDR R1,R0,#0
	ADD R2,R1,#1
	STR R2,R0,#0
	ADD R6,R6,#-1
	STR R1,R6,#0
	ADD R6,R6,#1
	;  LBL82
	LD R3,LBL81
	JMP R3
LBL81
	.FILL LBL70
LBL82
LBL71
	LEA R0,LBL83
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL84
LBL83
	.STRINGZ "\n"
LBL84
	LD R0,LBL85
	JSRR R0
	BRnzp LBL86
LBL85
	.FILL PRINTF
LBL86
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R5,#-1
	LDR R1,R0,#0
	ADD R2,R1,#1
	STR R2,R0,#0
	ADD R6,R6,#-1
	STR R1,R6,#0
	ADD R6,R6,#1
	;  LBL88
	LD R3,LBL87
	JMP R3
LBL87
	.FILL LBL53
LBL88
LBL54
	LD R0,LBL91
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL92
LBL91
	.FILL #0
LBL92
	ADD R0,R5,#-4
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
LBL89
	LD R0,LBL94
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL95
LBL94
	.FILL #0
LBL95
	LDR R0,R5,#-4
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL93
	ADD R2,R2,#1
LBL93
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL97
	LD R3,LBL96
	JMP R3
LBL96
	.FILL LBL90
LBL97
	LEA R0,LBL98
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL99
LBL98
	.STRINGZ "From which pile will you take sticks? "
LBL99
	LD R0,LBL100
	JSRR R0
	BRnzp LBL101
LBL100
	.FILL PRINTF
LBL101
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	LD R0,LBL110
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL111
LBL110
	.FILL #1
LBL111
	ADD R0,R5,#-5
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R0,LBL112
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL113
LBL112
	.STRINGZ "%d"
LBL113
	LD R0,LBL114
	JSRR R0
	BRnzp LBL115
LBL114
	.FILL SCANF
LBL115
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#2
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRz LBL109
	ADD R2,R2,#1
LBL109
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRz LBL117
	LD R3,LBL116
	JMP R3
LBL116
	.FILL LBL107
LBL117
	LD R0,LBL119
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL120
LBL119
	.FILL #1
LBL120
	LDR R0,R5,#-5
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnz LBL118
	ADD R2,R2,#1
LBL118
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL107
	AND R2,R2,#0
	BRnzp LBL108
LBL107
	AND R2,R2,#0
	ADD R2,R2,#1
LBL108
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRz LBL122
	LD R3,LBL121
	JMP R3
LBL121
	.FILL LBL105
LBL122
	LD R0,LBL124
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL125
LBL124
	.FILL #3
LBL125
	LDR R0,R5,#-5
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRzp LBL123
	ADD R2,R2,#1
LBL123
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL105
	AND R2,R2,#0
	BRnzp LBL106
LBL105
	AND R2,R2,#0
	ADD R2,R2,#1
LBL106
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRz LBL127
	LD R3,LBL126
	JMP R3
LBL126
	.FILL LBL103
LBL127
	LD R0,LBL129
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL130
LBL129
	.FILL #0
LBL130
	LD R0,LBL131
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL132
LBL131
	.FILL #0
LBL132
	LD R0,LBL133
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL134
LBL133
	.FILL #1
LBL134
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL128
	ADD R2,R2,#1
LBL128
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL103
	AND R2,R2,#0
	BRnzp LBL104
LBL103
	AND R2,R2,#0
	ADD R2,R2,#1
LBL104
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL136
	LD R3,LBL135
	JMP R3
LBL135
	.FILL LBL102
LBL136
	LEA R0,LBL137
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL138
LBL137
	.STRINGZ "That's not a good choice.\n"
LBL138
	LD R0,LBL139
	JSRR R0
	BRnzp LBL140
LBL139
	.FILL PRINTF
LBL140
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	;  LBL143
	LD R3,LBL142
	JMP R3
LBL142
	.FILL LBL141
LBL143
LBL102
	LD R0,LBL144
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL145
LBL144
	.FILL #1
LBL145
	ADD R0,R5,#-4
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
	LD R0,LBL146
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL147
LBL146
	.FILL #0
LBL147
	LD R0,LBL148
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL149
LBL148
	.FILL #1
LBL149
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R0,R5,#-5
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
LBL141
	;  LBL151
	LD R3,LBL150
	JMP R3
LBL150
	.FILL LBL89
LBL151
LBL90
	LD R0,LBL154
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL155
LBL154
	.FILL #0
LBL155
	ADD R0,R5,#-4
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
LBL152
	LD R0,LBL157
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL158
LBL157
	.FILL #0
LBL158
	LDR R0,R5,#-4
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL156
	ADD R2,R2,#1
LBL156
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL160
	LD R3,LBL159
	JMP R3
LBL159
	.FILL LBL153
LBL160
	LD R0,LBL161
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL162
LBL161
	.FILL #0
LBL162
	LD R0,LBL163
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL164
LBL163
	.FILL #1
LBL164
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R0,LBL165
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL166
LBL165
	.STRINGZ "How many sticks will you take from pile %d? "
LBL166
	LD R0,LBL167
	JSRR R0
	BRnzp LBL168
LBL167
	.FILL PRINTF
LBL168
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#2
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	LD R0,LBL175
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL176
LBL175
	.FILL #1
LBL176
	ADD R0,R5,#-6
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R0,LBL177
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL178
LBL177
	.STRINGZ "%d"
LBL178
	LD R0,LBL179
	JSRR R0
	BRnzp LBL180
LBL179
	.FILL SCANF
LBL180
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#2
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRz LBL174
	ADD R2,R2,#1
LBL174
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRz LBL182
	LD R3,LBL181
	JMP R3
LBL181
	.FILL LBL172
LBL182
	LD R0,LBL184
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL185
LBL184
	.FILL #0
LBL185
	LDR R0,R5,#-6
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRn LBL183
	ADD R2,R2,#1
LBL183
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL172
	AND R2,R2,#0
	BRnzp LBL173
LBL172
	AND R2,R2,#0
	ADD R2,R2,#1
LBL173
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRz LBL187
	LD R3,LBL186
	JMP R3
LBL186
	.FILL LBL170
LBL187
	LDR R0,R5,#-5
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R5,#-6
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRzp LBL188
	ADD R2,R2,#1
LBL188
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL170
	AND R2,R2,#0
	BRnzp LBL171
LBL170
	AND R2,R2,#0
	ADD R2,R2,#1
LBL171
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL190
	LD R3,LBL189
	JMP R3
LBL189
	.FILL LBL169
LBL190
	LEA R0,LBL191
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL192
LBL191
	.STRINGZ "That's not a good choice.\n"
LBL192
	LD R0,LBL193
	JSRR R0
	BRnzp LBL194
LBL193
	.FILL PRINTF
LBL194
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	;  LBL197
	LD R3,LBL196
	JMP R3
LBL196
	.FILL LBL195
LBL197
LBL169
	LD R0,LBL198
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL199
LBL198
	.FILL #1
LBL199
	ADD R0,R5,#-4
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
LBL195
	;  LBL201
	LD R3,LBL200
	JMP R3
LBL200
	.FILL LBL152
LBL201
LBL153
	LD R0,LBL202
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL203
LBL202
	.FILL #0
LBL203
	LD R0,LBL204
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL205
LBL204
	.FILL #0
LBL205
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R5,#-5
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R1
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
	LD R0,LBL212
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL213
LBL212
	.FILL #0
LBL213
	LD R0,LBL214
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL215
LBL214
	.FILL #0
LBL215
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL211
	ADD R2,R2,#1
LBL211
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL217
	LD R3,LBL216
	JMP R3
LBL216
	.FILL LBL209
LBL217
	LD R0,LBL219
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL220
LBL219
	.FILL #0
LBL220
	LD R0,LBL221
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL222
LBL221
	.FILL #1
LBL222
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL218
	ADD R2,R2,#1
LBL218
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRz LBL209
	AND R2,R2,#0
	ADD R2,R2,#1
	BRnzp LBL210
LBL209
	AND R2,R2,#0
LBL210
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL224
	LD R3,LBL223
	JMP R3
LBL223
	.FILL LBL207
LBL224
	LD R0,LBL226
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL227
LBL226
	.FILL #0
LBL227
	LD R0,LBL228
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL229
LBL228
	.FILL #2
LBL229
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL225
	ADD R2,R2,#1
LBL225
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRz LBL207
	AND R2,R2,#0
	ADD R2,R2,#1
	BRnzp LBL208
LBL207
	AND R2,R2,#0
LBL208
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL231
	LD R3,LBL230
	JMP R3
LBL230
	.FILL LBL206
LBL231
	LEA R0,LBL232
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL233
LBL232
	.STRINGZ "You win!\n"
LBL233
	LD R0,LBL234
	JSRR R0
	BRnzp LBL235
LBL234
	.FILL PRINTF
LBL235
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	LD R0,LBL236
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL237
LBL236
	.FILL #1
LBL237
	ADD R0,R5,#-3
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
	;  LBL240
	LD R3,LBL239
	JMP R3
LBL239
	.FILL LBL238
LBL240
LBL206
	LD R0,LBL243
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL244
LBL243
	.FILL #0
LBL244
	LD R0,LBL245
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL246
LBL245
	.FILL #3
LBL246
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	LD R3,LBL247
	JSRR R3
	BRnzp LBL248
LBL247
	.FILL MODULUS
LBL248
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R0,R5,#-5
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
LBL241
	LD R0,LBL250
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL251
LBL250
	.FILL #0
LBL251
	LDR R0,R5,#-5
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL249
	ADD R2,R2,#1
LBL249
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL253
	LD R3,LBL252
	JMP R3
LBL252
	.FILL LBL242
LBL253
	LD R0,LBL254
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL255
LBL254
	.FILL #0
LBL255
	LD R0,LBL256
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL257
LBL256
	.FILL #3
LBL257
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	LD R3,LBL258
	JSRR R3
	BRnzp LBL259
LBL258
	.FILL MODULUS
LBL259
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R0,R5,#-5
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
	;  LBL261
	LD R3,LBL260
	JMP R3
LBL260
	.FILL LBL241
LBL261
LBL242
	LD R0,LBL262
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL263
LBL262
	.FILL #0
LBL263
	LD R0,LBL264
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL265
LBL264
	.FILL #1
LBL265
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R0,R5,#-6
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
	LD R0,LBL266
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL267
LBL266
	.FILL #0
LBL267
	LD R0,LBL268
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL269
LBL268
	.FILL #1
LBL269
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R5,#-6
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R0,LBL270
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL271
LBL270
	.STRINGZ "I take %d from pile %d\n"
LBL271
	LD R0,LBL272
	JSRR R0
	BRnzp LBL273
LBL272
	.FILL PRINTF
LBL273
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#3
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	LD R0,LBL274
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL275
LBL274
	.FILL #0
LBL275
	LD R0,LBL276
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL277
LBL276
	.FILL #0
LBL277
	LDR R1,R6,#0
	ADD R6,R6,#1
	LDR R0,R6,#0
	ADD R6,R6,#1
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R5,#-5
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R1
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
	LD R0,LBL284
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL285
LBL284
	.FILL #0
LBL285
	LD R0,LBL286
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL287
LBL286
	.FILL #0
LBL287
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL283
	ADD R2,R2,#1
LBL283
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL289
	LD R3,LBL288
	JMP R3
LBL288
	.FILL LBL281
LBL289
	LD R0,LBL291
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL292
LBL291
	.FILL #0
LBL292
	LD R0,LBL293
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL294
LBL293
	.FILL #1
LBL294
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL290
	ADD R2,R2,#1
LBL290
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRz LBL281
	AND R2,R2,#0
	ADD R2,R2,#1
	BRnzp LBL282
LBL281
	AND R2,R2,#0
LBL282
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL296
	LD R3,LBL295
	JMP R3
LBL295
	.FILL LBL279
LBL296
	LD R0,LBL298
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL299
LBL298
	.FILL #0
LBL299
	LD R0,LBL300
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL301
LBL300
	.FILL #2
LBL301
	LDR R1,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R1,R0,R1
	LDR R0,R1,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL297
	ADD R2,R2,#1
LBL297
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRz LBL279
	AND R2,R2,#0
	ADD R2,R2,#1
	BRnzp LBL280
LBL279
	AND R2,R2,#0
LBL280
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R0,R0,#0
	BRnp LBL303
	LD R3,LBL302
	JMP R3
LBL302
	.FILL LBL278
LBL303
	LEA R0,LBL304
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL305
LBL304
	.STRINGZ "I win!\n"
LBL305
	LD R0,LBL306
	JSRR R0
	BRnzp LBL307
LBL306
	.FILL PRINTF
LBL307
	LDR R0,R6,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	ADD R6,R6,#1
	LD R0,LBL308
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL309
LBL308
	.FILL #1
LBL309
	ADD R0,R5,#-3
	LDR R1,R6,#0
	STR R1,R0,#0
	ADD R6,R6,#1
	;  LBL312
	LD R3,LBL311
	JMP R3
LBL311
	.FILL LBL310
LBL312
LBL278
LBL310
LBL238
	;  LBL314
	LD R3,LBL313
	JMP R3
LBL313
	.FILL LBL44
LBL314
LBL45
	LD R0,LBL315
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL316
LBL315
	.FILL #0
LBL316
	LDR R0,R6,#0
	ADD R6,R6,#1
	STR R0,R5,#3
	;  LBL318
	LD R3,LBL317
	JMP R3
LBL317
	.FILL LBL1
LBL318
LBL1

;---------------------------------------------------------------------------
; STUDENT CODE ENDS HERE
;---------------------------------------------------------------------------

	LDR	R0,R6,#0	; restore R0...R3
	LDR	R1,R6,#1
	LDR	R2,R6,#2
	LDR	R3,R6,#3

	ADD	R6,R5,#1	; pop off local variables
	LDR	R5,R6,#0
	LDR	R7,R6,#1
	ADD	R6,R6,#2	; leave return value on stack
	RET
	
;---------------------------------------------------------------------------
; C library routines
;---------------------------------------------------------------------------

; assembly routines in this library
;   MULTIPLY (R0 <- R0 * R1)
;   DIVIDE   (R0 <- R0 / R1, rounded toward 0)
;   MODULUS  (R0 <- R0 MOD R1, using C's definition)

; routines with C interfaces in this library
;   int PRINTF (const char* fmt, ...);
;   int SCANF (const char* fmt, ...);
;   void SRAND (int new_seed);
;   int RAND ();
; NOTES: 
;    - ALL C ROUTINES LEAVE A RETURN VALUE LOCATION ON THE STACK, EVEN
;      IF THEY PRODUCE NO RETURN VALUE!
;    - PRINTF and SCANF only handle %d, %%, \n, \\, and normal characters
;

; INTERNAL routines (you should not call them)
;   LOG_RIGHT_SHIFT
;   PRINT_NUM
;   LOAD_FORMAT
;

;---------------------------------------------------------------------------

; MULTIPLY -- calculate R0 * R1
;     INPUTS -- R0 and R1
;     OUTPUTS -- R0 is the product
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
MULTIPLY
	ADD R6,R6,#-3	; save R1, R2, and R3
	STR R1,R6,#0
	STR R2,R6,#1
	STR R3,R6,#2

	AND R2,R2,#0	; number of negative operands

	ADD R1,R1,#0	; set R1 to its absolute value
	BRzp MULT_R1_NON_NEG
	NOT R1,R1
	ADD R1,R1,#1
	ADD R2,R2,#1
MULT_R1_NON_NEG

	AND R3,R3,#0
MULT_LOOP
	ADD R1,R1,#0
	BRz MULT_FINISH
	ADD R3,R3,R0
	ADD R1,R1,#-1
	BRnzp MULT_LOOP

MULT_FINISH
	ADD R0,R3,#0	; move result into R0

	AND R2,R2,#1	; negate answer?
	BRz MULT_DONE
	NOT R0,R0
	ADD R0,R0,#1

MULT_DONE
	LDR R1,R6,#0	; restore R1, R2, and R3
	LDR R2,R6,#1
	LDR R3,R6,#2
	ADD R6,R6,#3
	RET


; DIVIDE -- calculate R0 / R1 (rounded toward zero)
;     INPUTS -- R0 and R1
;     OUTPUTS -- R0 is the quotient
;     SIDE EFFECTS -- uses stack to save registers; may print divide by
;                     zero error
;     NOTE: the calling convention here is NOT for use directly by C
;
DIVIDE	ADD R6,R6,#-4	; save R1, R2, R3, and R7
	STR R1,R6,#0
	STR R2,R6,#1
	STR R3,R6,#2
	STR R7,R6,#3

	AND R2,R2,#0	; number of negative operands
	ADD R2,R2,#1

	ADD R1,R1,#0	; set R1 to its negative absolute value
	BRn DIV_R1_NEG
	BRp DIV_R1_POS
	LEA R0,MSG_DIV
	PUTS
	AND R0,R0,#0
	BRnzp DIV_DONE
DIV_R1_POS
	NOT R1,R1
	ADD R1,R1,#1
	ADD R2,R2,#-1
DIV_R1_NEG

	ADD R0,R0,#0	; set R0 to its absolute value
	BRzp DIV_R0_NON_NEG
	NOT R0,R0
	ADD R0,R0,#1
	ADD R2,R2,#1
DIV_R0_NON_NEG

	AND R3,R3,#0
DIV_LOOP
	ADD R0,R0,R1
	BRn DIV_FINISH
	ADD R3,R3,#1
	BRnzp DIV_LOOP
DIV_FINISH
	ADD R0,R3,#0	; move result into R0

	AND R2,R2,#1	; negate answer?
	BRz DIV_DONE
	NOT R0,R0
	ADD R0,R0,#1

DIV_DONE
	LDR R1,R6,#0	; restore R1, R2, R3, and R7
	LDR R2,R6,#1
	LDR R3,R6,#2
	LDR R7,R6,#3
	ADD R6,R6,#4
	RET

MSG_DIV	.STRINGZ "\nDIVIDE BY ZERO\n"



; MODULUS -- calculate R0 MOD R1 (defined in C as R0 - (R0 / R1) * R1)
;     INPUTS -- R0 and R1
;     OUTPUTS -- R0 is the modulus
;     SIDE EFFECTS -- uses stack to save registers; may print divide by
;                     zero error
;     NOTE: the calling convention here is NOT for use directly by C
;
MODULUS	ADD R6,R6,#-3	; save R0, R1, and R7
	STR R0,R6,#0
	STR R1,R6,#1
	STR R7,R6,#2

	JSR DIVIDE	; R0 = R0 / R1
	JSR MULTIPLY	; R0 = (R0 / R1) * R1
	NOT R1,R0	; negate it
	ADD R1,R1,#1
	LDR R0,R6,#0	; add to original R0
	ADD R0,R0,R1

	LDR R1,R6,#1	; restore R1 and R7
	LDR R7,R6,#2
	ADD R6,R6,#3
	RET


; SRAND -- set random number generation seed
;     INPUTS -- new seed (on top of stack)
;     OUTPUTS -- one (meaningless) location left on top of stack
;     SIDE EFFECTS -- changes random seed
;     NOTE: call as a C function
;
SRAND	ADD R6,R6,#-1		; save R0
	STR R0,R6,#0
	LDR R0,R6,#1
	ST R0,RAND_SEED
	LDR R0,R6,#0		; restore R0
	RET


; LOG_RIGHT_SHIFT -- logically shift R0 right by one bit (MSB <- 0)
;     INPUTS -- R0
;     OUTPUTS -- R0 shifted right by a bit
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
LOG_RIGHT_SHIFT
	ADD R6,R6,#-1		; save R1
	STR R1,R6,#0

	AND R0,R0,xFFFE		; set low bit to 0 (will become MSB)

	AND R1,R1,#0		; loop 15 times...
	ADD R1,R1,#15

LRSHFT_LOOP
	ADD R0,R0,#0		; rotate left (copy high bit to low bit)
	BRn LOW_BIT_IS_1
	ADD R0,R0,R0
	BRnzp LRSHFT_NEXT
LOW_BIT_IS_1
	ADD R0,R0,R0
	ADD R0,R0,1

LRSHFT_NEXT
	ADD R1,R1,#-1
	BRp LRSHFT_LOOP

	LDR R1,R6,#0		; restore R1
	ADD R6,R6,#1
	RET


; RAND -- generate random number using the function
;             NEW = (27193 * OLD) + 35993   MOD 65536
;	  the low bit is right-shifted out before returning, since
;         it is not random (the rest are not too bad, at least by 
;         separation of order 2 in Knuth's methods...)
;     INPUTS -- none
;     OUTPUTS -- random value left on top of stack (return value)
;     SIDE EFFECTS -- changes random seed
;     NOTE: call as a C function
;
RAND	ADD R6,R6,#-3		; save R0, R1, and R7
	STR R0,R6,#0
	STR R1,R6,#1
	STR R7,R6,#2
	LD R0,RAND_SEED
	ADD R1,R0,R0		; x 0002
	ADD R1,R1,R0		; x 0003
	ADD R1,R1,R1		; x 0006
	ADD R1,R1,R1		; x 000C
	ADD R1,R1,R0		; x 000D
	ADD R1,R1,R1		; x 001A
	ADD R1,R1,R1		; x 0034
	ADD R1,R1,R0		; x 0035
	ADD R1,R1,R1		; x 006A
	ADD R1,R1,R1		; x 00D4
	ADD R1,R1,R1		; x 01A8
	ADD R1,R1,R1		; x 0350
	ADD R1,R1,R0		; x 0351
	ADD R1,R1,R1		; x 06A2
	ADD R1,R1,R0		; x 06A3
	ADD R1,R1,R1		; x 0D46
	ADD R1,R1,R0		; x 0D47
	ADD R1,R1,R1		; x 1A8E
	ADD R1,R1,R1		; x 351C
	ADD R1,R1,R1		; x 6A38
	ADD R0,R1,R0		; x 6A39 = #27193
	LD R1,RAND_ADD
	ADD R0,R0,R1
	ST R0,RAND_SEED
	JSR LOG_RIGHT_SHIFT	; drop the low bit
	LDR R7,R6,#2		; restore R7
	STR R0,R6,#2		; save return value onto stack
	LDR R0,R6,#0		; restore R0 and R1 
	LDR R1,R6,#1
	ADD R6,R6,#2
	RET

; storage for SRAND and RAND

RAND_SEED 
	.BLKW 1
RAND_ADD
	.FILL #35993


; PRINT_NUM -- print a number in decimal to the monitor (based on code 
;              incorporated as TRAP x26 for MP2 in the Spring 2004 
;              semester of ECE190)
;     INPUTS -- R0 is the number to be printed
;     OUTPUTS -- R0 is the number of characters printed
;     SIDE EFFECTS -- none
;     NOTE: the calling convention here is NOT for use directly by C
;
; The basic strategy is to handle the sign first, then to loop over place
; values starting from 10,000 down to 10.  Place values are subtracted
; repeatedly to calculate each digit, then digits are printed, with 
; leading zeroes omitted.

; R0 is the current digit (calculated in the inner loop)
; R1 points to table of negative digit place values
; R2 holds current digit's place value, again negative
; R3 is the remaining value after removing the previous digit
; R4 is a temporary
; R5 holds the ASCII value '0'
; R6 is a marker used to avoid leading zeroes

PRINT_NUM
	ST R1,PN_SAVE_R1	; callee saves registers
	ST R2,PN_SAVE_R2
	ST R3,PN_SAVE_R3
	ST R4,PN_SAVE_R4
	ST R5,PN_SAVE_R5
	ST R6,PN_SAVE_R6
	ST R7,PN_SAVE_R7

	AND R3,R0,#0		; initialize number of characters printed
	ST R3,PN_PRINTED

	ADD R3,R0,#0		; move to R3 and check for negative value
	BRzp PN_NON_NEG
	LD R0,PN_MINUS		; if negative, print a minus sign
	OUT
	LD R0,PN_PRINTED	; add one to printed characters count
	ADD R0,R0,#1
	ST R0,PN_PRINTED
	NOT R3,R3		; and replace R0 with its absolute value
	ADD R3,R3,#1		; (-32768 will be handled correctly, too)
PN_NON_NEG
	
	LEA R1,PN_SUB		; initialize pointer to place value table
	LD R5,PN_ASC_ZERO	; initialize register with ASCII '0'
	AND R6,R6,#0		; skip leading zeroes
PN_LOOP
	LDR R2,R1,#0		; load digit place value from table
	BRz PN_LAST_DIGIT	; end of table?
	AND R0,R0,#0		; start current digit at 0 (count ADDs)
PN_DIG_LOOP			; loop to determine digit value
	ADD R4,R3,R2		; subtract place value once
	BRn PN_DIG_DONE		; done?
	ADD R3,R4,#0		; no, so copy to remaining value
	ADD R0,R0,#1		;   and increment digit
	BRnzp PN_DIG_LOOP
PN_DIG_DONE
	ADD R4,R0,R6		; do not print leading zeroes
	BRz PN_NO_PRINT
	ADD R0,R0,R5		; print current digit
	OUT
	LD R0,PN_PRINTED	; add one to printed characters count
	ADD R0,R0,#1
	ST R0,PN_PRINTED
	ADD R6,R6,#1		; always print subsequent digits, even zeroes
PN_NO_PRINT
	ADD R1,R1,#1		; point to next place value
	BRnzp PN_LOOP		; loop back for next digit
PN_LAST_DIGIT
	ADD R0,R3,R5		; always print last digit
	OUT
	LD R0,PN_PRINTED	; add one to printed characters count
	ADD R0,R0,#1

	LD R1,PN_SAVE_R1	; restore original register values
	LD R2,PN_SAVE_R2
	LD R3,PN_SAVE_R3
	LD R4,PN_SAVE_R4
	LD R5,PN_SAVE_R5
	LD R6,PN_SAVE_R6
	LD R7,PN_SAVE_R7
	RET

PN_SAVE_R1 .BLKW 1		; space for caller's register values
PN_SAVE_R2 .BLKW 1
PN_SAVE_R3 .BLKW 1
PN_SAVE_R4 .BLKW 1
PN_SAVE_R5 .BLKW 1
PN_SAVE_R6 .BLKW 1
PN_SAVE_R7 .BLKW 1
PN_PRINTED .BLKW 1

PN_SUB  .FILL #-10000		; table of place values
	.FILL #-1000
	.FILL #-100
	.FILL #-10
	.FILL #0

PN_ASC_ZERO .FILL x30		; '0'
PN_MINUS    .FILL x2D		; '-'


; LOAD_FORMAT -- load a character from a format string (for PRINTF or
;		 SCANF), translating escape sequences (-1 for %d)
;                and advancing the string pointer appropriately
;     INPUTS -- R1 is the format string pointer
;     OUTPUTS -- R0 is the next character (-1 for %d)
;                R1 is advanced either one or two locations
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
LOAD_FORMAT
	ADD R6,R6,#-2	; save R2 and R3
	STR R2,R6,#0
	STR R3,R6,#1
	LDR R0,R1,#0
	LD R2,LDF_TEST_1
	ADD R3,R0,R2
	BRnp LDF_NOT_PCT
	LDR R0,R1,#1
	ADD R2,R0,R2
	BRnp LDF_CHECK_D
	ADD R1,R1,#1
LDF_BAD_PCT
	LDR R0,R1,#0
	BRnzp LDF_DONE
LDF_CHECK_D
	LD R2,LDF_TEST_2
	ADD R0,R0,R2
	BRnp LDF_BAD_PCT
	AND R0,R0,#0
	ADD R0,R0,#-1
	ADD R1,R1,#1
	BRnzp LDF_DONE
LDF_NOT_PCT
	LD R2,LDF_TEST_3
	ADD R3,R0,R2
	BRnp LDF_DONE
	LDR R0,R1,#1
	ADD R2,R0,R2
	BRnp LDF_CHECK_N
	ADD R1,R1,#1
LDF_BAD_BS
	LDR R0,R1,#0
	BRnzp LDF_DONE
LDF_CHECK_N
	LD R2,LDF_TEST_4
	ADD R0,R0,R2
	BRnp LDF_BAD_BS
	AND R0,R0,#0
	ADD R0,R0,#10
	ADD R1,R1,#1
LDF_DONE
	ADD R1,R1,#1	; default string pointer advance
	LDR R2,R6,#0	; restore R2 and R3
	LDR R3,R6,#1
	ADD R6,R6,#2
	RET

LDF_TEST_1 	.FILL xFFDB	; -'%'
LDF_TEST_2	.FILL xFF9C	; -'d'
LDF_TEST_3	.FILL xFFA4	; -'\\'
LDF_TEST_4	.FILL xFF92	; -'n'


; PRINTF -- print formatted data
;     INPUTS -- format string followed by arguments
;     OUTPUTS -- number of characters printed left on top of stack 
;                (return value)
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: call as a C function
;
; R0 holds the character to print
; R1 is the format string pointer
; R2 points to the next argument
; R3 is the number of characters printed so far
;
PRINTF	ADD R6,R6,#-5		; save R0, R1, R2, R3, and R7
	STR R0,R6,#0
	STR R1,R6,#1
	STR R2,R6,#2
	STR R3,R6,#3
	STR R7,R6,#4
	LDR R1,R6,#5
	ADD R2,R6,#6
	AND R3,R3,#0
PR_LOOP	JSR LOAD_FORMAT
	ADD R0,R0,#0
	BRz PR_DONE
	BRp PR_REG
	LDR R0,R2,#0
	ADD R2,R2,#1
	JSR PRINT_NUM
	ADD R3,R3,R0
	BRnzp PR_LOOP
PR_REG	OUT
	ADD R3,R3,#1
	BRnzp PR_LOOP
PR_DONE	LDR R7,R6,#4		; restore R7
	STR R3,R6,#4		; save return value
	LDR R0,R6,#0		; restore R0, R1, R2, and R3
	LDR R1,R6,#1
	LDR R2,R6,#2
	LDR R3,R6,#3
	ADD R6,R6,#4
	RET


; BUF_GETC -- read a character from the keyboard, with preference for
;                a character previously read but buffered (in INBUF)
;     INPUTS -- none
;     OUTPUTS -- R4 holds the character
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
BUF_GETC
	ADD R6,R6,#-2
	STR R0,R6,#0
	STR R7,R6,#1
	LD R4,INBUF
	BRnp BGC_OLD
	GETC
	OUT
	ADD R4,R0,#0
	BRnzp BGC_DONE
BGC_OLD	LD R0,INBUF2
        ST R0,INBUF
	AND R0,R0,#0
	ST R0,INBUF
BGC_DONE
	LDR R0,R6,#0
	LDR R7,R6,#1
	ADD R6,R6,#2
	RET

; BUF_UNGETC -- push a character back into the input buffer
;     INPUTS -- R4 holds the character
;     OUTPUTS -- none
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
BUF_UNGETC
	ADD R6,R6,#-1
	STR R0,R6,#0
	LD R0,INBUF
	ST R0,INBUF2
	ST R4,INBUF
	LDR R0,R6,#0
	ADD R6,R6,#1
	RET

; READ_NUM -- read a decimal number from the keyboard, starting with
;             a character previously read but buffered (in INBUF) if necessary;
;             skip white space before the first digit; terminate on non-digit
;             (after first digit); buffer character that causes termination;
;             ignore overflow
;             (this code based on readnumsub.asm code from 190 materials)
;     INPUTS -- none
;     OUTPUTS -- R4 holds the number typed in; R0 holds 1 if number was typed,
;                or 0 if not
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;

; R0 is used as a temporary register
; R1 holds the current value of the number being input
; R2 holds the additive inverse of ASCII '0' (0xFFD0)
; R3 is used as a temporary register
; R4 holds the value of the last key pressed
; R5 marks whether a digit has been seen (positive), just a negative sign (-),
;    or nothing has been seen (0) yet

READ_NUM
	ADD R6,R6,#-5		; save R1, R2, R3, R5, and R7
	STR R1,R6,#0
	STR R2,R6,#1
	STR R3,R6,#2
	STR R5,R6,#3
	STR R7,R6,#4
	AND R1,R1,#0		; clear the current value
	LD R2,RN_NEG_0		; put the value -x30 in R2
	AND R5,R5,#0		; no digits yet
	ST R5,RN_NEGATE
READ_LOOP
	JSR BUF_GETC
	ADD R0,R4,R2		; subtract x30 from R4 and store in R0 
	BRn RN_NON_DIG		; smaller than '0' means a non-digit
	ADD R3,R0,#-10		; check if > '9'
	BRzp RN_NON_DIG		; greater than '9' means a non-digit
	ADD R5,R4,#0		; a digit has been seen
	ADD R3,R1,R1		; sequence of adds multiplies R1 by 10
	ADD R3,R3,R3
	ADD R1,R1,R3
	ADD R1,R1,R1
	ADD R1,R1,R0		; finally, add in new digit
	BRnzp READ_LOOP		; get another digit
RN_NON_DIG
	; if we see space, tab, CR, or LF, we consume if no digits have
	; been seen; otherwise, we stop and buffer the character
	AND R0,R0,#0
	ADD R5,R5,#0
	BRp RN_GOT_NUM 
	BRz RN_NO_DIGITS

	; need to put the minus sign back, too
	JSR BUF_UNGETC
	LD R4,RN_MINUS
	BRnzp RN_SAVE_CHAR

RN_NO_DIGITS
	ADD R3,R4,#-9
	BRz READ_LOOP
	ADD R3,R4,#-10
	BRz READ_LOOP
	ADD R3,R4,#-13
	BRz READ_LOOP
	ADD R3,R4,#-16
	ADD R3,R3,#-16
	BRz READ_LOOP

	LD R3,RN_NEG_MIN
	ADD R3,R3,R4
	BRnp RN_SAVE_CHAR
	ADD R5,R5,#-1
	ST R5,RN_NEGATE
	BRnzp READ_LOOP

RN_GOT_NUM
	ADD R0,R0,#1
	LD R5,RN_NEGATE
	BRz RN_SAVE_CHAR
	NOT R1,R1
	ADD R1,R1,#1
RN_SAVE_CHAR
	JSR BUF_UNGETC
	ADD R4,R1,#0		; move R1 into R4	
	LDR R1,R6,#0		; restore R1, R2, R3, R5, and R7
	LDR R2,R6,#1
	LDR R3,R6,#2
	LDR R5,R6,#3
	LDR R7,R6,#4
	ADD R6,R6,#5
	RET

RN_NEG_0	.FILL xFFD0	; -'0'
RN_NEG_MIN	.FILL xFFD3	; -'-'
RN_MINUS	.FILL x002D	; '-'
RN_NEGATE	.BLKW 1

; SCANF -- scan in formatted data
;     INPUTS -- format string followed by arguments
;     OUTPUTS -- number of integers converted left on top of stack 
;                (return value)
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: call as a C function
;
; R0 holds the character to be read
; R1 is the format string pointer
; R2 points to the next argument
; R3 is the number of integer conversions so far
; R4 is the character/number actually read from the keyboard
;
SCANF	ADD R6,R6,#-6		; save R0, R1, R2, R3, R4, and R7
	STR R0,R6,#0
	STR R1,R6,#1
	STR R2,R6,#2
	STR R3,R6,#3
	STR R4,R6,#4
	STR R7,R6,#5
	LDR R1,R6,#6
	ADD R2,R6,#7
	AND R3,R3,#0
SC_LOOP	JSR LOAD_FORMAT
	ADD R0,R0,#0
	BRz SC_DONE
	BRp SC_REG
	JSR READ_NUM
	ADD R0,R0,#0
	BRz SC_DONE
	LDR R0,R2,#0
	ADD R2,R2,#1
	STR R4,R0,#0
	ADD R3,R3,#1
	BRnzp SC_LOOP
SC_REG	JSR BUF_GETC
	NOT R0,R0
	ADD R0,R0,#1
	ADD R0,R0,R4
	BRz SC_LOOP
	JSR BUF_UNGETC
SC_DONE	LDR R7,R6,#5		; restore R7
	STR R3,R6,#5		; save return value
	LDR R0,R6,#0		; restore R0, R1, R2, R3, and R4
	LDR R1,R6,#1
	LDR R2,R6,#2
	LDR R3,R6,#3
	LDR R4,R6,#4
	ADD R6,R6,#5
	RET

; buffered input characters (0 means none)
INBUF	.FILL x0000
INBUF2	.FILL x0000

;---------------------------------------------------------------------------
; global data space allocation
;---------------------------------------------------------------------------

GLOBDATA
	.BLKW #3

;---------------------------------------------------------------------------
; stack allocation
;---------------------------------------------------------------------------

	.BLKW #1000
STACK

	.END

