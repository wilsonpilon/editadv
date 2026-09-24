// _____________________________________________________________________________
//
//  Parser Module Implementation (Capítulo 4, 5 e 7)
// _____________________________________________________________________________

#include "parser.h"

#if defined(MSXGL)
    #include "core.h"
    #include "string.h"
#else
    #include <string.h>
    #include <ctype.h>
#endif

// Tabela de nomes padrão dos 34 verbos pré-definidos do sistema (Capítulo 4.1)
static const char* const g_DefaultVerbs[34] = {
    "NORTE/N",
    "SUL/S",
    "LESTE/L",
    "OESTE/O",
    "GRAVE",
    "RECUPERE",
    "ENTRE",
    "SUBA",
    "SAIA",
    "DESCA",
    "HORAS",
    "QUANTO",
    "TEMOS/INV/I",
    "RECOMECE/REINICIE",
    "HA",
    "GARIMPE",
    "PENSE",
    "GRITE",
    "CORRA",
    "PEGUE/PEGAR/APANHE",
    "COLOQUE/PONHA/GUARDE",
    "TROQUE",
    "COMPRE",
    "ROUBE",
    "TIRE",
    "QUEBRE",
    "SOLTE/LARGUE/DEIXE",
    "EXAMINE/OLHE/VER/L",
    "PROCURE/BUSQUE",
    "OFERECA/DOE/DE",
    "FACA/CONSTRUA",
    "JOGUE/ATIRE",
    "CONSERTE/REPARE",
    "VENDA"
};

// Compara uma palavra com uma lista de sinônimos separados por barra: "NOME/SIN1/SIN2"
static bool MatchWord(const char* word, const char* synonyms)
{
    const char* p;
    const char* start;
    u8 wlen, slen;

    if (word == NULL || synonyms == NULL) return FALSE;
    wlen = 0;
    while (word[wlen]) wlen++;
    if (wlen == 0) return FALSE;

    p = synonyms;
    while (*p)
    {
        start = p;
        while (*p && *p != '/') p++;
        slen = (u8)(p - start);

        if (wlen == slen)
        {
            u8 i;
            bool match = TRUE;
            for (i = 0; i < wlen; i++)
            {
                if (word[i] != start[i])
                {
                    match = FALSE;
                    break;
                }
            }
            if (match) return TRUE;
        }

        if (*p == '/') p++;
    }

    return FALSE;
}

static u8 StrLen(const char* s)
{
    u8 len = 0;
    if (s == NULL) return 0;
    while (*s++) len++;
    return len;
}

static bool StrEqual(const char* s1, const char* s2)
{
    if (s1 == NULL || s2 == NULL) return FALSE;
    while (*s1 && (*s1 == *s2)) { s1++; s2++; }
    return (*s1 == *s2);
}

static void StrCat(char* dest, const char* src, u8 max_len)
{
    u8 dlen = StrLen(dest);
    if (dest == NULL || src == NULL) return;
    while (*src && dlen < (max_len - 1))
    {
        dest[dlen++] = *src++;
    }
    dest[dlen] = '\0';
}

// -----------------------------------------------------------------------------
// Parser_IsNoiseWord
// -----------------------------------------------------------------------------
bool Parser_IsNoiseWord(const char* word)
{
    static const char* const noise[] = {
        "A", "O", "AS", "OS", "UM", "UMA", "UNS", "UMAS",
        "DE", "DO", "DA", "DOS", "DAS",
        "EM", "NO", "NA", "NOS", "NAS",
        "PARA", "PRA", "COM", "POR", NULL
    };
    u8 i = 0;
    while (noise[i] != NULL)
    {
        if (StrEqual(word, noise[i])) return TRUE;
        i++;
    }
    return FALSE;
}

// -----------------------------------------------------------------------------
// Parser_FindVerb
// -----------------------------------------------------------------------------
static u8 Parser_FindVerb(const char* word)
{
    u8 i;
    for (i = 0; i < 34; i++)
    {
        if (MatchWord(word, g_DefaultVerbs[i]))
        {
            return (i + 1);
        }
    }
    return 0;
}

// -----------------------------------------------------------------------------
// Parser_FindObject
// -----------------------------------------------------------------------------
static u8 Parser_FindObject(const char* word, const Game_Database* db)
{
    u8 i;
    if (db == NULL || db->objetos == NULL) return 0;

    for (i = 0; i < db->num_objetos; i++)
    {
        const Game_Object* obj = db->objetos[i];
        if (obj != NULL && obj->nome != NULL)
        {
            if (MatchWord(word, obj->nome))
            {
                return obj->id;
            }
        }
    }
    return 0;
}

// -----------------------------------------------------------------------------
// Parser_Parse
// -----------------------------------------------------------------------------
bool Parser_Parse(const char* input, const Game_Database* db, Game_State* state, char* parsed_echo, u8 echo_max_len)
{
    char word[32];
    u8 word_idx = 0;
    u8 meaningful_words = 0;
    const char* p = input;

    state->verbo_atual = 0;
    state->obj_buffer[0] = 0;
    state->obj_buffer[1] = 0;

    if (parsed_echo != NULL && echo_max_len > 0)
    {
        parsed_echo[0] = '\0';
    }

    if (input == NULL) return FALSE;

    while (*p)
    {
        // Pula espaços
        while (*p == ' ' || *p == '\t' || *p == '\r' || *p == '\n') p++;
        if (*p == '\0') break;

        // Extrai próxima palavra
        word_idx = 0;
        while (*p && *p != ' ' && *p != '\t' && *p != '\r' && *p != '\n')
        {
            if (word_idx < (sizeof(word) - 1))
            {
                word[word_idx++] = *p;
            }
            p++;
        }
        word[word_idx] = '\0';

        // Verifica se é palavra de ruído / conectivo
        if (Parser_IsNoiseWord(word))
        {
            continue;
        }

        // Primeira palavra significativa: VERBO
        if (meaningful_words == 0)
        {
            state->verbo_atual = Parser_FindVerb(word);
            meaningful_words++;

            if (parsed_echo != NULL && state->verbo_atual > 0)
            {
                // Copia o primeiro nome do verbo para o eco
                const char* vname = g_DefaultVerbs[state->verbo_atual - 1];
                u8 k = 0;
                while (vname[k] && vname[k] != '/' && k < (echo_max_len - 1))
                {
                    parsed_echo[k] = vname[k];
                    k++;
                }
                parsed_echo[k] = '\0';
            }
        }
        // Segunda palavra significativa: OBJETO 1
        else if (meaningful_words == 1)
        {
            state->obj_buffer[0] = Parser_FindObject(word, db);
            meaningful_words++;

            if (parsed_echo != NULL && state->obj_buffer[0] > 0)
            {
                u8 cur = StrLen(parsed_echo);
                if (cur < (echo_max_len - 2))
                {
                    parsed_echo[cur++] = ' ';
                    parsed_echo[cur] = '\0';
                    StrCat(parsed_echo, word, echo_max_len);
                }
            }
        }
        // Terceira palavra significativa: OBJETO 2
        else if (meaningful_words == 2)
        {
            state->obj_buffer[1] = Parser_FindObject(word, db);
            meaningful_words++;

            if (parsed_echo != NULL && state->obj_buffer[1] > 0)
            {
                u8 cur = StrLen(parsed_echo);
                if (cur < (echo_max_len - 2))
                {
                    parsed_echo[cur++] = ' ';
                    parsed_echo[cur] = '\0';
                    StrCat(parsed_echo, word, echo_max_len);
                }
            }
            break;
        }
    }

    return (state->verbo_atual > 0);
}
