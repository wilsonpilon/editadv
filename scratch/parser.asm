;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.6.0 #16555 (MINGW64)
;--------------------------------------------------------
	.module parser
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strlen
	.globl _strcmp
	.globl _strncat
	.globl _Parser_IsNoiseWord
	.globl _Parser_Parse
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
;engine/src/parser.c:55: static bool MatchWord(const char* word, const char* synonyms)
;	---------------------------------
; Function MatchWord
; ---------------------------------
_MatchWord:
	push	ix
	ld	ix,	#0
	add	ix, sp
	push	af
	push	af
	push	af
	ld	c, l
	ld	b, h
	ld	-3 (ix), e
	ld	-2 (ix), d
;engine/src/parser.c:61: if (word == NULL || synonyms == NULL) return FALSE;
	ld	a, b
	or	a, c
	jr	z, 00101$
	ld	a, -2 (ix)
	or	a, -3 (ix)
	jr	nz, 00102$
00101$:
	xor	a, a
	jp	00128$
00102$:
;engine/src/parser.c:63: while (word[wlen]) wlen++;
	ld	d, #0x00
00104$:
	ld	l, d
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	z, 00160$
	inc	d
	jr	00104$
00160$:
	ld	e, d
;engine/src/parser.c:64: if (wlen == 0) return FALSE;
	ld	a, d
	or	a,a
	jr	z, 00128$
;engine/src/parser.c:66: p = synonyms;
	push	iy
	ex	(sp), hl
	ld	l, -3 (ix)
	ex	(sp), hl
	ex	(sp), hl
	ld	h, -2 (ix)
	ex	(sp), hl
	pop	iy
;engine/src/parser.c:67: while (*p)
00122$:
	ld	a, (iy)
	or	a, a
	jr	z, 00124$
;engine/src/parser.c:69: start = p;
	pop	hl
	push	iy
;engine/src/parser.c:70: while (*p && *p != '/') p++;
	push	iy
	pop	hl
00110$:
	ld	a, (hl)
	or	a, a
	jr	z, 00161$
	cp	a, #0x2f
	jr	z, 00161$
	inc	hl
	jr	00110$
00161$:
	push	hl
	pop	iy
;engine/src/parser.c:71: slen = (u8)(p - start);
	ld	d, -6 (ix)
	ld	a, l
	sub	a, d
;engine/src/parser.c:73: if (wlen == slen)
	sub	a, e
	jr	nz, 00119$
;engine/src/parser.c:76: bool match = TRUE;
	ld	d, #0x01
;engine/src/parser.c:77: for (i = 0; i < wlen; i++)
	ld	-1 (ix), #0x00
00126$:
	ld	a, -1 (ix)
	sub	a, e
	jr	nc, 00115$
;engine/src/parser.c:79: if (word[i] != start[i])
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	-4 (ix), a
	ld	a, -6 (ix)
	add	a, -1 (ix)
	ld	l, a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	h, a
	ld	a, (hl)
	sub	a, -4 (ix)
	jr	z, 00127$
;engine/src/parser.c:81: match = FALSE;
	ld	d, #0x00
;engine/src/parser.c:82: break;
	jr	00115$
00127$:
;engine/src/parser.c:77: for (i = 0; i < wlen; i++)
	inc	-1 (ix)
	jr	00126$
00115$:
;engine/src/parser.c:85: if (match) return TRUE;
	ld	a, d
	or	a, a
	jr	z, 00119$
	ld	a, #0x01
	jr	00128$
00119$:
;engine/src/parser.c:88: if (*p == '/') p++;
	ld	a, (iy)
	cp	a, #0x2f
	jr	nz, 00122$
	inc	iy
	jr	00122$
00124$:
;engine/src/parser.c:91: return FALSE;
	xor	a, a
00128$:
;engine/src/parser.c:92: }
	ld	sp, ix
	pop	ix
	ret
_g_DefaultVerbs:
	.dw __str_0
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
	.dw __str_13
	.dw __str_14
	.dw __str_15
	.dw __str_16
	.dw __str_17
	.dw __str_18
	.dw __str_19
	.dw __str_20
	.dw __str_21
	.dw __str_22
	.dw __str_23
	.dw __str_24
	.dw __str_25
	.dw __str_26
	.dw __str_27
	.dw __str_28
	.dw __str_29
	.dw __str_30
	.dw __str_31
	.dw __str_32
	.dw __str_33
