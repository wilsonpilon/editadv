// _____________________________________________________________________________
//
//  UI Module Implementation - 3-Field Screen Layout (Capítulo 2)
// _____________________________________________________________________________

#include "ui.h"

#if defined(MSXGL)
    #include "msxgl.h"
    #include "font_custom.h"
#elif defined(__SDCC)
    // MSX BIOS Standard Entry Points (Z80)
    static void Bios_InitText(void) __naked
    {
    __asm
        call 0x005F // INITXT: Screen 0
        ret
    __endasm;
    }

    static void Bios_Cls(void) __naked
    {
    __asm
        call 0x00C3 // CLS
        ret
    __endasm;
    }

    static void Bios_SetCursor(u8 col, u8 row) __naked
    {
        col; row; // Suppress unreferenced warning
    __asm
        ld hl, #2
        add hl, sp
        ld a, (hl)    // col
        inc a         // BIOS POSIT usa 1-based (1..40)
        ld h, a
        inc hl
        ld a, (hl)    // row
        inc a         // BIOS POSIT usa 1-based (1..24)
        ld l, a
        call 0x00C6   // POSIT: H=col, L=row
        ret
    __endasm;
    }

    static void Bios_Chput(char c) __naked
    {
        c;
    __asm
        ld hl, #2
        add hl, sp
        ld a, (hl)
        call 0x00A2   // CHPUT
        ret
    __endasm;
    }

    static char Bios_Chget(void) __naked
    {
    __asm
        call 0x009F   // CHGET
        ld l, a
        ret
    __endasm;
    }

    static void Bios_WaitFrame(void) __naked
    {
    __asm
        ei
        halt
        ret
    __endasm;
    }
#else
    #include <stdio.h>
    #include <string.h>
    #include <ctype.h>
#endif

static u8 g_CenterCursorX = SCREEN_MARGIN_LEFT;
static u8 g_CenterCursorY = SCREEN_ROW_CENTER_START;

// -----------------------------------------------------------------------------
// UI_Init
// -----------------------------------------------------------------------------
void UI_Init(void)
{
#if defined(MSXGL)
    VDP_SetMode(VDP_MODE_SCREEN0);
    VDP_ClearVRAM();
    VDP_SetColor(0xF1);
    Print_SetTextFont(NULL, 1);
    // Carrega o alfabeto customizado de vram.dat para a VRAM (0x0800 ~ 0x0FFF)
    VDP_WriteVRAM_16K(g_FontCustom, 0x0800, 2048);
    Print_SetColor(COLOR_WHITE, COLOR_BLACK);

    // Configura taxa de repetição do teclado da BIOS para digitação confortável
    // REPCNT (0xF3F7): atraso inicial antes de iniciar repetição (~50 frames / ~0.8s)
    // RPTTICK (0xF3F8): intervalo de repetição (8 frames)
    *(volatile u8*)0xF3F7 = 50;
    *(volatile u8*)0xF3F8 = 8;
#elif defined(__SDCC)
    Bios_InitText();
    Bios_Cls();
    *(volatile u8*)0xF3F7 = 50;
    *(volatile u8*)0xF3F8 = 8;
#endif
    UI_DrawLayout();
    UI_ClearCenter();
}

// -----------------------------------------------------------------------------
// UI_DrawLayout
// Desenha as barras divisórias nas linhas 1 (0x1B) e 22 (0x1A)
// e os marcadores de início (0x18) nas linhas 0 e 23, coluna 2
// -----------------------------------------------------------------------------
// Macro para calcular endereço linear na VRAM da SCREEN 0 (Name Table em 0x0000)
#define VRAM_TEXT_ADDR(col, row) ((u16)((row) * SCREEN_TEXT_WIDTH + (col)))

