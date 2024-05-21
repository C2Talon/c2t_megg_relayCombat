import <c2t_megg_relayCombat.ash>

void main() {
	buffer page = visit_url();

	// other scripts modifying things can go here

	page = page.c2t_megg_relayCombat();

	// other scripts modifying things can also go here

	page.write();
}

