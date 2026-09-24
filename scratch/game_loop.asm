;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.6.0 #16555 (MINGW64)
;--------------------------------------------------------
	.module game_loop
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _Interpreter_DescribeCurrentRoom
	.globl _Interpreter_GetMessageText
	.globl _Interpreter_CallFunction
	.globl _Interpreter_Execute
	.globl _Parser_Parse
	.globl _UI_ReadLine
	.globl _UI_NewLineCenter
	.globl _UI_PrintCenter
	.globl _UI_ClearCenter
	.globl _UI_SetTopText
	.globl _UI_Init
	.globl _Game_Init
	.globl _Game_Run
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
;engine/src/game_loop.c:22: void Game_Init(const Game_Database* db, Game_State* state)
;	---------------------------------
; Function Game_Init
; ---------------------------------
_Game_Init::
	push	ix
	ld	ix,	#0
	add	ix, sp
	ld	iy, #-10
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), l
	ld	-1 (ix), h
;engine/src/game_loop.c:27: for (i = 0; i < REG_COUNT; i++)
	ld	bc, #0x0000
00117$:
;engine/src/game_loop.c:29: state->registers[i] = 0;
	ld	l, c
	ld	h, b
	add	hl, de
	ld	(hl), #0x00
;engine/src/game_loop.c:27: for (i = 0; i < REG_COUNT; i++)
	inc	bc
	ld	a, b
	sub	a, #0x01
	jr	c, 00117$
;engine/src/game_loop.c:31: state->obj_evidencia = 0;
	ld	hl, #0x0100
	add	hl, de
	ld	(hl), #0x00
;engine/src/game_loop.c:32: state->obj_buffer[0] = 0;
	ld	l, e
	ld	h, d
	inc	hl
	inc	h
	ld	(hl), #0x00
;engine/src/game_loop.c:33: state->obj_buffer[1] = 0;
	ld	hl, #0x0102
	add	hl, de
	ld	(hl), #0x00
;engine/src/game_loop.c:34: state->verbo_atual = 0;
	ld	hl, #0x0103
	add	hl, de
	ld	(hl), #0x00
;engine/src/game_loop.c:35: state->gosub_ret_func = 0;
	ld	hl, #0x0104
	add	hl, de
	ld	(hl), #0x00
;engine/src/game_loop.c:36: state->gosub_ret_pc = 0;
	ld	hl, #0x0105
	add	hl, de
	ld	(hl), #0x00
;engine/src/game_loop.c:37: state->flag_espera_cmd = FALSE;
	ld	hl, #0x0106
	add	hl, de
	ld	(hl), #0x00
;engine/src/game_loop.c:38: state->flag_fim = FALSE;
	ld	hl, #0x0107
	add	hl, de
	ld	(hl), #0x00
;engine/src/game_loop.c:39: state->flag_reiniciar = FALSE;
	ld	hl, #0x0108
	add	hl, de
	ld	(hl), #0x00
;engine/src/game_loop.c:41: if (db == NULL) return;
	ld	a, -1 (ix)
	or	a, -2 (ix)
	jp	z, 00122$
;engine/src/game_loop.c:44: state->registers[REG_POSICAO] = db->posicao_inicial;
	ld	c, e
	ld	b, d
	inc	bc
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(bc), a
;engine/src/game_loop.c:47: if (db->objetos != NULL)
	ld	bc, #0x0008
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	add	hl, bc
	ex	(sp), hl
	pop	hl
	push	hl
	ld	a, (hl)
	inc	hl
	or	a, (hl)
	jp	z, 00116$
;engine/src/game_loop.c:49: for (i = 0; i < db->num_objetos; i++)
	ld	-8 (ix), e
	ld	-7 (ix), d
	ld	a, -2 (ix)
	ld	-6 (ix), a
	ld	a, -1 (ix)
	ld	-5 (ix), a
	ld	bc, #0x0000
00120$:
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	push	bc
	ld	bc, #0x000a
	add	hl, bc
	pop	bc
	ld	l, (hl)
	ld	h, #0x00
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	jr	nc, 00116$
;engine/src/game_loop.c:51: const Game_Object* obj = db->objetos[i];
	pop	hl
	push	hl
	ld	a, (hl)
	ld	-4 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-3 (ix), a
	ld	l, c
	ld	h, b
	add	hl, hl
	ld	a, -4 (ix)
	add	a, l
	ld	l, a
	ld	a, -3 (ix)
	adc	a, h
	ld	h, a
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;engine/src/game_loop.c:52: if (obj != NULL && obj->id > 0 && obj->id <= OBJ_MAX)
	ld	l, a
	or	a, h
	jr	z, 00121$
	ld	a, (hl)
	or	a, a
	jr	z, 00121$
	cp	a, #0x64
	jr	nc, 00121$
