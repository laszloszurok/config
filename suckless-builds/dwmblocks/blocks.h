//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		        /*Update Interval*/	   /*Update Signal*/
    { "",       "~/scripts/status/wifinetwork",      10,       0 },

    { "│ ",     "~/scripts/status/disk",             60,       0 },

    { "│ ",     "~/scripts/status/volume",	          0,	  10 },

    { "│ ",     "~/scripts/status/brightness",        0,	  11 },
	
    { "│ ",     "~/scripts/status/battery",           5,	   0 },
    
    { "│ ",     "~/scripts/status/kblayout",	      0,	  12 },
    
    { "│ ",     "~/scripts/status/lightlockerstatus", 0,	  14 },

    { "│ ",     "~/scripts/status/clock",	          5,	   0 },
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = ' ';