__str_0:
	.ascii "NORTE/N"
	.db 0x00
__str_1:
	.ascii "SUL/S"
	.db 0x00
__str_2:
	.ascii "LESTE/L"
	.db 0x00
__str_3:
	.ascii "OESTE/O"
	.db 0x00
__str_4:
	.ascii "GRAVE"
	.db 0x00
__str_5:
	.ascii "RECUPERE"
	.db 0x00
__str_6:
	.ascii "ENTRE"
	.db 0x00
__str_7:
	.ascii "SUBA"
	.db 0x00
__str_8:
	.ascii "SAIA"
	.db 0x00
__str_9:
	.ascii "DESCA"
	.db 0x00
__str_10:
	.ascii "HORAS"
	.db 0x00
__str_11:
	.ascii "QUANTO"
	.db 0x00
__str_12:
	.ascii "TEMOS/INV/I"
	.db 0x00
__str_13:
	.ascii "RECOMECE/REINICIE"
	.db 0x00
__str_14:
	.ascii "HA"
	.db 0x00
__str_15:
	.ascii "GARIMPE"
	.db 0x00
__str_16:
	.ascii "PENSE"
	.db 0x00
__str_17:
	.ascii "GRITE"
	.db 0x00
__str_18:
	.ascii "CORRA"
	.db 0x00
__str_19:
	.ascii "PEGUE/PEGAR/APANHE"
	.db 0x00
__str_20:
	.ascii "COLOQUE/PONHA/GUARDE"
	.db 0x00
__str_21:
	.ascii "TROQUE"
	.db 0x00
__str_22:
	.ascii "COMPRE"
	.db 0x00
__str_23:
	.ascii "ROUBE"
	.db 0x00
__str_24:
	.ascii "TIRE"
	.db 0x00
__str_25:
	.ascii "QUEBRE"
	.db 0x00
__str_26:
	.ascii "SOLTE/LARGUE/DEIXE"
	.db 0x00
__str_27:
	.ascii "EXAMINE/OLHE/VER/L"
	.db 0x00
__str_28:
	.ascii "PROCURE/BUSQUE"
	.db 0x00
__str_29:
	.ascii "OFERECA/DOE/DE"
	.db 0x00
__str_30:
	.ascii "FACA/CONSTRUA"
	.db 0x00
__str_31:
	.ascii "JOGUE/ATIRE"
	.db 0x00
__str_32:
	.ascii "CONSERTE/REPARE"
	.db 0x00
__str_33:
	.ascii "VENDA"
	.db 0x00
;engine/src/parser.c:97: bool Parser_IsNoiseWord(const char* word)
;	---------------------------------
; Function Parser_IsNoiseWord
; ---------------------------------
_Parser_IsNoiseWord::
	push	ix
	ld	ix,	#0
	add	ix, sp
	dec	sp
	ld	c, l
	ld	b, h
;engine/src/parser.c:106: while (noise[i] != NULL)
	ld	-1 (ix), #0x00
00103$:
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_Parser_IsNoiseWord_noise_10000_68
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, d
	or	a, e
	jr	z, 00105$
;engine/src/parser.c:108: if (strcmp(word, noise[i]) == 0) return TRUE;
	push	bc
	ld	l, c
	ld	h, b
	call	_strcmp
	pop	bc
	ld	a, d
	or	a, e
	jr	nz, 00102$
	ld	a, #0x01
	jr	00106$
00102$:
;engine/src/parser.c:109: i++;
	inc	-1 (ix)
	jr	00103$
00105$:
;engine/src/parser.c:111: return FALSE;
	xor	a, a
00106$:
;engine/src/parser.c:112: }
	inc	sp
	pop	ix
	ret
_Parser_IsNoiseWord_noise_10000_68:
	.dw ___str_34
	.dw ___str_35
	.dw ___str_36
	.dw ___str_37
	.dw ___str_38
	.dw ___str_39
	.dw ___str_40
	.dw ___str_41
	.dw ___str_42
	.dw ___str_43
	.dw ___str_44
	.dw ___str_45
	.dw ___str_46
	.dw ___str_47
	.dw ___str_48
	.dw ___str_49
	.dw ___str_50
	.dw ___str_51
	.dw ___str_52
	.dw ___str_53
	.dw ___str_54
	.dw ___str_55
	.dw #0x0000