;engine/src/game_loop.c:54: state->registers[REG_OBJETO_OFFSET + obj->id] = obj->situacao_inicial;
	add	a, #0x64
	add	a, -8 (ix)
	ld	-4 (ix), a
	ld	a, #0x00
	adc	a, -7 (ix)
	ld	-3 (ix), a
	inc	hl
	ld	a, (hl)
	push	hl
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), a
	pop	hl
;engine/src/game_loop.c:56: if (obj->situacao_inicial == OBJ_SIT_CARREGADO)
	ld	a, (hl)
	cp	a, #0xfa
	jr	nz, 00108$
;engine/src/game_loop.c:58: state->registers[REG_OBJETOS_CARREGADOS]++;
	ld	hl, #0x0008
	add	hl, de
	inc	(hl)
	jr	00121$
00108$:
;engine/src/game_loop.c:60: else if (obj->situacao_inicial == OBJ_SIT_EM_OBJ3_ABERTO ||
	cp	a, #0xfb
	jr	z, 00104$
;engine/src/game_loop.c:61: obj->situacao_inicial == OBJ_SIT_EM_OBJ3_FECHADO)
	cp	a, #0xfd
	jr	nz, 00121$
00104$:
;engine/src/game_loop.c:63: state->registers[REG_OBJETOS_NO_OBJ3]++;
	ld	hl, #0x0007
	add	hl, de
	inc	(hl)
00121$:
;engine/src/game_loop.c:49: for (i = 0; i < db->num_objetos; i++)
	inc	bc
	jr	00120$
00116$:
;engine/src/game_loop.c:70: UI_Init();
	push	de
	call	_UI_Init
	pop	de
;engine/src/game_loop.c:71: UI_SetTopText(db->titulo);
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	de
	call	_UI_SetTopText
	pop	de
;engine/src/game_loop.c:74: Interpreter_CallFunction(FUNC_RESET, db, state);
	push	de
	push	de
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	a, #0x01
	call	_Interpreter_CallFunction
;engine/src/game_loop.c:77: UI_PrintCenter(Interpreter_GetMessageText(MSG_INTRO, db));
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	a, #0x0b
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:78: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:79: UI_NewLineCenter();
	call	_UI_NewLineCenter
	pop	de
;engine/src/game_loop.c:80: Interpreter_DescribeCurrentRoom(db, state);
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	call	_Interpreter_DescribeCurrentRoom
00122$:
;engine/src/game_loop.c:81: }
	ld	sp, ix
	pop	ix
	ret
;engine/src/game_loop.c:86: static u8 GetRoomExit(const Game_Database* db, u8 room_id, Game_Direction dir)
;	---------------------------------
; Function GetRoomExit
; ---------------------------------
_GetRoomExit:
	push	ix
	ld	ix,	#0
	add	ix, sp
	push	af
	ex	de, hl
;engine/src/game_loop.c:89: if (db == NULL || db->posicoes == NULL) return 0;
	ld	a, d
	or	a, e
	jr	z, 00101$
	ld	c, e
	ld	b, d
	ld	hl, #5
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, b
	or	a, c
	jr	nz, 00126$
00101$:
	xor	a, a
	jr	00113$
;engine/src/game_loop.c:91: for (i = 0; i < db->num_posicoes; i++)
00126$:
	ld	a, 5 (ix)
	sub	a, #0x04
	ld	a, #0x00
	rla
	ld	-2 (ix), a
	ld	-1 (ix), #0x00
00111$:
	ld	hl, #7
	add	hl, de
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	nc, 00109$
;engine/src/game_loop.c:93: const Game_Position* pos = db->posicoes[i];
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;engine/src/game_loop.c:94: if (pos != NULL && pos->id == room_id)
	ld	l, a
	or	a, h
	jr	z, 00112$
	ld	a, (hl)
	sub	a, 4 (ix)
	jr	nz, 00112$
;engine/src/game_loop.c:96: if (dir < DIR_COUNT)
	ld	a, -2 (ix)
	or	a, a
	jr	z, 00112$
;engine/src/game_loop.c:98: return pos->saidas[dir];
	inc	hl
	ld	e, 5 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	jr	00113$
00112$:
;engine/src/game_loop.c:91: for (i = 0; i < db->num_posicoes; i++)
	inc	-1 (ix)
	jr	00111$
00109$:
;engine/src/game_loop.c:102: return 0;
	xor	a, a
00113$:
;engine/src/game_loop.c:103: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	bc
	jp	(hl)
;engine/src/game_loop.c:108: static const Game_Object* GetObject(const Game_Database* db, u8 obj_id)
;	---------------------------------
; Function GetObject
; ---------------------------------
_GetObject:
	push	ix
	ld	ix,	#0
	add	ix, sp
	dec	sp
	ex	de, hl
