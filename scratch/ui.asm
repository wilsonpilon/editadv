;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.6.0 #16555 (MINGW64)
;--------------------------------------------------------
	.module ui
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _UI_Init
	.globl _UI_DrawLayout
	.globl _UI_SetTopText
	.globl _UI_ClearCenter
	.globl _UI_NewLineCenter
	.globl _UI_PrintCharCenter
	.globl _UI_PrintCenter
	.globl _UI_PrintNumberCenter
	.globl _UI_ReadLine
	.globl _UI_PauseSeconds
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
_g_CenterCursorX:
	.ds 1
_g_CenterCursorY:
	.ds 1
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
;engine/src/ui.c:12: static void Bios_InitText(void) __naked
;	---------------------------------
; Function Bios_InitText
; ---------------------------------
_Bios_InitText:
;engine/src/ui.c:17: __endasm;
	call 0x005F
	ret
;engine/src/ui.c:18: }
;engine/src/ui.c:20: static void Bios_Cls(void) __naked
;	---------------------------------
; Function Bios_Cls
; ---------------------------------
_Bios_Cls:
;engine/src/ui.c:25: __endasm;
	call 0x00C3
	ret
;engine/src/ui.c:26: }
;engine/src/ui.c:28: static void Bios_SetCursor(u8 col, u8 row) __naked
;	---------------------------------
; Function Bios_SetCursor
; ---------------------------------
_Bios_SetCursor:
;engine/src/ui.c:43: __endasm;
	ld hl, #2
	add hl, sp
	ld a, (hl)
	inc a
	ld h, a
	inc hl
	ld a, (hl)
	inc a
	ld l, a
	call 0x00C6
	ret
;engine/src/ui.c:44: }
;engine/src/ui.c:46: static void Bios_Chput(char c) __naked
;	---------------------------------
; Function Bios_Chput
; ---------------------------------
_Bios_Chput:
;engine/src/ui.c:55: __endasm;
	ld hl, #2
	add hl, sp
	ld a, (hl)
	call 0x00A2
	ret
;engine/src/ui.c:56: }
;engine/src/ui.c:58: static char Bios_Chget(void) __naked
;	---------------------------------
; Function Bios_Chget
; ---------------------------------
_Bios_Chget:
;engine/src/ui.c:64: __endasm;
	call 0x009F
	ld l, a
	ret
;engine/src/ui.c:65: }
;engine/src/ui.c:67: static void Bios_WaitFrame(void) __naked
;	---------------------------------
; Function Bios_WaitFrame
; ---------------------------------
_Bios_WaitFrame:
;engine/src/ui.c:73: __endasm;
	ei
	halt
	ret
;engine/src/ui.c:74: }
;engine/src/ui.c:87: void UI_Init(void)
;	---------------------------------
; Function UI_Init
; ---------------------------------
_UI_Init::
;engine/src/ui.c:94: Bios_InitText();
	call	_Bios_InitText
;engine/src/ui.c:95: Bios_Cls();
	call	_Bios_Cls
;engine/src/ui.c:97: UI_DrawLayout();
	call	_UI_DrawLayout
;engine/src/ui.c:98: UI_ClearCenter();
;engine/src/ui.c:99: }
	jp	_UI_ClearCenter
;engine/src/ui.c:105: void UI_DrawLayout(void)
;	---------------------------------
; Function UI_DrawLayout
; ---------------------------------
_UI_DrawLayout::
;engine/src/ui.c:115: Bios_SetCursor(0, SCREEN_ROW_DIVIDER_1);
	ld	l, #0x01
	xor	a, a
	call	_Bios_SetCursor
;engine/src/ui.c:116: for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput('-');
	ld	c, #0x00
00103$:
	push	bc
	ld	a, #0x2d
	call	_Bios_Chput
	pop	bc
	inc	c
	ld	a, c
	sub	a, #0x28
	jr	c, 00103$
;engine/src/ui.c:118: Bios_SetCursor(0, SCREEN_ROW_DIVIDER_2);
	ld	l, #0x15
	xor	a, a
	call	_Bios_SetCursor
;engine/src/ui.c:119: for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput('-');
	ld	c, #0x00
00105$:
	push	bc
	ld	a, #0x2d
	call	_Bios_Chput
	pop	bc
	inc	c
	ld	a, c
	sub	a, #0x28
	jr	c, 00105$
;engine/src/ui.c:121: }
	ret
;engine/src/ui.c:126: void UI_SetTopText(const char* text)
;	---------------------------------
; Function UI_SetTopText
; ---------------------------------
_UI_SetTopText::
;engine/src/ui.c:138: Bios_SetCursor(0, SCREEN_ROW_TOP_START);
	push	hl
	xor	a, a
	ld	l, a
	call	_Bios_SetCursor
	pop	hl