___str_34:
	.ascii "A"
	.db 0x00
___str_35:
	.ascii "O"
	.db 0x00
___str_36:
	.ascii "AS"
	.db 0x00
___str_37:
	.ascii "OS"
	.db 0x00
___str_38:
	.ascii "UM"
	.db 0x00
___str_39:
	.ascii "UMA"
	.db 0x00
___str_40:
	.ascii "UNS"
	.db 0x00
___str_41:
	.ascii "UMAS"
	.db 0x00
___str_42:
	.ascii "DE"
	.db 0x00
___str_43:
	.ascii "DO"
	.db 0x00
___str_44:
	.ascii "DA"
	.db 0x00
___str_45:
	.ascii "DOS"
	.db 0x00
___str_46:
	.ascii "DAS"
	.db 0x00
___str_47:
	.ascii "EM"
	.db 0x00
___str_48:
	.ascii "NO"
	.db 0x00
___str_49:
	.ascii "NA"
	.db 0x00
___str_50:
	.ascii "NOS"
	.db 0x00
___str_51:
	.ascii "NAS"
	.db 0x00
___str_52:
	.ascii "PARA"
	.db 0x00
___str_53:
	.ascii "PRA"
	.db 0x00
___str_54:
	.ascii "COM"
	.db 0x00
___str_55:
	.ascii "POR"
	.db 0x00
;engine/src/parser.c:117: static u8 Parser_FindVerb(const char* word)
;	---------------------------------
; Function Parser_FindVerb
; ---------------------------------
_Parser_FindVerb:
	push	ix
	ld	ix,	#0
	add	ix, sp
	ld	iy, #-8
	add	iy, sp
	ld	sp, iy
	ld	-3 (ix), l
	ld	-2 (ix), h
;engine/src/parser.c:120: for (i = 0; i < 34; i++)
	ld	-6 (ix), #0x00
	ld	-1 (ix), #0x00
00104$:
;engine/src/parser.c:122: if (MatchWord(word, g_DefaultVerbs[i]))
	ld	a, -1 (ix)
	ld	-5 (ix), a
	ld	-4 (ix), #0x00
	ld	a, -5 (ix)
	ld	-8 (ix), a
	ld	-7 (ix), #0x00
	sla	-8 (ix)
	rl	-7 (ix)
	ld	a, #<(_g_DefaultVerbs)
	add	a, -8 (ix)
	ld	-5 (ix), a
	ld	a, #>(_g_DefaultVerbs)
	adc	a, -7 (ix)
	ld	-4 (ix), a
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	a, (hl)
	ld	-5 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-4 (ix), a
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	_MatchWord
	or	a, a
	jr	z, 00105$
;engine/src/parser.c:124: return (i + 1);
	ld	a, -6 (ix)
	inc	a
	jr	00106$
00105$:
;engine/src/parser.c:120: for (i = 0; i < 34; i++)
	inc	-1 (ix)
	ld	a, -1 (ix)
	ld	-6 (ix), a
	sub	a, #0x22
	jr	c, 00104$
;engine/src/parser.c:127: return 0;
	xor	a, a
00106$:
;engine/src/parser.c:128: }
	ld	sp, ix
	pop	ix
	ret
;engine/src/parser.c:133: static u8 Parser_FindObject(const char* word, const Game_Database* db)
;	---------------------------------
; Function Parser_FindObject
; ---------------------------------
_Parser_FindObject:
	push	ix
	ld	ix,	#0
	add	ix, sp
	push	af
	push	af
	dec	sp
	ld	-3 (ix), l
	ld	-2 (ix), h
;engine/src/parser.c:136: if (db == NULL || db->objetos == NULL) return 0;
	ld	a, d
	or	a, e
	jr	z, 00101$
	ld	hl, #0x0008
	add	hl, de
	ld	c,l
	ld	b,h
	ld	a, (hl)
	inc	hl
	or	a, (hl)
	jr	nz, 00126$
00101$:
	xor	a, a
	jr	00113$
;engine/src/parser.c:138: for (i = 0; i < db->num_objetos; i++)
00126$:
	push	de
	pop	iy
	ld	-1 (ix), #0x00
00111$:
	ld	e, 10 (iy)
	ld	a, -1 (ix)
	sub	a, e
	jr	nc, 00109$