;engine/src/game_loop.c:111: if (db == NULL || db->objetos == NULL || obj_id == 0) return NULL;
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
	jr	z, 00101$
	ld	a, 4 (ix)
	or	a, a
	jr	nz, 00125$
00101$:
	ld	de, #0x0000
	jr	00112$
;engine/src/game_loop.c:113: for (i = 0; i < db->num_objetos; i++)
00125$:
	ld	-1 (ix), #0x00
00110$:
	ld	hl, #10
	add	hl, de
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	nc, 00108$
;engine/src/game_loop.c:115: const Game_Object* obj = db->objetos[i];
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;engine/src/game_loop.c:116: if (obj != NULL && obj->id == obj_id)
	ld	l, a
	or	a, h
	jr	z, 00111$
	ld	a, (hl)
	sub	a, 4 (ix)
	jr	nz, 00111$
;engine/src/game_loop.c:118: return obj;
	ex	de, hl
	jr	00112$
00111$:
;engine/src/game_loop.c:113: for (i = 0; i < db->num_objetos; i++)
	inc	-1 (ix)
	jr	00110$
00108$:
;engine/src/game_loop.c:121: return NULL;
	ld	de, #0x0000
00112$:
;engine/src/game_loop.c:122: }
	inc	sp
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
;engine/src/game_loop.c:128: void Game_Run(const Game_Database* db, Game_State* state)
;	---------------------------------
; Function Game_Run
; ---------------------------------
_Game_Run::
	push	ix
	ld	ix,	#0
	add	ix, sp
	ld	iy, #-137
	add	iy, sp
	ld	sp, iy
	ld	-3 (ix), l
	ld	-2 (ix), h
;engine/src/game_loop.c:133: Game_Init(db, state);
	ld	-5 (ix), e
	ld	-4 (ix), d
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	_Game_Init
;engine/src/game_loop.c:135: while (!state->flag_fim)
	ld	de, #0x0108
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	add	hl, de
	ld	-57 (ix), l
	ld	-56 (ix), h
	ld	de, #0x0107
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	add	hl, de
	ld	-55 (ix), l
	ld	-54 (ix), h
	ld	de, #0x000e
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	add	hl, de
	ld	-53 (ix), l
	ld	-52 (ix), h
	ld	a, -3 (ix)
	ld	-51 (ix), a
	ld	a, -2 (ix)
	ld	-50 (ix), a
	ld	a, -53 (ix)
	ld	-49 (ix), a
	ld	a, -52 (ix)
	ld	-48 (ix), a
	ld	a, -55 (ix)
	ld	-47 (ix), a
	ld	a, -54 (ix)
	ld	-46 (ix), a
	ld	a, -57 (ix)
	ld	-45 (ix), a
	ld	a, -56 (ix)
	ld	-44 (ix), a
	ld	a, -55 (ix)
	ld	-43 (ix), a
	ld	a, -54 (ix)
	ld	-42 (ix), a
	ld	a, -57 (ix)
	ld	-41 (ix), a
	ld	a, -56 (ix)
	ld	-40 (ix), a
	ld	a, -5 (ix)
	ld	-39 (ix), a
	ld	a, -4 (ix)
	ld	-38 (ix), a
	ld	a, -5 (ix)
	ld	-37 (ix), a
	ld	a, -4 (ix)
	ld	-36 (ix), a
	ld	a, -55 (ix)
	ld	-35 (ix), a
	ld	a, -54 (ix)
	ld	-34 (ix), a
	ld	a, -57 (ix)
	ld	-33 (ix), a
	ld	a, -56 (ix)
	ld	-32 (ix), a
	ld	de, #0x0101
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	add	hl, de
	ld	-31 (ix), l
	ld	-30 (ix), h
	ld	a, -5 (ix)
	ld	-29 (ix), a
	ld	a, -4 (ix)
	ld	-28 (ix), a
	ld	a, -31 (ix)
	ld	-27 (ix), a
	ld	a, -30 (ix)
	ld	-26 (ix), a
	ld	de, #0x0103
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	add	hl, de
	ld	-25 (ix), l
	ld	-24 (ix), h
	ld	de, #0x000b
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	add	hl, de
	ld	-23 (ix), l
	ld	-22 (ix), h
	ld	a, -3 (ix)
	ld	-21 (ix), a
	ld	a, -2 (ix)
	ld	-20 (ix), a
	ld	a, -23 (ix)
	ld	-19 (ix), a
	ld	a, -22 (ix)
	ld	-18 (ix), a
	ld	a, -25 (ix)
	ld	-17 (ix), a
	ld	a, -24 (ix)
	ld	-16 (ix), a
	ld	a, -31 (ix)
	ld	-15 (ix), a
	ld	a, -30 (ix)
	ld	-14 (ix), a
	ld	a, -25 (ix)
	ld	-13 (ix), a
	ld	a, -24 (ix)
	ld	-12 (ix), a
