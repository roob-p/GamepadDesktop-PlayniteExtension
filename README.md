# GamepadDesktop-(PlayniteExtension)
🎮 Control Playnite Desktop using your X-input gamepad, with an integrated virtual keyboard and multiple actions mapped to the buttons.

✨ This extension lets you use your gamepad with Playnite Desktop, allowing to control variuos functions (mouse, scrollbars, Playnite shortcuts) and reaching specific customizable sections and panels with a click. A virtual keyboard, to interact with fields, search and global search panels, is available.  

## 🚀 Functionality:
- Commons actions are mapped to every button and axes, with mouse movement, barscroll and shortcuts for functions.
- Integrated onscreen keyboard working via x-input.
- Visual wizard to easy set the reachables points of sections and panels.
- 3 slot to set the reachables points and fast slot-changes with a click.
- Functions and buttons customizable.
- Support for autorun when Playnite is started. When Playnite is not focussed, the script will be put in idle.
- Playnite menu indicating the program' s state and easy actions to run/stop, edit config and lauynch wizard.
- Support for different resolutions and onscreen keyboard automatic scaling.



## ⚙️ How it works:
- The extension partition the screen into "sections" reachable by button presses (LB and RB for default). It also permits to reach specific sections and panels, and can launches Playnite's funcionality shortcuts.
- You can edit panels and sectons position lauching the `Gamepad-Wizard`: just put the mouse cursor on the indicated points and wait few seconds: the reachable points of the current slot will be saved. No restart is required.
- You can edit the controller layout editing the `Keys` section in `config.ini`. Almost any functions to the assigned button can be changed, with few exception:
  - When the osk is opened the, `tabjump_next` (RT for default) is used for mouseleft click. `A` is used for press the osk button (this is the only funcion not configurable).
  - You can change the slot with `$explorerAndSlot_back` (`$LS` for default) wich also shows/hides the Playnite Explorer panel to the left, and `$FilterAndSlot_back` (`$RS` for default) witch also show/hides the Playnite Filter panel to the right) by long pressing them.
  - You can send `F11` and put Playnite in Fullscreen by pressing `$globalsearch` (`$back` for default) witch also is used to open the Playnite global search.
- The default keys are:  
  -*`LS`* (`LSX`: `$mousemovx` , `LSY`: `$mousemovy`): (mouse movement)    
  -*`RS`* (`RSY`): `$scroll` (bar scrollI)  
  -`A`: `$mouseleft` (mouseleft click)  
  -`B`: `$mouseright` (mouseright click)  
  -`X`: `$osk` (open/close osk)  
  -`Y`: `$search` (search panel)  
  -`back`: `$globalsearch` (global search + Playnite Fullscreen mode by long press)  
  -`start`: `$enter` (enter key)  
  -`LB`: `$section_back` (jump to the previous section)  
  -`RB`: `$section_back` (jump to the next section)  
  -`LT`: `$tabjump_back` (jump to the previous panel of the current section)  
  -`RT`: `$tabjump_next` (jump to the next panel of the current section)  
  -*`$LSB`* (`LS`): `$explorerAndSlot_back` (open/close Playnite Explorer panel, or change slot keys by long press)  
  -*`$RSB`* (`RS`): `$filterAndSlot_next` (open/close Playnite Explorer panel, or change slot keys by long press)

## ⚠️ Notes:
- Please, remeber to maximize Playnite. This is required for the extension to work correctly.   
- Please, remember that any time the program is started the reachable points are loaded from the first slot, under [Global] section. You can also edit them directly open the `config.ini`. [Global.slo2] and [Global.slot3] contains the points of the other slots.
- The extension search the Title of Playnite Global Search for interacting with the global search, wich is variable. I added the most common cases but, for some language, the Title need to be added in future realease. Please, if you encounter dysfunctionality open an issue indicating the used language and, for the moment, switch to the English version.  
  

  
