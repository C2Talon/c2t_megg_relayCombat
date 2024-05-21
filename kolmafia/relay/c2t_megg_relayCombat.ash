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
	record something {
		string color;
		string text;
	} status;

	if (!mMonsterId.find() || !mReplace.find())
		return page;

	mon = mMonsterId.group(1).to_monster();
	replace = mReplace.group(1);

	if (c2t_megg_maxed() contains mon)
		status = new something("gray","max donated");
	else if (mon == $monster[none])
		status = new something("red","unknown monster");
	else if (!mon.copyable)
		status = new something("gray","not eggable");
	else
		status = new something("blue","not max donated");

	append = `<br /><font size="2" color="{status.color}">Mimic DNA Bank status: {status.text}</font>`;

	out.replace_string(replace,replace+append);

	return out;
}
