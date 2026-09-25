// _____________________________________________________________________________
//
//  Clean-Room Reverse-Engineered Adventure Engine for MSX
//  Main Entry Point
// _____________________________________________________________________________

#include "game_types.h"
#include "game_data.h"
#include "game_loop.h"
#include "ui.h"

#if defined(MSXGL)
    #include "msxgl.h"
#endif

static Game_State g_GameState;

void main(void)
{
    while (1)
    {
        Game_Run(&g_GameDatabase, &g_GameState);

        // Quando a partida termina (vitória ou derrota), nunca reinicie o hardware abruptamente
        UI_NewLineCenter();
        UI_PrintCenter("[ Pressione tecla para recome\207ar ]");
#if defined(MSXGL)
        BIOS_GetCharacter();
#elif defined(__SDCC)
        Bios_Chget();
#endif
    }
}