;engine/src/ui.c:139: for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput(' ');
	ld	c, #0x00
00107$:
	push	hl
	push	bc
	ld	a, #0x20
	call	_Bios_Chput
	pop	bc
	pop	hl
	inc	c
	ld	a, c
	sub	a, #0x28
	jr	c, 00107$
;engine/src/ui.c:140: if (text != NULL)
	ld	a, h
	or	a, l
	ret	z
;engine/src/ui.c:142: Bios_SetCursor(1, SCREEN_ROW_TOP_START);
	push	hl
	ld	l, #0x00
	ld	a, #0x01
	call	_Bios_SetCursor
	pop	hl
;engine/src/ui.c:143: while (*text) Bios_Chput(*text++);
00102$:
	ld	a, (hl)
	or	a, a
	ret	z
	inc	hl
	push	hl
	call	_Bios_Chput
	pop	hl
;engine/src/ui.c:148: }
	jr	00102$
;engine/src/ui.c:153: void UI_ClearCenter(void)
;	---------------------------------
; Function UI_ClearCenter
; ---------------------------------
_UI_ClearCenter::
;engine/src/ui.c:163: for (y = SCREEN_ROW_CENTER_START; y <= SCREEN_ROW_CENTER_END; y++)
	ld	l, #0x02
00105$:
;engine/src/ui.c:165: Bios_SetCursor(0, y);
	push	hl
	xor	a, a
	call	_Bios_SetCursor
	pop	hl
;engine/src/ui.c:166: for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput(' ');
	ld	h, #0x00
00103$:
	push	hl
	ld	a, #0x20
	call	_Bios_Chput
	pop	hl
	inc	h
	ld	a, h
	sub	a, #0x28
	jr	c, 00103$
;engine/src/ui.c:163: for (y = SCREEN_ROW_CENTER_START; y <= SCREEN_ROW_CENTER_END; y++)
	inc	l
	ld	a, #0x14
	sub	a, l
	jr	nc, 00105$
;engine/src/ui.c:171: g_CenterCursorX = 0;
	xor	a, a
	ld	(#_g_CenterCursorX), a
;engine/src/ui.c:172: g_CenterCursorY = SCREEN_ROW_CENTER_START;
	ld	hl, #_g_CenterCursorY
	ld	(hl), #0x02
;engine/src/ui.c:173: }
	ret
;engine/src/ui.c:178: void UI_NewLineCenter(void)
;	---------------------------------
; Function UI_NewLineCenter
; ---------------------------------
_UI_NewLineCenter::
;engine/src/ui.c:180: g_CenterCursorX = 0;
	xor	a, a
	ld	(#_g_CenterCursorX), a
;engine/src/ui.c:181: g_CenterCursorY++;
	ld	hl, #_g_CenterCursorY
	inc	(hl)
;engine/src/ui.c:183: if (g_CenterCursorY > SCREEN_ROW_CENTER_END)
	ld	a, #0x14
	ld	hl, #_g_CenterCursorY
	sub	a, (hl)
	ret	nc
;engine/src/ui.c:191: Bios_SetCursor(0, SCREEN_ROW_CENTER_END);
	ld	l, #0x14
	xor	a, a
	call	_Bios_SetCursor
;engine/src/ui.c:193: const char* msg = "-- Pressione tecla --";
	ld	hl, #___str_0+0
;engine/src/ui.c:194: while (*msg) Bios_Chput(*msg++);
00101$:
	ld	a, (hl)
	or	a, a
	jr	z, 00103$
	inc	hl
	push	hl
	call	_Bios_Chput
	pop	hl
	jr	00101$
00103$:
;engine/src/ui.c:196: Bios_Chget();
	call	_Bios_Chget
;engine/src/ui.c:197: UI_ClearCenter();
;engine/src/ui.c:203: }
	jp	_UI_ClearCenter
___str_0:
	.ascii "-- Pressione tecla --"
	.db 0x00
;engine/src/ui.c:208: void UI_PrintCharCenter(char c)
;	---------------------------------
; Function UI_PrintCharCenter
; ---------------------------------
_UI_PrintCharCenter::
;engine/src/ui.c:210: if (c == '\n' || c == '\r')
	ld	c, a
	sub	a, #0x0a
	jp	z, _UI_NewLineCenter
	ld	a, c
	sub	a, #0x0d
;engine/src/ui.c:212: UI_NewLineCenter();
;engine/src/ui.c:213: return;
	jp	z, _UI_NewLineCenter
;engine/src/ui.c:220: Bios_SetCursor(g_CenterCursorX, g_CenterCursorY);
	push	bc
	ld	a, (_g_CenterCursorY)
	ld	l, a
	ld	a, (_g_CenterCursorX)
	call	_Bios_SetCursor
	pop	bc
;engine/src/ui.c:221: Bios_Chput(c);
	ld	a, c
	call	_Bios_Chput