00211$:
	ld	l, -55 (ix)
	ld	h, -54 (ix)
	ld	a, (hl)
	ld	-1 (ix), a
	or	a, a
	jp	nz, 00213$
;engine/src/game_loop.c:137: if (state->flag_reiniciar)
	ld	l, -57 (ix)
	ld	h, -56 (ix)
	ld	a, (hl)
	or	a, a
	jr	z, 00102$
;engine/src/game_loop.c:139: Game_Init(db, state);
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	_Game_Init
;engine/src/game_loop.c:140: continue;
	jr	00211$
00102$:
;engine/src/game_loop.c:146: if (db != NULL && db->funcoes != NULL)
	ld	a, -2 (ix)
	or	a, -3 (ix)
	jp	z, 00111$
	ld	l, -49 (ix)
	ld	h, -48 (ix)
	ld	a, (hl)
	ld	-7 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-6 (ix), a
	or	a, -7 (ix)
	jp	z, 00111$
;engine/src/game_loop.c:149: for (i = 0; i < db->num_funcoes; i++)
	ld	-1 (ix), #0x00
00215$:
	ld	l, -51 (ix)
	ld	h, -50 (ix)
	ld	de, #0x0010
	add	hl, de
	ld	a,-1 (ix)
	sub	a,(hl)
	jp	nc, 00111$
;engine/src/game_loop.c:151: const Game_Function* f = db->funcoes[i];
	ld	l, -53 (ix)
	ld	h, -52 (ix)
	ld	a, (hl)
	ld	-11 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-10 (ix), a
	ld	a, -1 (ix)
	ld	-7 (ix), a
	ld	-6 (ix), #0x00
	ld	a, -7 (ix)
	ld	-9 (ix), a
	ld	-8 (ix), #0x00
	sla	-9 (ix)
	rl	-8 (ix)
	ld	e, -9 (ix)
	ld	d, -8 (ix)
	ld	l, -11 (ix)
	ld	h, -10 (ix)
	add	hl, de
	ld	-7 (ix), l
	ld	-6 (ix), h
	ld	a, (hl)
	ld	-7 (ix), a
	inc	hl
	ld	a, (hl)
;engine/src/game_loop.c:152: if (f != NULL && f->id == FUNC_PRE_COMANDO)
	ld	-6 (ix), a
	or	a, -7 (ix)
	jr	z, 00216$
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	a, (hl)
	cp	a, #0x05
	jr	nz, 00216$
;engine/src/game_loop.c:154: if (f->instruction_count > 0 && f->instructions[0].op != OP_NOP)
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	-1 (ix), a
	or	a, a
	jr	z, 00111$
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	inc	hl
	ld	a, (hl)
	ld	-7 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-6 (ix), a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	a, (hl)
	or	a, a
	jr	z, 00111$