// -----------------------------------------------------------------------------
// UI_DrawLayout
// Desenha as barras divisórias nas linhas 1 (0x1B) e 22 (0x1A)
// e os marcadores de início (0x18) nas linhas 0 e 23, coluna 2
// -----------------------------------------------------------------------------
void UI_DrawLayout(void)
{
#if defined(MSXGL)
    // Linha 0: Marcador inicial na coluna 2
    VDP_Poke_16K(SCREEN_CHAR_MARKER, VRAM_TEXT_ADDR(SCREEN_MARGIN_LEFT, SCREEN_ROW_TOP_START));

    // Linha 1: Divisória superior (0x1B das colunas 2 a 37)
    VDP_FillVRAM_16K(SCREEN_CHAR_DIVIDER_TOP, VRAM_TEXT_ADDR(SCREEN_MARGIN_LEFT, SCREEN_ROW_DIVIDER_1), SCREEN_BAR_WIDTH);

    // Linha 22: Divisória inferior (0x1A das colunas 2 a 37)
    VDP_FillVRAM_16K(SCREEN_CHAR_DIVIDER_BOTTOM, VRAM_TEXT_ADDR(SCREEN_MARGIN_LEFT, SCREEN_ROW_DIVIDER_2), SCREEN_BAR_WIDTH);

    // Linha 23: Marcador inicial na coluna 2
    VDP_Poke_16K(SCREEN_CHAR_MARKER, VRAM_TEXT_ADDR(SCREEN_MARGIN_LEFT, SCREEN_ROW_BOTTOM_START));
#elif defined(__SDCC)
    u8 x;
    Bios_SetCursor(SCREEN_MARGIN_LEFT, SCREEN_ROW_TOP_START);
    Bios_Chput(SCREEN_CHAR_MARKER);

    Bios_SetCursor(0, SCREEN_ROW_DIVIDER_1);
    Bios_Chput(' ');
    Bios_Chput(' ');
    for (x = SCREEN_MARGIN_LEFT; x <= SCREEN_MARGIN_RIGHT; x++) Bios_Chput(SCREEN_CHAR_DIVIDER_TOP);
    Bios_Chput(' ');
    Bios_Chput(' ');

    Bios_SetCursor(0, SCREEN_ROW_DIVIDER_2);
    Bios_Chput(' ');
    Bios_Chput(' ');
    for (x = SCREEN_MARGIN_LEFT; x <= SCREEN_MARGIN_RIGHT; x++) Bios_Chput(SCREEN_CHAR_DIVIDER_BOTTOM);
    Bios_Chput(' ');
    Bios_Chput(' ');

    Bios_SetCursor(SCREEN_MARGIN_LEFT, SCREEN_ROW_BOTTOM_START);
    Bios_Chput(SCREEN_CHAR_MARKER);
#endif
}

// Helper para decodificar caracteres UTF-8 de 1 ou 2 bytes para os códigos da fonte customizada (vram.dat)
static u8 UI_DecodeUTF8Char(const char** pStr)
{
    u8 c;
    if (pStr == NULL || *pStr == NULL) return 0;
    c = (u8)**pStr;
    if (c == '\0') return 0;
    (*pStr)++;
    if (c == 0xC3)
    {
        u8 c2 = (u8)**pStr;
        if (c2 == '\0') return 0;
        (*pStr)++;
        switch (c2)
        {
            // Maiúsculas acentuadas
            case 0x80: return 0x8F; // À
            case 0x81: return 0x84; // Á
            case 0x82: return 0x8C; // Â
            case 0x83: return 0xB0; // Ã
            case 0x87: return 0x80; // Ç
            case 0x88: return 0x90; // È
            case 0x89: return 0x90; // É
            case 0x8A: return 0x8D; // Ê
            case 0x8C: return 0x89; // Ì
            case 0x8D: return 0x89; // Í
            case 0x92: return 0x8A; // Ò
            case 0x93: return 0x8A; // Ó
            case 0x94: return 0x8E; // Ô
            case 0x95: return 0xB4; // Õ
            case 0x99: return 0x8B; // Ù
            case 0x9A: return 0x8B; // Ú

            // Minúsculas acentuadas
            case 0xA0: return 0x85; // à
            case 0xA1: return 0xA0; // á
            case 0xA2: return 0x83; // â
            case 0xA3: return 0xB1; // ã
            case 0xA7: return 0x87; // ç
            case 0xA8: return 0x82; // è
            case 0xA9: return 0x82; // é
            case 0xAA: return 0x88; // ê
            case 0xAC: return 0xA1; // ì
            case 0xAD: return 0xA1; // í
            case 0xB2: return 0x95; // ò
            case 0xB3: return 0xA2; // ó
            case 0xB4: return 0x93; // ô
            case 0xB5: return 0xB6; // õ (código 0xB6 em vram.dat para õ minúsculo)
            case 0xB9: return 0xA3; // ù
            case 0xBA: return 0xA3; // ú
            default: return c2;
        }
    }
    else if (c == 0xC2)
    {
        u8 c2 = (u8)**pStr;
        if (c2 == '\0') return 0;
        (*pStr)++;
        if (c2 == 0xA0) return ' '; // Non-breaking space
        if (c2 == 0xAA) return 0x9B; // ª
        if (c2 == 0xBA) return 0x9C; // º
        return c2;
    }
    if (c == '!') return 0x5B; // Ponto de exclamação na fonte customizada vram.dat (0x21 é Á)
    return c;
}

