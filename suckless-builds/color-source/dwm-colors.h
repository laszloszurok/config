#include "variables.h"

static const char *colors[][3]      = {
    /*                 fg           bg          border                         */
    [SchemeNorm]   = { norm_fg,     norm_bg,    norm_border }, 
    [SchemeSel]    = { sel_fg,      sel_bg,     sel_border },  // the focused win
    [SchemeUrg]    = { urg_fg,      urg_bg,     urg_border },
	[SchemeHid]    = { hid_fg,      hid_bg,     hid_border },
    [SchemeNotSel] = { not_sel_fg,  not_sel_bg, not_sel_border }  // unfocused wins
};
