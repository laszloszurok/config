//Modify this file to change what commands output to your statusbar, and recompile using the make command.
// │
static const Block blocks[] = {
	/*Icon*/	/*Command*/		        /*Update Interval*/	   /*Update Signal*/
    { "  ",      "~/scripts/status/weather",             0,    20 },
    { "   ",     "~/scripts/status/wifinetwork",         0,    15 },
    { "   ",     "~/scripts/status/newsboat_status",     7200, 21 },
    { "   ",     "~/scripts/status/sys_resources",       0,    18 },
    { "   ",     "~/scripts/status/disk",                0,    16 },
    { "   ",     "~/scripts/status/kblayout",            0,    12 },
    { "   ",     "~/scripts/status/volume",              0,    10 },
    { "   ",     "~/scripts/status/battery",             5,    17 },
    { "   ",     "~/scripts/status/clock",               5,    13 },
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = ' ';
