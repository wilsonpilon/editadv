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
    Game_Run(&g_GameDatabase, &g_GameState);

#if defined(MSXGL)
    BIOS_Exit(0);
#endif
}
