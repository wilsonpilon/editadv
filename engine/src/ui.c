// _____________________________________________________________________________
//
//  UI Module Implementation - 3-Field Screen Layout (Capítulo 2)
// _____________________________________________________________________________

#include "ui.h"

#if defined(MSXGL)
    #include "msxgl.h"
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

static u8 g_CenterCursorX = 0;
static u8 g_CenterCursorY = SCREEN_ROW_CENTER_START;

// -----------------------------------------------------------------------------
// UI_Init
// -----------------------------------------------------------------------------
void UI_Init(void)
{
#if defined(MSXGL)
    VDP_SetMode(VDP_MODE_SCREEN0);
    VDP_ClearVRAM();
    Print_SetColor(COLOR_WHITE, COLOR_BLACK);
#elif defined(__SDCC)
    Bios_InitText();
    Bios_Cls();
#endif
    UI_DrawLayout();
    UI_ClearCenter();
}

// -----------------------------------------------------------------------------
// UI_DrawLayout
// Desenha as barras divisórias nas linhas 1 e 21
// -----------------------------------------------------------------------------
void UI_DrawLayout(void)
{
    u8 x;
#if defined(MSXGL)
    Print_SetPosition(0, SCREEN_ROW_DIVIDER_1);
    for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Print_DrawChar('-');

    Print_SetPosition(0, SCREEN_ROW_DIVIDER_2);
    for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Print_DrawChar('-');
#elif defined(__SDCC)
    Bios_SetCursor(0, SCREEN_ROW_DIVIDER_1);
    for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput('-');

    Bios_SetCursor(0, SCREEN_ROW_DIVIDER_2);
    for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput('-');
#endif
}

// -----------------------------------------------------------------------------
// UI_SetTopText
// -----------------------------------------------------------------------------
void UI_SetTopText(const char* text)
{
    u8 x;
#if defined(MSXGL)
    Print_SetPosition(0, SCREEN_ROW_TOP_START);
    for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Print_DrawChar(' ');
    if (text != NULL)
    {
        Print_SetPosition(1, SCREEN_ROW_TOP_START);
        Print_DrawText(text);
    }
#elif defined(__SDCC)
    Bios_SetCursor(0, SCREEN_ROW_TOP_START);
    for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput(' ');
    if (text != NULL)
    {
        Bios_SetCursor(1, SCREEN_ROW_TOP_START);
        while (*text) Bios_Chput(*text++);
    }
#else
    if (text) printf("[TOPO] %s\n", text);
#endif
}

// -----------------------------------------------------------------------------
// UI_ClearCenter
// -----------------------------------------------------------------------------
void UI_ClearCenter(void)
{
    u8 y, x;
#if defined(MSXGL)
    for (y = SCREEN_ROW_CENTER_START; y <= SCREEN_ROW_CENTER_END; y++)
    {
        Print_SetPosition(0, y);
        for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Print_DrawChar(' ');
    }
#elif defined(__SDCC)
    for (y = SCREEN_ROW_CENTER_START; y <= SCREEN_ROW_CENTER_END; y++)
    {
        Bios_SetCursor(0, y);
        for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput(' ');
    }
#else
    printf("\n--- [CENTRO LIMPO] ---\n");
#endif
    g_CenterCursorX = 0;
    g_CenterCursorY = SCREEN_ROW_CENTER_START;
}

// -----------------------------------------------------------------------------
// UI_NewLineCenter
// -----------------------------------------------------------------------------
void UI_NewLineCenter(void)
{
    g_CenterCursorX = 0;
    g_CenterCursorY++;

    if (g_CenterCursorY > SCREEN_ROW_CENTER_END)
    {
#if defined(MSXGL)
        Print_SetPosition(0, SCREEN_ROW_CENTER_END);
        Print_DrawText("-- Pressione uma tecla --");
        BIOS_GetCharacter();
        UI_ClearCenter();
#elif defined(__SDCC)
        Bios_SetCursor(0, SCREEN_ROW_CENTER_END);
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
// -----------------------------------------------------------------------------
void UI_PrintCharCenter(char c)
{
    if (c == '\n' || c == '\r')
    {
        UI_NewLineCenter();
        return;
    }

#if defined(MSXGL)
    Print_SetPosition(g_CenterCursorX, g_CenterCursorY);
    Print_DrawChar(c);
#elif defined(__SDCC)
    Bios_SetCursor(g_CenterCursorX, g_CenterCursorY);
    Bios_Chput(c);
#else
    putchar(c);
#endif

    g_CenterCursorX++;
    if (g_CenterCursorX >= SCREEN_TEXT_WIDTH)
    {
        UI_NewLineCenter();
    }
}

// -----------------------------------------------------------------------------
// UI_PrintCenter
// -----------------------------------------------------------------------------
void UI_PrintCenter(const char* text)
{
    if (text == NULL) return;

    while (*text)
    {
        UI_PrintCharCenter(*text);
        text++;
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

// -----------------------------------------------------------------------------
// UI_ReadLine
// -----------------------------------------------------------------------------
void UI_ReadLine(char* buffer, u8 max_len)
{
    u8 len = 0;
    u8 x;

    if (max_len == 0 || buffer == NULL) return;

#if defined(MSXGL) || defined(__SDCC)
    // Limpa a área de prompt inferior
    #if defined(MSXGL)
        Print_SetPosition(0, SCREEN_ROW_BOTTOM_START);
        for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Print_DrawChar(' ');
        Print_SetPosition(0, SCREEN_ROW_BOTTOM_START);
        Print_DrawText("> ");
    #else
        Bios_SetCursor(0, SCREEN_ROW_BOTTOM_START);
        for (x = 0; x < SCREEN_TEXT_WIDTH; x++) Bios_Chput(' ');
        Bios_SetCursor(0, SCREEN_ROW_BOTTOM_START);
        Bios_Chput('>');
        Bios_Chput(' ');
    #endif

    while (TRUE)
    {
        char ch;
        #if defined(MSXGL)
            ch = (char)BIOS_GetCharacter();
        #else
            ch = Bios_Chget();
        #endif

        if (ch == 13 || ch == 10) // ENTER
        {
            break;
        }
        else if (ch == 8 || ch == 127) // Backspace / DEL
        {
            if (len > 0)
            {
                len--;
                #if defined(MSXGL)
                    Print_SetPosition(2 + len, SCREEN_ROW_BOTTOM_START);
                    Print_DrawChar(' ');
                #else
                    Bios_SetCursor(2 + len, SCREEN_ROW_BOTTOM_START);
                    Bios_Chput(' ');
                #endif
            }
        }
        else if (ch >= 32 && ch < 127 && len < (max_len - 1) && len < (SCREEN_TEXT_WIDTH - 4))
        {
            if (ch >= 'a' && ch <= 'z')
            {
                ch = ch - ('a' - 'A');
            }
            buffer[len] = ch;
            #if defined(MSXGL)
                Print_SetPosition(2 + len, SCREEN_ROW_BOTTOM_START);
                Print_DrawChar(ch);
            #else
                Bios_SetCursor(2 + len, SCREEN_ROW_BOTTOM_START);
                Bios_Chput(ch);
            #endif
            len++;
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
