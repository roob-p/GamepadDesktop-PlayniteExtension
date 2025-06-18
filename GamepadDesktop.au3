#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=iconW.ico
#AutoIt3Wrapper_Outfile=GamepadDesktop.exe
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Description=GamepadDesktop
#AutoIt3Wrapper_Res_Fileversion=1.0.2.0
#AutoIt3Wrapper_Res_ProductName=GamepadDesktop (Playnite-Extension)
#AutoIt3Wrapper_Res_ProductVersion=1.0.2
#AutoIt3Wrapper_Res_CompanyName=roob-p (author)
#AutoIt3Wrapper_Res_LegalCopyright=roob-p (author)
#AutoIt3Wrapper_Res_LegalTradeMarks=roob-p (author)
#AutoIt3Wrapper_Res_Language=1040
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <_XInput.au3>
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPI.au3>
#include <WinAPISys.au3>
#include <WinAPISysWin.au3>
#include <Misc.au3>
#include <Keyboard.au3>
#AutoIt3Wrapper_Run_Debug_Mode=n
;AutoItSetOption("TrayIconDebug", 1)
;TraySetToolTip("Executing" & @ScriptLineNumber)

Opt("WinWaitDelay", 0)
Opt("WinTextMatchMode", 2)
Opt("WinTitleMatchMode", 2)

If _Singleton("GamepadDesktop", 1) = 0 Then
	exit
	endif


$wait=2
Global $PlaynitePreviouslyActive = False
$PlayniteCurActive=0
$act=0
$timeractive=0
$timertemp=0

Opt("MouseCoordMode",1)


$hWndd=0
$nstring=0

$activee=0

TraySetIcon(@ScriptDir & "\iconW.ico")

$showosk=False


$inifile=@ScriptDir & "\config.ini"
$inputhwnd = _XInputInit()
$mousepressed= False
$message=""
$PlayniteActive=""
$PlayniteSearchActive=""
$PlayniteActionActive=""
$globalsearchwin=0
$PlayniteActivated=0
$slot="slot1"
$glob="Global"
$wizardExists=0

$hWndLast="asodihasdofhisdaohfosdhf"
$hWndLast2="asodihasdofhisdaohfosdhf"


$globalsearchAttempts = 0

Global $tb_pressed1 = False
Global $tn_pressed1 = False
Global $tb_pressed2 = False
Global $tn_pressed2 = False
Global $explorer_pressed = False
Global $filter_pressed = False
Global $osknotpressed = True
GLobal $oskpressed= False
Global $search_pressed=False

Global $sb_pressed1= False
Global $sn_pressed1=False
Global $sb_pressed2= False
Global $sn_pressed2=False


Global $GSpressedTime = 0
Global $GSisPressing = False

Global $SGSPressedTime = 0
Global $SGSIsPressing = False

;Global $LSIsPressing = False
;Global $RSIsPressing = False
;Global $LSPressedTime = 0
;Global $RSPressedTime = 0

Global $explorerIsPressing = False
Global $explorerPressedTime = 0
Global $explorerDuration= ""

Global $filterIsPressing = False
Global $filterPressedTime = 0
Global $filterDuration= ""

Global $mousePressed[4] = [False,False,False,False]
Global $mouseDownTimer = 0

Global $frameDelay = 1000 / 165	;120,100,60; (60fps-> 16.67 ms)
Global $gfpsTimer, $gframeDelay

Global $scrolldiv = 4000


$time=0
$sleepIdleTime=600

$timer=0
$timercheck=0
$timerW=0
$timerpos=0
Global $timerleftpress=0
$timerleftpress2=0
Global $lastMouseMove = 0
Global $timeridle= 0
Global $hasfocus= False
$timerlost=0
$timerlostact=False

;$timerfps=Timerinit()

$timerTooltip=""
$emergencyTimer=""

Global $adlibactive = False



Global $prevX = 0, $prevY = 0
$sensitivity = 150
$deadZone = 2000
$smoothFactor=0.2


$sensitivity=Iniread($inifile,"Mouse","sensitivity","")
$deadzone=Iniread($inifile,"Mouse","deadzone","")
$smoothFactor=Iniread($inifile,"Mouse","smoothFactor","")



