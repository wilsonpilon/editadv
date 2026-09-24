;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.6.0 #16555 (MINGW64)
;--------------------------------------------------------
	.module interpreter
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _rand
	.globl _UI_PauseSeconds
	.globl _UI_PrintNumberCenter
	.globl _UI_NewLineCenter
	.globl _UI_PrintCharCenter
	.globl _UI_PrintCenter
	.globl _UI_ClearCenter
	.globl _Interpreter_GetMessageText
	.globl _Interpreter_GetObjectName
	.globl _Interpreter_DescribeCurrentRoom
	.globl _Interpreter_CallFunction
	.globl _Interpreter_Execute
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_Interpreter_GetObjectName_s_obj_name_buf_10000_103:
	.ds 24
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute ram data
;--------------------------------------------------------
	.area _DABS (ABS)
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;engine/src/interpreter.c:40: const char* Interpreter_GetMessageText(u8 msg_id, const Game_Database* db)
;	---------------------------------
; Function Interpreter_GetMessageText
; ---------------------------------
_Interpreter_GetMessageText::
	push	ix
	ld	ix,	#0
	add	ix, sp
	dec	sp
	ld	-1 (ix), a
;engine/src/interpreter.c:44: if (db != NULL && db->mensagens != NULL)
	ld	a, d
	or	a, e
	jr	z, 00106$
	ld	c, e
	ld	b, d
	ld	hl, #17
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, b
	or	a, c
	jr	z, 00106$
;engine/src/interpreter.c:46: for (i = 0; i < db->num_mensagens; i++)
	push	de
	pop	iy
	ld	e, #0x00
00112$:
	ld	d, 19 (iy)
	ld	a, e
	sub	a, d
	jr	nc, 00106$
;engine/src/interpreter.c:48: if (db->mensagens[i] != NULL && db->mensagens[i]->id == msg_id)
	ld	l, e
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	or	a, h
	jr	z, 00113$
	ld	a, (hl)
	sub	a, -1 (ix)
	jr	nz, 00113$
;engine/src/interpreter.c:50: return db->mensagens[i]->text;
	inc	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	jr	00114$
00113$:
;engine/src/interpreter.c:46: for (i = 0; i < db->num_mensagens; i++)
	inc	e
	jr	00112$
00106$:
;engine/src/interpreter.c:55: if (msg_id >= 11 && msg_id <= 22)
	ld	a, -1 (ix)
	sub	a, #0x0b
	jr	c, 00109$
	ld	a, #0x16
	sub	a, -1 (ix)
	jr	c, 00109$
;engine/src/interpreter.c:57: return g_SystemMessages[msg_id];
	ld	bc, #_g_SystemMessages+0
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	jr	00114$
00109$:
;engine/src/interpreter.c:60: return "";
	ld	de, #___str_0
00114$:
;engine/src/interpreter.c:61: }
	inc	sp
	pop	ix
	ret
_g_SystemMessages:
	.dw ___str_0
	.dw ___str_0
	.dw ___str_0
	.dw ___str_0
	.dw ___str_0
	.dw ___str_0
	.dw ___str_0
	.dw ___str_0
	.dw ___str_0
	.dw ___str_0
	.dw ___str_0
	.dw __str_1
	.dw __str_2
	.dw __str_3
	.dw __str_4
	.dw __str_5
	.dw __str_6
	.dw __str_7
	.dw __str_8
	.dw __str_9
	.dw __str_10
	.dw __str_11
	.dw __str_12
___str_0:
	.db 0x00
__str_1:
	.ascii "Bem-vindo "
	.db 0xc3
	.db 0xa0
	.ascii " aventura!"
	.db 0x00
__str_2:
	.ascii "Achei o que voc"
	.db 0xc3
	.db 0xaa
	.ascii " queria."
	.db 0x00
__str_3:
	.ascii "Est"
	.db 0xc3
	.db 0xa1
	.ascii " muito escuro aqui. "
	.db 0xc3
	.db 0x89
	.ascii " melhor arranjar alguma luz ou teremos problemas."
	.db 0x00
__str_4:
	.ascii "Perd"
	.db 0xc3
	.db 0xa3
	.ascii "o, n"
	.db 0xc3
	.db 0xa3
	.ascii "o entendi..."
	.db 0x00
__str_5:
	.db 0xc3
	.db 0x89
	.ascii " imposs"
	.db 0xc3
	.db 0xad
	.ascii "vel ir nesta dire"
	.db 0xc3
	.db 0xa7
	.db 0xc3
	.db 0xa3
	.ascii "o."
	.db 0x00
__str_6:
	.ascii "Isto n"
	.db 0xc3
	.db 0xa3
	.ascii "o "
	.db 0xc3
	.db 0xa9
	.ascii " poss"
	.db 0xc3
	.db 0xad
	.ascii "vel."
	.db 0x00
__str_7:
	.ascii "N"
	.db 0xc3
	.db 0xb3
	.ascii "s n"
	.db 0xc3
	.db 0xa3
	.ascii "o temos isso."
	.db 0x00
__str_8:
	.ascii "N"
	.db 0xc3
	.db 0xb3
	.ascii "s j"
	.db 0xc3
	.db 0xa1
	.ascii " temos isso."
	.db 0x00
__str_9:
	.ascii "Eu n"
	.db 0xc3
	.db 0xa3
	.ascii "o estou vendo isso por aqui."
	.db 0x00
__str_10:
	.db 0xc3
	.db 0x89
	.ascii " apenas um objeto comum."
	.db 0x00
__str_11:
	.ascii "N"
	.db 0xc3
	.db 0xa3
	.ascii "o d"
	.db 0xc3
	.db 0xa1
	.ascii " para carregar mais nada."
	.db 0x00
__str_12:
	.ascii "N"
	.db 0xc3
	.db 0xa3
	.ascii "o cabe mais nada dentro."
	.db 0x00
;engine/src/interpreter.c:67: const char* Interpreter_GetObjectName(u8 obj_id, const Game_Database* db)
;	---------------------------------
; Function Interpreter_GetObjectName
; ---------------------------------
_Interpreter_GetObjectName::
	push	ix
	ld	ix,	#0
	add	ix, sp
	push	af
	push	af
;engine/src/interpreter.c:72: if (obj_id == 0 || db == NULL || db->objetos == NULL) return "";
	ld	-2 (ix), a
	or	a, a
	jr	z, 00101$
	ld	a, d
	or	a, e
	jr	z, 00101$
	ld	c, e
	ld	b, d
	ld	hl, #8
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, b
	or	a, c
	jr	nz, 00138$
00101$:
	ld	de, #___str_13
	jr	00117$
;engine/src/interpreter.c:74: for (i = 0; i < db->num_objetos; i++)
00138$:
	ld	-1 (ix), #0x00
00115$:
	ld	hl, #10
	add	hl, de
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	nc, 00113$
;engine/src/interpreter.c:76: const Game_Object* obj = db->objetos[i];
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;engine/src/interpreter.c:77: if (obj != NULL && obj->id == obj_id)
	ld	l, a
	or	a, h
	jr	z, 00116$
	ld	a, (hl)
	sub	a, -2 (ix)
	jr	nz, 00116$
;engine/src/interpreter.c:79: const char* p = obj->nome;
	inc	hl
	inc	hl
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
;engine/src/interpreter.c:81: while (*p && *p != '/' && k < (sizeof(s_obj_name_buf) - 1))
	ld	e, #0x00
00107$:
	ld	a, (bc)
	ld	d, a
;engine/src/interpreter.c:83: s_obj_name_buf[k++] = *p++;
	ld	a, e
	add	a, #<(_Interpreter_GetObjectName_s_obj_name_buf_10000_103)
	ld	-4 (ix), a
	ld	a, #0x00
	adc	a, #>(_Interpreter_GetObjectName_s_obj_name_buf_10000_103)
	ld	-3 (ix), a
;engine/src/interpreter.c:81: while (*p && *p != '/' && k < (sizeof(s_obj_name_buf) - 1))
	ld	a, d
	or	a, a
	jr	z, 00109$
	ld	a, d
	sub	a, #0x2f
	jr	z, 00109$
	ld	a, e
	sub	a, #0x17
	jr	nc, 00109$
;engine/src/interpreter.c:83: s_obj_name_buf[k++] = *p++;
	inc	e
	inc	bc
	pop	hl
	push	hl
	ld	(hl), d
	jr	00107$
00109$:
;engine/src/interpreter.c:85: s_obj_name_buf[k] = '\0';
	pop	hl
	ld	(hl), #0x00
	push	hl
;engine/src/interpreter.c:86: return s_obj_name_buf;
	ld	de, #_Interpreter_GetObjectName_s_obj_name_buf_10000_103
	jr	00117$
00116$:
;engine/src/interpreter.c:74: for (i = 0; i < db->num_objetos; i++)
	inc	-1 (ix)
	jr	00115$
