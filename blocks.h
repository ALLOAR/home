static const Block blocks[] = {
        /*Icon   */ /*Command*/                                                 /*Interval*/ /*Signal*/
	{ " Vol.", "pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}'",   1,          0  },
	{ "", "xkblayout-state print %s",                                       1,          0  },
        { "Mem:",  "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",   1,          0  },
        { "",      "date '+%b %d (%a) %I:%M%p'",                                1,          0  },
};
static char delim[] = " | ";
static unsigned int delimLen = 5;
