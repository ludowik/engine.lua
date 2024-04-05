if arg and arg[#arg] == "vsc_debug" then
    local lldebugger = require "lldebugger"
    lldebugger.start()
end

print(_VERSION)

require 'ffi'
sdl = require 'sdl_interface'
require 'engine'

-- init SDL
local result = sdl.SDL_Init(sdl.SDL_INIT_EVERYTHING)
if result ~= 0 then
    sdl.SDL_Log("Could not init SDL: %s", sdl.SDL_GetError())
    return -1
end

-- create window
local window = sdl.SDL_CreateWindow("", sdl.SDL_WINDOWPOS_CENTERED, sdl.SDL_WINDOWPOS_CENTERED, 640, 480, 0)
if window == nullptr then
    sdl.SDL_Log("Could not create a window: %s", sdl.SDL_GetError())
    return -1
end
print(sdl.SDL_GetWindowID(window))

-- create renderer
local renderer = sdl.SDL_CreateRenderer(window, -1, sdl.SDL_RENDERER_ACCELERATED);
if renderer == nullptr then
    sdl.SDL_Log("Could not create a renderer: %s", sdl.SDL_GetError())
    return -1
end

Engine.load()

local event = ffi.new('SDL_Event')
while true do
    sdl.SDL_PollEvent(event)
    if event.type == sdl.SDL_WINDOWEVENT then
        if event.window.event == sdl.SDL_WINDOWEVENT_CLOSE then
            break
        end

    elseif event.type == sdl.SDL_KEYDOWN then
        if event.keyboard.keysym.scancode == sdl.SDL_SCANCODE_ESCAPE then
            break
        end
    end

    Engine.update(1/60)
    Engine.draw()
end

sdl.SDL_DestroyRenderer(renderer)
sdl.SDL_DestroyWindow(window)
sdl.SDL_Quit()