;engine/src/parser.c:140: const Game_Object* obj = db->objetos[i];
	ld	l, c
	ld	h, b
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, de
	ld	a, (hl)
	ld	-5 (ix), a
	inc	hl
	ld	a, (hl)
;engine/src/parser.c:141: if (obj != NULL && obj->nome != NULL)
	ld	-4 (ix), a
	or	a, -5 (ix)
	jr	z, 00112$
	pop	hl
	push	hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, d
	or	a, e
	jr	z, 00112$
;engine/src/parser.c:143: if (MatchWord(word, obj->nome))
	push	bc
	push	iy
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	_MatchWord
	pop	iy
	pop	bc
	or	a, a
	jr	z, 00112$
;engine/src/parser.c:145: return obj->id;
	pop	hl
	push	hl
	ld	a, (hl)
	jr	00113$
00112$:
;engine/src/parser.c:138: for (i = 0; i < db->num_objetos; i++)
	inc	-1 (ix)
	jr	00111$
00109$:
;engine/src/parser.c:149: return 0;
	xor	a, a
00113$:
;engine/src/parser.c:150: }
	ld	sp, ix
	pop	ix
	ret
;engine/src/parser.c:155: bool Parser_Parse(const char* input, const Game_Database* db, Game_State* state, char* parsed_echo, u8 echo_max_len)
;	---------------------------------
; Function Parser_Parse
; ---------------------------------
_Parser_Parse::
	push	ix
	ld	ix,	#0
	add	ix, sp
	ld	iy, #-50
	add	iy, sp
	ld	sp, iy
	ld	c, l
	ld	b, h
	ld	-3 (ix), e
	ld	-2 (ix), d
;engine/src/parser.c:159: u8 meaningful_words = 0;
	ld	-1 (ix), #0x00
;engine/src/parser.c:160: const char* p = input;
	ld	-18 (ix), c
	ld	-17 (ix), b
;engine/src/parser.c:162: state->verbo_atual = 0;
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	ld	hl, #0x0103
	add	hl, de
	ld	-16 (ix), l
	ld	-15 (ix), h
	ld	(hl), #0x00
;engine/src/parser.c:163: state->obj_buffer[0] = 0;
	ld	hl, #0x0101
	add	hl, de
	ld	-14 (ix), l
	ld	-13 (ix), h
	ld	(hl), #0x00
;engine/src/parser.c:164: state->obj_buffer[1] = 0;
	ld	hl, #0x0102
	add	hl, de
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	(hl), #0x00
;engine/src/parser.c:166: if (parsed_echo != NULL && echo_max_len > 0)
	ld	a, 7 (ix)
	or	a, 6 (ix)
	jr	z, 00102$
	ld	a, 8 (ix)
	or	a, a
	jr	z, 00102$
;engine/src/parser.c:168: parsed_echo[0] = '\0';
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ld	(hl), #0x00
00102$:
;engine/src/parser.c:171: if (input == NULL) return FALSE;
	ld	a, b
	or	a, c
	jr	nz, 00206$
	xor	a, a
	jp	00154$
;engine/src/parser.c:173: while (*p)
00206$:
00151$:
	ld	l, -18 (ix)
	ld	h, -17 (ix)
	ld	a, (hl)
	or	a, a
	jp	z, 00153$
;engine/src/parser.c:176: while (*p == ' ' || *p == '\t' || *p == '\r' || *p == '\n') p++;
	ld	e, -18 (ix)
	ld	d, -17 (ix)
00109$:
	ld	a, (de)
	cp	a, #0x20
	jr	z, 00110$
	cp	a, #0x09
	jr	z, 00110$
	cp	a, #0x0d
	jr	z, 00110$
	cp	a, #0x0a
	jr	nz, 00111$
00110$:
	inc	de
	jr	00109$
00111$:
;engine/src/parser.c:177: if (*p == '\0') break;
	or	a, a
	jp	z, 00153$
;engine/src/parser.c:181: while (*p && *p != ' ' && *p != '\t' && *p != '\r' && *p != '\n')
	ld	-8 (ix), #0x00
	ld	-5 (ix), e
	ld	-4 (ix), d
00120$:
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	a, (hl)
	ld	-9 (ix), a
;engine/src/parser.c:185: word[word_idx++] = *p;
	ld	e, -8 (ix)
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	-7 (ix), l
	ld	-6 (ix), h