// -----------------------------------------------------------------------------
// UI_SetTopText
// Escreve o texto a partir da coluna 4 (após marcador na col 2 e espaço na col 3)
// -----------------------------------------------------------------------------
void UI_SetTopText(const char* text)
{
#if defined(MSXGL)
    u16 addr = VRAM_TEXT_ADDR(4, SCREEN_ROW_TOP_START);
    u8 max_chars = SCREEN_MARGIN_RIGHT - 4 + 1; // 38 - 4 + 1 = 35
    u8 decoded_buf[36];
    u8 len = 0;

    // Limpa colunas 4 a 39 instantaneamente
    VDP_FillVRAM_16K(' ', addr, SCREEN_TEXT_WIDTH - 4);

    if (text != NULL)
    {
        while (*text && len < max_chars)
        {
            u8 ch = UI_DecodeUTF8Char(&text);
            if (ch == '\0') break;
            decoded_buf[len++] = ch;
        }
        if (len > 0)
        {
            VDP_WriteVRAM_16K(decoded_buf, addr, len);
        }
    }
#elif defined(__SDCC)
    u8 x;
    Bios_SetCursor(4, SCREEN_ROW_TOP_START);
    for (x = 4; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput(' ');

    if (text != NULL)
    {
        Bios_SetCursor(4, SCREEN_ROW_TOP_START);
        for (x = 4; *text && x <= SCREEN_MARGIN_RIGHT; x++)
        {
            u8 ch = UI_DecodeUTF8Char(&text);
            if (ch == '\0') break;
            Bios_Chput((char)ch);
        }
    }
#else
    if (text) printf("[TOPO] %s\n", text);
#endif
}

// -----------------------------------------------------------------------------
// UI_ClearCenter
// Limpa linhas 2 a 21 instantaneamente em VRAM
// -----------------------------------------------------------------------------
void UI_ClearCenter(void)
{
#if defined(MSXGL)
    // Limpa todas as 20 linhas centrais (linhas 2 a 21 = 20 * 40 = 800 bytes) com Fill rápido
    VDP_FillVRAM_16K(' ', VRAM_TEXT_ADDR(0, SCREEN_ROW_CENTER_START), (SCREEN_ROW_CENTER_END - SCREEN_ROW_CENTER_START + 1) * SCREEN_TEXT_WIDTH);
#elif defined(__SDCC)
    u8 y, x;
    for (y = SCREEN_ROW_CENTER_START; y <= SCREEN_ROW_CENTER_END; y++)
    {
        Bios_SetCursor(0, y);
        for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput(' ');
    }
#else
    printf("\n--- [CENTRO LIMPO] ---\n");
#endif
    g_CenterCursorX = SCREEN_MARGIN_LEFT;
    g_CenterCursorY = SCREEN_ROW_CENTER_START;
}

// -----------------------------------------------------------------------------
// UI_NewLineCenter
// -----------------------------------------------------------------------------
void UI_NewLineCenter(void)
{
    g_CenterCursorX = SCREEN_MARGIN_LEFT;
    g_CenterCursorY++;

    if (g_CenterCursorY > SCREEN_ROW_CENTER_END)
    {
#if defined(MSXGL)
        Print_SetPosition(SCREEN_MARGIN_LEFT, SCREEN_ROW_CENTER_END);
        Print_DrawText("-- Pressione uma tecla --");
        BIOS_GetCharacter();
        UI_ClearCenter();
#elif defined(__SDCC)
        Bios_SetCursor(SCREEN_MARGIN_LEFT, SCREEN_ROW_CENTER_END);
        {
            const char* msg = "-- Pressione tecla --";
            while (*msg) Bios_Chput(*msg++);
        }
        Bios_Chget();
        UI_ClearCenter();
#else
        printf("\n");
        g_CenterCursorY = SCREEN_ROW_CENTER_START;
#endif
    }
}

// -----------------------------------------------------------------------------
// UI_PrintCharCenter
// Imprime diretamente na VRAM respeitando margens 2..37 com quebra automática
// -----------------------------------------------------------------------------
void UI_PrintCharCenter(char c)
{
    if (c == '\n' || c == '\r')
    {
        UI_NewLineCenter();
        return;
    }

#if defined(MSXGL)
    VDP_Poke_16K((u8)c, VRAM_TEXT_ADDR(g_CenterCursorX, g_CenterCursorY));
#elif defined(__SDCC)
    Bios_SetCursor(g_CenterCursorX, g_CenterCursorY);
    Bios_Chput(c);
#else
    putchar(c);
#endif

    g_CenterCursorX++;
    if (g_CenterCursorX > SCREEN_MARGIN_RIGHT)
    {
        UI_NewLineCenter();
    }
}

// -----------------------------------------------------------------------------
// UI_PrintCenter
// Com suporte a decodificação UTF-8, quebra correta de palavras e escrita em bloco VRAM
// -----------------------------------------------------------------------------
void UI_PrintCenter(const char* text)
{
    u8 word_buf[48];
    if (text == NULL) return;

    while (*text)
    {
        if (*text == '\n' || *text == '\r')
        {
            UI_NewLineCenter();
            text++;
            continue;
        }
        if (*text == ' ')
        {
            UI_PrintCharCenter(' ');
            text++;
            continue;
        }

        // Decodifica a palavra inteira para word_buf respeitando UTF-8
        {
            u8 word_len = 0;
            while (*text && *text != ' ' && *text != '\n' && *text != '\r' && word_len < (sizeof(word_buf) - 1))
            {
                u8 ch = UI_DecodeUTF8Char(&text);
                if (ch == '\0') break;
                word_buf[word_len++] = ch;
            }

            // Se não cabe na linha atual mas cabe numa linha nova, quebra antes
            if (word_len <= (SCREEN_MARGIN_RIGHT - SCREEN_MARGIN_LEFT + 1) &&
                (g_CenterCursorX + word_len - 1) > SCREEN_MARGIN_RIGHT)
            {
                UI_NewLineCenter();
            }

#if defined(MSXGL)
            // Se a palavra cabe na linha, escreve ela em bloco diretamente na VRAM
            if ((g_CenterCursorX + word_len - 1) <= SCREEN_MARGIN_RIGHT)
            {
                VDP_WriteVRAM_16K(word_buf, VRAM_TEXT_ADDR(g_CenterCursorX, g_CenterCursorY), word_len);
                g_CenterCursorX += word_len;
                if (g_CenterCursorX > SCREEN_MARGIN_RIGHT)
                {
                    UI_NewLineCenter();
                }
            }
            else
            {
                u8 k;
                for (k = 0; k < word_len; k++)
                {
                    UI_PrintCharCenter((char)word_buf[k]);
                }
            }
#elif defined(__SDCC)
            {
                u8 k;
                for (k = 0; k < word_len; k++)
                {
                    UI_PrintCharCenter((char)word_buf[k]);
                }
            }
#else
            {
                u8 k;
                for (k = 0; k < word_len; k++)
                {
                    putchar(word_buf[k]);
                }
            }
#endif
        }
    }
}

// -----------------------------------------------------------------------------
// UI_PrintNumberCenter
// -----------------------------------------------------------------------------
void UI_PrintNumberCenter(u8 value)
{
    char buf[4];
    u8 idx = 0;
    if (value >= 100)
    {
        buf[idx++] = '0' + (value / 100);
        value %= 100;
        buf[idx++] = '0' + (value / 10);
        buf[idx++] = '0' + (value % 10);
    }
    else if (value >= 10)
    {
        buf[idx++] = '0' + (value / 10);
        buf[idx++] = '0' + (value % 10);
    }
    else
    {
        buf[idx++] = '0' + value;
    }
    buf[idx] = '\0';
    UI_PrintCenter(buf);
}

// Helper para verificar se a tecla SHIFT está pressionada no MSX (matriz NEWKEY linha 6, bit 0)
static u8 UI_IsShiftPressed(void)
{
#if defined(MSXGL) || defined(__SDCC)
    volatile u8* pNewKeyRow6 = (volatile u8*)0xFBEB;
    return ((*pNewKeyRow6 & 0x01) == 0);
#else
    return 0;
#endif
}

// Helper para verificar se QUALQUER tecla alfanumérica/direcional está pressionada (linhas 0..5 e 7..8)
static bool UI_IsAnyKeyPressed(void)
{
#if defined(MSXGL) || defined(__SDCC)
    volatile u8* pNewKey = (volatile u8*)0xFBE5;
    u8 r;
    for (r = 0; r <= 8; r++)
    {
        if (r == 6) continue; // Ignora teclas modificadoras (SHIFT, CTRL, GRAPH, CODE)
        if (pNewKey[r] != 0xFF) return TRUE;
    }
    return FALSE;
#else
    return FALSE;
#endif
}

// -----------------------------------------------------------------------------
// UI_ReadLine
// Entrada de dados na linha 23 com atalhos para Ç e letras acentuadas
// -----------------------------------------------------------------------------
void UI_ReadLine(char* buffer, u8 max_len)
{
    u8 len = 0;
    u8 dead_key = 0;
    u16 prompt_base = VRAM_TEXT_ADDR(4, SCREEN_ROW_BOTTOM_START);

    if (max_len == 0 || buffer == NULL) return;

#if defined(MSXGL) || defined(__SDCC)
    // Limpa a área de comando da linha 23
    #if defined(MSXGL)
        VDP_Poke_16K(SCREEN_CHAR_MARKER, VRAM_TEXT_ADDR(SCREEN_MARGIN_LEFT, SCREEN_ROW_BOTTOM_START));
        VDP_FillVRAM_16K(' ', prompt_base, SCREEN_TEXT_WIDTH - 4);
        VDP_Poke_16K('_', prompt_base); // Cursor inicial
    #else
        Bios_SetCursor(SCREEN_MARGIN_LEFT, SCREEN_ROW_BOTTOM_START);
        Bios_Chput(SCREEN_CHAR_MARKER);
        Bios_Chput(' ');
        {
            u8 x;
            for (x = 4; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput(' ');
        }
        Bios_SetCursor(4, SCREEN_ROW_BOTTOM_START);
    #endif

    while (TRUE)
    {
        u8 ch;
        #if defined(MSXGL)
            ch = (u8)BIOS_GetCharacter();
        #else
            ch = (u8)Bios_Chget();
        #endif

        if (ch == 13 || ch == 10) // ENTER
        {
            #if defined(MSXGL)
                // Remove o cursor visual
                VDP_Poke_16K(' ', prompt_base + len);
            #endif
            break;
        }
        else if (ch == 8 || ch == 127) // Backspace / DEL
        {
            if (dead_key != 0)
            {
                dead_key = 0;
                continue;
            }
            if (len > 0)
            {
                #if defined(MSXGL)
                    VDP_Poke_16K(' ', prompt_base + len); // Apaga cursor na pos antiga
                    len--;
                    VDP_Poke_16K('_', prompt_base + len); // Desenha cursor na pos nova
                #else
                    len--;
                    Bios_SetCursor(4 + len, SCREEN_ROW_BOTTOM_START);
                    Bios_Chput(' ');
                #endif
            }
            continue;
        }

        // --- Suporte a Atalhos de Teclado para Ç e Acentos ---

        // 1. Tecla direta de Ç ou códigos estendidos (BIOS nacional / Latin-1 / CP437)
        if (ch == 0x80 || ch == 0x87 || ch == 0xC7 || ch == 0xE7)
        {
            ch = 0x80; // Ç
        }
        else if (ch == 0x90 || ch == 0x82 || ch == 0xC9 || ch == 0xE9)
        {
            ch = 0x90; // É
        }
        else if (ch == 0x84 || ch == 0xA0 || ch == 0xC1 || ch == 0xE1)
        {
            ch = 0x84; // Á
        }
        else if (ch == 0x89 || ch == 0xA1 || ch == 0xCD || ch == 0xED)
        {
            ch = 0x89; // Í
        }
        else if (ch == 0x8A || ch == 0xA2 || ch == 0xD3 || ch == 0xF3)
        {
            ch = 0x8A; // Ó
        }
        else if (ch == 0x8B || ch == 0xA3 || ch == 0xDA || ch == 0xFA)
        {
            ch = 0x8B; // Ú
        }
        else if (ch == 0xB0 || ch == 0xB1 || ch == 0xC3 || ch == 0xE3)
        {
            ch = 0xB0; // Ã
        }
        else if (ch == 0xB4 || ch == 0xB5 || ch == 0xD5 || ch == 0xF5)
        {
            ch = 0xB4; // Õ
        }
        else if (ch == 0x8C || ch == 0x83 || ch == 0xC2 || ch == 0xE2)
        {
            ch = 0x8C; // Â
        }
        else if (ch == 0x8E || ch == 0x93 || ch == 0xD4 || ch == 0xF4)
        {
            ch = 0x8E; // Ô
        }
        else if (ch == 0x8D || ch == 0x88 || ch == 0xCA || ch == 0xEA)
        {
            ch = 0x8D; // Ê
        }
        // 2. Atalho rápido CTRL+C -> Ç
        else if (ch == 3)
        {
            ch = 0x80; // Ç
        }
        // 3. Teclas de atalho SHIFT + NÚMEROS (Padrão MSX do Editor de Adventures):
        // SHIFT+0 = Ç, SHIFT+1..9 = Á, É, Í, Ó, Ú, Ã, Õ, Â, Ô
        else if (UI_IsShiftPressed())
        {
            if (ch == '0' || ch == ')') ch = 0x80; // SHIFT+0 -> Ç
            else if (ch == '1' || ch == '!') ch = 0x84; // SHIFT+1 -> Á
            else if (ch == '2' || ch == '"' || ch == '@') ch = 0x90; // SHIFT+2 -> É
            else if (ch == '3' || ch == '#') ch = 0x89; // SHIFT+3 -> Í
            else if (ch == '4' || ch == '$') ch = 0x8A; // SHIFT+4 -> Ó
            else if (ch == '5' || ch == '%') ch = 0x8B; // SHIFT+5 -> Ú
            else if (ch == '6' || ch == '&') ch = 0xB0; // SHIFT+6 -> Ã
            else if (ch == '7') ch = 0xB4; // SHIFT+7 -> Õ
            else if (ch == '8' || ch == '*' || ch == '(') ch = 0x8C; // SHIFT+8 -> Â
            else if (ch == '9') ch = 0x8E; // SHIFT+9 -> Ô
        }
        // 4. Suporte a Dead Keys (teclado internacional / emuladores):
        // ' + C -> Ç, ' + vogal -> Á/É/Í/Ó/Ú, ~ + A/O -> Ã/Õ, ^ + vogal -> Â/Ê/Ô
        if (dead_key != 0)
        {
            u8 prev_dead = dead_key;
            dead_key = 0;
            if (prev_dead == '\'')
            {
                if (ch == 'C' || ch == 'c') ch = 0x80; // ' + C -> Ç
                else if (ch == 'A' || ch == 'a') ch = 0x84; // ' + A -> Á
                else if (ch == 'E' || ch == 'e') ch = 0x90; // ' + E -> É
                else if (ch == 'I' || ch == 'i') ch = 0x89; // ' + I -> Í
                else if (ch == 'O' || ch == 'o') ch = 0x8A; // ' + O -> Ó
                else if (ch == 'U' || ch == 'u') ch = 0x8B; // ' + U -> Ú
                else if (ch == ' ' || ch == '\'') ch = '\'';
            }
            else if (prev_dead == '~')
            {
                if (ch == 'A' || ch == 'a') ch = 0xB0; // ~ + A -> Ã
                else if (ch == 'O' || ch == 'o') ch = 0xB4; // ~ + O -> Õ
                else if (ch == ' ' || ch == '~') ch = '~';
            }
            else if (prev_dead == '^')
            {
                if (ch == 'A' || ch == 'a') ch = 0x8C; // ^ + A -> Â
                else if (ch == 'E' || ch == 'e') ch = 0x8D; // ^ + E -> Ê
                else if (ch == 'O' || ch == 'o') ch = 0x8E; // ^ + O -> Ô
                else if (ch == ' ' || ch == '^') ch = '^';
            }
            else if (prev_dead == '`')
            {
                if (ch == 'A' || ch == 'a') ch = 0x8F; // ` + A -> À
                else if (ch == ' ' || ch == '`') ch = '`';
            }
        }
        else if (ch == '\'' || ch == '~' || ch == '^' || ch == '`')
        {
            dead_key = ch;
            continue;
        }

        // Insere caractere no buffer
        if (ch >= 32 && len < (max_len - 1) && (4 + len) <= SCREEN_MARGIN_RIGHT)
        {
            if (ch >= 'a' && ch <= 'z')
            {
                ch = ch - ('a' - 'A');
            }
            buffer[len] = (char)ch;
            #if defined(MSXGL)
                VDP_Poke_16K(ch, prompt_base + len);
                len++;
                if ((4 + len) <= SCREEN_MARGIN_RIGHT)
                {
                    VDP_Poke_16K('_', prompt_base + len);
                }
                // Aguarda o usuário soltar a tecla para NUNCA duplicar ou triplicar letras
                while (UI_IsAnyKeyPressed())
                {
                    Halt();
                }
                while (BIOS_HasCharacter());
            #else
                Bios_SetCursor(4 + len, SCREEN_ROW_BOTTOM_START);
                Bios_Chput((char)ch);
                len++;
                while (UI_IsAnyKeyPressed())
                {
                    Bios_WaitFrame();
                }
            #endif
        }
    }
    buffer[len] = '\0';
#else
    printf("\n> ");
    if (fgets(buffer, max_len, stdin) != NULL)
    {
        char* p = buffer;
        while (*p)
        {
            if (*p == '\n' || *p == '\r') { *p = '\0'; break; }
            if (*p >= 'a' && *p <= 'z') { *p = *p - ('a' - 'A'); }
            p++;
        }
    }
#endif
}

// -----------------------------------------------------------------------------
// UI_PauseSeconds
// -----------------------------------------------------------------------------
void UI_PauseSeconds(u8 seconds)
{
#if defined(MSXGL)
    u16 i, frames = (u16)seconds * 60;
    for (i = 0; i < frames; i++) Halt();
#elif defined(__SDCC)
    u16 i, frames = (u16)seconds * 60;
    for (i = 0; i < frames; i++) Bios_WaitFrame();
#else
    (void)seconds;
#endif
}