00113$:
;engine/src/interpreter.c:89: return "";
	ld	de, #___str_13
00117$:
;engine/src/interpreter.c:90: }
	ld	sp, ix
	pop	ix
	ret
___str_13:
	.db 0x00
;engine/src/interpreter.c:95: void Interpreter_DescribeCurrentRoom(const Game_Database* db, Game_State* state)
;	---------------------------------
; Function Interpreter_DescribeCurrentRoom
; ---------------------------------
_Interpreter_DescribeCurrentRoom::
	push	ix
	ld	ix,	#0
	add	ix, sp
	ld	iy, #-11
	add	iy, sp
	ld	sp, iy
	ld	-3 (ix), l
	ld	-2 (ix), h
	ld	-5 (ix), e
	ld	-4 (ix), d
;engine/src/interpreter.c:97: u8 room_id = state->registers[REG_POSICAO];
	ld	a, -5 (ix)
	ld	-7 (ix), a
	ld	a, -4 (ix)
	ld	-6 (ix), a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	inc	hl
	ld	a, (hl)
	ld	-11 (ix), a
;engine/src/interpreter.c:99: const Game_Position* pos = NULL;
	xor	a, a
	ld	-9 (ix), a
	ld	-8 (ix), a
;engine/src/interpreter.c:102: if (state->registers[REG_ILUMINACAO] != 0 && state->registers[REG_ESTADO_OBJ2] == 0)
	ld	a, -5 (ix)
	ld	-7 (ix), a
	ld	a, -4 (ix)
	ld	-6 (ix), a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	de, #0x0009
	add	hl, de
	ld	a, (hl)
	ld	-1 (ix), a
	or	a, a
	jr	z, 00102$
	ld	a, -5 (ix)
	ld	-7 (ix), a
	ld	a, -4 (ix)
	ld	-6 (ix), a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	de, #0x000a
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	nz, 00102$
;engine/src/interpreter.c:104: UI_PrintCenter(Interpreter_GetMessageText(MSG_ESCURO, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x0d
	call	_Interpreter_GetMessageText
	ld	-7 (ix), e
	ld	-6 (ix), d
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/interpreter.c:105: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/interpreter.c:106: return;
	jp	00127$
00102$:
;engine/src/interpreter.c:109: if (db != NULL && db->posicoes != NULL)
	ld	a, -2 (ix)
	or	a, -3 (ix)
	jr	z, 00109$
	ld	a, -3 (ix)
	ld	-7 (ix), a
	ld	a, -2 (ix)
	ld	-6 (ix), a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	de, #0x0005
	add	hl, de
	ld	a, (hl)
	ld	-7 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-6 (ix), a
	or	a, -7 (ix)
	jr	z, 00109$
;engine/src/interpreter.c:111: for (i = 0; i < db->num_posicoes; i++)
	ld	c, -3 (ix)
	ld	b, -2 (ix)
	ld	e, #0x00
00123$:
	ld	hl, #7
	add	hl, bc
	ld	a, e
	sub	a, (hl)
	jr	nc, 00109$
;engine/src/interpreter.c:113: if (db->posicoes[i] != NULL && db->posicoes[i]->id == room_id)
	ld	l, e
	ld	h, #0x00
	add	hl, hl
	ld	a, l
	add	a, -7 (ix)
	ld	l, a
	ld	a, h
	adc	a, -6 (ix)
	ld	h, a
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	or	a, h
	jr	z, 00124$
	ld	a, (hl)
	sub	a, -11 (ix)
	jr	nz, 00124$
;engine/src/interpreter.c:115: pos = db->posicoes[i];
	ld	-9 (ix), l
	ld	-8 (ix), h
;engine/src/interpreter.c:116: break;
	jr	00109$
00124$:
;engine/src/interpreter.c:111: for (i = 0; i < db->num_posicoes; i++)
	inc	e
	jr	00123$
00109$:
;engine/src/interpreter.c:121: if (pos != NULL && pos->desc != NULL)
	ld	a, -8 (ix)
	or	a, -9 (ix)
	jr	z, 00112$
	ld	a, -9 (ix)
	ld	-7 (ix), a
	ld	a, -8 (ix)
	ld	-6 (ix), a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	de, #0x0005
	add	hl, de
	ld	a, (hl)
	ld	-7 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-6 (ix), a
	or	a, -7 (ix)
	jr	z, 00112$
;engine/src/interpreter.c:123: UI_PrintCenter(pos->desc);
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	call	_UI_PrintCenter
;engine/src/interpreter.c:124: UI_NewLineCenter();
	call	_UI_NewLineCenter
00112$:
;engine/src/interpreter.c:129: bool first = TRUE;
	ld	-10 (ix), #0x01
;engine/src/interpreter.c:130: for (i = 1; i <= db->num_objetos; i++)
	ld	a, -5 (ix)
	ld	-9 (ix), a
	ld	a, -4 (ix)
	ld	-8 (ix), a
	ld	a, -3 (ix)
	ld	-7 (ix), a
	ld	a, -2 (ix)
	ld	-6 (ix), a
	ld	-1 (ix), #0x01
00126$:
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	de, #0x000a
	add	hl, de
	ld	a, (hl)
	sub	a, -1 (ix)
	jr	c, 00127$
;engine/src/interpreter.c:133: if (i == OBJ_ID_LOCAL) continue;
	ld	a, -1 (ix)
	dec	a
	jr	z, 00120$
;engine/src/interpreter.c:135: if (state->registers[REG_OBJETO_OFFSET + i] == room_id)
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ld	e, -9 (ix)
	ld	d, -8 (ix)
	add	hl, de
	ld	a, (hl)
	sub	a, -11 (ix)
	jr	nz, 00120$
;engine/src/interpreter.c:137: if (first)
	ld	a, -10 (ix)
	or	a, a
	jr	z, 00117$
;engine/src/interpreter.c:139: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/interpreter.c:140: UI_PrintCenter("Neste local tem:");
	ld	hl, #___str_14
	call	_UI_PrintCenter
;engine/src/interpreter.c:141: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/interpreter.c:142: first = FALSE;
	ld	-10 (ix), #0x00
00117$:
;engine/src/interpreter.c:144: UI_PrintCenter("- ");
	ld	hl, #___str_15
	call	_UI_PrintCenter
;engine/src/interpreter.c:145: UI_PrintCenter(Interpreter_GetObjectName(i, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, -1 (ix)
	call	_Interpreter_GetObjectName
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/interpreter.c:146: UI_NewLineCenter();
	call	_UI_NewLineCenter
00120$:
;engine/src/interpreter.c:130: for (i = 1; i <= db->num_objetos; i++)
	inc	-1 (ix)
	jr	00126$
00127$:
;engine/src/interpreter.c:150: }
	ld	sp, ix
	pop	ix
	ret
___str_14:
	.ascii "Neste local tem:"
	.db 0x00
___str_15:
	.ascii "- "
	.db 0x00
;engine/src/interpreter.c:155: void Interpreter_CallFunction(u8 func_id, const Game_Database* db, Game_State* state)
;	---------------------------------
; Function Interpreter_CallFunction
; ---------------------------------
_Interpreter_CallFunction::
	push	ix
	ld	ix,	#0
	add	ix, sp
	push	af
	push	af
	ld	-2 (ix), a
	ld	c, e
	ld	b, d
;engine/src/interpreter.c:158: if (db == NULL || db->funcoes == NULL || func_id == 0) return;
	ld	a, b
	or	a, c
	jr	z, 00112$
	ld	e, c
	ld	d, b
	ld	hl, #14
	add	hl, de
	ld	a, (hl)
	ld	-4 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-3 (ix), a
	or	a, -4 (ix)
	jr	z, 00112$
	ld	a, -2 (ix)
	or	a, a
;engine/src/interpreter.c:160: for (i = 0; i < db->num_funcoes; i++)
	jr	z, 00112$
	push	bc
	pop	iy
	ld	-1 (ix), #0x00
00110$:
	ld	e, 16 (iy)
	ld	a, -1 (ix)
	sub	a, e
	jr	nc, 00112$
;engine/src/interpreter.c:162: const Game_Function* f = db->funcoes[i];
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	pop	de
	push	de
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;engine/src/interpreter.c:163: if (f != NULL && f->id == func_id)
	ld	a, d
	or	a, e
	jr	z, 00111$
	ld	a, (de)
	sub	a, -2 (ix)
	jr	nz, 00111$
;engine/src/interpreter.c:165: Interpreter_Execute(f->instructions, f->instruction_count, db, state);
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ex	de, hl
	inc	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	push	bc
	push	af
	inc	sp
	ex	de, hl
	call	_Interpreter_Execute
;engine/src/interpreter.c:166: return;
	jr	00112$
00111$:
;engine/src/interpreter.c:160: for (i = 0; i < db->num_funcoes; i++)
	inc	-1 (ix)
	jr	00110$
00112$:
;engine/src/interpreter.c:169: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
;engine/src/interpreter.c:175: void Interpreter_Execute(const Game_Instruction* instructions, u8 count, const Game_Database* db, Game_State* state)
;	---------------------------------
; Function Interpreter_Execute
; ---------------------------------
_Interpreter_Execute::
	push	ix
	ld	ix,	#0
	add	ix, sp
	ld	iy, #-124
	add	iy, sp
	ld	sp, iy
	ld	-3 (ix), l
	ld	-2 (ix), h
;engine/src/interpreter.c:177: u8 pc = 0;
	ld	-1 (ix), #0x00
;engine/src/interpreter.c:179: if (instructions == NULL || count == 0) return;
	ld	a, -2 (ix)
	or	a, -3 (ix)
	jp	z, 00262$
	ld	a, 4 (ix)
	or	a, a
	jp	z, 00262$
;engine/src/interpreter.c:181: state->flag_espera_cmd = FALSE;
	ld	a, 7 (ix)
	ld	-120 (ix), a
	ld	a, 8 (ix)
	ld	-119 (ix), a
	ld	de, #0x0106
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	add	hl, de
	ld	-118 (ix), l
	ld	-117 (ix), h
	ld	(hl), #0x00
;engine/src/interpreter.c:183: while (pc < count && !state->flag_espera_cmd && !state->flag_fim && !state->flag_reiniciar)
	ld	a, -120 (ix)
	ld	-116 (ix), a
	ld	a, -119 (ix)
	ld	-115 (ix), a
	ld	a, -120 (ix)
	ld	-114 (ix), a
	ld	a, -119 (ix)
	ld	-113 (ix), a
	ld	a, -120 (ix)
	ld	-112 (ix), a
	ld	a, -119 (ix)
	ld	-111 (ix), a
	ld	a, -120 (ix)
	ld	-110 (ix), a
	ld	a, -119 (ix)
	ld	-109 (ix), a
	ld	a, -120 (ix)
	ld	-108 (ix), a
	ld	a, -119 (ix)
	ld	-107 (ix), a
	ld	de, #0x0100
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	add	hl, de
	ld	-106 (ix), l
	ld	-105 (ix), h
	ld	a, -120 (ix)
	ld	-104 (ix), a
	ld	a, -119 (ix)
	ld	-103 (ix), a
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	inc	hl
	ld	-102 (ix), l
	ld	-101 (ix), h
	ld	a, -102 (ix)
	ld	-100 (ix), a
	ld	a, -101 (ix)
	ld	-99 (ix), a
	ld	a, -106 (ix)
	ld	-98 (ix), a
	ld	a, -105 (ix)
	ld	-97 (ix), a
	ld	a, -120 (ix)
	ld	-96 (ix), a
	ld	a, -119 (ix)
	ld	-95 (ix), a
	ld	a, -106 (ix)
	ld	-94 (ix), a
	ld	a, -105 (ix)
	ld	-93 (ix), a
	ld	a, -120 (ix)
	ld	-92 (ix), a
	ld	a, -119 (ix)
	ld	-91 (ix), a
	ld	a, -106 (ix)
	ld	-90 (ix), a
	ld	a, -105 (ix)
	ld	-89 (ix), a
	ld	a, -102 (ix)
	ld	-88 (ix), a
	ld	a, -101 (ix)
	ld	-87 (ix), a
	ld	a, -120 (ix)
	ld	-86 (ix), a
	ld	a, -119 (ix)
	ld	-85 (ix), a
	ld	a, 5 (ix)
	ld	-84 (ix), a
	ld	a, 6 (ix)
	ld	-83 (ix), a
	ld	de, #0x000a
	ld	l, -84 (ix)
	ld	h, -83 (ix)
	add	hl, de
	ld	-82 (ix), l
	ld	-81 (ix), h
	ld	a, -106 (ix)
	ld	-80 (ix), a
	ld	a, -105 (ix)
	ld	-79 (ix), a
	ld	a, -106 (ix)
	ld	-78 (ix), a
	ld	a, -105 (ix)
	ld	-77 (ix), a
	ld	a, -106 (ix)
	ld	-76 (ix), a
	ld	a, -105 (ix)
	ld	-75 (ix), a
	ld	a, -106 (ix)
	ld	-74 (ix), a
	ld	a, -105 (ix)
	ld	-73 (ix), a
	ld	a, -120 (ix)
	ld	-72 (ix), a
	ld	a, -119 (ix)
	ld	-71 (ix), a
	ld	a, -120 (ix)
	ld	-70 (ix), a
	ld	a, -119 (ix)
	ld	-69 (ix), a
	ld	a, -120 (ix)
	ld	-68 (ix), a
	ld	a, -119 (ix)
	ld	-67 (ix), a
	ld	a, -82 (ix)
	ld	-66 (ix), a
	ld	a, -81 (ix)
	ld	-65 (ix), a
	ld	a, -120 (ix)
	ld	-64 (ix), a
	ld	a, -119 (ix)
	ld	-63 (ix), a
	ld	a, -120 (ix)
	ld	-62 (ix), a
	ld	a, -119 (ix)
	ld	-61 (ix), a
	ld	a, -82 (ix)
	ld	-60 (ix), a
	ld	a, -81 (ix)
	ld	-59 (ix), a
	ld	a, -106 (ix)
	ld	-58 (ix), a
	ld	a, -105 (ix)
	ld	-57 (ix), a
	ld	a, -120 (ix)
	ld	-56 (ix), a
	ld	a, -119 (ix)
	ld	-55 (ix), a
	ld	a, -120 (ix)
	ld	-54 (ix), a
	ld	a, -119 (ix)
	ld	-53 (ix), a
	ld	a, -120 (ix)
	ld	-52 (ix), a
	ld	a, -119 (ix)
	ld	-51 (ix), a
	ld	a, -120 (ix)
	ld	-50 (ix), a
	ld	a, -119 (ix)
	ld	-49 (ix), a
	ld	a, -102 (ix)
	ld	-48 (ix), a
	ld	a, -101 (ix)
	ld	-47 (ix), a
	ld	a, -82 (ix)
	ld	-46 (ix), a
	ld	a, -81 (ix)
	ld	-45 (ix), a
	ld	a, -84 (ix)
	ld	-44 (ix), a
	ld	a, -83 (ix)
	ld	-43 (ix), a
	ld	a, -84 (ix)
	ld	-42 (ix), a
	ld	a, -83 (ix)
	ld	-41 (ix), a
	ld	a, -120 (ix)
	ld	-40 (ix), a
	ld	a, -119 (ix)
	ld	-39 (ix), a
	ld	a, -120 (ix)
	ld	-38 (ix), a
	ld	a, -119 (ix)
	ld	-37 (ix), a
	ld	a, -120 (ix)
	ld	-36 (ix), a
	ld	a, -119 (ix)
	ld	-35 (ix), a
	ld	a, -120 (ix)
	ld	-34 (ix), a
	ld	a, -119 (ix)
	ld	-33 (ix), a
	ld	a, -120 (ix)
	ld	-32 (ix), a
	ld	a, -119 (ix)
	ld	-31 (ix), a
	ld	a, -120 (ix)
	ld	-30 (ix), a
	ld	a, -119 (ix)
	ld	-29 (ix), a
	ld	a, -120 (ix)
	ld	-28 (ix), a
	ld	a, -119 (ix)
	ld	-27 (ix), a
	ld	a, -120 (ix)
	ld	-26 (ix), a
	ld	a, -119 (ix)
	ld	-25 (ix), a
	ld	a, -102 (ix)
	ld	-24 (ix), a
	ld	a, -101 (ix)
	ld	-23 (ix), a
	ld	a, -120 (ix)
	ld	-22 (ix), a
	ld	a, -119 (ix)
	ld	-21 (ix), a
	ld	a, -102 (ix)
	ld	-20 (ix), a
	ld	a, -101 (ix)
	ld	-19 (ix), a
	ld	a, -120 (ix)
	ld	-18 (ix), a
	ld	a, -119 (ix)
	ld	-17 (ix), a
	ld	a, -120 (ix)
	ld	-16 (ix), a
	ld	a, -119 (ix)
	ld	-15 (ix), a
	ld	a, -120 (ix)
	ld	-14 (ix), a
	ld	a, -119 (ix)
	ld	-13 (ix), a
	ld	a, -120 (ix)
	ld	-12 (ix), a
	ld	a, -119 (ix)
	ld	-11 (ix), a
	ld	a, -120 (ix)
	ld	-10 (ix), a
	ld	a, -119 (ix)
	ld	-9 (ix), a
	ld	a, -120 (ix)
	ld	-8 (ix), a
	ld	a, -119 (ix)
	ld	-7 (ix), a
00239$:
	ld	a, -1 (ix)
	sub	a, 4 (ix)
	jp	nc, 00262$
	ld	l, -118 (ix)
	ld	h, -117 (ix)
	ld	a, (hl)
	or	a, a
	jp	nz, 00262$
	ld	l, -116 (ix)
	ld	h, -115 (ix)
	ld	de, #0x0107
	add	hl, de
	ld	a, (hl)
	or	a, a
	jp	nz, 00262$
	ld	l, -114 (ix)
	ld	h, -113 (ix)
	ld	de, #0x0108
	add	hl, de
	ld	a, (hl)
	or	a, a
	jp	nz, 00262$
;engine/src/interpreter.c:185: const Game_Instruction* inst = &instructions[pc];
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, -3 (ix)
	ld	e, a
	ld	a, h
	adc	a, -2 (ix)
	ld	d, a
;engine/src/interpreter.c:186: u8 op = inst->op;
	ld	a, (de)
	ld	c, a
;engine/src/interpreter.c:187: u8 p1 = inst->p1;
	push	de
	pop	iy
	ld	a, 1 (iy)
	ld	-4 (ix), a
;engine/src/interpreter.c:188: u8 p2 = inst->p2;
	push	de
	pop	iy
	ld	a, 2 (iy)
	ld	-6 (ix), a
;engine/src/interpreter.c:189: u8 p3 = inst->p3;
	push	de
	pop	iy
	ld	a, 3 (iy)
	ld	-5 (ix), a
;engine/src/interpreter.c:191: switch (op)
	ld	a, #0x2c
	sub	a, c
	jp	c, 00235$
	ld	b, #0x00
	ld	hl, #00816$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00816$:
	.dw	00235$
	.dw	00105$
	.dw	00106$
	.dw	00107$
	.dw	00118$
	.dw	00126$
	.dw	00135$
	.dw	00136$
	.dw	00137$
	.dw	00140$
	.dw	00141$
	.dw	00142$
	.dw	00145$
	.dw	00148$
	.dw	00151$
	.dw	00154$
	.dw	00157$
	.dw	00160$
	.dw	00163$
	.dw	00174$
	.dw	00175$
	.dw	00176$
	.dw	00181$
	.dw	00395$
	.dw	00398$
	.dw	00190$
	.dw	00404$
	.dw	00200$
	.dw	00201$
	.dw	00202$
	.dw	00203$
	.dw	00204$
	.dw	00205$
	.dw	00206$
	.dw	00207$
	.dw	00208$
	.dw	00209$
	.dw	00210$
	.dw	00211$
	.dw	00217$
	.dw	00218$
	.dw	00221$
	.dw	00222$
	.dw	00223$
	.dw	00227$
;engine/src/interpreter.c:197: case OP_MSG:
00105$:
;engine/src/interpreter.c:198: UI_PrintCenter(Interpreter_GetMessageText(p1, db));
	ld	e, -84 (ix)
	ld	d, -83 (ix)
	ld	a, -4 (ix)
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/interpreter.c:199: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/interpreter.c:200: break;
	jp	00235$
;engine/src/interpreter.c:202: case OP_NVC:
00106$:
;engine/src/interpreter.c:203: state->flag_espera_cmd = TRUE;
	ld	l, -118 (ix)
	ld	h, -117 (ix)
	ld	(hl), #0x01
;engine/src/interpreter.c:204: return;
	jp	00262$
;engine/src/interpreter.c:206: case OP_LLIST:
00107$:
;engine/src/interpreter.c:208: u8 room_id = state->registers[REG_POSICAO];
	ld	c, -120 (ix)
	ld	b, -119 (ix)
	inc	bc
	ld	a, (bc)
	ld	-1 (ix), a
;engine/src/interpreter.c:210: bool found = FALSE;
	ld	c, #0x00
;engine/src/interpreter.c:211: for (i = 1; i <= db->num_objetos; i++)
	ld	a, -120 (ix)
	ld	-5 (ix), a
	ld	a, -119 (ix)
	ld	-4 (ix), a
	ld	a, -84 (ix)
	ld	-7 (ix), a
	ld	a, -83 (ix)
	ld	-6 (ix), a
	ld	a, -82 (ix)
	ld	-10 (ix), a
	ld	a, -81 (ix)
	ld	-9 (ix), a
	ld	-8 (ix), #0x01
00243$:
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	b, (hl)
	ld	a, b
	sub	a, -8 (ix)
	jr	c, 00115$
;engine/src/interpreter.c:213: if (i == OBJ_ID_LOCAL) continue;
	ld	a, -8 (ix)
	dec	a
	jr	z, 00114$
;engine/src/interpreter.c:214: if (state->registers[REG_OBJETO_OFFSET + i] == room_id)
	ld	e, -8 (ix)
	ld	d, #0x00
	ld	hl, #0x0064
	add	hl, de
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	add	hl, de
	ld	a, (hl)
	sub	a, -1 (ix)
	jr	nz, 00114$
;engine/src/interpreter.c:216: if (!found)
	ld	a, c
	or	a, a
	jr	nz, 00111$
;engine/src/interpreter.c:218: UI_PrintCenter("Neste local tem:");
	ld	hl, #___str_16
	call	_UI_PrintCenter
;engine/src/interpreter.c:219: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/interpreter.c:220: found = TRUE;
	ld	c, #0x01
00111$:
;engine/src/interpreter.c:222: UI_PrintCenter("- ");
	push	bc
	ld	hl, #___str_17
	call	_UI_PrintCenter
;engine/src/interpreter.c:223: UI_PrintCenter(Interpreter_GetObjectName(i, db));
	ld	e, -7 (ix)
	ld	d, -6 (ix)
	ld	a, -8 (ix)
	call	_Interpreter_GetObjectName
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/interpreter.c:224: UI_NewLineCenter();
	call	_UI_NewLineCenter
	pop	bc
00114$:
;engine/src/interpreter.c:211: for (i = 1; i <= db->num_objetos; i++)
	inc	-8 (ix)
	jr	00243$
00115$:
;engine/src/interpreter.c:227: if (!found)
	ld	a, c
	or	a, a
	jr	nz, 00117$
;engine/src/interpreter.c:229: UI_PrintCenter("Não há nada de especial aqui.");
	ld	hl, #___str_18
	call	_UI_PrintCenter
;engine/src/interpreter.c:230: UI_NewLineCenter();
	call	_UI_NewLineCenter
00117$:
;engine/src/interpreter.c:232: state->flag_espera_cmd = TRUE;
	ld	l, -118 (ix)
	ld	h, -117 (ix)
	ld	(hl), #0x01
;engine/src/interpreter.c:233: return;
	jp	00262$
;engine/src/interpreter.c:236: case OP_CLIST:
00118$:
;engine/src/interpreter.c:239: bool found = FALSE;
	ld	-6 (ix), #0x00
;engine/src/interpreter.c:240: for (i = 1; i <= db->num_objetos; i++)
	ld	a, -120 (ix)
	ld	-5 (ix), a
	ld	a, -119 (ix)
	ld	-4 (ix), a
	ld	a, 5 (ix)
	ld	-10 (ix), a
	ld	a, 6 (ix)
	ld	-9 (ix), a
	ld	a, -10 (ix)
	ld	-8 (ix), a
	ld	a, -9 (ix)
	ld	-7 (ix), a
	ld	-1 (ix), #0x01
00245$:
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	de, #0x000a
	add	hl, de
	ld	c, (hl)
	ld	a, c
	sub	a, -1 (ix)
	jr	c, 00123$
;engine/src/interpreter.c:242: if (state->registers[REG_OBJETO_OFFSET + i] == OBJ_SIT_CARREGADO)
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	add	hl, de
	ld	a, (hl)
	cp	a, #0xfa
	jr	nz, 00246$
;engine/src/interpreter.c:244: if (!found)
	ld	a, -6 (ix)
	or	a, a
	jr	nz, 00120$
;engine/src/interpreter.c:246: UI_PrintCenter("Você está carregando:");
	ld	hl, #___str_19
	call	_UI_PrintCenter
;engine/src/interpreter.c:247: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/interpreter.c:248: found = TRUE;
	ld	-6 (ix), #0x01
00120$:
;engine/src/interpreter.c:250: UI_PrintCenter("- ");
	ld	hl, #___str_17
	call	_UI_PrintCenter
;engine/src/interpreter.c:251: UI_PrintCenter(Interpreter_GetObjectName(i, db));
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	a, -1 (ix)
	call	_Interpreter_GetObjectName
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/interpreter.c:252: UI_NewLineCenter();
	call	_UI_NewLineCenter
00246$:
;engine/src/interpreter.c:240: for (i = 1; i <= db->num_objetos; i++)
	inc	-1 (ix)
	jr	00245$
00123$:
;engine/src/interpreter.c:255: if (!found)
	ld	a, -6 (ix)
	or	a, a
	jr	nz, 00125$
;engine/src/interpreter.c:257: UI_PrintCenter("Você não está carregando nada.");
	ld	hl, #___str_20
	call	_UI_PrintCenter
;engine/src/interpreter.c:258: UI_NewLineCenter();
	call	_UI_NewLineCenter
00125$:
;engine/src/interpreter.c:260: state->flag_espera_cmd = TRUE;
	ld	l, -118 (ix)
	ld	h, -117 (ix)
	ld	(hl), #0x01
;engine/src/interpreter.c:261: return;
	jp	00262$
;engine/src/interpreter.c:264: case OP_DLIST:
00126$:
;engine/src/interpreter.c:267: bool found = FALSE;
	ld	-6 (ix), #0x00
;engine/src/interpreter.c:268: for (i = 1; i <= db->num_objetos; i++)
	ld	a, -120 (ix)
	ld	-5 (ix), a
	ld	a, -119 (ix)
	ld	-4 (ix), a
	ld	a, 5 (ix)
	ld	-10 (ix), a
	ld	a, 6 (ix)
	ld	-9 (ix), a
	ld	a, -10 (ix)
	ld	-8 (ix), a
	ld	a, -9 (ix)
	ld	-7 (ix), a
	ld	-1 (ix), #0x01
00248$:
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	de, #0x000a
	add	hl, de
	ld	c, (hl)
	ld	a, c
	sub	a, -1 (ix)
	jr	c, 00132$
;engine/src/interpreter.c:270: u8 sit = state->registers[REG_OBJETO_OFFSET + i];
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	add	hl, de
	ld	a, (hl)
;engine/src/interpreter.c:271: if (sit == OBJ_SIT_EM_OBJ3_ABERTO || sit == OBJ_SIT_EM_OBJ3_FECHADO)
	cp	a, #0xfb
	jr	z, 00129$
	cp	a, #0xfd
	jr	nz, 00249$
00129$:
;engine/src/interpreter.c:273: if (!found)
	ld	a, -6 (ix)
	or	a, a
	jr	nz, 00128$
;engine/src/interpreter.c:275: UI_PrintCenter("Dentro tem:");
	ld	hl, #___str_21
	call	_UI_PrintCenter
;engine/src/interpreter.c:276: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/interpreter.c:277: found = TRUE;
	ld	-6 (ix), #0x01
00128$:
;engine/src/interpreter.c:279: UI_PrintCenter("- ");
	ld	hl, #___str_17
	call	_UI_PrintCenter
;engine/src/interpreter.c:280: UI_PrintCenter(Interpreter_GetObjectName(i, db));
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	a, -1 (ix)
	call	_Interpreter_GetObjectName
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/interpreter.c:281: UI_NewLineCenter();
	call	_UI_NewLineCenter
00249$:
;engine/src/interpreter.c:268: for (i = 1; i <= db->num_objetos; i++)
	inc	-1 (ix)
	jr	00248$
00132$:
;engine/src/interpreter.c:284: if (!found)
	ld	a, -6 (ix)
	or	a, a
	jr	nz, 00134$
;engine/src/interpreter.c:286: UI_PrintCenter("Está vazio.");
	ld	hl, #___str_22
	call	_UI_PrintCenter
;engine/src/interpreter.c:287: UI_NewLineCenter();
	call	_UI_NewLineCenter
00134$:
;engine/src/interpreter.c:289: state->flag_espera_cmd = TRUE;
	ld	l, -118 (ix)
	ld	h, -117 (ix)
	ld	(hl), #0x01
;engine/src/interpreter.c:290: return;
	jp	00262$
;engine/src/interpreter.c:293: case OP_OBJ:
00135$:
;engine/src/interpreter.c:295: u8 target = (p1 != 0) ? p1 : state->obj_evidencia;
	ld	a, -4 (ix)
	or	a, a
	jr	z, 00264$
	ld	a, -4 (ix)
	jr	00265$
00264$:
	ld	l, -90 (ix)
	ld	h, -89 (ix)
	ld	a, (hl)
00265$:
;engine/src/interpreter.c:296: UI_PrintCenter(Interpreter_GetObjectName(target, db));
	ld	e, 5 (ix)
	ld	d, 6 (ix)
	call	_Interpreter_GetObjectName
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/interpreter.c:297: break;
	jp	00235$
;engine/src/interpreter.c:300: case OP_INC:
00136$:
;engine/src/interpreter.c:301: state->registers[p1]++;
	ld	e, -4 (ix)
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	d, #0x00
	add	hl, de
	inc	(hl)
;engine/src/interpreter.c:302: break;
	jp	00235$
;engine/src/interpreter.c:304: case OP_DEC:
00137$:
;engine/src/interpreter.c:305: if (state->registers[p1] > 0)
	ld	e, -4 (ix)
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jp	z, 00235$
;engine/src/interpreter.c:307: state->registers[p1]--;
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	ld	d, #0x00
	add	hl, de
	dec	(hl)
	ld	c, (hl)
;engine/src/interpreter.c:309: break;
	jp	00235$
;engine/src/interpreter.c:311: case OP_LDR:
00140$:
;engine/src/interpreter.c:312: state->registers[p1] = p2;
	ld	e, -4 (ix)
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, -6 (ix)
	ld	(hl), a
;engine/src/interpreter.c:313: break;
	jp	00235$
;engine/src/interpreter.c:315: case OP_SOMA:
00141$:
;engine/src/interpreter.c:316: state->registers[p1] += p2;
	ld	e, -4 (ix)
	ld	a, e
	add	a, -14 (ix)
	ld	c, a
	ld	a, #0x00
	adc	a, -13 (ix)
	ld	b, a
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	add	a, -6 (ix)
	ld	(bc), a
;engine/src/interpreter.c:317: break;
	jp	00235$
;engine/src/interpreter.c:319: case OP_RND:
00142$:
;engine/src/interpreter.c:320: if (p2 > 0)
	ld	a, -6 (ix)
	or	a, a
	jp	z, 00235$
;engine/src/interpreter.c:322: state->registers[p1] += (u8)(rand() % (p2 + 1));
	ld	e, -4 (ix)
	ld	a, e
	add	a, -16 (ix)
	ld	c, a
	ld	a, #0x00
	adc	a, -15 (ix)
	ld	b, a
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	ld	d, #0x00
	add	hl, de
	push	hl
	push	bc
	call	_rand
	push	de
	pop	iy
	pop	bc
	pop	hl
	ld	e, -6 (ix)
	ld	d, #0x00
	inc	de
	push	hl
	push	bc
	push	iy
	pop	hl
	call	__modsint
	pop	bc
	pop	hl
	ld	a, (hl)
	add	a, e
	ld	(bc), a
;engine/src/interpreter.c:324: break;
	jp	00235$
;engine/src/interpreter.c:326: case OP_REG_EQ:
00145$:
;engine/src/interpreter.c:327: if (state->registers[p1] == p2)
	ld	e, -4 (ix)
	ld	l, -112 (ix)
	ld	h, -111 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	sub	a, -6 (ix)
	jp	nz, 00235$
;engine/src/interpreter.c:329: pc = p3;
	ld	a, -5 (ix)
	ld	-1 (ix), a
;engine/src/interpreter.c:330: continue;
	jp	00239$
;engine/src/interpreter.c:334: case OP_REG_GT:
00148$:
;engine/src/interpreter.c:335: if (state->registers[p1] > p2)
	ld	e, -4 (ix)
	ld	l, -110 (ix)
	ld	h, -109 (ix)
	ld	d, #0x00
	add	hl, de
	ld	c, (hl)
	ld	a, -6 (ix)
	sub	a, c
	jp	nc, 00235$
;engine/src/interpreter.c:337: pc = p3;
	ld	a, -5 (ix)
	ld	-1 (ix), a
;engine/src/interpreter.c:338: continue;
	jp	00239$
;engine/src/interpreter.c:342: case OP_REG_LT:
00151$:
;engine/src/interpreter.c:343: if (state->registers[p1] < p2)
	ld	e, -4 (ix)
	ld	l, -108 (ix)
	ld	h, -107 (ix)
	ld	d, #0x00
	add	hl, de
	ld	c, (hl)
	ld	a, c
	sub	a, -6 (ix)
	jp	nc, 00235$
;engine/src/interpreter.c:345: pc = p3;
	ld	a, -5 (ix)
	ld	-1 (ix), a
;engine/src/interpreter.c:346: continue;
	jp	00239$
;engine/src/interpreter.c:350: case OP_AQUI:
00154$:
;engine/src/interpreter.c:352: u8 target = (p1 != 0) ? p1 : state->obj_evidencia;
	ld	a, -4 (ix)
	or	a, a
	jr	z, 00266$
	ld	c, -4 (ix)
	jr	00267$
00266$:
	ld	l, -106 (ix)
	ld	h, -105 (ix)
	ld	c, (hl)
00267$:
;engine/src/interpreter.c:353: if (state->registers[REG_OBJETO_OFFSET + target] == state->registers[REG_POSICAO])
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ld	e, -104 (ix)
	ld	d, -103 (ix)
	add	hl, de
	ld	a, (hl)
	ld	l, -102 (ix)
	ld	h, -101 (ix)
	ld	c, (hl)
	sub	a, c
	jp	nz, 00235$
;engine/src/interpreter.c:355: pc = p2;
	ld	a, -6 (ix)
	ld	-1 (ix), a
;engine/src/interpreter.c:356: continue;
	jp	00239$
;engine/src/interpreter.c:361: case OP_LOCAL:
00157$:
;engine/src/interpreter.c:362: if (state->registers[REG_POSICAO] == p1)
	ld	l, -100 (ix)
	ld	h, -99 (ix)
	ld	a, (hl)
	sub	a, -4 (ix)
	jp	nz, 00235$
;engine/src/interpreter.c:364: pc = p2;
	ld	a, -6 (ix)
	ld	-1 (ix), a
;engine/src/interpreter.c:365: continue;
	jp	00239$
;engine/src/interpreter.c:369: case OP_TEMOS:
00160$:
;engine/src/interpreter.c:371: u8 target = (p1 != 0) ? p1 : state->obj_evidencia;
	ld	a, -4 (ix)
	or	a, a
	jr	z, 00268$
	ld	c, -4 (ix)
	jr	00269$
00268$:
	ld	l, -98 (ix)
	ld	h, -97 (ix)
	ld	c, (hl)
00269$:
;engine/src/interpreter.c:372: if (state->registers[REG_OBJETO_OFFSET + target] == OBJ_SIT_CARREGADO)
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ld	e, -96 (ix)
	ld	d, -95 (ix)
	add	hl, de
	ld	a, (hl)
	cp	a, #0xfa
	jp	nz, 00235$
;engine/src/interpreter.c:374: pc = p2;
	ld	a, -6 (ix)
	ld	-1 (ix), a
;engine/src/interpreter.c:375: continue;
	jp	00239$
;engine/src/interpreter.c:380: case OP_SOLTA:
00163$:
;engine/src/interpreter.c:382: if (p1 == 100) // Solta todos os objetos carregados
	ld	a, -4 (ix)
	sub	a, #0x64
	jr	nz, 00172$
;engine/src/interpreter.c:385: for (i = 1; i <= db->num_objetos; i++)
	ld	c, #0x01
00251$:
	ld	l, -82 (ix)
	ld	h, -81 (ix)
	ld	b, (hl)
	ld	a, b
	sub	a, c
	jr	c, 00166$
;engine/src/interpreter.c:387: if (state->registers[REG_OBJETO_OFFSET + i] == OBJ_SIT_CARREGADO)
	ld	e, c
	ld	d, #0x00
	ld	hl, #0x0064
	add	hl, de
	ex	de, hl
	ld	l, -86 (ix)
	ld	h, -85 (ix)
	add	hl, de
	ld	a, (hl)
	cp	a, #0xfa
	jr	nz, 00252$
;engine/src/interpreter.c:389: state->registers[REG_OBJETO_OFFSET + i] = state->registers[REG_POSICAO];
	ld	a, e
	add	a, -120 (ix)
	ld	e, a
	ld	a, d
	adc	a, -119 (ix)
	ld	d, a
	ld	l, -88 (ix)
	ld	h, -87 (ix)
	ld	a, (hl)
	ld	(de), a
00252$:
;engine/src/interpreter.c:385: for (i = 1; i <= db->num_objetos; i++)
	inc	c
	jr	00251$
00166$:
;engine/src/interpreter.c:392: state->registers[REG_OBJETOS_CARREGADOS] = 0;
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	ld	de, #0x0008
	add	hl, de
	ld	(hl), #0x00
	jp	00235$
00172$:
;engine/src/interpreter.c:396: u8 target = (p1 != 0) ? p1 : state->obj_evidencia;
	ld	a, -4 (ix)
	or	a, a
	jr	z, 00270$
	ld	c, -4 (ix)
	jr	00271$
00270$:
	ld	l, -80 (ix)
	ld	h, -79 (ix)
	ld	c, (hl)
00271$:
;engine/src/interpreter.c:397: if (state->registers[REG_OBJETO_OFFSET + target] == OBJ_SIT_CARREGADO)
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ex	de, hl
	ld	l, -18 (ix)
	ld	h, -17 (ix)
	add	hl, de
	ld	a, (hl)
	cp	a, #0xfa
	jp	nz, 00235$
;engine/src/interpreter.c:399: state->registers[REG_OBJETO_OFFSET + target] = state->registers[REG_POSICAO];
	ld	a, e
	add	a, -120 (ix)
	ld	c, a
	ld	a, d
	adc	a, -119 (ix)
	ld	b, a
	ld	l, -20 (ix)
	ld	h, -19 (ix)
	ld	a, (hl)
	ld	(bc), a
;engine/src/interpreter.c:400: if (state->registers[REG_OBJETOS_CARREGADOS] > 0)
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	ld	de, #0x0008
	add	hl, de
	ld	a, (hl)
	or	a, a
	jp	z, 00235$
;engine/src/interpreter.c:402: state->registers[REG_OBJETOS_CARREGADOS]--;
	dec	a
	ld	(hl), a
;engine/src/interpreter.c:406: break;
	jp	00235$
;engine/src/interpreter.c:409: case OP_PEGA:
00174$:
;engine/src/interpreter.c:411: u8 target = (p1 != 0) ? p1 : state->obj_evidencia;
	ld	a, -4 (ix)
	or	a, a
	jr	z, 00272$
	ld	c, -4 (ix)
	jr	00273$
00272$:
	ld	l, -78 (ix)
	ld	h, -77 (ix)
	ld	c, (hl)
00273$:
;engine/src/interpreter.c:412: state->registers[REG_OBJETO_OFFSET + target] = OBJ_SIT_CARREGADO;
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ld	e, -22 (ix)
	ld	d, -21 (ix)
	add	hl, de
	ld	(hl), #0xfa
;engine/src/interpreter.c:413: state->registers[REG_OBJETOS_CARREGADOS]++;
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	ld	de, #0x0008
	add	hl, de
	inc	(hl)
;engine/src/interpreter.c:414: break;
	jp	00235$
;engine/src/interpreter.c:417: case OP_CRIA:
00175$:
;engine/src/interpreter.c:419: u8 target = (p1 != 0) ? p1 : state->obj_evidencia;
	ld	a, -4 (ix)
	or	a, a
	jr	z, 00274$
	ld	c, -4 (ix)
	jr	00275$
00274$:
	ld	l, -76 (ix)
	ld	h, -75 (ix)
	ld	c, (hl)
00275$:
;engine/src/interpreter.c:420: state->registers[REG_OBJETO_OFFSET + target] = state->registers[REG_POSICAO];
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ld	a, l
	add	a, -26 (ix)
	ld	c, a
	ld	a, h
	adc	a, -25 (ix)
	ld	b, a
	ld	l, -24 (ix)
	ld	h, -23 (ix)
	ld	a, (hl)
	ld	(bc), a
;engine/src/interpreter.c:421: break;
	jp	00235$
;engine/src/interpreter.c:424: case OP_APAG:
00176$:
;engine/src/interpreter.c:426: u8 target = (p1 != 0) ? p1 : state->obj_evidencia;
	ld	a, -4 (ix)
	or	a, a
	jr	z, 00276$
	ld	c, -4 (ix)
	jr	00277$
00276$:
	ld	l, -74 (ix)
	ld	h, -73 (ix)
	ld	c, (hl)
00277$:
;engine/src/interpreter.c:427: if (state->registers[REG_OBJETO_OFFSET + target] == OBJ_SIT_CARREGADO)
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ex	de, hl
	ld	l, -72 (ix)
	ld	h, -71 (ix)
	add	hl, de
	ld	a, (hl)
	cp	a, #0xfa
	jr	nz, 00180$
;engine/src/interpreter.c:429: if (state->registers[REG_OBJETOS_CARREGADOS] > 0)
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	ld	bc, #0x0008
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	z, 00180$
;engine/src/interpreter.c:431: state->registers[REG_OBJETOS_CARREGADOS]--;
	dec	a
	ld	(hl), a
00180$:
;engine/src/interpreter.c:434: state->registers[REG_OBJETO_OFFSET + target] = OBJ_SIT_INEXISTENTE;
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	add	hl, de
	ld	(hl), #0x00
;engine/src/interpreter.c:435: break;
	jp	00235$
;engine/src/interpreter.c:438: case OP_GOSUB:
00181$:
;engine/src/interpreter.c:439: state->gosub_ret_pc = pc + 1;
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	ld	de, #0x0105
	add	hl, de
	ld	a, -1 (ix)
	inc	a
	ld	(hl), a
;engine/src/interpreter.c:440: Interpreter_CallFunction(p1, db, state);
	ld	l, -120 (ix)
	ld	h, -119 (ix)
	push	hl
	ld	e, 5 (ix)
	ld	d, 6 (ix)
	ld	a, -4 (ix)
	call	_Interpreter_CallFunction
;engine/src/interpreter.c:441: break;
	jp	00235$
;engine/src/interpreter.c:446: for (i = 1; i <= db->num_objetos; i++)
00395$:
	ld	c, #0x01
00254$:
	ld	l, -66 (ix)
	ld	h, -65 (ix)
	ld	b, (hl)
	ld	a, b
	sub	a, c
	jp	c, 00235$
;engine/src/interpreter.c:448: if (state->registers[REG_OBJETO_OFFSET + i] == OBJ_SIT_EM_OBJ3_FECHADO)
	ld	e, c
	ld	d, #0x00
	ld	hl, #0x0064
	add	hl, de
	ex	de, hl
	ld	l, -68 (ix)
	ld	h, -67 (ix)
	add	hl, de
	ld	a, (hl)
	cp	a, #0xfd
	jr	nz, 00255$
;engine/src/interpreter.c:450: state->registers[REG_OBJETO_OFFSET + i] = OBJ_SIT_EM_OBJ3_ABERTO;
	ld	l, -70 (ix)
	ld	h, -69 (ix)
	add	hl, de
	ld	(hl), #0xfb
00255$:
;engine/src/interpreter.c:446: for (i = 1; i <= db->num_objetos; i++)
	inc	c
	jr	00254$
;engine/src/interpreter.c:459: for (i = 1; i <= db->num_objetos; i++)
00398$:
	ld	c, #0x01
00257$:
	ld	l, -60 (ix)
	ld	h, -59 (ix)
	ld	b, (hl)
	ld	a, b
	sub	a, c
	jp	c, 00235$
;engine/src/interpreter.c:461: if (state->registers[REG_OBJETO_OFFSET + i] == OBJ_SIT_EM_OBJ3_ABERTO)
	ld	e, c
	ld	d, #0x00
	ld	hl, #0x0064
	add	hl, de
	ex	de, hl
	ld	l, -62 (ix)
	ld	h, -61 (ix)
	add	hl, de
	ld	a, (hl)
	cp	a, #0xfb
	jr	nz, 00258$
;engine/src/interpreter.c:463: state->registers[REG_OBJETO_OFFSET + i] = OBJ_SIT_EM_OBJ3_FECHADO;
	ld	l, -64 (ix)
	ld	h, -63 (ix)
	add	hl, de
	ld	(hl), #0xfd
00258$:
;engine/src/interpreter.c:459: for (i = 1; i <= db->num_objetos; i++)
	inc	c
	jr	00257$
;engine/src/interpreter.c:469: case OP_POE:
00190$:
;engine/src/interpreter.c:471: u8 target = (p1 != 0) ? p1 : state->obj_evidencia;
	ld	a, -4 (ix)
	or	a, a
	jr	z, 00278$
	ld	c, -4 (ix)
	jr	00279$
00278$:
	ld	l, -58 (ix)
	ld	h, -57 (ix)
	ld	c, (hl)
00279$:
;engine/src/interpreter.c:472: if (state->registers[REG_OBJETO_OFFSET + target] == OBJ_SIT_CARREGADO)
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ex	de, hl
	ld	l, -54 (ix)
	ld	h, -53 (ix)
	add	hl, de
	ld	a, (hl)
	cp	a, #0xfa
	jr	nz, 00194$
;engine/src/interpreter.c:474: if (state->registers[REG_OBJETOS_CARREGADOS] > 0)
	ld	l, -56 (ix)
	ld	h, -55 (ix)
	ld	bc, #0x0008
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	z, 00194$
;engine/src/interpreter.c:476: state->registers[REG_OBJETOS_CARREGADOS]--;
	dec	a
	ld	(hl), a
00194$:
;engine/src/interpreter.c:479: state->registers[REG_OBJETO_OFFSET + target] = OBJ_SIT_EM_OBJ3_ABERTO;
	ld	l, -56 (ix)
	ld	h, -55 (ix)
	add	hl, de
	ld	(hl), #0xfb
;engine/src/interpreter.c:480: state->registers[REG_OBJETOS_NO_OBJ3]++;
	ld	l, -56 (ix)
	ld	h, -55 (ix)
	ld	de, #0x0007
	add	hl, de
	inc	(hl)
;engine/src/interpreter.c:481: break;
	jp	00235$
;engine/src/interpreter.c:487: for (i = 1; i <= db->num_objetos; i++)
00404$:
	ld	c, #0x01
00260$:
	ld	l, -46 (ix)
	ld	h, -45 (ix)
	ld	b, (hl)
	ld	a, b
	sub	a, c
	jr	c, 00199$
;engine/src/interpreter.c:489: u8 sit = state->registers[REG_OBJETO_OFFSET + i];
	ld	e, c
	ld	d, #0x00
	ld	hl, #0x0064
	add	hl, de
	ld	e, -52 (ix)
	ld	d, -51 (ix)
	add	hl, de
	ld	a, (hl)
;engine/src/interpreter.c:490: if (sit == OBJ_SIT_EM_OBJ3_ABERTO || sit == OBJ_SIT_EM_OBJ3_FECHADO)
	ld	-4 (ix), a
	sub	a, #0xfb
	jr	z, 00196$
	ld	a, -4 (ix)
	sub	a, #0xfd
	jr	nz, 00261$
00196$:
;engine/src/interpreter.c:492: state->registers[REG_OBJETO_OFFSET + i] = state->registers[REG_POSICAO];
	ld	e, c
	ld	d, #0x00
	ld	hl, #0x0064
	add	hl, de
	ld	a, l
	add	a, -50 (ix)
	ld	e, a
	ld	a, h
	adc	a, -49 (ix)
	ld	d, a
	ld	l, -48 (ix)
	ld	h, -47 (ix)
	ld	a, (hl)
	ld	(de), a
00261$:
;engine/src/interpreter.c:487: for (i = 1; i <= db->num_objetos; i++)
	inc	c
	jr	00260$
00199$:
;engine/src/interpreter.c:495: state->registers[REG_OBJETOS_NO_OBJ3] = 0;
	ld	l, -28 (ix)
	ld	h, -27 (ix)
	ld	de, #0x0007
	add	hl, de
	ld	(hl), #0x00
;engine/src/interpreter.c:496: break;
	jp	00235$
;engine/src/interpreter.c:499: case OP_OK:
00200$:
;engine/src/interpreter.c:500: UI_PrintCenter("Ok.");
	ld	hl, #___str_23
	call	_UI_PrintCenter
;engine/src/interpreter.c:501: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/interpreter.c:502: state->flag_espera_cmd = TRUE;
	ld	c, 7 (ix)
	ld	b, 8 (ix)
	ld	hl, #0x0106
	add	hl, bc
	ld	(hl), #0x01
;engine/src/interpreter.c:503: return;
	jp	00262$
;engine/src/interpreter.c:505: case OP_REGN:
00201$:
;engine/src/interpreter.c:506: UI_PrintNumberCenter(state->registers[p1]);
	ld	e, -4 (ix)
	ld	l, -30 (ix)
	ld	h, -29 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	call	_UI_PrintNumberCenter
;engine/src/interpreter.c:507: break;
	jp	00235$
;engine/src/interpreter.c:509: case OP_NVF:
00202$:
;engine/src/interpreter.c:510: state->flag_espera_cmd = TRUE;
	ld	c, 7 (ix)
	ld	b, 8 (ix)
	ld	hl, #0x0106
	add	hl, bc
	ld	(hl), #0x01
;engine/src/interpreter.c:511: return;
	jp	00262$
;engine/src/interpreter.c:513: case OP_REF:
00203$:
;engine/src/interpreter.c:514: return;
	jp	00262$
;engine/src/interpreter.c:516: case OP_FIM:
00204$:
;engine/src/interpreter.c:517: state->flag_fim = TRUE;
	ld	c, 7 (ix)
	ld	b, 8 (ix)
	ld	hl, #0x0107
	add	hl, bc
	ld	(hl), #0x01
;engine/src/interpreter.c:518: return;
	jp	00262$
;engine/src/interpreter.c:520: case OP_NEU:
00205$:
;engine/src/interpreter.c:521: state->flag_reiniciar = TRUE;
	ld	c, 7 (ix)
	ld	b, 8 (ix)
	ld	hl, #0x0108
	add	hl, bc
	ld	(hl), #0x01
;engine/src/interpreter.c:522: return;
	jp	00262$
;engine/src/interpreter.c:524: case OP_DESC:
00206$:
;engine/src/interpreter.c:525: Interpreter_DescribeCurrentRoom(db, state);
	ld	e, 7 (ix)
	ld	d, 8 (ix)
	ld	l, 5 (ix)
	ld	h, 6 (ix)
	call	_Interpreter_DescribeCurrentRoom
;engine/src/interpreter.c:526: state->flag_espera_cmd = TRUE;
	ld	c, 7 (ix)
	ld	b, 8 (ix)
	ld	hl, #0x0106
	add	hl, bc
	ld	(hl), #0x01
;engine/src/interpreter.c:527: return;
	jp	00262$
;engine/src/interpreter.c:529: case OP_RET:
00207$:
;engine/src/interpreter.c:530: return;
	jp	00262$
;engine/src/interpreter.c:532: case OP_GOTO:
00208$:
;engine/src/interpreter.c:533: pc = p1;
	ld	a, -4 (ix)
	ld	-1 (ix), a
;engine/src/interpreter.c:534: continue;
	jp	00239$
;engine/src/interpreter.c:536: case OP_PAUSA:
00209$:
;engine/src/interpreter.c:537: UI_PauseSeconds(p1);
	ld	a, -4 (ix)
	call	_UI_PauseSeconds
;engine/src/interpreter.c:538: break;
	jp	00235$
;engine/src/interpreter.c:540: case OP_FLAG:
00210$:
;engine/src/interpreter.c:541: state->registers[p1] = p2;
	ld	e, -4 (ix)
	ld	l, -32 (ix)
	ld	h, -31 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, -6 (ix)
	ld	(hl), a
;engine/src/interpreter.c:542: break;
	jp	00235$
;engine/src/interpreter.c:544: case OP_EVID:
00211$:
;engine/src/interpreter.c:545: if (p1 == 1) state->obj_evidencia = state->obj_buffer[0];
	ld	a, -4 (ix)
	dec	a
	jr	nz, 00215$
	ld	c, -36 (ix)
	ld	a, -35 (ix)
	inc	a
	ld	b, a
	ld	l, -34 (ix)
	ld	h, -33 (ix)
	ld	de, #0x0101
	add	hl, de
	ld	a, (hl)
	ld	(bc), a
	jp	00235$
00215$:
;engine/src/interpreter.c:546: else if (p1 == 2) state->obj_evidencia = state->obj_buffer[1];
	ld	a, -4 (ix)
	sub	a, #0x02
	jp	nz, 00235$
	ld	c, -40 (ix)
	ld	a, -39 (ix)
	inc	a
	ld	b, a
	ld	l, -38 (ix)
	ld	h, -37 (ix)
	ld	de, #0x0102
	add	hl, de
	ld	a, (hl)
	ld	(bc), a
;engine/src/interpreter.c:547: break;
	jp	00235$
;engine/src/interpreter.c:549: case OP_CLS:
00217$:
;engine/src/interpreter.c:550: UI_ClearCenter();
	call	_UI_ClearCenter
;engine/src/interpreter.c:551: break;
	jp	00235$
;engine/src/interpreter.c:553: case OP_EVD_EQ:
00218$:
;engine/src/interpreter.c:554: if (state->obj_evidencia == p1)
	ld	l, -94 (ix)
	ld	h, -93 (ix)
	ld	a, (hl)
	sub	a, -4 (ix)
	jp	nz, 00235$
;engine/src/interpreter.c:556: pc = p2;
	ld	a, -6 (ix)
	ld	-1 (ix), a
;engine/src/interpreter.c:557: continue;
	jp	00239$
;engine/src/interpreter.c:561: case OP_CHRS:
00221$:
;engine/src/interpreter.c:562: UI_PrintCharCenter((char)p1);
	ld	a, -4 (ix)
	call	_UI_PrintCharCenter
;engine/src/interpreter.c:563: break;
	jp	00235$
;engine/src/interpreter.c:565: case OP_PRT:
00222$:
;engine/src/interpreter.c:566: UI_PrintCenter(Interpreter_GetMessageText(p1, db));
	ld	e, 5 (ix)
	ld	d, 6 (ix)
	ld	a, -4 (ix)
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/interpreter.c:567: UI_PrintCenter(" ");
	ld	hl, #___str_24
	call	_UI_PrintCenter
;engine/src/interpreter.c:568: UI_PrintCenter(Interpreter_GetObjectName(p2, db));
	ld	e, 5 (ix)
	ld	d, 6 (ix)
	ld	a, -6 (ix)
	call	_Interpreter_GetObjectName
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/interpreter.c:569: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/interpreter.c:570: state->flag_espera_cmd = TRUE;
	ld	c, 7 (ix)
	ld	b, 8 (ix)
	ld	hl, #0x0106
	add	hl, bc
	ld	(hl), #0x01
;engine/src/interpreter.c:571: return;
	jp	00262$
;engine/src/interpreter.c:573: case OP_DNT:
00223$:
;engine/src/interpreter.c:575: u8 sit = state->registers[REG_OBJETO_OFFSET + p1];
	ld	c, -4 (ix)
	ld	b, #0x00
	ld	hl, #0x0064
	add	hl, bc
	ld	e, -92 (ix)
	ld	d, -91 (ix)
	add	hl, de
	ld	a, (hl)
;engine/src/interpreter.c:576: if (sit == OBJ_SIT_EM_OBJ3_ABERTO || sit == OBJ_SIT_EM_OBJ3_FECHADO)
	ld	-4 (ix), a
	sub	a, #0xfb
	jr	z, 00224$
	ld	a, -4 (ix)
	sub	a, #0xfd
	jp	nz, 00235$
00224$:
;engine/src/interpreter.c:578: pc = p2;
	ld	a, -6 (ix)
	ld	-1 (ix), a
;engine/src/interpreter.c:579: continue;
	jp	00239$
;engine/src/interpreter.c:584: case OP_CMD:
00227$:
;engine/src/interpreter.c:585: if (p1 > 0 && p1 <= db->num_comandos && db->comandos != NULL)
	ld	a, -4 (ix)
	or	a, a
	jp	z, 00235$
	ld	l, -42 (ix)
	ld	h, -41 (ix)
	ld	de, #0x000d
	add	hl, de
	ld	c, (hl)
	ld	a, c
	sub	a, -4 (ix)
	jp	c, 00235$
	ld	c, -44 (ix)
	ld	b, -43 (ix)
	ld	hl, #11
	add	hl, bc
	ld	a, (hl)
	ld	-124 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-123 (ix), a
	or	a, -124 (ix)
	jp	z, 00235$
;engine/src/interpreter.c:587: const Game_Command* cmd = db->comandos[p1 - 1];
	ld	a, -4 (ix)
	ld	-122 (ix), a
	ld	-121 (ix), #0x00
	pop	hl
	pop	bc
	push	bc
	push	hl
	dec	bc
	ld	-5 (ix), c
	ld	-4 (ix), b
	ld	a, -5 (ix)
	ld	-122 (ix), a
	ld	-121 (ix), #0x00
	sla	-122 (ix)
	rl	-121 (ix)
	pop	hl
	pop	de
	push	de
	push	hl
	add	hl, de
	ld	-5 (ix), l
	ld	-4 (ix), h
	ld	a, (hl)
	ld	-5 (ix), a
	inc	hl
	ld	a, (hl)
;engine/src/interpreter.c:588: if (cmd != NULL)
	ld	-4 (ix), a
	or	a, -5 (ix)
	jr	z, 00235$
;engine/src/interpreter.c:590: Interpreter_Execute(cmd->instructions, cmd->instruction_count, db, state);
	ld	a, -5 (ix)
	ld	-122 (ix), a
	ld	a, -4 (ix)
	ld	-121 (ix), a
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	de, #0x0005
	add	hl, de
	ld	a, (hl)
	ld	-6 (ix), a
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	-5 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-4 (ix), a
	ld	l, 7 (ix)
	ld	h, 8 (ix)
	push	hl
	ld	l, -44 (ix)
	ld	h, -43 (ix)
	push	hl
	ld	a, -6 (ix)
	push	af
	inc	sp
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	call	_Interpreter_Execute
;engine/src/interpreter.c:597: }
00235$:
;engine/src/interpreter.c:599: pc++;
	inc	-1 (ix)
	jp	00239$
00262$:
;engine/src/interpreter.c:601: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	inc	sp
	jp	(hl)
___str_16:
	.ascii "Neste local tem:"
	.db 0x00
___str_17:
	.ascii "- "
	.db 0x00
___str_18:
	.ascii "N"
	.db 0xc3
	.db 0xa3
	.ascii "o h"
	.db 0xc3
	.db 0xa1
	.ascii " nada de especial aqui."
	.db 0x00
___str_19:
	.ascii "Voc"
	.db 0xc3
	.db 0xaa
	.ascii " est"
	.db 0xc3
	.db 0xa1
	.ascii " carregando:"
	.db 0x00
___str_20:
	.ascii "Voc"
	.db 0xc3
	.db 0xaa
	.ascii " n"
	.db 0xc3
	.db 0xa3
	.ascii "o est"
	.db 0xc3
	.db 0xa1
	.ascii " carregando nada."
	.db 0x00
___str_21:
	.ascii "Dentro tem:"
	.db 0x00
___str_22:
	.ascii "Est"
	.db 0xc3
	.db 0xa1
	.ascii " vazio."
	.db 0x00
___str_23:
	.ascii "Ok."
	.db 0x00
___str_24:
	.ascii " "
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
