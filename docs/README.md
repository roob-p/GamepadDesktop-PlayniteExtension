<!--[🔙 Back](https://roob-p.github.io)--> 
<!--[![🔙 Back](https://img.shields.io/badge/🔙-Back-blue)](https://roob-p.github.io)-->
[![🔙 Back](https://img.shields.io/badge/🔙-Back-white?style=flat-square&logoColor=blue&color=blue)](https://roob-p.github.io)

# 🎮 GamepadDesktop (Playnite Extension)
Control Playnite Desktop using your Xinput gamepad, with an integrated virtual keyboard and multiple functions mapped to the buttons!

✨ This extension lets you use your gamepad with Playnite Desktop, allowing you to control various functions (mouse, scrollbars, Playnite shortcuts) and reach specific sections and panels through customizable positions. A virtual keyboard, to interact with fields, search and global search panels, is included.  
 
## 🚀 Functionality:
- Common actions are mapped to every button and axes: mouse movement, scrollbars and function shortcuts.
- Integrated onscreen keyboard controlled via Xinput.
- Visual wizard to easily set the reachable points of sections and panels.
- Three customizable slots for reachable points, quickly switchable with a button press
- Customizable button mapping.
- Support for autorun when Playnite starts. The script goes idle when Playnite is not focused.
- Playnite menu integration showing program status and quick actions (run/stop, config edit, launch Wizard).
- Support for different resolutions and auto-scaling onscreen keyboard.



## ⚙️ How it works:
- The extension divides the screen into "sections" that can be reached by pressing buttons (*for default:* `LB` *and* `RB`). It also allows access to specific panels and can launch Playnite functions via shortcuts.
- Use the `GamepadDesktop-Wizard` to edit panel and section positions: simply place the mouse over the indicated points and wait a few seconds. The Wizard saves the positions of the current slot. No restart required.
- You can edit the controller layout by editing the `Keys` section in `config.ini`. Almost all buttons can be changed, with few exceptions:
  - When the OSK is open, `tabjump_next` *(`RT` for default)* is used for left mouse click. `A` is used to press buttons on the OnScreen Keyboard *(this is the only non-configurable function).*
  - Change slot by long-pressing `$explorerAndSlot_back` *(`LS` by default)* and `$FilterAndSlot_next` *(`RS` by default).* Short-pressing toggles Playnite’s Explorer and Filter panels.
  - Long-press `$globalsearch` *(`back` by default)* to launch Playnite fullscreen; short-press it to open Global Search.
- The default keys are:
  
  -*`(Left Stick)`* `LSX` → `$mousemovx` , `LSY` → `$mousemovy` (mouse movement)    
  -*`(Right Stick)`* `RSY` → `$scroll` (scrollbars)  
  -`A` → `$mouseleft` (mouseleft click)  
  -`B` → `$mouseright` (mouseright click)  
  -`X` → `$osk` (open/close osk)  
  -`Y` → `$search` (search panel)  
  -`back` → `$globalsearch` (global search + Playnite Fullscreen mode by long press)  
  -`start` → `$enter` (enter key)  
  -`LB` → `$section_back` (jump to the previous section)  
  -`RB` → `$section_next` (jump to the next section)  
  -`LT` → `$tabjump_back` (jump to the previous panel of the current section)  
  -`RT` → `$tabjump_next` (jump to the next panel of the current section)  
  -*`(Left Stick Button)`* `LS` → `$explorerAndSlot_back` (toggle Playnite Explorer panel, or change slot by long press)  
  -*`(Right Stick Button)`* `RS` → `$filterAndSlot_next` (toggle Playnite Filter panel, or change slot by long press)  
  -`D-pad`:`OSK closed` → selects games in the second zone, or navigates UI components (fields, zoom controls, and elements of the Explorer and Filter panels) in the first or third zone.   
  -`D-pad`:`OSK open` → moves between buttons on the OnScreen Keyboard.

  
  #### 📄 You can open `config.ini` and also edit manually several variables:
  - Mouse settings: `$sensitivity`, `$deadzone` and `$smoothfactor` *(`[Mouse]` section):*
  - Reachable positions of sections and panels *(`[Global]` section):*
    - `$sectionNx`, `$sectionNy` → indicates the 3 points reachable with `$section_back` and `$section_next` *(`LB` and `RB` by default).*  
    - `$sectionNpanelx`, `$sectionNpanely` → reachable points of the Explorer's Tab (if you are in the first zone) or the Zoom control bar (if you are in the second zone).  
    - `$limit1`,`$limit2` → horizontal points which divide the screen in three zones. They are calculated in this manner: *DesktopXRes/ChosenMousePosition*, rounded to the third decimal.
    - `$CurrentSlot` *(`[Wizard]` section)* → modified when you change slot with controller. Used by the wizard to save the points. You can modified it and run the `wizard` also without `GamepadDesktop` running.
  - `$time` → duration *(in seconds)* for which `GamepadDesktop` continues to allow mouse control after `Playnite` loses focus. Useful for interacting with game clients (e.g., `Steam, GOG`) to install games or recovering if OS steals focus (e.g., popups, updates). You can customize this value in the `[Global]` section *(default 17s).*

 

  ### 🔄 Autorun:  
- You can set `Autorun = 1` in `autorun.ini` (also possible by clicking the `Playnite` context menu) to automatically start `GamepadDesktop` when `Playnite` launches.
 

## ⚠️ Notes:
- Please, make sure to maximize Playnite. It's required for the extension to work properly.
<!-- - When Playnite is not focused, `GamepadDesktop` still allows control of the cursor and mouse buttons for 17 seconds. This period lets you interact with game launchers or clients (e.g., Steam, GOG) to install games. After that, the script enters idle mode.!--> 
- On each start, the script loads reachable points from the first slot, under `[Global]` section. You can also edit them directly open the `config.ini` manually or by using the corresponding menu option. `[Global.slot2]` and `[Global.slot3]` contains the points of the other slots.
- When Playnite is not focused, `GamepadDesktop` still allows mouse control (movement, right click, and left click via both `$mouseleft` and `$tabjump_next`) for the duration set by `$time`. This lets you interact with other windows or recover if the OS steals focus. Please remember to click back on `Playnite` after interacting with any prompted clients or launchers. After this period, the script goes idle until `Playnite` regains focus.
- The extension uses the window title of Playnite's Global Search to interact with it. Since this varies by language, only the most common cases are supported. If you encounter issues, please open an issue and specify your language. In the meantime, switching Playnite to English is recommended as a temporary workaround.
- Each time `GamepadDesktop` starts, `$CurrentSlot` (under `[Wizard]`) is set to the first slot.

<br>

**If you enjoy GamepadDesktop, you can buy me a coffee. It will be appreciated ;)**

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/E1E214R1KB)

<br>


<!--![1](https://github.com/roob-p/GamepadDesktop-PlayniteExtension/blob/main/media/1.gif)!-->
<!--[2](https://github.com/roob-p/GamepadDesktop-PlayniteExtension/blob/main/media/2.gif)!-->

### 📺 See it in action!
🚀 **Here's a quick demo of how GamepadDesktop works!**
<!--Here's a quick demo of how GamepadDesktop works:!-->

<table style="width: 100%; text-align: left;">
  <tr>
    <td style="padding: 0; vertical-align: top;">
      <img src="https://github.com/roob-p/GamepadDesktop-PlayniteExtension/blob/main/media/1.gif" style="width: 100%; height: auto;" />
    </td>
  </tr>
   <tr>
    <td style="padding: 0; vertical-align: top;">
      <img src="https://github.com/roob-p/GamepadDesktop-PlayniteExtension/blob/main/media/2.gif" style="width: 100%; height: auto;" />
         </td>
  </tr>
</table>




#### ✨ Here's how the wizard works!  
<table style="width: 100%; text-align: left;">
<tr>
    <td style="padding: 0; vertical-align: top;">
      <img src="https://github.com/roob-p/GamepadDesktop-PlayniteExtension/blob/main/media/3.gif" style="width: 100%; height: auto;" />
    </td>
 </tr>
 </table>
<!--![Wizard](https://github.com/roob-p/GamepadDesktop-PlayniteExtension/blob/main/media/3.gif)!-->



### 🎖️ Credits
This gamepad script was written in AutoIt.  
XInput support was added via the XInput UDF by Oxin8 (xoninx@gmail.com), a short, but useful, AutoIt script found on the web that allows reading the XInput state.

<br>

- Install directly:
  [GamepadDesktop](https://playnite.link/addons.html#GamepadDesktop)
- Download last version:
[v1.0.1]( https://github.com/roob-p/GamepadDesktop-PlayniteExtension/releases/download/v1.0.1/GamepadDesktop_v1.0.1.pext)