$section1x=50
$section1y=105

$section2x=500
$section2y=105

$section3x=1750
$section3y=105

$section4x=""
$section4y=""



$scroll1x=274
$scroll1y=105

$scroll2x=1678
$scroll2y=68

$scroll3x=1919
$scroll3y=140
$scroll3ymax=1000

$scroll1pos=""
$scroll2pos=""
$scroll3pos=""

$section1panelx=270
$section1panely=75

$section2panelx=400
$section2panely=1015

$search_panelx=220
$search_panely=25

$limit1=6.881
$limit2=1.144

$ScreenMinY = 60
$ScreenMaxY = 1000


IniWrite($inifile,"Wizard","$currentSlot","Global")

Global $drag = False, $offset[2], $prevPos = [-1, -1]


$tabi=0
$tab2y= 313
$jump=55



$section1x=Iniread($inifile,"Global","$section1x","")
$section1y=Iniread($inifile,"Global","$section1y","")
$section2x=Iniread($inifile,"Global","$section2x","")
$section2y=Iniread($inifile,"Global","$section2y","")
$section3x=Iniread($inifile,"Global","$section3x","")
$section3y=Iniread($inifile,"Global","$section3y","")

$section1panelx=Iniread($inifile,"Global","$section1panelx","")
$section1panely=Iniread($inifile,"Global","$section1panely","")
$section2panelx=Iniread($inifile,"Global","$section2panelx","")
$section2panely=Iniread($inifile,"Global","$section2panely","")
$search_panelx=Iniread($inifile,"Global","$search_panelx","")
$search_panely=Iniread($inifile,"Global","$search_panely","")

$limit1=Iniread($inifile,"Global","$limit1","")
$limit2=Iniread($inifile,"Global","$limit2","")

$time=Iniread($inifile,"Global","$time","")
$sleepIdleTime=Iniread($inifile,"Global","$sleepIdleTime","")





$pos=0


$resX= @DesktopWidth
$resY= @DesktopHeight


Global $scrolling = False



Global $holdDelay = 400     ; delay before key repeat starts (ms)
Global $repeatSpeed = 25    ; key repeat speed (ms)

Global $wasDown[6] = [False, False, False, False, False, False]
Global $firstPressTime[6] = [0, 0, 0, 0, 0]
Global $lastRepeatTime[6] = [0, 0, 0, 0, 0]




$input = _XInputGetInput($inputhwnd)
$buttons = _XInputButtons($input[2])


$A=$buttons[11]
$B=$buttons[12]
$X=$buttons[13]
$Y=$buttons[14]
$start=$buttons[5]
$back=$buttons[6]
$LS=$buttons[7]
$RS=$buttons[8]
$LB=$buttons[9]
$RB=$buttons[10]
$up=$buttons[1]
$down=$buttons[2]
$left=$buttons[3]
$right=$buttons[4]

$LT=$input[3]
$RT=$input[4]

$LSX=$input[5]
$LSY=$input[6]
$RSX=$input[7]
$RSY=$input[8]

$LS=$buttons[7]
$RS=$buttons[8]


$LSleft = $LSX<-3000
$LSright = $LSX>3000
$LSdown = $LSY<-3000
$LSup = $LSY>3000

$RSleft = $RSX<-3000
$RSright = $RSX>3000
$RSdown = $RSY<-3000
$RSup = $RSY>3000



