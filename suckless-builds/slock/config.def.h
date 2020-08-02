/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#222",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* default message */
static const char * message = "                    -@                \n                   .##@               \n                  .####@              \n                  @#####@             \n                . *######@            \n               .##@o@#####@           \n              /############@          \n             /##############@         \n            @######@**%######@        \n           @######`     %#####o       \n          @######@       ######%      \n        -@#######h       ######@.`    \n       /#####h**``       `**%@####@   \n      @H@*`                    `*%#@  \n     *`                            `*\n              Session locked";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "-adobe-courier-medium-r-normal--18-180-75-75-m-110-iso10646-1";















