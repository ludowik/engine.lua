#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <SDL3/SDL.h>

#include <lua/lua.hpp>

//int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow) {
int main(int argc, char* argv[]) {
    int status;
    lua_State *L;

    L = luaL_newstate(); // open Lua
    if (!L)
    {
        return -1; // Checks that Lua started up
    }

    luaL_openlibs(L); // load Lua libraries
    // if (argc > 1)
    {
        chdir("/Users/lca/Dev/engine.lua");
        status = luaL_loadfile(L, "main.lua"); // argv[1]); // load Lua script
        
        if (status)
        {
            /* If something went wrong, error message is at the top of */
            /* the stack */
            fprintf(stderr, "Couldn't load file: %s\n", lua_tostring(L, -1));
            exit(1);
        }

        int ret = lua_pcall(L, 0, 0, 0);       // tell Lua to run the script
        if (ret != 0)
        {
            fprintf(stderr, "%s\n", lua_tostring(L, -1)); // tell us what mistake we made
            return 1;
        }
    }

    lua_close(L); // Close Lua
    return 0;
}