;engine/src/parser.c:181: while (*p && *p != ' ' && *p != '\t' && *p != '\r' && *p != '\n')
	ld	a, -9 (ix)
	or	a, a
	jr	z, 00225$
	ld	a, -9 (ix)
	sub	a, #0x20
	jr	z, 00225$
	ld	a, -9 (ix)
	sub	a, #0x09
	jr	z, 00225$
	ld	a, -9 (ix)
	sub	a, #0x0d
	jr	z, 00225$
	ld	a, -9 (ix)
	sub	a, #0x0a
	jr	z, 00225$
;engine/src/parser.c:183: if (word_idx < (sizeof(word) - 1))
	ld	a, -8 (ix)
	sub	a, #0x1f
	jr	nc, 00115$
;engine/src/parser.c:185: word[word_idx++] = *p;
	inc	-8 (ix)
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	a, -9 (ix)
	ld	(hl), a
00115$:
;engine/src/parser.c:187: p++;
	inc	-5 (ix)
	jr	nz, 00120$
	inc	-4 (ix)
	jr	00120$
00225$:
	ld	a, -5 (ix)
	ld	-18 (ix), a
	ld	a, -4 (ix)
	ld	-17 (ix), a
;engine/src/parser.c:189: word[word_idx] = '\0';
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	(hl), #0x00
;engine/src/parser.c:192: if (Parser_IsNoiseWord(word))
	ld	hl, #0
	add	hl, sp
	call	_Parser_IsNoiseWord
	or	a, a
	jp	nz, 00151$
;engine/src/parser.c:208: while (vname[k] && vname[k] != '/' && k < (echo_max_len - 1))
	ld	c, 8 (ix)
	ld	b, #0x00
;engine/src/parser.c:198: if (meaningful_words == 0)
	ld	a, -1 (ix)
	or	a, a
	jp	nz, 00149$
;engine/src/parser.c:200: state->verbo_atual = Parser_FindVerb(word);
	push	bc
	ld	hl, #2
	add	hl, sp
	call	_Parser_FindVerb
	pop	bc
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	(hl), a
;engine/src/parser.c:201: meaningful_words++;
	ld	-1 (ix), #0x01
;engine/src/parser.c:203: if (parsed_echo != NULL && state->verbo_atual > 0)
	ld	a, 7 (ix)
	or	a, 6 (ix)
	jp	z, 00151$
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	a, (hl)
	or	a, a
	jp	z, 00151$
;engine/src/parser.c:206: const char* vname = g_DefaultVerbs[state->verbo_atual - 1];
	dec	a
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	add	hl, hl
	ld	iy, #_g_DefaultVerbs
	ex	de, hl
	add	iy, de
	ld	a, 0 (iy)
	ld	-10 (ix), a
	ld	a, 1 (iy)
	ld	-9 (ix), a
;engine/src/parser.c:208: while (vname[k] && vname[k] != '/' && k < (echo_max_len - 1))
	ld	e, #0x00
00127$:
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	ld	-8 (ix), a
;engine/src/parser.c:210: parsed_echo[k] = vname[k];
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ld	d, #0x00
	add	hl, de
;engine/src/parser.c:208: while (vname[k] && vname[k] != '/' && k < (echo_max_len - 1))
	ld	a, -8 (ix)
	or	a, a
	jr	z, 00129$
	ld	a, -8 (ix)
	sub	a, #0x2f
	jr	z, 00129$
	ld	a, c
	add	a, #0xff
	ld	-7 (ix), a
	ld	a, b
	adc	a, #0xff
	ld	-6 (ix), a
	ld	-5 (ix), e
	ld	-4 (ix), #0x00
	ld	a, -5 (ix)
	sub	a, -7 (ix)
	ld	a, #0x00
	sbc	a, -6 (ix)
	jp	po, 00442$
	xor	a, #0x80
00442$:
	jp	p, 00129$
;engine/src/parser.c:210: parsed_echo[k] = vname[k];
	ld	a, -8 (ix)
	ld	(hl), a
;engine/src/parser.c:211: k++;
	inc	e
	jr	00127$
00129$:
;engine/src/parser.c:213: parsed_echo[k] = '\0';
	ld	(hl), #0x00
	jp	00151$
