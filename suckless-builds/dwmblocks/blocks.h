//Modify this file to change what commands output to your statusbar, and recompile using the make command.
// │
static const Block blocks[] = {
	/*Icon*/	/*Command*/		        /*Update Interval*/	   /*Update Signal*/
    { "  ",     "~/scripts/status/wifinetwork",         20,   15 },
    { "  ",     "~/scripts/status/cpu",                 0,    18 },
    { "  ",     "~/scripts/status/memory",              0,    19 },
    { "  ",     "~/scripts/status/disk",                60,   16 },
    { "  ",     "~/scripts/status/lightlockerstatus",   0,    14 },
    { "  ",     "~/scripts/status/kblayout",            0,    12 },
    { "  ",     "~/scripts/status/volume",              0,    10 },
    /* { "  ",     "~/scripts/status/brightness",          0,    11 }, */
    { "  ",     "~/scripts/status/battery",             5,    17 },
    { "  ",     "~/scripts/status/clock",               5,    13 },
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = ' ';
