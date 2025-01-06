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
if not result then
    sdl.SDL_Log("Could not init SDL: %s", sdl.SDL_GetError())
    return -1
end

-- create window
local window = sdl.SDL_CreateWindow("", 640, 480, 0)
if window == nil then
    sdl.SDL_Log("Could not create a window: %s", sdl.SDL_GetError())
    return -1
end

-- create renderer
local renderer = sdl.SDL_CreateRenderer(window, nil)
print('create renderer....')
if renderer == nil then
    sdl.SDL_Log("Could not create a renderer: %s", sdl.SDL_GetError())
    return -1
end

Engine.load()

local event = ffi.new('SDL_Event')
while true do
    sdl.SDL_PollEvent(event)
    if event.type == sdl.SDL_EVENT_WINDOW_CLOSE_REQUESTED then
        break

    elseif event.type == sdl.SDL_EVENT_KEY_DOWN then
        if event.keyboard.scancode == sdl.SDL_SCANCODE_ESCAPE then
            break
        end
    end

    Engine.update(1/60)
    Engine.draw()
end

sdl.SDL_DestroyRenderer(renderer)
sdl.SDL_DestroyWindow(window)
sdl.SDL_Quit()
