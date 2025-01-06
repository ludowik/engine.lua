-- https://github.com/torch/sdl2-ffi/blob/master/cdefs.lua

ffi = ffi or require 'ffi'

local sdl = ffi.load('SDL3.framework/SDL3')
ffi.cdef[[
    typedef int8_t Sint8;
    typedef uint8_t Uint8;
    typedef int16_t Sint16;
    typedef uint16_t Uint16;
    typedef int32_t Sint32;
    typedef uint32_t Uint32;
    typedef int64_t Sint64;
    typedef uint64_t Uint64;

    typedef struct SDL_Window SDL_Window;
    typedef struct SDL_Renderer SDL_Renderer;
    typedef Uint32 SDL_WindowID;

    bool SDL_Init(Uint32 flags);
    void SDL_Quit(void);

    enum {
        SDL_INIT_TIMER          = 0x00000001,
        SDL_INIT_AUDIO          = 0x00000010,
        SDL_INIT_VIDEO          = 0x00000020,
        SDL_INIT_JOYSTICK       = 0x00000200,
        SDL_INIT_HAPTIC         = 0x00001000,
        SDL_INIT_GAMECONTROLLER = 0x00002000,
        SDL_INIT_EVENTS         = 0x00004000,
        SDL_INIT_NOPARACHUTE    = 0x00100000,
        SDL_INIT_EVERYTHING     = ( SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_EVENTS | SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC | SDL_INIT_GAMECONTROLLER )
    };

    typedef enum {
        SDL_EVENT_FIRST     = 0,     /**< Unused (do not remove) */
    
        /* Application events */
        SDL_EVENT_QUIT           = 0x100, /**< User-requested quit */
    
        /* These application events have special meaning on iOS and Android, see README-ios.md and README-android.md for details */
        SDL_EVENT_TERMINATING,      /**< The application is being terminated by the OS. This event must be handled in a callback set with SDL_AddEventWatch().
                                         Called on iOS in applicationWillTerminate()
                                         Called on Android in onDestroy()
                                    */
        SDL_EVENT_LOW_MEMORY,       /**< The application is low on memory, free memory if possible. This event must be handled in a callback set with SDL_AddEventWatch().
                                         Called on iOS in applicationDidReceiveMemoryWarning()
                                         Called on Android in onTrimMemory()
                                    */
        SDL_EVENT_WILL_ENTER_BACKGROUND, /**< The application is about to enter the background. This event must be handled in a callback set with SDL_AddEventWatch().
                                         Called on iOS in applicationWillResignActive()
                                         Called on Android in onPause()
                                    */
        SDL_EVENT_DID_ENTER_BACKGROUND, /**< The application did enter the background and may not get CPU for some time. This event must be handled in a callback set with SDL_AddEventWatch().
                                         Called on iOS in applicationDidEnterBackground()
                                         Called on Android in onPause()
                                    */
        SDL_EVENT_WILL_ENTER_FOREGROUND, /**< The application is about to enter the foreground. This event must be handled in a callback set with SDL_AddEventWatch().
                                         Called on iOS in applicationWillEnterForeground()
                                         Called on Android in onResume()
                                    */
        SDL_EVENT_DID_ENTER_FOREGROUND, /**< The application is now interactive. This event must be handled in a callback set with SDL_AddEventWatch().
                                         Called on iOS in applicationDidBecomeActive()
                                         Called on Android in onResume()
                                    */
    
        SDL_EVENT_LOCALE_CHANGED,  /**< The user's locale preferences have changed. */
    
        SDL_EVENT_SYSTEM_THEME_CHANGED, /**< The system theme changed */
    
        /* Display events */
        /* 0x150 was SDL_DISPLAYEVENT, reserve the number for sdl2-compat */
        SDL_EVENT_DISPLAY_ORIENTATION = 0x151,   /**< Display orientation has changed to data1 */
        SDL_EVENT_DISPLAY_ADDED,                 /**< Display has been added to the system */
        SDL_EVENT_DISPLAY_REMOVED,               /**< Display has been removed from the system */
        SDL_EVENT_DISPLAY_MOVED,                 /**< Display has changed position */
        SDL_EVENT_DISPLAY_DESKTOP_MODE_CHANGED,  /**< Display has changed desktop mode */
        SDL_EVENT_DISPLAY_CURRENT_MODE_CHANGED,  /**< Display has changed current mode */
        SDL_EVENT_DISPLAY_CONTENT_SCALE_CHANGED, /**< Display has changed content scale */
        SDL_EVENT_DISPLAY_FIRST = SDL_EVENT_DISPLAY_ORIENTATION,
        SDL_EVENT_DISPLAY_LAST = SDL_EVENT_DISPLAY_CONTENT_SCALE_CHANGED,
    
        /* Window events */
        /* 0x200 was SDL_WINDOWEVENT, reserve the number for sdl2-compat */
        /* 0x201 was SDL_EVENT_SYSWM, reserve the number for sdl2-compat */
        SDL_EVENT_WINDOW_SHOWN = 0x202,     /**< Window has been shown */
        SDL_EVENT_WINDOW_HIDDEN,            /**< Window has been hidden */
        SDL_EVENT_WINDOW_EXPOSED,           /**< Window has been exposed and should be redrawn, and can be redrawn directly from event watchers for this event */
        SDL_EVENT_WINDOW_MOVED,             /**< Window has been moved to data1, data2 */
        SDL_EVENT_WINDOW_RESIZED,           /**< Window has been resized to data1xdata2 */
        SDL_EVENT_WINDOW_PIXEL_SIZE_CHANGED,/**< The pixel size of the window has changed to data1xdata2 */
        SDL_EVENT_WINDOW_METAL_VIEW_RESIZED,/**< The pixel size of a Metal view associated with the window has changed */
        SDL_EVENT_WINDOW_MINIMIZED,         /**< Window has been minimized */
        SDL_EVENT_WINDOW_MAXIMIZED,         /**< Window has been maximized */
        SDL_EVENT_WINDOW_RESTORED,          /**< Window has been restored to normal size and position */
        SDL_EVENT_WINDOW_MOUSE_ENTER,       /**< Window has gained mouse focus */
        SDL_EVENT_WINDOW_MOUSE_LEAVE,       /**< Window has lost mouse focus */
        SDL_EVENT_WINDOW_FOCUS_GAINED,      /**< Window has gained keyboard focus */
        SDL_EVENT_WINDOW_FOCUS_LOST,        /**< Window has lost keyboard focus */
        SDL_EVENT_WINDOW_CLOSE_REQUESTED,   /**< The window manager requests that the window be closed */
        SDL_EVENT_WINDOW_HIT_TEST,          /**< Window had a hit test that wasn't SDL_HITTEST_NORMAL */
        SDL_EVENT_WINDOW_ICCPROF_CHANGED,   /**< The ICC profile of the window's display has changed */
        SDL_EVENT_WINDOW_DISPLAY_CHANGED,   /**< Window has been moved to display data1 */
        SDL_EVENT_WINDOW_DISPLAY_SCALE_CHANGED, /**< Window display scale has been changed */
        SDL_EVENT_WINDOW_SAFE_AREA_CHANGED, /**< The window safe area has been changed */
        SDL_EVENT_WINDOW_OCCLUDED,          /**< The window has been occluded */
        SDL_EVENT_WINDOW_ENTER_FULLSCREEN,  /**< The window has entered fullscreen mode */
        SDL_EVENT_WINDOW_LEAVE_FULLSCREEN,  /**< The window has left fullscreen mode */
        SDL_EVENT_WINDOW_DESTROYED,         /**< The window with the associated ID is being or has been destroyed. If this message is being handled
                                                 in an event watcher, the window handle is still valid and can still be used to retrieve any properties
                                                 associated with the window. Otherwise, the handle has already been destroyed and all resources
                                                 associated with it are invalid */
        SDL_EVENT_WINDOW_HDR_STATE_CHANGED, /**< Window HDR properties have changed */
        SDL_EVENT_WINDOW_FIRST = SDL_EVENT_WINDOW_SHOWN,
        SDL_EVENT_WINDOW_LAST = SDL_EVENT_WINDOW_HDR_STATE_CHANGED,
    
        /* Keyboard events */
        SDL_EVENT_KEY_DOWN        = 0x300, /**< Key pressed */
        SDL_EVENT_KEY_UP,                  /**< Key released */
        SDL_EVENT_TEXT_EDITING,            /**< Keyboard text editing (composition) */
        SDL_EVENT_TEXT_INPUT,              /**< Keyboard text input */
        SDL_EVENT_KEYMAP_CHANGED,          /**< Keymap changed due to a system event such as an
                                                input language or keyboard layout change. */
        SDL_EVENT_KEYBOARD_ADDED,          /**< A new keyboard has been inserted into the system */
        SDL_EVENT_KEYBOARD_REMOVED,        /**< A keyboard has been removed */
        SDL_EVENT_TEXT_EDITING_CANDIDATES, /**< Keyboard text editing candidates */
    
        /* Mouse events */
        SDL_EVENT_MOUSE_MOTION    = 0x400, /**< Mouse moved */
        SDL_EVENT_MOUSE_BUTTON_DOWN,       /**< Mouse button pressed */
        SDL_EVENT_MOUSE_BUTTON_UP,         /**< Mouse button released */
        SDL_EVENT_MOUSE_WHEEL,             /**< Mouse wheel motion */
        SDL_EVENT_MOUSE_ADDED,             /**< A new mouse has been inserted into the system */
        SDL_EVENT_MOUSE_REMOVED,           /**< A mouse has been removed */
    
        /* Joystick events */
        SDL_EVENT_JOYSTICK_AXIS_MOTION  = 0x600, /**< Joystick axis motion */
        SDL_EVENT_JOYSTICK_BALL_MOTION,          /**< Joystick trackball motion */
        SDL_EVENT_JOYSTICK_HAT_MOTION,           /**< Joystick hat position change */
        SDL_EVENT_JOYSTICK_BUTTON_DOWN,          /**< Joystick button pressed */
        SDL_EVENT_JOYSTICK_BUTTON_UP,            /**< Joystick button released */
        SDL_EVENT_JOYSTICK_ADDED,                /**< A new joystick has been inserted into the system */
        SDL_EVENT_JOYSTICK_REMOVED,              /**< An opened joystick has been removed */
        SDL_EVENT_JOYSTICK_BATTERY_UPDATED,      /**< Joystick battery level change */
        SDL_EVENT_JOYSTICK_UPDATE_COMPLETE,      /**< Joystick update is complete */
    
        /* Gamepad events */
        SDL_EVENT_GAMEPAD_AXIS_MOTION  = 0x650, /**< Gamepad axis motion */
        SDL_EVENT_GAMEPAD_BUTTON_DOWN,          /**< Gamepad button pressed */
        SDL_EVENT_GAMEPAD_BUTTON_UP,            /**< Gamepad button released */
        SDL_EVENT_GAMEPAD_ADDED,                /**< A new gamepad has been inserted into the system */
        SDL_EVENT_GAMEPAD_REMOVED,              /**< A gamepad has been removed */
        SDL_EVENT_GAMEPAD_REMAPPED,             /**< The gamepad mapping was updated */
        SDL_EVENT_GAMEPAD_TOUCHPAD_DOWN,        /**< Gamepad touchpad was touched */
        SDL_EVENT_GAMEPAD_TOUCHPAD_MOTION,      /**< Gamepad touchpad finger was moved */
        SDL_EVENT_GAMEPAD_TOUCHPAD_UP,          /**< Gamepad touchpad finger was lifted */
        SDL_EVENT_GAMEPAD_SENSOR_UPDATE,        /**< Gamepad sensor was updated */
        SDL_EVENT_GAMEPAD_UPDATE_COMPLETE,      /**< Gamepad update is complete */
        SDL_EVENT_GAMEPAD_STEAM_HANDLE_UPDATED,  /**< Gamepad Steam handle has changed */
    
        /* Touch events */
        SDL_EVENT_FINGER_DOWN      = 0x700,
        SDL_EVENT_FINGER_UP,
        SDL_EVENT_FINGER_MOTION,
        SDL_EVENT_FINGER_CANCELED,
    
        /* 0x800, 0x801, and 0x802 were the Gesture events from SDL2. Do not reuse these values! sdl2-compat needs them! */
    
        /* Clipboard events */
        SDL_EVENT_CLIPBOARD_UPDATE = 0x900, /**< The clipboard or primary selection changed */
    
        /* Drag and drop events */
        SDL_EVENT_DROP_FILE        = 0x1000, /**< The system requests a file open */
        SDL_EVENT_DROP_TEXT,                 /**< text/plain drag-and-drop event */
        SDL_EVENT_DROP_BEGIN,                /**< A new set of drops is beginning (NULL filename) */
        SDL_EVENT_DROP_COMPLETE,             /**< Current set of drops is now complete (NULL filename) */
        SDL_EVENT_DROP_POSITION,             /**< Position while moving over the window */
    
        /* Audio hotplug events */
        SDL_EVENT_AUDIO_DEVICE_ADDED = 0x1100,  /**< A new audio device is available */
        SDL_EVENT_AUDIO_DEVICE_REMOVED,         /**< An audio device has been removed. */
        SDL_EVENT_AUDIO_DEVICE_FORMAT_CHANGED,  /**< An audio device's format has been changed by the system. */
    
        /* Sensor events */
        SDL_EVENT_SENSOR_UPDATE = 0x1200,     /**< A sensor was updated */
    
        /* Pressure-sensitive pen events */
        SDL_EVENT_PEN_PROXIMITY_IN = 0x1300,  /**< Pressure-sensitive pen has become available */
        SDL_EVENT_PEN_PROXIMITY_OUT,          /**< Pressure-sensitive pen has become unavailable */
        SDL_EVENT_PEN_DOWN,                   /**< Pressure-sensitive pen touched drawing surface */
        SDL_EVENT_PEN_UP,                     /**< Pressure-sensitive pen stopped touching drawing surface */
        SDL_EVENT_PEN_BUTTON_DOWN,            /**< Pressure-sensitive pen button pressed */
        SDL_EVENT_PEN_BUTTON_UP,              /**< Pressure-sensitive pen button released */
        SDL_EVENT_PEN_MOTION,                 /**< Pressure-sensitive pen is moving on the tablet */
        SDL_EVENT_PEN_AXIS,                   /**< Pressure-sensitive pen angle/pressure/etc changed */
    
        /* Camera hotplug events */
        SDL_EVENT_CAMERA_DEVICE_ADDED = 0x1400,  /**< A new camera device is available */
        SDL_EVENT_CAMERA_DEVICE_REMOVED,         /**< A camera device has been removed. */
        SDL_EVENT_CAMERA_DEVICE_APPROVED,        /**< A camera device has been approved for use by the user. */
        SDL_EVENT_CAMERA_DEVICE_DENIED,          /**< A camera device has been denied for use by the user. */
    
        /* Render events */
        SDL_EVENT_RENDER_TARGETS_RESET = 0x2000, /**< The render targets have been reset and their contents need to be updated */
        SDL_EVENT_RENDER_DEVICE_RESET, /**< The device has been reset and all textures need to be recreated */
        SDL_EVENT_RENDER_DEVICE_LOST, /**< The device has been lost and can't be recovered. */
    
        /* Reserved events for private platforms */
        SDL_EVENT_PRIVATE0 = 0x4000,
        SDL_EVENT_PRIVATE1,
        SDL_EVENT_PRIVATE2,
        SDL_EVENT_PRIVATE3,
    
        /* Internal events */
        SDL_EVENT_POLL_SENTINEL = 0x7F00, /**< Signals the end of an event poll cycle */
    
        /** Events SDL_EVENT_USER through SDL_EVENT_LAST are for your use,
         *  and should be allocated with SDL_RegisterEvents()
         */
        SDL_EVENT_USER    = 0x8000,
    
        /**
         *  This last event is only for bounding internal arrays
         */
        SDL_EVENT_LAST    = 0xFFFF,
    
        /* This just makes sure the enum is the size of Uint32 */
        SDL_EVENT_ENUM_PADDING = 0x7FFFFFFF
    } SDL_EventType;

    typedef struct SDL_WindowEvent {
        SDL_EventType type; /**< SDL_EVENT_WINDOW_* */
        Uint32 reserved;
        Uint64 timestamp;   /**< In nanoseconds, populated using SDL_GetTicksNS() */
        SDL_WindowID windowID; /**< The associated window */
        Sint32 data1;       /**< event dependent data */
        Sint32 data2;       /**< event dependent data */
    } SDL_WindowEvent;

    typedef enum {
        SDL_SCANCODE_UNKNOWN = 0,
        SDL_SCANCODE_A = 4,
        SDL_SCANCODE_B = 5,
        SDL_SCANCODE_C = 6,
        SDL_SCANCODE_D = 7,
        SDL_SCANCODE_E = 8,
        SDL_SCANCODE_F = 9,
        SDL_SCANCODE_G = 10,
        SDL_SCANCODE_H = 11,
        SDL_SCANCODE_I = 12,
        SDL_SCANCODE_J = 13,
        SDL_SCANCODE_K = 14,
        SDL_SCANCODE_L = 15,
        SDL_SCANCODE_M = 16,
        SDL_SCANCODE_N = 17,
        SDL_SCANCODE_O = 18,
        SDL_SCANCODE_P = 19,
        SDL_SCANCODE_Q = 20,
        SDL_SCANCODE_R = 21,
        SDL_SCANCODE_S = 22,
        SDL_SCANCODE_T = 23,
        SDL_SCANCODE_U = 24,
        SDL_SCANCODE_V = 25,
        SDL_SCANCODE_W = 26,
        SDL_SCANCODE_X = 27,
        SDL_SCANCODE_Y = 28,
        SDL_SCANCODE_Z = 29,
        SDL_SCANCODE_1 = 30,
        SDL_SCANCODE_2 = 31,
        SDL_SCANCODE_3 = 32,
        SDL_SCANCODE_4 = 33,
        SDL_SCANCODE_5 = 34,
        SDL_SCANCODE_6 = 35,
        SDL_SCANCODE_7 = 36,
        SDL_SCANCODE_8 = 37,
        SDL_SCANCODE_9 = 38,
        SDL_SCANCODE_0 = 39,
        SDL_SCANCODE_RETURN = 40,
        SDL_SCANCODE_ESCAPE = 41,
        SDL_SCANCODE_BACKSPACE = 42,
        SDL_SCANCODE_TAB = 43,
        SDL_SCANCODE_SPACE = 44,
        SDL_SCANCODE_MINUS = 45,
        SDL_SCANCODE_EQUALS = 46,
        SDL_SCANCODE_LEFTBRACKET = 47,
        SDL_SCANCODE_RIGHTBRACKET = 48,
        SDL_SCANCODE_BACKSLASH = 49,
        SDL_SCANCODE_NONUSHASH = 50,
        SDL_SCANCODE_SEMICOLON = 51,
        SDL_SCANCODE_APOSTROPHE = 52,
        SDL_SCANCODE_GRAVE = 53,
        SDL_SCANCODE_COMMA = 54,
        SDL_SCANCODE_PERIOD = 55,
        SDL_SCANCODE_SLASH = 56,
        SDL_SCANCODE_CAPSLOCK = 57,
        SDL_SCANCODE_F1 = 58,
        SDL_SCANCODE_F2 = 59,
        SDL_SCANCODE_F3 = 60,
        SDL_SCANCODE_F4 = 61,
        SDL_SCANCODE_F5 = 62,
        SDL_SCANCODE_F6 = 63,
        SDL_SCANCODE_F7 = 64,
        SDL_SCANCODE_F8 = 65,
        SDL_SCANCODE_F9 = 66,
        SDL_SCANCODE_F10 = 67,
        SDL_SCANCODE_F11 = 68,
        SDL_SCANCODE_F12 = 69,
        SDL_SCANCODE_PRINTSCREEN = 70,
        SDL_SCANCODE_SCROLLLOCK = 71,
        SDL_SCANCODE_PAUSE = 72,
        SDL_SCANCODE_INSERT = 73,
        SDL_SCANCODE_HOME = 74,
        SDL_SCANCODE_PAGEUP = 75,
        SDL_SCANCODE_DELETE = 76,
        SDL_SCANCODE_END = 77,
        SDL_SCANCODE_PAGEDOWN = 78,
        SDL_SCANCODE_RIGHT = 79,
        SDL_SCANCODE_LEFT = 80,
        SDL_SCANCODE_DOWN = 81,
        SDL_SCANCODE_UP = 82,
        SDL_SCANCODE_NUMLOCKCLEAR = 83,
        SDL_SCANCODE_KP_DIVIDE = 84,
        SDL_SCANCODE_KP_MULTIPLY = 85,
        SDL_SCANCODE_KP_MINUS = 86,
        SDL_SCANCODE_KP_PLUS = 87,
        SDL_SCANCODE_KP_ENTER = 88,
        SDL_SCANCODE_KP_1 = 89,
        SDL_SCANCODE_KP_2 = 90,
        SDL_SCANCODE_KP_3 = 91,
        SDL_SCANCODE_KP_4 = 92,
        SDL_SCANCODE_KP_5 = 93,
        SDL_SCANCODE_KP_6 = 94,
        SDL_SCANCODE_KP_7 = 95,
        SDL_SCANCODE_KP_8 = 96,
        SDL_SCANCODE_KP_9 = 97,
        SDL_SCANCODE_KP_0 = 98,
        SDL_SCANCODE_KP_PERIOD = 99,
        SDL_SCANCODE_NONUSBACKSLASH = 100,
        SDL_SCANCODE_APPLICATION = 101,
        SDL_SCANCODE_POWER = 102,
        SDL_SCANCODE_KP_EQUALS = 103,
        SDL_SCANCODE_F13 = 104,
        SDL_SCANCODE_F14 = 105,
        SDL_SCANCODE_F15 = 106,
        SDL_SCANCODE_F16 = 107,
        SDL_SCANCODE_F17 = 108,
        SDL_SCANCODE_F18 = 109,
        SDL_SCANCODE_F19 = 110,
        SDL_SCANCODE_F20 = 111,
        SDL_SCANCODE_F21 = 112,
        SDL_SCANCODE_F22 = 113,
        SDL_SCANCODE_F23 = 114,
        SDL_SCANCODE_F24 = 115,
        SDL_SCANCODE_EXECUTE = 116,
        SDL_SCANCODE_HELP = 117,
        SDL_SCANCODE_MENU = 118,
        SDL_SCANCODE_SELECT = 119,
        SDL_SCANCODE_STOP = 120,
        SDL_SCANCODE_AGAIN = 121,
        SDL_SCANCODE_UNDO = 122,
        SDL_SCANCODE_CUT = 123,
        SDL_SCANCODE_COPY = 124,
        SDL_SCANCODE_PASTE = 125,
        SDL_SCANCODE_FIND = 126,
        SDL_SCANCODE_MUTE = 127,
        SDL_SCANCODE_VOLUMEUP = 128,
        SDL_SCANCODE_VOLUMEDOWN = 129,
        SDL_SCANCODE_KP_COMMA = 133,
        SDL_SCANCODE_KP_EQUALSAS400 = 134,
        SDL_SCANCODE_INTERNATIONAL1 = 135,
        SDL_SCANCODE_INTERNATIONAL2 = 136,
        SDL_SCANCODE_INTERNATIONAL3 = 137,
        SDL_SCANCODE_INTERNATIONAL4 = 138,
        SDL_SCANCODE_INTERNATIONAL5 = 139,
        SDL_SCANCODE_INTERNATIONAL6 = 140,
        SDL_SCANCODE_INTERNATIONAL7 = 141,
        SDL_SCANCODE_INTERNATIONAL8 = 142,
        SDL_SCANCODE_INTERNATIONAL9 = 143,
        SDL_SCANCODE_LANG1 = 144,
        SDL_SCANCODE_LANG2 = 145,
        SDL_SCANCODE_LANG3 = 146,
        SDL_SCANCODE_LANG4 = 147,
        SDL_SCANCODE_LANG5 = 148,
        SDL_SCANCODE_LANG6 = 149,
        SDL_SCANCODE_LANG7 = 150,
        SDL_SCANCODE_LANG8 = 151,
        SDL_SCANCODE_LANG9 = 152,
        SDL_SCANCODE_ALTERASE = 153,
        SDL_SCANCODE_SYSREQ = 154,
        SDL_SCANCODE_CANCEL = 155,
        SDL_SCANCODE_CLEAR = 156,
        SDL_SCANCODE_PRIOR = 157,
        SDL_SCANCODE_RETURN2 = 158,
        SDL_SCANCODE_SEPARATOR = 159,
        SDL_SCANCODE_OUT = 160,
        SDL_SCANCODE_OPER = 161,
        SDL_SCANCODE_CLEARAGAIN = 162,
        SDL_SCANCODE_CRSEL = 163,
        SDL_SCANCODE_EXSEL = 164,
        SDL_SCANCODE_KP_00 = 176,
        SDL_SCANCODE_KP_000 = 177,
        SDL_SCANCODE_THOUSANDSSEPARATOR = 178,
        SDL_SCANCODE_DECIMALSEPARATOR = 179,
        SDL_SCANCODE_CURRENCYUNIT = 180,
        SDL_SCANCODE_CURRENCYSUBUNIT = 181,
        SDL_SCANCODE_KP_LEFTPAREN = 182,
        SDL_SCANCODE_KP_RIGHTPAREN = 183,
        SDL_SCANCODE_KP_LEFTBRACE = 184,
        SDL_SCANCODE_KP_RIGHTBRACE = 185,
        SDL_SCANCODE_KP_TAB = 186,
        SDL_SCANCODE_KP_BACKSPACE = 187,
        SDL_SCANCODE_KP_A = 188,
        SDL_SCANCODE_KP_B = 189,
        SDL_SCANCODE_KP_C = 190,
        SDL_SCANCODE_KP_D = 191,
        SDL_SCANCODE_KP_E = 192,
        SDL_SCANCODE_KP_F = 193,
        SDL_SCANCODE_KP_XOR = 194,
        SDL_SCANCODE_KP_POWER = 195,
        SDL_SCANCODE_KP_PERCENT = 196,
        SDL_SCANCODE_KP_LESS = 197,
        SDL_SCANCODE_KP_GREATER = 198,
        SDL_SCANCODE_KP_AMPERSAND = 199,
        SDL_SCANCODE_KP_DBLAMPERSAND = 200,
        SDL_SCANCODE_KP_VERTICALBAR = 201,
        SDL_SCANCODE_KP_DBLVERTICALBAR = 202,
        SDL_SCANCODE_KP_COLON = 203,
        SDL_SCANCODE_KP_HASH = 204,
        SDL_SCANCODE_KP_SPACE = 205,
        SDL_SCANCODE_KP_AT = 206,
        SDL_SCANCODE_KP_EXCLAM = 207,
        SDL_SCANCODE_KP_MEMSTORE = 208,
        SDL_SCANCODE_KP_MEMRECALL = 209,
        SDL_SCANCODE_KP_MEMCLEAR = 210,
        SDL_SCANCODE_KP_MEMADD = 211,
        SDL_SCANCODE_KP_MEMSUBTRACT = 212,
        SDL_SCANCODE_KP_MEMMULTIPLY = 213,
        SDL_SCANCODE_KP_MEMDIVIDE = 214,
        SDL_SCANCODE_KP_PLUSMINUS = 215,
        SDL_SCANCODE_KP_CLEAR = 216,
        SDL_SCANCODE_KP_CLEARENTRY = 217,
        SDL_SCANCODE_KP_BINARY = 218,
        SDL_SCANCODE_KP_OCTAL = 219,
        SDL_SCANCODE_KP_DECIMAL = 220,
        SDL_SCANCODE_KP_HEXADECIMAL = 221,
        SDL_SCANCODE_LCTRL = 224,
        SDL_SCANCODE_LSHIFT = 225,
        SDL_SCANCODE_LALT = 226,
        SDL_SCANCODE_LGUI = 227,
        SDL_SCANCODE_RCTRL = 228,
        SDL_SCANCODE_RSHIFT = 229,
        SDL_SCANCODE_RALT = 230,
        SDL_SCANCODE_RGUI = 231,
        SDL_SCANCODE_MODE = 257,
        SDL_SCANCODE_AUDIONEXT = 258,
        SDL_SCANCODE_AUDIOPREV = 259,
        SDL_SCANCODE_AUDIOSTOP = 260,
        SDL_SCANCODE_AUDIOPLAY = 261,
        SDL_SCANCODE_AUDIOMUTE = 262,
        SDL_SCANCODE_MEDIASELECT = 263,
        SDL_SCANCODE_WWW = 264,
        SDL_SCANCODE_MAIL = 265,
        SDL_SCANCODE_CALCULATOR = 266,
        SDL_SCANCODE_COMPUTER = 267,
        SDL_SCANCODE_AC_SEARCH = 268,
        SDL_SCANCODE_AC_HOME = 269,
        SDL_SCANCODE_AC_BACK = 270,
        SDL_SCANCODE_AC_FORWARD = 271,
        SDL_SCANCODE_AC_STOP = 272,
        SDL_SCANCODE_AC_REFRESH = 273,
        SDL_SCANCODE_AC_BOOKMARKS = 274,
        SDL_SCANCODE_BRIGHTNESSDOWN = 275,
        SDL_SCANCODE_BRIGHTNESSUP = 276,
        SDL_SCANCODE_DISPLAYSWITCH = 277,
        SDL_SCANCODE_KBDILLUMTOGGLE = 278,
        SDL_SCANCODE_KBDILLUMDOWN = 279,
        SDL_SCANCODE_KBDILLUMUP = 280,
        SDL_SCANCODE_EJECT = 281,
        SDL_SCANCODE_SLEEP = 282,
        SDL_SCANCODE_APP1 = 283,
        SDL_SCANCODE_APP2 = 284,
        SDL_NUM_SCANCODES = 512
    } SDL_Scancode;

    typedef Uint32 SDL_KeyboardID;
    typedef Sint32 SDL_Keycode;
    typedef Uint16 SDL_Keymod;

    typedef struct SDL_KeyboardEvent {
        SDL_EventType type;     /**< SDL_EVENT_KEY_DOWN or SDL_EVENT_KEY_UP */
        Uint32 reserved;
        Uint64 timestamp;       /**< In nanoseconds, populated using SDL_GetTicksNS() */
        SDL_WindowID windowID;  /**< The window with keyboard focus, if any */
        SDL_KeyboardID which;   /**< The keyboard instance id, or 0 if unknown or virtual */
        SDL_Scancode scancode;  /**< SDL physical key code */
        SDL_Keycode key;        /**< SDL virtual key code */
        SDL_Keymod mod;         /**< current key modifiers */
        Uint16 raw;             /**< The platform dependent scancode for this event */
        bool down;              /**< true if the key is pressed */
        bool repeat;            /**< true if this is a key repeat */
    } SDL_KeyboardEvent;

    typedef union SDL_Event {
        Uint32 type;
        SDL_WindowEvent window;
        SDL_KeyboardEvent keyboard;
        Uint8 padding[128];
    } SDL_Event;

    typedef enum {
        SDL_WINDOWEVENT_NONE,
        SDL_WINDOWEVENT_SHOWN,
        SDL_WINDOWEVENT_HIDDEN,
        SDL_WINDOWEVENT_EXPOSED,
        SDL_WINDOWEVENT_MOVED,
        SDL_WINDOWEVENT_RESIZED,
        SDL_WINDOWEVENT_SIZE_CHANGED,
        SDL_WINDOWEVENT_MINIMIZED,
        SDL_WINDOWEVENT_MAXIMIZED,
        SDL_WINDOWEVENT_RESTORED,
        SDL_WINDOWEVENT_ENTER,
        SDL_WINDOWEVENT_LEAVE,
        SDL_WINDOWEVENT_FOCUS_GAINED,
        SDL_WINDOWEVENT_FOCUS_LOST,
        SDL_WINDOWEVENT_CLOSE
    } SDL_WindowEventID;

    typedef Uint64 SDL_WindowFlags;

    SDL_Window * SDL_CreateWindow(const char *title, int w, int h, SDL_WindowFlags flags);
    void SDL_DestroyWindow(SDL_Window* window);
    Uint32 SDL_GetWindowID(SDL_Window* window);
    SDL_Window* SDL_GetWindowFromID(Uint32 id);

    typedef enum {
        SDL_RENDERER_SOFTWARE = 0x00000001,
        SDL_RENDERER_ACCELERATED = 0x00000002,
        SDL_RENDERER_PRESENTVSYNC = 0x00000004,
        SDL_RENDERER_TARGETTEXTURE = 0x00000008
    } SDL_RendererFlags;

    SDL_Renderer* SDL_CreateRenderer(SDL_Window *window, const char *name);
    void SDL_DestroyRenderer(SDL_Renderer* renderer);
    SDL_Renderer* SDL_GetRenderer(SDL_Window* window);

    int SDL_PollEvent(SDL_Event* event);

    void SDL_Log(const char* fmt, ...);
    const char* SDL_GetError(void);
]]

return sdl