$mouseleft=IniRead($inifile,"Keys","$mouseleft","")
$mouseright=IniRead($inifile,"Keys","$mouseright","")
$search = IniRead($inifile,"Keys","$search","")
$globalsearch = IniRead($inifile,"Keys","$globalsearch","")
$mousemovx=IniRead($inifile,"Keys","$mousemovx","")
$mousemovy=IniRead($inifile,"Keys","$mousemovy","")
$scroll=IniRead($inifile,"Keys","$scroll","")
$tabjump_back=IniRead($inifile,"Keys","$tabjump_back","")
$tabjump_next=IniRead($inifile,"Keys","$tabjump_next","")
$section_back=IniRead($inifile,"Keys","$section_back","")
$section_next=IniRead($inifile,"Keys","$section_next","")
$enter=IniRead($inifile,"Keys","$enter","")
$osk=IniRead($inifile,"Keys","$osk","")
$up=IniRead($inifile,"Keys","$up","")
$down=IniRead($inifile,"Keys","$down","")
$left=IniRead($inifile,"Keys","$left","")
$right=IniRead($inifile,"Keys","$right","")
$filter=IniRead($inifile,"Keys","$filterAndSlot_next","")
$explorer=IniRead($inifile,"Keys","$explorerAndSlot_back","")
;$stand-glob_search==IniRead($inifile,"Keys","$stand-glob_search","")

$confirm="A"
$standglob_search=""


AdlibRegister(mouseBenteract,100)
AdlibRegister(wizardcheck,250)
;AdlibRegister(PlayniteIsActive,250)


;SplashTextOn("BO",$message,-1,400,-1,-1)

While 1
;_FPSLimiter_Start(165)
$timerfps=Timerinit()


;buttons()
;mouse()





;If TimerDiff($timer) > 300 then
;$timer = TimerInit()
;;;;PlayniteActive()
;PlayniteIsActive()
;endif


main()

if timerdiff($timerTooltip)>2500 Then
	Tooltip("")
	endif




	Local $elapsed = TimerDiff($timerfps)
    Local $remaining = $frameDelay - $elapsed
		;Local $remaining = Int($frameDelay - $elapsed) ;no
	If $remaining > 0 Then
	;If $remaining > 0 And $remaining < 18 Then
		Sleep($remaining)
		;sleep(1)
	Else
		;sleep(1)
		endif
	;If $remaining > 0 And $remaining < 18 Then Sleep($remaining)    ;165hz: 18; 120fps: 20; 100hz: 25; 60fps: 33




 ;_FPSLimiter_End()
wend





func pos()

if MouseGetPos(0)<($resX/$limit1) then
$pos=1
;if (MouseGetPos(0))>=($resX/$limit1) and (MouseGetPos(0)) <($resX-($resX/$limit2)) then; old
elseif (MouseGetPos(0))>=($resX/$limit1) and (MouseGetPos(0) < $resx/$limit2) then
	$pos=2
;if (MouseGetPos(0))>=($resX-($resX/$limit2)) then old
elseif (MouseGetPos(0)>=$resX/$limit2) then
	$pos=3
endif
endfunc

func verbose()
$message="Pos: "& $pos &"  Mousex  "& mousegetpos(0)& "  MouseY  " & mousegetpos(1) & "  Calc  "& $resx-mousegetpos(0) & @CRLF & "curActive: " & $PlayniteCurActive & @CRLF & "$hWndd: " & $hWndd & @CRLF & "nstring: " & $nstring & @CRLF & "active :" & $PlayniteActivated & @CRLF & "mousepressed: " & $mousepressed  & @CRLF & "globsearchwin: " & $globalsearchwin  & @CRLF & "wgt(active): " & wingettitle("[ACTIVE]")& @CRLF & "guigetcursorinfo: " & GUIGetCursorInfo("[ACTIVE]") ;& WinGetTitle("[ACTIVE]") & @CRLF & $globalsearchwin ;& @CRLF & PlayniteIsActive; & @CRLF & WinGetTitle("[ACTIVE]")
ControlSetText("BO","","Static1", $message)
	endfunc

func main()
;verbose()


;if $PlayniteActivated=1 then
If PlayniteIsActive() Then
;$hasfocus=True ;useless
$timerlostact=False


;local $msg=GUIGetMsg()
;if $msg>0 Then
;	senderM($msg)
;endif

buttons()
pos()
mouse()
sender()
drag()

;sleep(1)
;sleep(10)


_HandleKey(bv($enter),5, "{ENTER}")

if $showosk=true Then
;sender()

$repeatSpeed = 25
    _HandleKeyX($up, 0)
    _HandleKeyX($down, 1)
    _HandleKeyX($left, 2)
    _HandleKeyX($right, 3)
	_HandleKeyX(bv($confirm),4)

	_Handlemouse(bv($tabjump_next),0)
	_Handlemouse(bv($mouseright),1)

	$timerleftpress=TimerInit()



