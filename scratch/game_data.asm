;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.6.0 #16555 (MINGW64)
;--------------------------------------------------------
	.module game_data
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _g_GameDatabase
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
	.area _CODE
_s_msg_0:
	.db #0x0b	; 11
	.dw __str_0
_s_msg_1:
	.db #0x1e	; 30
	.dw __str_1
_s_msg_2:
	.db #0x1f	; 31
	.dw __str_2
_s_msg_3:
	.db #0x20	; 32
	.dw __str_3
_s_msg_4:
	.db #0x21	; 33
	.dw __str_4
_s_msg_5:
	.db #0x22	; 34
	.dw __str_5
_s_msg_6:
	.db #0x23	; 35
	.dw __str_6
_s_messages:
	.dw _s_msg_0
	.dw _s_msg_1
	.dw _s_msg_2
	.dw _s_msg_3
	.dw _s_msg_4
	.dw _s_msg_5
	.dw _s_msg_6
_s_obj_0:
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.dw __str_7
	.dw __str_8
_s_obj_1:
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x03	; 3
	.dw __str_9
	.dw __str_10
_s_obj_2:
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.dw __str_11
	.dw __str_12
_s_obj_3:
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.dw __str_13
	.dw __str_14
_s_obj_4:
	.db #0x05	; 5
	.db #0x01	; 1
	.db #0x03	; 3
	.dw __str_15
	.dw __str_16
_s_objects:
	.dw _s_obj_0
	.dw _s_obj_1
	.dw _s_obj_2
	.dw _s_obj_3
	.dw _s_obj_4
_s_pos_0:
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.dw __str_17
_s_pos_1:
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x04	; 4
	.dw __str_18
_s_pos_2:
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.dw __str_19
_s_pos_3:
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.dw __str_20
_s_positions:
	.dw _s_pos_0
	.dw _s_pos_1
	.dw _s_pos_2
	.dw _s_pos_3
_s_func_inst_0:
	.db #0x09	; 9
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_s_func_0:
	.db #0x01	; 1
	.dw _s_func_inst_0
	.db #0x03	; 3
_s_func_inst_1:
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x13	; 19
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_s_func_1:
	.db #0x06	; 6
	.dw _s_func_inst_1
	.db #0x09	; 9
_s_func_inst_2:
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_s_func_2:
	.db #0x07	; 7
	.dw _s_func_inst_2
	.db #0x06	; 6
_s_func_inst_3:
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_s_func_3:
	.db #0x0d	; 13
	.dw _s_func_inst_3
	.db #0x06	; 6
_s_func_inst_4:
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x29	; 41
	.db #0x2e	; 46
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_s_func_4:
	.db #0x0e	; 14
	.dw _s_func_inst_4
	.db #0x08	; 8
_s_functions:
	.dw _s_func_0
	.dw _s_func_1
	.dw _s_func_2
	.dw _s_func_3
	.dw _s_func_4
_s_cmd_inst_0:
	.db #0x11	; 17
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_s_cmd_0:
	.db #0x1f	; 31
	.db #0x02	; 2
	.db #0x00	; 0
	.dw _s_cmd_inst_0
	.db #0x06	; 6
_s_cmd_inst_1:
	.db #0x10	; 16
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x23	; 35
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_s_cmd_1:
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.dw _s_cmd_inst_1
	.db #0x08	; 8
_s_commands:
	.dw _s_cmd_0
	.dw _s_cmd_1
_g_GameDatabase:
	.dw __str_21
	.db #0x01	; 1
	.db #0x05	; 5
	.db #0x03	; 3
	.dw _s_positions
	.db #0x04	; 4
	.dw _s_objects
	.db #0x05	; 5
	.dw _s_commands
	.db #0x02	; 2
	.dw _s_functions
	.db #0x05	; 5
	.dw _s_messages
	.db #0x07	; 7
__str_0:
	.ascii "A Mansao Misteriosa - Uma aventura em texto para MSX."
	.db 0x00
__str_1:
	.ascii "Voce riscou um fosforo e acendeu a vela. Uma luz suave ilumi"
	.ascii "na o ambiente."
	.db 0x00
__str_2:
	.ascii "Voce assoprou e apagou a vela."
	.db 0x00
__str_3:
	.ascii "Pegou."
	.db 0x00
__str_4:
	.ascii "Soltou no chao."
	.db 0x00
__str_5:
	.ascii "Guardou dentro da mala."
	.db 0x00
__str_6:
	.ascii "Voce usou a chave e destrancou o portao sul! Parabens, voce "
	.ascii "venceu!"
	.db 0x00
__str_7:
	.ascii "LOCAL"
	.db 0x00
__str_8:
	.ascii "O local onde voce se encontra."
	.db 0x00
__str_9:
	.ascii "VELA/VELAS"
	.db 0x00
__str_10:
	.ascii "Uma vela de cera amarelada."
	.db 0x00
__str_11:
	.ascii "MALA/BOLSA"
	.db 0x00
__str_12:
	.ascii "Uma mala de couro aberta para guardar objetos."
	.db 0x00
__str_13:
	.ascii "CHAVE/CHAVES"
	.db 0x00
__str_14:
	.ascii "Uma chave de bronze pesada."
	.db 0x00
__str_15:
	.ascii "FOSFORO/FOSFOROS"
	.db 0x00
__str_16:
	.ascii "Uma caixinha com fosforos."
	.db 0x00
__str_17:
	.ascii "Voce esta no grande hall de entrada de uma antiga mansao. Ao"
	.ascii " norte ha uma sala de estar. A saida ao sul esta trancada."
	.db 0x00
__str_18:
	.ascii "Voce esta em uma confortavel sala de estar com lareira apaga"
	.ascii "da. Ha passagens para o sul, leste e oeste."
	.db 0x00
__str_19:
	.ascii "Uma biblioteca silenciosa com estantes repletas de livros em"
	.ascii "poeirados. A saida fica a oeste."
	.db 0x00
__str_20:
	.ascii "Um porao escuro e gelado sob a mansao. A escada para a sala "
	.ascii "de estar sobe a leste."
	.db 0x00
__str_21:
	.ascii "A Mansao Misteriosa"
	.db 0x00
	.area _INITIALIZER
	.area _CABS (ABS)
