/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>
#include "../color-source/dwm-colors.h"
#include "movestack.c"

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 15;       /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int horizpadbar        = 0;        /* horizontal padding for statusbar */
static const int vertpadbar         = 7;        /* vertical padding for statusbar */

static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */

static const char *fonts[]          = { "FontAwesome:size=12", "monospace:size=10" };

/* tagging */
static const char *tags[] = { "", "", "", "", "", "",  "", "", "", "scratchtag" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	
    /* class|instance|title|tags|mask|isfloating|isterminal|noswallow|monitor */
	{ "st-256color",        NULL, NULL,      0, 0, 1,  0, -1 },
    { "firefox",            NULL, NULL, 1 << 1, 0, 0, -1, -1 },
    { "qutebrowser",        NULL, NULL, 1 << 1, 0, 0, -1, -1 },
    { "Brave-browser",      NULL, NULL, 1 << 1, 0, 0, -1, -1 },
    { "Spotify",            NULL, NULL, 1 << 2, 0, 0,  0, -1 },
    { "Skype",              NULL, NULL, 1 << 3, 0, 0,  0, -1 },
    { "zoom",               NULL, NULL, 1 << 3, 0, 0,  0, -1 },
    { "Ripcord",            NULL, NULL, 1 << 3, 0, 0,  0, -1 },
    { "discord",            NULL, NULL, 1 << 3, 0, 0,  0, -1 },
    { "jetbrains-webstorm", NULL, NULL, 1 << 4, 0, 0,  0, -1 },
    { "jetbrains-clion",    NULL, NULL, 1 << 4, 0, 0,  0, -1 },
    { "jetbrains-idea",     NULL, NULL, 1 << 4, 0, 0,  0, -1 },
    { "jetbrains-idea-ce",  NULL, NULL, 1 << 4, 0, 0,  0, -1 },
    { "jetbrains-studio",   NULL, NULL, 1 << 4, 0, 0,  0, -1 },
    { "com.oracle.javafx.scenebuipp.ScederApp",
                            NULL, NULL, 1 << 4, 0, 0,  0, -1 },
	{ "st-256color",        NULL,"nvim",1 << 4, 0, 1,  0, -1 },
    { "code-oss",           NULL, NULL, 1 << 4, 0, 0,  0, -1 },
    { "VSCodium",           NULL, NULL, 1 << 4, 0, 0,  0, -1 },
    { "PacketTracer7",      NULL, NULL, 1 << 4, 0, 0,  0, -1 },
    { "Gimp",               NULL, NULL, 1 << 5, 0, 0,  0, -1 },
    { "Blender",            NULL, NULL, 1 << 5, 0, 0,  0, -1 },
    { "Inkscape",           NULL, NULL, 1 << 5, 0, 0,  0, -1 },
    { "draw.io",            NULL, NULL, 1 << 5, 0, 0,  0, -1 },
    { "Pcmanfm",            NULL, NULL, 1 << 6, 0, 0,  0, -1 },
    { "Zathura",            NULL, NULL, 1 << 6, 0, 0,  0, -1 },
    { "DesktopEditors",     NULL, NULL, 1 << 6, 0, 0,  0, -1 },
    { "Virt-manager",       NULL, NULL, 1 << 7, 0, 0,  0, -1 },
    { "VirtualBox Manager", NULL, NULL, 1 << 7, 0, 0,  0, -1 },
    { "Genymotion",         NULL, NULL, 1 << 7, 0, 0,  0, -1 },
    { "qBittorrent",        NULL, NULL, 1 << 8, 0, 0,  0, -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "│ ",      tile },    /* first entry is default */
	{ "│ ",      monocle },
	{ "│ ",      centeredmaster },
	{ "│ ",      centeredfloatingmaster },
	{ "│ ",      NULL },    /* no layout function means floating behavior */
    { NULL,       NULL } /* indicates the end of the list, has to be the last */
};

    /* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
        { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
        { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
        { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
        { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

    /* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

    /* commands */
    static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
    static const char *dmenucmd[] = { "dmenu_hist", NULL }; // make sure it's in $PATH
    static const char *dmenu_sudo_cmd[] = { "dmenu_hist", "sudo", NULL }; // running programs with sudo
    static const char *passmenucmd[] = { "passmenu", "-fn", "monospace:size=12", "-h", "26", "-i", "-p", "copy:", NULL };
    static const char *termcmd[]  = { "st", NULL };
    static const char scratchpadname[] = "scratchpad";
    static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", NULL };

    static Key keys[] = {
        /* modifier                     key        function        argument */
        { MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
        { MODKEY|ControlMask,           XK_d,      spawn,          {.v = dmenu_sudo_cmd } },

        { MODKEY,                       XK_p,      spawn,          {.v = passmenucmd } },
        { MODKEY,                       XK_s,      togglescratch,  {.v = scratchpadcmd } },
        { MODKEY,                       XK_b,      togglebar,      {0} },
        { MODKEY,                       XK_k,      focusstackvis,  {.i = -1 } },
        { MODKEY,                       XK_j,      focusstackvis,  {.i = +1 } },
        { MODKEY,                       XK_q,      killclient,     {0} },

        { Mod1Mask,                     XK_1,      setlayout,      {.v = &layouts[0]} },
        { Mod1Mask,                     XK_2,      setlayout,      {.v = &layouts[1]} },
        { Mod1Mask,                     XK_3,      setlayout,      {.v = &layouts[2]} },
        { Mod1Mask,                     XK_4,      setlayout,      {.v = &layouts[3]} },
        { Mod1Mask,                     XK_5,      setlayout,      {.v = &layouts[4]} },
        { Mod1Mask,                     XK_space,  setlayout,      {0} }, /* toggle betwwen this and the last used layout */

        { Mod1Mask,		                XK_n,      cyclelayout,    {.i = +1 } },
        { Mod1Mask,                     XK_p,      cyclelayout,    {.i = -1 } },

        { Mod1Mask,                     XK_f,      togglefloating, {0} },

        { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
        { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
        { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
        { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
        { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
        { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },

        { ControlMask|ShiftMask,        XK_j,      movestack,      {.i = +1} },
        { ControlMask|ShiftMask,        XK_k,      movestack,      {.i = -1} },
        
        { MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
        { MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },

        { MODKEY|ShiftMask,             XK_k,      shiftview,      {.i = +1} },
        { MODKEY|ShiftMask,             XK_j,      shiftview,      {.i = -1} },
        
        { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
        
	    { MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} },
	    { MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} },
	    { MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },

        { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
        { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
        { MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
       
        { Mod1Mask|ShiftMask,           XK_r,      quit,           {1} }, // restarting dwm in place
        { Mod1Mask|ShiftMask,           XK_q,      quit,           {0} }, // logging out from the session
        
        { 0, XF86XK_AudioPrev,         spawn, SHCMD("playerctl previous") },
        { 0, XF86XK_AudioPlay,         spawn, SHCMD("playerctl play-pause") },
        { 0, XF86XK_AudioNext,         spawn, SHCMD("playerctl next") },

        /* 0 is the index of the sink. Use 'pactl list sinks' to get sink names */
        { 0, XF86XK_AudioRaiseVolume,  spawn, SHCMD("pactl set-sink-volume 0 +5%; pkill -RTMIN+10 dwmblocks") },
        { 0, XF86XK_AudioLowerVolume,  spawn, SHCMD("pactl set-sink-volume 0 -5%; pkill -RTMIN+10 dwmblocks") },
        { 0, XF86XK_AudioMute,         spawn, SHCMD("pactl set-sink-mute 0 toggle; pkill -RTMIN+10 dwmblocks") },

        { 0, XF86XK_MonBrightnessUp,   spawn, SHCMD("xbacklight -inc 3; dunstify --replace=1 \"Brightness $(xbacklight -get | awk '{print int($1)\"%\"}')\"") },
        { 0, XF86XK_MonBrightnessDown, spawn, SHCMD("xbacklight -dec 3; dunstify --replace=1 \"Brightness $(xbacklight -get | awk '{print int($1)\"%\"}')\"") },

        { 0,                 XK_Print, spawn, SHCMD("screenshot") },
        { MODKEY,            XK_Print, spawn, SHCMD("screenshot -w") },
        { MODKEY|ShiftMask,  XK_Print, spawn, SHCMD("screenshot -s") },
        
        { MODKEY,            XK_v,     spawn, SHCMD("st -e vifm") },
        { MODKEY,            XK_n,     spawn, SHCMD("st -e newsboat; pkill -RTMIN+21 dwmblocks") },
        { MODKEY,            XK_e,     spawn, SHCMD("st -e $EDITOR") },
        { MODKEY,            XK_c,     spawn, SHCMD("st -f 'mono:pixelsize=20:antialias=true:autohint=true' -e calcurse") },
        { MODKEY,            XK_space, spawn, SHCMD("pkill -RTMIN+12 dwmblocks") },

        TAGKEYS( XK_1, 0 )
        TAGKEYS( XK_2, 1 )
        TAGKEYS( XK_3, 2 )
        TAGKEYS( XK_4, 3 )
        TAGKEYS( XK_5, 4 )
        TAGKEYS( XK_6, 5 )
        TAGKEYS( XK_7, 6 )
        TAGKEYS( XK_8, 7 )
        TAGKEYS( XK_9, 8 )
    };

    /* button definitions */
    /* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
    static Button buttons[] = {
        /* click                event mask      button          function        argument */
        { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
        { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	    { ClkWinTitle,          0,              Button1,        togglewin,      {0} },
        { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    	{ ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
    	{ ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
    	{ ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
        { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
        { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
        { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
        { ClkTagBar,            0,              Button1,        view,           {0} },
        { ClkTagBar,            0,              Button3,        toggleview,     {0} },
        { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
        { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
    };