else

$repeatSpeed = 10

    _HandleKey($up, 0, "{UP}")
    _HandleKey($down, 1, "{DOWN}")
    _HandleKey($left, 2, "{LEFT}")
    _HandleKey($right, 3, "{RIGHT}")


	_Handlemouse(bv($mouseleft),0)
	_Handlemouse(bv($mouseright),1)


	endif



If bv($osk) Then
    If Not $oskPressed Then
		if $showosk = True Then
			guisetstate(@SW_HIDE,$tgui)
			$showosk=False
		else

		$showosk = True
		guisetstate(@SW_SHOW,$tgui)

		WinActivate("Playnite")
		GUICtrlSetState($hiddenBtn, $GUI_FOCUS)

		endif

        $oskPressed = True
    EndIf
Else
    $oskPressed = False
EndIf




if bv($search) then
	if not $search_pressed then
	if $showosk=True then
            MouseClick("left",$search_panelx,$search_panely,1,0)
			$search_pressed=True
			else
			$showosk=True
			guisetstate(@SW_SHOW)
			WinActivate("Playnite")
			MouseClick("left",$search_panelx,$search_panely,1,0)
			$search_pressed=True
			endif
	endif
	Else
	$search_pressed=False
endif




If bv($globalsearch) Then
    If Not $GSisPressing Then
        $GSpressedTime = TimerInit()
        $GSisPressing = True
    EndIf
Else
    If $GSisPressing Then
        Local $Sduration = TimerDiff($GSpressedTime)
        $GSisPressing = False

        If $Sduration < 1000 Then

			if $showosk=True then
            Send("^f")
			else
			$showosk=True
			guisetstate(@SW_SHOW)
			WinActivate("Playnite")
			send("^f")
			endif
        Else
			send("{F11}")
        EndIf
    EndIf
EndIf



;unused, for now
If bv($standglob_search) Then
    If Not $SGSIsPressing Then
        $SGSPressedTime = TimerInit()
        $SGSIsPressing = True
    EndIf
Else
    If $SGSIsPressing Then
        Local $SGSDuration = TimerDiff($SGSpressedTime)
        $SGSIsPressing = False

        If $SGSDuration < 1000 Then
            MouseClick("left",$search_panelx,$search_panely,1,0)
        Else
			send("^f")
        EndIf
    EndIf
EndIf



if bv($explorer) then
	if not $explorerIsPressing  Then
		$explorerPressedTime = TimerInit()
        $explorerIsPressing = True
	endif
else
	if $explorerIsPressing then
	$explorerDuration= TimerDiff($explorerPressedTime)
	$explorerIsPressing=False

		if $explorerDuration<800 Then
		send("^e")
		else
		changeslotback()
		endif
	endif
endif



if bv($filter) then
	if not $filterIsPressing  Then
		$filterPressedTime = TimerInit()
        $filterIsPressing = True
	endif
else
	if $filterIsPressing then
	$filterDuration= TimerDiff($filterPressedTime)
	$filterIsPressing=False

		if $filterDuration<800 Then
		send("^g")
		else
		changeslotnext()
		endif
	endif
endif




$chain=0


;sections
if bv($section_back) and $pos<=2 then
	If Not $sb_pressed1 Then
	MouseClick("left",$section1x,$section1y,1,10)
	$pos=1
	$sb_pressed1=True
	endif
Else
    $sb_pressed1 = False
endif

if bv($section_back) and $pos=3 then
	If Not $sb_pressed2 Then
	MouseClick("left",$section2x+10,$section2y,1,10)
	MouseClick("left",$section2x,$section2y,1,11)
	;MouseClick("left",$section2x-1,$section2y,1,0)
	$pos=2
	$sb_pressed2=True
	endif
Else
    $sb_pressed2 = False
endif


if bv($section_next) and $pos=1 then
	If Not $sn_pressed1 Then
	MouseClick("left",$section2x,$section2y,1,10)
	$pos=2
	$mouseposx=mousegetpos(0)
	$mouseposy=mousegetpos(1)
	$chain=1
	$sn_pressed1=True
	endif
