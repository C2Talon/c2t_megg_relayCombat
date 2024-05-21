//c2t megg relayCombat
//c2t

//adds a line of text to denote whether a monster in combat already has its mimic eggs maxed or not

import <c2t_megg.ash>


buffer c2t_megg_relayCombat(buffer page) {
	buffer out = page;
	monster mon;
	string replace,append;
	matcher mMonsterId = create_matcher("<!--\\sMONSTERID:\\s(\\d+)\\s-->",page);
	matcher mReplace = create_matcher("(<td id='fmsg' valign=center>.*?<span[^>]+>.*?</span>)",page);

	if (!mMonsterId.find() || !mReplace.find())
		return page;

	mon = mMonsterId.group(1).to_monster();
	replace = mReplace.group(1);

	if (c2t_megg_maxed() contains mon)
		append = "<br /><font size=2 color=gray>Mimic DNA Bank status: max donated</font>";
	else if (mon == $monster[none])
		append = "<br /><font size=2 color=red>Mimic DNA Bank status: unknown monster</font>";
	else if (!mon.copyable)
		append = "<br /><font size=2 color=gray>Mimic DNA Bank status: not eggable</font>";
	else
		append = "<br /><font size=2 color=blue>Mimic DNA Bank status: not max donated</font>";

	out.replace_string(replace,replace+append);

	return out;
}