;engine/src/ui.c:226: g_CenterCursorX++;
	ld	hl, #_g_CenterCursorX
	inc	(hl)
;engine/src/ui.c:227: if (g_CenterCursorX >= SCREEN_TEXT_WIDTH)
	ld	a, (_g_CenterCursorX+0)
	sub	a, #0x28
;engine/src/ui.c:229: UI_NewLineCenter();
	jp	nc, _UI_NewLineCenter
;engine/src/ui.c:231: }
	ret
;engine/src/ui.c:236: void UI_PrintCenter(const char* text)
;	---------------------------------
; Function UI_PrintCenter
; ---------------------------------
_UI_PrintCenter::
	ex	de, hl
;engine/src/ui.c:238: if (text == NULL) return;
	ld	a, d
	or	a, e
;engine/src/ui.c:240: while (*text)
	ret	z
00103$:
	ld	a, (de)
	or	a, a
	ret	z
;engine/src/ui.c:242: UI_PrintCharCenter(*text);
	push	de
	call	_UI_PrintCharCenter
	pop	de
;engine/src/ui.c:243: text++;
	inc	de
;engine/src/ui.c:245: }
	jr	00103$
;engine/src/ui.c:250: void UI_PrintNumberCenter(u8 value)
;	---------------------------------
; Function UI_PrintNumberCenter
; ---------------------------------
_UI_PrintNumberCenter::
	push	ix
	ld	ix,	#0
	add	ix, sp
	ld	hl, #-5
	add	hl, sp
	ld	sp, hl
;engine/src/ui.c:256: buf[idx++] = '0' + (value / 100);
;engine/src/ui.c:254: if (value >= 100)
	ld	c,a
	ld	e,a
	sub	a, #0x64
	jr	c, 00105$
;engine/src/ui.c:256: buf[idx++] = '0' + (value / 100);
	push	de
	ld	l, #0x64
	ld	a, e
	call	__divuchar
	ld	a, e
	pop	de
	add	a, #0x30
	ld	-5 (ix), a
;engine/src/ui.c:257: value %= 100;
	ld	l, #0x64
	ld	a, e
	call	__moduchar
;engine/src/ui.c:258: buf[idx++] = '0' + (value / 10);
	push	de
	ld	l, #0x0a
	ld	a, e
	call	__divuchar
	ld	a, e
	pop	de
	add	a, #0x30
	ld	-4 (ix), a
;engine/src/ui.c:259: buf[idx++] = '0' + (value % 10);
	ld	-1 (ix), #0x03
	ld	l, #0x0a
	ld	a, e
	call	__moduchar
	ld	a, e
	add	a, #0x30
	ld	-3 (ix), a
	jr	00106$
00105$:
;engine/src/ui.c:261: else if (value >= 10)
	ld	a, c
	sub	a, #0x0a
	jr	c, 00102$
;engine/src/ui.c:263: buf[idx++] = '0' + (value / 10);
	push	de
	ld	l, #0x0a
	ld	a, e
	call	__divuchar
	ld	a, e
	pop	de
	add	a, #0x30
	ld	-5 (ix), a
;engine/src/ui.c:264: buf[idx++] = '0' + (value % 10);
	ld	-1 (ix), #0x02
	ld	l, #0x0a
	ld	a, e
	call	__moduchar
	ld	a, e
	add	a, #0x30
	ld	-4 (ix), a
	jr	00106$
00102$:
;engine/src/ui.c:268: buf[idx++] = '0' + value;
	ld	-1 (ix), #0x01
	ld	a, c
	add	a, #0x30
	ld	-5 (ix), a
00106$:
;engine/src/ui.c:270: buf[idx] = '\0';
	ld	hl, #0
	add	hl, sp
	ex	de, hl
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x00
;engine/src/ui.c:271: UI_PrintCenter(buf);
	ex	de, hl
	call	_UI_PrintCenter
;engine/src/ui.c:272: }
	ld	sp, ix
	pop	ix
	ret
;engine/src/ui.c:277: void UI_ReadLine(char* buffer, u8 max_len)
;	---------------------------------
; Function UI_ReadLine
; ---------------------------------
_UI_ReadLine::
	push	ix
	ld	ix,	#0
	add	ix, sp
	push	af
	push	af
	ld	-2 (ix), l
	ld	-1 (ix), h
;engine/src/ui.c:279: u8 len = 0;
	ld	c, #0x00
;engine/src/ui.c:282: if (max_len == 0 || buffer == NULL) return;
	ld	a, 4 (ix)
	or	a, a
	jp	z, 00128$
	ld	a, -1 (ix)
	or	a, -2 (ix)
	jp	z, 00128$
;engine/src/ui.c:292: Bios_SetCursor(0, SCREEN_ROW_BOTTOM_START);
	push	bc
	ld	l, #0x16
	xor	a, a
	call	_Bios_SetCursor
	pop	bc