Else
    $sn_pressed1 = False
endif

;endif

if bv($section_next) and $pos>=2 then
	If Not $sn_pressed2 Then
	MouseClick("left",$section3x,$section3y,1,10)
	$pos=3
	$sn_pressed2=True
	endif
Else
    $sn_pressed2 = False
endif





;scrolls_calls
	if $pos=1 Then
		ScrollWheel1(BV($scroll), $deadzone)
		endif

	if $pos=2 Then
		ScrollWheel2(BV($scroll), $deadzone)
		endif

	if $pos=3 Then
		ScrollWheel3(BV($scroll), $deadzone)
		endif




;section1_panel
If bv($tabjump_back) And $pos = 1 Then
    If Not $tb_pressed1 Then
        MouseClick("left", $section1panelx, $section1panely, 1, 0)
        $tb_pressed1 = True
    EndIf
Else
    $tb_pressed1 = False
EndIf


if $showosk=False then


;section2_panel (zoom)
;If bv($tabjump_next) And $pos = 2 Then
If bv($tabjump_next) And $pos = 2 and (TimerDiff($timerleftpress)>200 or $timerleftpress=0) Then
    If Not $tn_pressed2 Then
        MouseClick("left", $section2panelx, $section2panely, 1, 0)
		$timerleftpress=0
        $tn_pressed2 = True
    EndIf
Else
    $tn_pressed2 = False
EndIf



Else

;_Handlemouse(bv($tabjump_next),0)  ;mouse-leftclick when the osk is open

endif


;section2 (back)
If bv($tabjump_back) And $pos = 2 Then
    If Not $tb_pressed2 Then
        MouseClick("left", $section2x, $section2y, 1, 0)
        $tb_pressed2 = True
    EndIf
Else
    $tb_pressed2 = False
EndIf


if ($chain=1) and (mousegetpos(0) <> $mouseposx or mousegetpos(1) <> $mouseposy)  Then
	$chain=0

endif


Else; PlayniteIsActive False:

	if $timerlostact=False then
	$timerlost=timerinit()
	$timerlostact=True
	endif

	If $showosk = True Then
	GUISetState(@SW_HIDE, $tGUI)
	$showosk = False
	EndIf

if timerdiff($timerlost)<$time*1000 then
Local $hWnd2 = WinGetHandle("[ACTIVE]")
Local $sClass2 = _WinAPI_GetClassName($hWnd2)

 If $hWnd2 <> $hWndLast2 Then

		$hWndd2 = WinGetTitle($hWnd2)
        $hWndLast2 = $hWnd2
    EndIf

	if not StringInStr($sClass2,"Playnite.Fullscreen") then
		;$timerleftpress2=timerinit()
		$timerleftpress=TimerInit()
	buttons()
	mouse()
	_Handlemouse(bv($mouseleft),0)
	_Handlemouse(bv($mouseright),1)
	;if and (TimerDiff($timerleftpress>200) or $timerleftpress=0)
	_Handlemouse(bv($tabjump_next),3)

	endif
else


    Sleep($sleepIdleTime)
endif




endif  ; PlayniteIsActive-PlayniteIsActivated

	endfunc ; main



func wizardcheck()
	if ProcessExists("GamepadDesktop-Wizard.exe") Then
		$wizardExists=1
	endif

	if $wizardExists=1 Then
	if not ProcessExists("GamepadDesktop-Wizard.exe") then
	$wizardExists=0
	reload()
	EndIf
	endif

	EndFunc


func reload()
$section1x=Iniread($inifile,$glob,"$section1x","")
$section1y=Iniread($inifile,$glob,"$section1y","")
$section2x=Iniread($inifile,$glob,"$section2x","")
$section2y=Iniread($inifile,$glob,"$section2y","")
$section3x=Iniread($inifile,$glob,"$section3x","")
$section3y=Iniread($inifile,$glob,"$section3y","")

