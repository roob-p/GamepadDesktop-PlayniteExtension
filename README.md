# 🎮 GamepadDesktop (Playnite Extension)
Control Playnite Desktop using your Xinput gamepad, with an integrated virtual keyboard and multiple functions mapped to the buttons.

✨ This extension lets you use your gamepad with Playnite Desktop, allowing you to control various functions (mouse, scrollbars, Playnite shortcuts) and reach specific sections and panels through customizable positions. A virtual keyboard, to interact with fields, search and global search panels, is included.  

## 🚀 Functionality:
- Common actions are mapped to every button and axes: mouse movement, scrollbars and functions shortcuts.
- Integrated onscreen keyboard controlled via Xinput.
- Visual wizard to easily set the reachables points of sections and panels.
- 3 customizable slots for reachable points, quickly switchable with a button press
- Customizable button mapping.
- Support for autorun when Playnite starts. The script goes idle when Playnite is not focused.
- Playnite menu integration showing program status and quick actions (run/stop, config edit, launch Wizard).
- Support for different resolutions and auto-scaling onscreen keyboard.



## ⚙️ How it works:
- The extension divides the screen into "sections" that can be reached by pressing buttons (*for default:* `LB` *and* `RB`). It also allows access to specific panels and can launch Playnite functions via shortcuts.
- Use the `Gamepad-Wizard` to edit panel and section positions: simply place the mouse over the indicated points and wait a few seconds. No restart required.
- You can edit the controller layout by editing the `Keys` section in `config.ini`. Almost all buttons can be changed, with few exceptions:
  - When the osk is opened the, `tabjump_next` (`RT` for default) is used for mouseleft click. `A` is used for press the button of the OnScreen keyboard *(this is the only funcion not configurable).*
  - Change slot by long-pressing `$explorerAndSlot_back` (`LS` by default) and `$FilterAndSlot_next` (`RS` by default). Short-pressing toggles Playnite’s Explorer and Filter panels.
  - Long-press `$globalsearch` (`back` by default) to launch Playnite fullscreen. Short-press it to open Global Search.
- The default keys are:
  
  -*`(Left Stick)`* `LSX` → `$mousemovx` , `LSY` → `$mousemovy` (mouse movement)    
  -*`(Right Stick)`* `RSY` → `$scroll` (bar scrollI)  
  -`A` → `$mouseleft` (mouseleft click)  
  -`B` → `$mouseright` (mouseright click)  
  -`X` → `$osk` (open/close osk)  
  -`Y` → `$search` (search panel)  
  -`back` → `$globalsearch` (global search + Playnite Fullscreen mode by long press)  
  -`start` → `$enter` (enter key)  
  -`LB` → `$section_back` (jump to the previous section)  
  -`RB` → `$section_back` (jump to the next section)  
  -`LT` → `$tabjump_back` (jump to the previous panel of the current section)  
  -`RT` → `$tabjump_next` (jump to the next panel of the current section)  
  -*`(Left Stick Button)`* `LS` → `$explorerAndSlot_back` (toggle Playnite Explorer panel, or change slot by long press)  
  -*`(Right Stick Button)`* `RS` → `$filterAndSlot_next` (toggle Playnite Filter panel, or change slot by long press)

 

## ⚠️ Notes:
- Please, make sure to maximize Playnite. It's required for the extension to work properly.   
- On each start, the script loads reachable points from the first slot, under `[Global]` section. You can also edit them directly open the `config.ini` manually or by using the corresponding menu option.. `[Global.slot2]` and `[Global.slot3]` contains the points of the other slots.
- The extension uses the window title of Playnite Global Search for interacts with Global Search. Since this varies by language, only the most common cases are supported. If you encounter issues, please open an issue and specify your language. In the meantime, switching Playnite to English is recommended. 

  </br>

If you enjoy GamepadDesktop, you can buy me a coffee. It will be appreciated ;)

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/E1E214R1KB)



### 📺 See it in action!
Here's a quick demo of how GamepadDesktop works:

  
