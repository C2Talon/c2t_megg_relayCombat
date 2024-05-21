# c2t_megg_relayCombat

Kolmafia relay script written in ASH to add a line of text to denote whether a monster in combat already has its mimic eggs maxed or not, as can be seen here:

![mimic_egg_status_in_combat.png](https://github.com/C2Talon/c2t_megg_relayCombat/blob/master/mimic_egg_status_in_combat.png "mimic egg status in combat example")

## Usage

`c2t_megg` ([https://github.com/C2Talon/c2t_megg](https://github.com/C2Talon/c2t_megg)) is required and will be installed when this is installed with either command in the sections below. However, in order to make the status line that this script adds accurate, at least one method of updating the local maxed egg list that `c2t_megg` utilizes will need be used to semi-regularly update the list. Otherwise, this script will probably tell many lies.

## Installation

If you do not have another script that modifies `fight.ash` in the `relay` folder, this can be installed via the KoLmafia CLI:
* `git checkout https://github.com/C2Talon/c2t_megg_relayCombat.git master`

### Installation when another script modifies `fight.ash`

Manual edits will be required if `fight.ash` is modified by another script. The `dep` branch can be used to install a version of this that does not have its own `fight.ash` file as follow:
* `git checkout https://github.com/C2Talon/c2t_megg_relayCombat.git dep`

Then the `fight.ash` file will have to be edited to `import` the `c2t_megg_relayCombat.ash` file, and also called to modify the output text before the `write()`, which might look something like the following:

```java
import <c2t_megg_relayCombat.ash>

void main() {
    buffer page = visit_url();

    // other scripts modifying things can go here

    page = page.c2t_megg_relayCombat();

    // other scripts modifying things can also go here

    page.write();
}
```

If the status line still does not show up in combat with the edits, the `c2t_megg_relayCombat()` call may need to be moved higher in the list.