;engine/src/game_loop.c:156: Interpreter_Execute(f->instructions, f->instruction_count, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	push	hl
	ld	a, -1 (ix)
	push	af
	inc	sp
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	call	_Interpreter_Execute
;engine/src/game_loop.c:158: break;
	jr	00111$
00216$:
;engine/src/game_loop.c:149: for (i = 0; i < db->num_funcoes; i++)
	inc	-1 (ix)
	jp	00215$
00111$:
;engine/src/game_loop.c:163: if (state->flag_fim || state->flag_reiniciar) continue;
	ld	l, -47 (ix)
	ld	h, -46 (ix)
	ld	a, (hl)
	or	a, a
	jp	nz, 00211$
	ld	l, -45 (ix)
	ld	h, -44 (ix)
	ld	a, (hl)
	or	a, a
	jp	nz, 00211$
;engine/src/game_loop.c:168: UI_ReadLine(input_line, sizeof(input_line));
	ld	a, #0x28
	push	af
	inc	sp
	ld	hl, #1
	add	hl, sp
	call	_UI_ReadLine
;engine/src/game_loop.c:172: if (input_line[0] == '\0')
	ld	hl, #0
	add	hl, sp
	ld	a, (hl)
	ld	-1 (ix), a
	or	a, a
	jr	nz, 00119$
;engine/src/game_loop.c:174: state->registers[REG_JOGADAS_L]++;
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	inc	hl
	inc	hl
	ld	-7 (ix), l
	ld	-6 (ix), h
	ld	a, (hl)
	ld	-1 (ix), a
	inc	a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	(hl), a
;engine/src/game_loop.c:175: if (state->registers[REG_JOGADAS_L] == 0)
	or	a, a
	jr	nz, 00117$
;engine/src/game_loop.c:177: state->registers[REG_JOGADAS_H]++;
	ld	de, #0x0003
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	add	hl, de
	ld	-7 (ix), l
	ld	-6 (ix), h
	ld	a, (hl)
	inc	a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	(hl), a
00117$:
;engine/src/game_loop.c:179: UI_ClearCenter();
	call	_UI_ClearCenter
;engine/src/game_loop.c:180: Interpreter_DescribeCurrentRoom(db, state);
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	_Interpreter_DescribeCurrentRoom
;engine/src/game_loop.c:181: continue;
	jp	00211$
00119$:
;engine/src/game_loop.c:185: state->registers[REG_JOGADAS_L]++;
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	inc	hl
	inc	hl
;engine/src/game_loop.c:186: if (state->registers[REG_JOGADAS_L] == 0)
	inc	(hl)
	jr	nz, 00121$
;engine/src/game_loop.c:188: state->registers[REG_JOGADAS_H]++;
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	inc	hl
	inc	hl
	inc	hl
	inc	(hl)
00121$:
;engine/src/game_loop.c:194: if (state->registers[REG_CONTADOR_4] != 0)
	ld	a, -5 (ix)
	add	a, #0x04
	ld	c, a
	ld	a, -4 (ix)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	jr	z, 00123$
;engine/src/game_loop.c:196: state->registers[REG_CONTADOR_4]++;
	inc	a
	ld	(bc), a
00123$:
;engine/src/game_loop.c:203: if (state->registers[REG_CONTADOR_5] != 0)
	ld	a, -5 (ix)
	add	a, #0x05
	ld	c, a
	ld	a, -4 (ix)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	jr	z, 00130$
;engine/src/game_loop.c:205: state->registers[REG_CONTADOR_5]--;
	ld	a, (bc)
	dec	a
	ld	(bc), a
;engine/src/game_loop.c:206: if (state->registers[REG_CONTADOR_5] == 0)
	or	a, a
	jr	nz, 00130$
;engine/src/game_loop.c:208: Interpreter_CallFunction(FUNC_TIMER_BOMBA, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x02
	call	_Interpreter_CallFunction
;engine/src/game_loop.c:209: if (state->flag_fim || state->flag_reiniciar) continue;
	ld	l, -43 (ix)
	ld	h, -42 (ix)
	ld	a, (hl)
	or	a, a
	jp	nz, 00211$
	ld	l, -41 (ix)
	ld	h, -40 (ix)
	ld	a, (hl)
	or	a, a
	jp	nz, 00211$
00130$:
;engine/src/game_loop.c:214: if (state->registers[REG_ILUMINACAO] != 0 && state->registers[REG_ESTADO_OBJ2] == 0)
	ld	l, -39 (ix)
	ld	h, -38 (ix)
	ld	de, #0x0009
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	z, 00137$
	ld	l, -37 (ix)
	ld	h, -36 (ix)
	ld	de, #0x000a
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	nz, 00137$
;engine/src/game_loop.c:216: state->registers[REG_PASSOS_ESCURO]++;
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	de, #0x0006
	add	hl, de
	inc	(hl)
	ld	a, (hl)
;engine/src/game_loop.c:217: if (state->registers[REG_PASSOS_ESCURO] >= 5)
	sub	a, #0x05
	jr	c, 00138$
;engine/src/game_loop.c:219: Interpreter_CallFunction(FUNC_ESCURO, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x03
	call	_Interpreter_CallFunction
;engine/src/game_loop.c:220: if (state->flag_fim || state->flag_reiniciar) continue;
	ld	l, -35 (ix)
	ld	h, -34 (ix)
	ld	a, (hl)
	or	a, a
	jp	nz, 00211$
	ld	l, -33 (ix)
	ld	h, -32 (ix)
	ld	a, (hl)
	or	a, a
	jp	nz, 00211$
	jr	00138$
00137$:
;engine/src/game_loop.c:225: state->registers[REG_PASSOS_ESCURO] = 0;
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	de, #0x0006
	add	hl, de
	ld	(hl), #0x00
00138$:
;engine/src/game_loop.c:232: bool verb_found = Parser_Parse(input_line, db, state, echo_text, sizeof(echo_text));
	ld	a, #0x28
	push	af
	inc	sp
	ld	hl, #41
	add	hl, sp
	push	hl
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	hl, #5
	add	hl, sp
	call	_Parser_Parse
	ld	c, a
;engine/src/game_loop.c:235: if (echo_text[0] != '\0')
	ld	a, -97 (ix)
	or	a, a
	jr	z, 00141$
;engine/src/game_loop.c:237: UI_SetTopText(echo_text);
	push	bc
	ld	hl, #42
	add	hl, sp
	call	_UI_SetTopText
	pop	bc
00141$:
;engine/src/game_loop.c:240: if (!verb_found)
	ld	a, c
	or	a, a
	jr	nz, 00143$
;engine/src/game_loop.c:242: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_ENTENDI, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x0e
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:243: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:244: continue;
	jp	00211$
00143$:
;engine/src/game_loop.c:248: if (state->obj_buffer[0] != 0)
	ld	l, -31 (ix)
	ld	h, -30 (ix)
	ld	c, (hl)
	ld	a, c
	or	a, a
	jr	z, 00145$
;engine/src/game_loop.c:250: state->obj_evidencia = state->obj_buffer[0];
	ld	l, -5 (ix)
	ld	a, -4 (ix)
	inc	a
	ld	h, a
	ld	(hl), c
00145$:
;engine/src/game_loop.c:257: bool cmd_executed = FALSE;
	ld	c, #0x00
;engine/src/game_loop.c:260: if (db != NULL && db->comandos != NULL)
	ld	a, -2 (ix)
	or	a, -3 (ix)
	jp	z, 00153$
	ld	l, -19 (ix)
	ld	h, -18 (ix)
	ld	a, (hl)
	inc	hl
	or	a, (hl)
	jr	z, 00153$
;engine/src/game_loop.c:262: for (c = 0; c < db->num_comandos; c++)
	ld	b, #0x00
00218$:
	ld	l, -21 (ix)
	ld	h, -20 (ix)
	ld	de, #0x000d
	add	hl, de
	ld	a, b
	sub	a, (hl)
	jr	nc, 00153$
;engine/src/game_loop.c:264: const Game_Command* cmd = db->comandos[c];
	ld	l, -23 (ix)
	ld	h, -22 (ix)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, b
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;engine/src/game_loop.c:265: if (cmd != NULL &&
	ld	a, d
	or	a, e
	jr	z, 00219$
;engine/src/game_loop.c:266: cmd->verbo == state->verbo_atual &&
	ld	a, (de)
	ld	l, -25 (ix)
	ld	h, -24 (ix)
	sub	a, (hl)
	jr	nz, 00219$
;engine/src/game_loop.c:267: cmd->objeto1 == state->obj_buffer[0] &&
	ld	l, e
	ld	h, d
	inc	hl
	ld	a, (hl)
	ld	l, -27 (ix)
	ld	h, -26 (ix)
	sub	a, (hl)
	jr	nz, 00219$
;engine/src/game_loop.c:268: cmd->objeto2 == state->obj_buffer[1])
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	l, -29 (ix)
	ld	h, -28 (ix)
	push	bc
	ld	bc, #0x0102
	add	hl, bc
	pop	bc
	sub	a, (hl)
	jr	nz, 00219$
;engine/src/game_loop.c:270: Interpreter_Execute(cmd->instructions, cmd->instruction_count, db, state);
	push	de
	pop	iy
	ld	b, 5 (iy)
	ld	hl, #3
	add	hl, de
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	push	de
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	push	de
	push	bc
	inc	sp
	ld	l, a
	call	_Interpreter_Execute
;engine/src/game_loop.c:271: cmd_executed = TRUE;
	ld	c, #0x01
;engine/src/game_loop.c:272: break;
	jr	00153$
00219$:
;engine/src/game_loop.c:262: for (c = 0; c < db->num_comandos; c++)
	inc	b
	jr	00218$
00153$:
;engine/src/game_loop.c:277: if (cmd_executed)
	ld	a, c
	or	a, a
	jp	nz, 00211$
;engine/src/game_loop.c:286: if (state->verbo_atual >= VERBO_NORTE && state->verbo_atual <= VERBO_OESTE)
	ld	l, -17 (ix)
	ld	h, -16 (ix)
	ld	a, (hl)
	cp	a, #0x01
	jr	c, 00164$
	cp	a, #0x05
	jr	nc, 00164$
;engine/src/game_loop.c:288: Game_Direction dir = (Game_Direction)(state->verbo_atual - 1);
	ld	e, a
	dec	e
;engine/src/game_loop.c:289: u8 saida = GetRoomExit(db, state->registers[REG_POSICAO], dir);
	ld	c, -5 (ix)
	ld	b, -4 (ix)
	inc	bc
	ld	a, (bc)
	push	bc
	ld	h, e
	push	hl
	inc	sp
	push	af
	inc	sp
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	_GetRoomExit
	pop	bc
;engine/src/game_loop.c:291: if (saida == 0)
	or	a, a
	jr	nz, 00161$
;engine/src/game_loop.c:294: UI_PrintCenter(Interpreter_GetMessageText(MSG_MOVIMENTO_INVALIDO, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x0f
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:295: UI_NewLineCenter();
	call	_UI_NewLineCenter
	jp	00211$
00161$:
;engine/src/game_loop.c:297: else if (saida <= POSICAO_MAX)
	cp	a, #0x64
	jr	nc, 00158$
;engine/src/game_loop.c:300: state->registers[REG_POSICAO] = saida;
	ld	(bc), a
;engine/src/game_loop.c:301: UI_ClearCenter();
	call	_UI_ClearCenter
;engine/src/game_loop.c:302: Interpreter_DescribeCurrentRoom(db, state);
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	_Interpreter_DescribeCurrentRoom
	jp	00211$
00158$:
;engine/src/game_loop.c:307: u8 func_id = saida - POSICAO_COND_OFFSET;
	add	a, #0x9c
;engine/src/game_loop.c:308: Interpreter_CallFunction(func_id, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	call	_Interpreter_CallFunction
;engine/src/game_loop.c:310: continue;
	jp	00211$
00164$:
;engine/src/game_loop.c:317: u8 obj_id = state->obj_buffer[0];
	ld	l, -15 (ix)
	ld	h, -14 (ix)
	ld	a, (hl)
;engine/src/game_loop.c:318: const Game_Object* obj = GetObject(db, obj_id);
	push	af
	inc	sp
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	_GetObject
;engine/src/game_loop.c:320: switch (state->verbo_atual)
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	ld	a, (hl)
	cp	a, #0x0d
	jp	z, 00207$
	cp	a, #0x0e
	jp	z, 00208$
	cp	a, #0x14
	jr	z, 00166$
	cp	a, #0x15
	jr	z, 00174$
	cp	a, #0x16
	jp	z, 00179$
	cp	a, #0x17
	jp	z, 00184$
	cp	a, #0x18
	jp	z, 00189$
	cp	a, #0x19
	jp	z, 00194$
	cp	a, #0x1a
	jp	z, 00199$
	cp	a, #0x1b
	jp	z, 00204$
	cp	a, #0x1c
	jp	z, 00205$
	cp	a, #0x1d
	jp	z, 00206$
	jp	00209$
;engine/src/game_loop.c:322: case VERBO_PEGUE:
00166$:
;engine/src/game_loop.c:323: if (obj != NULL && (obj->consistencia & OBJ_CONSIST_PEGAR))
	ld	a, d
	or	a, e
	jr	z, 00171$
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ld	a, (bc)
	rrca
	jr	nc, 00171$
;engine/src/game_loop.c:325: Interpreter_CallFunction(FUNC_PADRAO_PEGAR, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x06
	call	_Interpreter_CallFunction
	jp	00211$
00171$:
;engine/src/game_loop.c:327: else if (obj == NULL)
	ld	a, d
	or	a, e
	jr	nz, 00168$
;engine/src/game_loop.c:329: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_ESTOU_VENDO, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x13
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:330: UI_NewLineCenter();
	call	_UI_NewLineCenter
	jp	00211$
00168$:
;engine/src/game_loop.c:334: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_POSSIVEL, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x10
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:335: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:337: break;
	jp	00211$
;engine/src/game_loop.c:339: case VERBO_COLOQUE:
00174$:
;engine/src/game_loop.c:340: if (obj != NULL && (obj->consistencia & OBJ_CONSIST_COLOCAR_OBJ3))
	ld	a, d
	or	a, e
	jr	z, 00176$
	inc	de
	inc	de
	ld	a, (de)
	bit	1, a
	jr	z, 00176$
;engine/src/game_loop.c:342: Interpreter_CallFunction(FUNC_PADRAO_COLOCAR_OBJ3, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x07
	call	_Interpreter_CallFunction
	jp	00211$
00176$:
;engine/src/game_loop.c:346: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_POSSIVEL, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x10
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:347: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:349: break;
	jp	00211$
;engine/src/game_loop.c:351: case VERBO_TROQUE:
00179$:
;engine/src/game_loop.c:352: if (obj != NULL && (obj->consistencia & OBJ_CONSIST_TROCAR))
	ld	a, d
	or	a, e
	jr	z, 00181$
	inc	de
	inc	de
	ld	a, (de)
	bit	2, a
	jr	z, 00181$
;engine/src/game_loop.c:354: Interpreter_CallFunction(FUNC_PADRAO_TROCAR, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x08
	call	_Interpreter_CallFunction
	jp	00211$
00181$:
;engine/src/game_loop.c:358: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_POSSIVEL, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x10
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:359: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:361: break;
	jp	00211$
;engine/src/game_loop.c:363: case VERBO_COMPRE:
00184$:
;engine/src/game_loop.c:364: if (obj != NULL && (obj->consistencia & OBJ_CONSIST_COMPRAR))
	ld	a, d
	or	a, e
	jr	z, 00186$
	inc	de
	inc	de
	ld	a, (de)
	bit	3, a
	jr	z, 00186$
;engine/src/game_loop.c:366: Interpreter_CallFunction(FUNC_PADRAO_COMPRAR, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x09
	call	_Interpreter_CallFunction
	jp	00211$
00186$:
;engine/src/game_loop.c:370: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_POSSIVEL, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x10
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:371: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:373: break;
	jp	00211$
;engine/src/game_loop.c:375: case VERBO_ROUBE:
00189$:
;engine/src/game_loop.c:376: if (obj != NULL && (obj->consistencia & OBJ_CONSIST_ROUBAR))
	ld	a, d
	or	a, e
	jr	z, 00191$
	inc	de
	inc	de
	ld	a, (de)
	bit	4, a
	jr	z, 00191$
;engine/src/game_loop.c:378: Interpreter_CallFunction(FUNC_PADRAO_ROUBAR, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x0a
	call	_Interpreter_CallFunction
	jp	00211$
00191$:
;engine/src/game_loop.c:382: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_POSSIVEL, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x10
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:383: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:385: break;
	jp	00211$
;engine/src/game_loop.c:387: case VERBO_TIRE:
00194$:
;engine/src/game_loop.c:388: if (obj != NULL && (obj->consistencia & OBJ_CONSIST_TIRAR))
	ld	a, d
	or	a, e
	jr	z, 00196$
	inc	de
	inc	de
	ld	a, (de)
	bit	5, a
	jr	z, 00196$
;engine/src/game_loop.c:390: Interpreter_CallFunction(FUNC_PADRAO_TIRAR, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x0b
	call	_Interpreter_CallFunction
	jp	00211$
00196$:
;engine/src/game_loop.c:394: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_POSSIVEL, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x10
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:395: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:397: break;
	jp	00211$
;engine/src/game_loop.c:399: case VERBO_QUEBRE:
00199$:
;engine/src/game_loop.c:400: if (obj != NULL && (obj->consistencia & OBJ_CONSIST_QUEBRAR))
	ld	a, d
	or	a, e
	jr	z, 00201$
	inc	de
	inc	de
	ld	a, (de)
	bit	6, a
	jr	z, 00201$
;engine/src/game_loop.c:402: Interpreter_CallFunction(FUNC_PADRAO_QUEBRAR, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x0c
	call	_Interpreter_CallFunction
	jp	00211$
00201$:
;engine/src/game_loop.c:406: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_POSSIVEL, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x10
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:407: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:409: break;
	jp	00211$
;engine/src/game_loop.c:411: case VERBO_SOLTE:
00204$:
;engine/src/game_loop.c:412: Interpreter_CallFunction(FUNC_PADRAO_SOLTAR, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x0d
	call	_Interpreter_CallFunction
;engine/src/game_loop.c:413: break;
	jp	00211$
;engine/src/game_loop.c:415: case VERBO_EXAMINE:
00205$:
;engine/src/game_loop.c:416: Interpreter_CallFunction(FUNC_PADRAO_EXAMINAR, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x0e
	call	_Interpreter_CallFunction
;engine/src/game_loop.c:417: break;
	jp	00211$
;engine/src/game_loop.c:419: case VERBO_PROCURE:
00206$:
;engine/src/game_loop.c:420: Interpreter_CallFunction(FUNC_PADRAO_PROCURAR, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x0f
	call	_Interpreter_CallFunction
;engine/src/game_loop.c:421: break;
	jp	00211$
;engine/src/game_loop.c:423: case VERBO_TEMOS:
00207$:
;engine/src/game_loop.c:426: Interpreter_Execute(cmd_clist, 1, db, state);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	hl, #_Game_Run_cmd_clist_70000_174
	call	_Interpreter_Execute
;engine/src/game_loop.c:427: break;
	jp	00211$
;engine/src/game_loop.c:430: case VERBO_RECOMECE:
00208$:
;engine/src/game_loop.c:431: state->flag_reiniciar = TRUE;
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	de, #0x0108
	add	hl, de
	ld	(hl), #0x01
;engine/src/game_loop.c:432: break;
	jp	00211$
;engine/src/game_loop.c:434: default:
00209$:
;engine/src/game_loop.c:435: UI_PrintCenter(Interpreter_GetMessageText(MSG_NAO_POSSIVEL, db));
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	a, #0x10
	call	_Interpreter_GetMessageText
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/game_loop.c:436: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:438: }
	jp	00211$
00213$:
;engine/src/game_loop.c:447: UI_ClearCenter();
	call	_UI_ClearCenter
;engine/src/game_loop.c:448: UI_PrintCenter("Fim da partida.");
	ld	hl, #___str_0
	call	_UI_PrintCenter
;engine/src/game_loop.c:449: UI_NewLineCenter();
	call	_UI_NewLineCenter
;engine/src/game_loop.c:450: }
	ld	sp, ix
	pop	ix
	ret
_Game_Run_cmd_clist_70000_174:
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
___str_0:
	.ascii "Fim da partida."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