$section1panelx=Iniread($inifile,$glob,"$section1panelx","")
$section1panely=Iniread($inifile,$glob,"$section1panely","")
$section2panelx=Iniread($inifile,$glob,"$section2panelx","")
$section2panely=Iniread($inifile,$glob,"$section2panely","")
$search_panelx=Iniread($inifile,$glob,"$search_panelx","")
$search_panely=Iniread($inifile,$glob,"$search_panely","")

$limit1=Iniread($inifile,"Global","$limit1","")
$limit2=Iniread($inifile,"Global","$limit2","")

	endfunc

Func changeslotnext()
  switch $slot
	case "slot1"
		$slot="slot2"
		$glob="Global.slot2"
	case "slot2"
		$slot="slot3"
		$glob="Global.slot3"
  endswitch
  reload()
  iniwrite($inifile,"Wizard","$currentSlot",$glob)
  $cPos=MouseGetPos()
  tooltip($slot,$cPos[0]+@DesktopWidth/50,$cPos[1],"","")
  $timerTooltip=TimerInit()
endfunc

func changeslotback()
  switch $slot
	case "slot2"
		$slot="slot1"
		$glob="Global"
	case "slot3"
		$slot="slot2"
		$glob="Global.slot2"
  endswitch
  reload()
  iniwrite($inifile,"Wizard","$currentSlot",$glob)
  $cPos=MouseGetPos()
  tooltip($slot,$cPos[0]+@DesktopWidth/50,$cPos[1])
  $timerTooltip=TimerInit()
endfunc





Func PlayniteIsActive()

Local $hWnd = WinGetHandle("[ACTIVE]")
Local $sClass = _WinAPI_GetClassName($hWnd)


 If $hWnd <> $hWndLast Then
        $hWndd = WinGetTitle($hWnd) ; This function is heavy, limit its usage. The IF statement ensures it's executed only when the active window changes.
        $hWndLast = $hWnd
    EndIf


If StringInStr($sClass,"Chrome_WidgetWin") Then Return 0

;If @error Or $hWnd = "" Then
If $hWnd = "" Then
    $hWndd = 0
Else
    ;$hWndd = WinGetTitle($hWnd) ; NO! adds unnecessary continuous overhead!
EndIf

$nstring=StringLen($hWndd)

$hWndd=StringLeft($hWndd,28)


if $nstring>8 and (StringInStr($hWndd," Playnite") or StringInStr($hWndd,"-Playnite") or StringInStr($hWndd,"Playnite ") or StringInStr($hWndd,"Playnite-")) then
	$globalsearchwin=1

endif


if $globalsearchwin=1 Then

		if not winactive("Playnite") and ($nstring = 0 Or ($nstring <= 8 And Not StringInStr($hWndd, "Playnite"))) then  ;perfetto
		WinActivate("Playnite")
		$globalsearchwin=0
		endif
	endif

		;if StringInStr($sClass,"Playnite.Desktop") Or ($nstring>8 and (StringInStr($hWndd," Playnite") or StringInStr($hWndd,"-Playnite"))) or WinActive("On Screen Keyboard") then
		if StringInStr($sClass,"Playnite.Desktop") Or ($nstring>8 and (StringInStr($hWndd," Playnite") or StringInStr($hWndd,"-Playnite"))) or StringInStr($hWndd, "On Screen Keyboard") then

$PlayniteActivated=1
Else
$PlayniteActivated=0

endif


;Return StringInStr($sClass,"Playnite.Desktop") Or ($nstring>8 and (StringInStr($hWndd," Playnite") or StringInStr($hWndd,"-Playnite"))) or WinActive("On Screen Keyboard")
Return StringInStr($sClass,"Playnite.Desktop") Or ($nstring>8 and (StringInStr($hWndd," Playnite") or StringInStr($hWndd,"-Playnite"))) or StringInStr($hWndd, "On Screen Keyboard")

endfunc




;Unused
func PlayniteActive()


if WinActive("Playnite") then
	$PlayniteActive = 1
else
	$PlayniteActive = 0
	endif

if WinActive("Ricerca Playnite")  Then
	$PlayniteSearchActive = 1
else
	$PlayniteSearchActive = 0
	endif

	endfunc