;engine/src/ui.c:293: for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput(' ');
	ld	b, #0x00
00126$:
	push	bc
	ld	a, #0x20
	call	_Bios_Chput
	pop	bc
	inc	b
	ld	a, b
	sub	a, #0x28
	jr	c, 00126$
;engine/src/ui.c:294: Bios_SetCursor(0, SCREEN_ROW_BOTTOM_START);
	push	bc
	ld	l, #0x16
	xor	a, a
	call	_Bios_SetCursor
;engine/src/ui.c:295: Bios_Chput('>');
	ld	a, #0x3e
	call	_Bios_Chput
;engine/src/ui.c:296: Bios_Chput(' ');
	ld	a, #0x20
	call	_Bios_Chput
	pop	bc
;engine/src/ui.c:299: while (TRUE)
00124$:
;engine/src/ui.c:305: ch = Bios_Chget();
	push	bc
	call	_Bios_Chget
	ld	e, a
	pop	bc
;engine/src/ui.c:332: buffer[len] = ch;
	ld	a, -2 (ix)
	add	a, c
	ld	-4 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-3 (ix), a
;engine/src/ui.c:308: if (ch == 13 || ch == 10) // ENTER
	ld	a, e
	sub	a, #0x0d
	jr	z, 00125$
	ld	a, e
	sub	a, #0x0a
	jr	z, 00125$
;engine/src/ui.c:312: else if (ch == 8 || ch == 127) // Backspace / DEL
	ld	a, e
	cp	a, #0x08
	jr	z, 00115$
	sub	a, #0x7f
	jr	nz, 00116$
00115$:
;engine/src/ui.c:314: if (len > 0)
	ld	a, c
	or	a, a
	jr	z, 00124$
;engine/src/ui.c:316: len--;
	dec	c
;engine/src/ui.c:321: Bios_SetCursor(2 + len, SCREEN_ROW_BOTTOM_START);
	ld	a, c
	add	a, #0x02
	push	bc
	ld	l, #0x16
	call	_Bios_SetCursor
;engine/src/ui.c:322: Bios_Chput(' ');
	ld	a, #0x20
	call	_Bios_Chput
	pop	bc
	jr	00124$
00116$:
;engine/src/ui.c:326: else if (ch >= 32 && ch < 127 && len < (max_len - 1) && len < (SCREEN_TEXT_WIDTH - 4))
	ld	a, e
	cp	a, #0x20
	jr	c, 00124$
	sub	a, #0x7f
	jr	nc, 00124$
	ld	b, 4 (ix)
	dec	b
	ld	a, c
	cp	a, b
	jr	nc, 00124$
	sub	a, #0x24
	jr	nc, 00124$
;engine/src/ui.c:328: if (ch >= 'a' && ch <= 'z')
	ld	a, e
	sub	a, #0x61
	jr	c, 00108$
	ld	a, #0x7a
	sub	a, e
	jr	c, 00108$
;engine/src/ui.c:330: ch = ch - ('a' - 'A');
	ld	a, e
	add	a, #0xe0
	ld	e, a
00108$:
;engine/src/ui.c:332: buffer[len] = ch;
	pop	hl
	push	hl
	ld	(hl), e
;engine/src/ui.c:337: Bios_SetCursor(2 + len, SCREEN_ROW_BOTTOM_START);
	ld	a, c
	add	a, #0x02
	push	bc
	push	de
	ld	l, #0x16
	call	_Bios_SetCursor
	pop	de
;engine/src/ui.c:338: Bios_Chput(ch);
	ld	a, e
	call	_Bios_Chput
	pop	bc
;engine/src/ui.c:340: len++;
	inc	c
	jr	00124$
00125$:
;engine/src/ui.c:343: buffer[len] = '\0';
	pop	hl
	ld	(hl), #0x00
	push	hl
00128$:
;engine/src/ui.c:357: }
	ld	sp, ix
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
;engine/src/ui.c:362: void UI_PauseSeconds(u8 seconds)
;	---------------------------------
; Function UI_PauseSeconds
; ---------------------------------
_UI_PauseSeconds::
;engine/src/ui.c:368: u16 i, frames = (u16)seconds * 60;
	ld	c, a
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
;engine/src/ui.c:369: for (i = 0; i < frames; i++) Bios_WaitFrame();
	ld	bc, #0x0000
00103$:
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	ret	nc
	push	hl
	push	bc
	call	_Bios_WaitFrame
	pop	bc
	pop	hl
	inc	bc
;engine/src/ui.c:373: }
	jr	00103$
	.area _CODE
	.area _INITIALIZER
__xinit__g_CenterCursorX:
	.db #0x00	; 0
__xinit__g_CenterCursorY:
	.db #0x02	; 2
	.area _CABS (ABS)
