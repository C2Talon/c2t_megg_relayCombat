//c2t megg relayCombat
//c2t

//adds a line of text to denote whether a monster in combat already has its mimic eggs maxed or not

import <c2t_megg.ash>


buffer c2t_megg_relayCombat(buffer page) {
	buffer out = page;
	monster mon;
	string replace,append;
	boolean[monster] maxlist;
	matcher m = create_matcher("<!--\\sMONSTERID:\\s(\\d+)\\s-->",page);
	record something {
		string color;
		string text;
	} status;

	if (!m.find())
		return page;

	mon = m.group(1).to_monster();
	maxlist = c2t_megg_maxed();

	if (maxlist.count() == 0)
		status = new something("red","list not found");
	else if (maxlist contains mon)
		status = new something("gray","max donated");
	else if (mon == $monster[none])
		status = new something("red","unknown monster");
	else if (!mon.copyable)
		status = new something("gray","not eggable");
	else
		status = new something("blue","not max donated");

	append = `<br /><font size="2" color="{status.color}">Mimic DNA Bank status: {status.text}</font>`;

	//find what to replace

	//basic
	m = create_matcher("<td id='fmsg' valign=center>.*?<span[^>]+id='monname'>.*?</span>",page);
	if (m.find())
		replace = m.group(0);

	//haiku dungeon
	m = create_matcher("(<td id='fmsg' valign=center><[Tt]able>.*?)</td></tr></table></td><!--\\sMONSTERID",page);
	if (m.find())
		replace = m.group(1);

	//replace it
	if (replace != "")
		out.replace_string(replace,replace+append);

	return out;
}