Func ScrollWheel1($value, $deadZone)
    If Abs($value) > $deadZone Then
        Local $steps = Ceiling((Abs($value) - $deadZone) / $scrolldiv) ; The smaller the divisor, the more sensitive it is.

        If $value < 0 Then
            MouseWheel($MOUSE_WHEEL_DOWN, $steps)
			;MouseWheel($MOUSE_WHEEL_DOWN, 1+$steps)
        Else
            MouseWheel($MOUSE_WHEEL_UP, $steps)
			;MouseWheel($MOUSE_WHEEL_UP, 1+$steps)
        EndIf
	;sleep(1)
    EndIf
	;sleep(1)
EndFunc



Func ScrollWheel2($value, $deadZone)
    If Abs($value) > $deadZone Then
        Local $steps = Ceiling((Abs($value) - $deadZone) / $scrolldiv)
        If $value < 0 Then
            MouseWheel($MOUSE_WHEEL_DOWN, $steps)
        Else
            MouseWheel($MOUSE_WHEEL_UP, $steps)
        EndIf
    EndIf
EndFunc



Func ScrollWheel3($value, $deadZone)
    If Abs($value) > $deadZone Then
        Local $steps = Ceiling((Abs($value) - $deadZone) / $scrolldiv)
        If $value < 0 Then
            MouseWheel($MOUSE_WHEEL_DOWN, $steps)
        Else
            MouseWheel($MOUSE_WHEEL_UP, $steps)
        EndIf
    EndIf
EndFunc





Func BV($name)
    Switch $name
        Case "A"
            Return $buttons[11]
        Case "B"
            Return $buttons[12]
        Case "X"
            Return $buttons[13]
        Case "Y"
            Return $buttons[14]
        Case "start"
            Return $buttons[5]
        Case "back"
            Return $buttons[6]
        Case "LB"
            Return $buttons[9]
        Case "RB"
            Return $buttons[10]
        Case "LT"
            Return $input[3]
        Case "RT"
            Return $input[4]
        Case "LS"
            Return $buttons[7]
        Case "RS"
            Return $buttons[8]
        Case "LSX"
            Return $input[5]
        Case "LSY"
            Return $input[6]
        Case "RSX"
            Return $input[7]
        Case "RSY"
            Return $input[8]
        ;Case Else
         ;   Return -1 ; default/null
	EndSwitch
EndFunc



func mouse()
	 If TimerDiff($lastMouseMove) < 10 then
		 sleep(1)
        Return
    EndIf



    $mousePos = MouseGetPos()

	If Abs(bv($mousemovx)) < $deadZone And Abs(bv($mousemovy)) < $deadZone Then


			$prevX = $mousePos[0]
			$prevY = $mousePos[1]

        ;;Sleep(50)
        ;;ContinueLoop
		return ;;instead of ContinueLoop
    EndIf


	$newX = $mousePos[0] + (bv($mousemovx) / 32768) * $sensitivity
    $newY = $mousePos[1] - (bv($mousemovy) / 32768) * $sensitivity


    $newX = Clip($newX, 0, @DesktopWidth)  ;1920
    $newY = Clip($newY, 0, @DesktopHeight) ;1080

	; Smooth movement - interpolation between current and target position
	; $smoothFactor = 0.1 ; How smooth should the movement be? (0 = no smoothing, 1 = very smooth)


    ; Gradually calculate the mouse position
    $finalX = $prevX + ($newX - $prevX) * $smoothFactor
    $finalY = $prevY + ($newY - $prevY) * $smoothFactor

    ; Gradually move the mouse towards the calculated position
    MouseMove($finalX, $finalY, 0)  ; Set "0" for speed since interpolation is used


    $prevX = $finalX
    $prevY = $finalY


	 $lastMouseMove = TimerInit()

;sleep(1)
endfunc



Func Clip($value, $min, $max)
    If $value < $min Then
        Return $min
    ElseIf $value > $max Then
        Return $max
    Else
        Return $value
    EndIf
EndFunc





