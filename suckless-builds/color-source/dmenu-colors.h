#include "variables.h"

static const char *colors[SchemeLast][2] = {
	/*                  fg         bg       */
	[SchemeNorm] = { norm_fg, norm_bg },
	[SchemeSel]  = { sel_fg, sel_bg },
	[SchemeOut]  = { "#000000", "#00ffff" },
};
