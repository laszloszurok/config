/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

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

/* #include "/home/pulzar/.cache/wal/colors-wal-dwm.h" */

#include "../color-source/dwm-colors.h"

/* tagging */
static const char *tags[] = { "", "", "", "", "", "",  "", "", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class               instance     title     tags mask    isfloating    isterminal    noswallow        monitor */
	{ "st-256color",        NULL,       NULL,            0,       0,         1,              0,               -1 },
    { "firefox",            NULL,       NULL,       1 << 1,       0,         0,             -1,               -1 },
    { "Brave-browser",      NULL,       NULL,       1 << 1,       0,         0,             -1,               -1 },
    { "Spotify",            NULL,       NULL,       1 << 2,       0,         0,              0,               -1 },
    { "Skype",              NULL,       NULL,       1 << 3,       0,         0,              0,               -1 },
    { "zoom",               NULL,       NULL,       1 << 3,       0,         0,              0,               -1 },
    { "Ripcord",            NULL,       NULL,       1 << 3,       0,         0,              0,               -1 },
    { "discord",            NULL,       NULL,       1 << 3,       0,         0,              0,               -1 },
    { "jetbrains-webstorm", NULL,       NULL,       1 << 4,       0,         0,              0,               -1 },
    { "jetbrains-idea",     NULL,       NULL,       1 << 4,       0,         0,              0,               -1 },
    { "jetbrains-idea-ce",  NULL,       NULL,       1 << 4,       0,         0,              0,               -1 },
    { "jetbrains-studio",   NULL,       NULL,       1 << 4,       0,         0,              0,               -1 },
    { "com.oracle.javafx.scenebuilder.app.SceneBuilderApp", 
                            NULL,       NULL,       1 << 4,       0,         0,              0,               -1 },
    { "code-oss",           NULL,       NULL,       1 << 4,       0,         0,              0,               -1 },
    { "VSCodium",           NULL,       NULL,       1 << 4,       0,         0,              0,               -1 },
    { "Gimp",               NULL,       NULL,       1 << 5,       0,         0,              0,               -1 },
    { "Inkscape",           NULL,       NULL,       1 << 5,       0,         0,              0,               -1 },
    { "Pcmanfm",            NULL,       NULL,       1 << 6,       0,         0,              0,               -1 },
    { "Virt-manager",       NULL,       NULL,       1 << 7,       0,         0,              0,               -1 },
    { "VirtualBox Manager", NULL,       NULL,       1 << 7,       0,         0,              0,               -1 },
    { "Genymotion",         NULL,       NULL,       1 << 7,       0,         0,              0,               -1 },
    { "qBittorrent",        NULL,       NULL,       1 << 8,       0,         0,              0,               -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "│ ",      tile },    /* first entry is default */
	{ "│ ",      NULL },    /* no layout function means floating behavior */
	{ "│ ",      monocle },
	{ "│ ",      centeredmaster },
	{ "│ ",      centeredfloatingmaster },
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
    static const char *passmenucmd[] = { "passmenu", "-fn", "monospace:size=12", "-h", "26", "-i", "-p", "copy:", NULL };
    static const char *termcmd[]  = { "st", NULL };
    static const char scratchpadname[] = "scratchpad";
    static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", NULL };

    static Key keys[] = {
        /* modifier                     key        function        argument */
        { MODKEY|ControlMask|ShiftMask, XK_q,      quit,           {1} }, // restarting dwm in place
        { MODKEY|ShiftMask,             XK_Escape, quit,           {0} }, // logging out from the session
	    { MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} },
	    { MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} },
	    { MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },
    	{ MODKEY,                       XK_s,      togglescratch,  {.v = scratchpadcmd } },
        { MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
        { MODKEY,                       XK_p,      spawn,          {.v = passmenucmd } },
        { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
        { MODKEY,                       XK_b,      togglebar,      {0} },
        { MODKEY,                       XK_k,      focusstackvis,  {.i = +1 } },
        { MODKEY,                       XK_j,      focusstackvis,  {.i = -1 } },
        { MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
        { MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
        { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
        { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
        { MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
        { MODKEY|ShiftMask,             XK_k,      shiftview,      {.i = +1} },
        { MODKEY|ShiftMask,             XK_j,      shiftview,      {.i = -1} },
        { MODKEY,                       XK_q,      killclient,     {0} },
        { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
        { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
        { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
        { MODKEY,                       XK_c,      setlayout,      {.v = &layouts[3]} },
        { MODKEY|ShiftMask,             XK_c,      setlayout,      {.v = &layouts[4]} },
        { MODKEY,                       XK_space,  setlayout,      {0} },
        { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
        { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
        { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
        { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
        { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
        { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
        { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
        TAGKEYS(                        XK_1,                      0)
        TAGKEYS(                        XK_2,                      1)
        TAGKEYS(                        XK_3,                      2)
        TAGKEYS(                        XK_4,                      3)
        TAGKEYS(                        XK_5,                      4)
        TAGKEYS(                        XK_6,                      5)
        TAGKEYS(                        XK_7,                      6)
        TAGKEYS(                        XK_8,                      7)
        TAGKEYS(                        XK_9,                      8)
        { 0,                       XF86XK_AudioPrev,           spawn,          SHCMD("playerctl previous") },
        { 0,                       XF86XK_AudioPlay,           spawn,          SHCMD("playerctl play-pause") },
        { 0,                       XF86XK_AudioNext,           spawn,          SHCMD("playerctl next") },
        { 0,                       XF86XK_AudioRaiseVolume,    spawn,          SHCMD("amixer sset Master 5%+ ;  pkill -RTMIN+10 dwmblocks") },
        { 0,                       XF86XK_AudioLowerVolume,    spawn,          SHCMD("amixer sset Master 5%- ; pkill -RTMIN+10 dwmblocks") },
        { 0,                       XF86XK_AudioMute,           spawn,          SHCMD("amixer sset Master toggle ; pkill -RTMIN+10 dwmblocks") },
        { 0,                       XF86XK_MonBrightnessUp,     spawn,          SHCMD("xbacklight -inc 3; $HOME/scripts/status/helper_scripts/brightness-notify") },
        { 0,                       XF86XK_MonBrightnessDown,   spawn,          SHCMD("xbacklight -dec 3; $HOME/scripts/status/helper_scripts/brightness-notify") },
        { Mod1Mask,                XK_space,                   spawn,          SHCMD("pkill -RTMIN+12 dwmblocks") },
        { 0,                       XK_Print,                   spawn,          SHCMD("$HOME/scripts/misc/screenshot") },
        { MODKEY,                  XK_Print,                   spawn,          SHCMD("$HOME/scripts/misc/screenshot -w") },
        { MODKEY|ShiftMask,        XK_Print,                   spawn,          SHCMD("$HOME/scripts/misc/screenshot -s") },
        { MODKEY,                  XK_n,                       spawn,          SHCMD("st -e newsboat; pkill RTMIN+21 dwmblocks") },
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