;osk off
Func _HandleKey($isDown, $index, $key)
     ;State change from not pressed to pressed (immediate send)
    If $isDown And Not $wasDown[$index] Then
        Send($key)
        $firstPressTime[$index] = TimerInit()
        $lastRepeatTime[$index] = TimerInit()
    ElseIf $isDown And $wasDown[$index] Then
        ; Auto repeat
        Local $heldTime = TimerDiff($firstPressTime[$index])
        Local $sinceLastRepeat = TimerDiff($lastRepeatTime[$index])
        If $heldTime >= $holdDelay And $sinceLastRepeat >= $repeatSpeed Then
            Send($key)
            $lastRepeatTime[$index] = TimerInit()
        EndIf
    EndIf

    $wasDown[$index] = $isDown
EndFunc

Func _HandleMouse($isDown,$index)
    If $isDown And Not $mousePressed[$index] Then
        switch $index
			case 0
			MouseDown("left")
			$mousePressed[0] = True
			case 1
			MouseDown("right")
			$mousePressed[1] = True
			case 3
			MouseDown("left")
			$mousePressed[3] = True
		endswitch
    ElseIf Not $isDown And $mousePressed[$index] Then
		switch $index
			case 0
			MouseUp("left")
			$mousePressed[0] = False
			case 1
			MouseUp("right")
			$mousePressed[1] = False
			Case 3
			MouseUp("left")
			$mousePressed[3] = False
		endswitch
    EndIf

EndFunc



func buttons()
	$input = _XInputGetInput($inputhwnd)
$buttons = _XInputButtons($input[2])


$A=$buttons[11]
$B=$buttons[12]
$X=$buttons[13]
$Y=$buttons[14]
$start=$buttons[5]
$back=$buttons[6]
$LS=$buttons[7]
$RS=$buttons[8]
$LB=$buttons[9]
$RB=$buttons[10]


$up=$buttons[1]
$down=$buttons[2]
$left=$buttons[3]
$right=$buttons[4]

$LT=$input[3]
$RT=$input[4]

$LSX=$input[5]
$LSY=$input[6]
$RSX=$input[7]
$RSY=$input[8]

$LS=$buttons[7]
$RS=$buttons[8]


$LSleft = $LSX<-3000
$LSright = $LSX>3000
$LSdown = $LSY<-3000
$LSup = $LSY>3000

$RSleft = $RSX<-3000
$RSright = $RSX>3000
$RSdown = $RSY<-3000
$RSup = $RSY>3000
	endfunc


;////////unused:




;unused
func emergency_close()
	If _IsPressed("1B") And TimerDiff($emergencyTimer) < 500 Then
    Exit
ElseIf _IsPressed("1B") Then
    $emergencyTimer = TimerInit()
EndIf

	endfunc

;unused
func mousecheck()
if $mousepressed=1 and WinActive="" and $show= True Then
	WinActive("On Screen Keyboard")
	endif
	endfunc


;unused
Func IsCursorOnTitlebar()
    Local $info = GUIGetCursorInfo($tGui)
    If @error Or Not IsArray($info) Then Return False

    ; If we're in the GUI but not on a control → probably the title bar
    If $info[4] = 0 Then Return True

    Return False
EndFunc


;unused
func ScrollWheel1m($value,$deadzone)
	;Local $speed = (-$value / 32768) * 5
If Abs($value) > $deadZone Then
	if $value<0 then
	MouseWheel($MOUSE_WHEEL_DOWN,1)
	Elseif $value>0 then
	MouseWheel($MOUSE_WHEEL_UP,1)
	endif
endif
endfunc

;unused
Func FPSLimiter_Start($fps)
    $gframeDelay = 1000 / $fps
    $gfpsTimer = TimerInit()
EndFunc

;unused
Func FPSLimiter_End()
    Local $elapsed = TimerDiff($gfpsTimer)
    Local $remaining = Int($gframeDelay - $elapsed)
    If $remaining > 0 And $remaining < $gframeDelay * 3 Then Sleep($remaining)
EndFunc


;added a more advanced function
;if bv($globalsearch) Then
;	send("^f")
;endif

;added a more advanced function
;if bv($enter) Then
;	send("{ENTER}")
;endif

;added a more advanced function
 ;if bv($mouseright) then
 ; mouseclick("right")
 ;endif