00149$:
;engine/src/parser.c:225: if (cur < (echo_max_len - 2))
	ld	a, c
	add	a, #0xfe
	ld	-5 (ix), a
	ld	a, b
	adc	a, #0xff
	ld	-4 (ix), a
;engine/src/parser.c:217: else if (meaningful_words == 1)
	ld	a, -1 (ix)
	dec	a
	jp	nz, 00146$
;engine/src/parser.c:219: state->obj_buffer[0] = Parser_FindObject(word, db);
	push	bc
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	hl, #2
	add	hl, sp
	call	_Parser_FindObject
	pop	bc
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	(hl), a
;engine/src/parser.c:220: meaningful_words++;
	inc	-1 (ix)
;engine/src/parser.c:222: if (parsed_echo != NULL && state->obj_buffer[0] > 0)
	ld	a, 7 (ix)
	or	a, 6 (ix)
	jp	z, 00151$
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	a, (hl)
	or	a, a
	jp	z, 00151$
;engine/src/parser.c:224: u8 cur = (u8)strlen(parsed_echo);
	push	bc
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	call	_strlen
	pop	bc
;engine/src/parser.c:225: if (cur < (echo_max_len - 2))
	ld	d, e
	ld	l, #0x00
	ld	a, d
	sub	a, -5 (ix)
	ld	a, l
	sbc	a, -4 (ix)
	jp	po, 00445$
	xor	a, #0x80
00445$:
	jp	p, 00151$
;engine/src/parser.c:227: parsed_echo[cur++] = ' ';
	ld	a, e
	inc	e
	add	a, 6 (ix)
	ld	l, a
	ld	a, #0x00
	adc	a, 7 (ix)
	ld	h, a
	ld	(hl), #0x20
;engine/src/parser.c:228: parsed_echo[cur] = '\0';
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ld	d, #0x00
	add	hl, de
	ld	(hl), #0x00
;engine/src/parser.c:229: strncat(parsed_echo, word, echo_max_len - cur - 1);
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	c, a
	sbc	a, a
	ld	b, a
	dec	bc
	push	bc
	ld	hl, #2
	add	hl, sp
	ex	de, hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	call	_strncat
	jp	00151$
00146$:
;engine/src/parser.c:234: else if (meaningful_words == 2)
	ld	a, -1 (ix)
	sub	a, #0x02
	jp	nz, 00151$
;engine/src/parser.c:236: state->obj_buffer[1] = Parser_FindObject(word, db);
	push	bc
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	hl, #2
	add	hl, sp
	call	_Parser_FindObject
	pop	bc
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	ld	(hl), a
;engine/src/parser.c:239: if (parsed_echo != NULL && state->obj_buffer[1] > 0)
	ld	a, 7 (ix)
	or	a, 6 (ix)
	jr	z, 00153$
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	ld	a, (hl)
	or	a, a
	jr	z, 00153$
;engine/src/parser.c:241: u8 cur = (u8)strlen(parsed_echo);
	push	bc
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	call	_strlen
	pop	bc
;engine/src/parser.c:242: if (cur < (echo_max_len - 2))
	ld	d, e
	ld	l, #0x00
	ld	a, d
	sub	a, -5 (ix)
	ld	a, l
	sbc	a, -4 (ix)
	jp	po, 00448$
	xor	a, #0x80
00448$:
	jp	p, 00153$
;engine/src/parser.c:244: parsed_echo[cur++] = ' ';
	ld	a, e
	inc	e
	add	a, 6 (ix)
	ld	l, a
	ld	a, #0x00
	adc	a, 7 (ix)
	ld	h, a
	ld	(hl), #0x20
;engine/src/parser.c:245: parsed_echo[cur] = '\0';
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ld	d, #0x00
	add	hl, de
	ld	(hl), #0x00
;engine/src/parser.c:246: strncat(parsed_echo, word, echo_max_len - cur - 1);
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	c, a
	sbc	a, a
	ld	b, a
	dec	bc
	push	bc
	ld	hl, #2
	add	hl, sp
	ex	de, hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	call	_strncat
;engine/src/parser.c:249: break;
00153$:
;engine/src/parser.c:253: return (state->verbo_atual > 0);
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	a, (hl)
	or	a, a
	ld	a, #0x01
	jr	nz, 00157$
	xor	a, a
00157$:
00154$:
;engine/src/parser.c:254: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	bc
	pop	bc
	inc	sp
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
