//c2t megg relayFightPage
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

	append = c2t_megg_maxed() contains mon
		? "<br /><font size=2 color=gray>Mimic egg status: maxed</font>"
		: "<br /><font size=2 color=blue>Mimic egg status: not maxed</font>";

	out.replace_string(replace,replace+append);

	return out;
}
