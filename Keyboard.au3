#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=some.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.0.1
#AutoIt3Wrapper_Res_ProductName=GamepadDesktop (Playnite-Extension)
#AutoIt3Wrapper_Res_ProductVersion=1.0.1
#AutoIt3Wrapper_Res_CompanyName=roob-p (author)
#AutoIt3Wrapper_Res_LegalCopyright=roob-p (author)
#AutoIt3Wrapper_Res_LegalTradeMarks=roob-p (author)
#AutoIt3Wrapper_Res_Language=1040
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <ButtonConstants.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <WinAPI.au3>


#AutoIt3Wrapper_Run_Debug_Mode=n
;AutoItSetOption("TrayIconDebug", 1)


;ProcessSetPriority("AutoIt3.exe", 2)
Opt("MouseCoordMode",2)


Local $hDLL = DllOpen("user32.dll")

Global $curX = -1, $curY = -1 ; No keys selected at beginning
Global $aButtons[6][15]
Global $aRowLengths = [15, 13, 13, 13, 14, 10]

Global $drag = False, $offset[2]

$hFocusKiller=""


$activee=0

;$resx=1920
;$resy=1080

$resx=@DesktopWidth
$resy=@DesktopHeight

$show=False
$recc=-1
$reca=0

$Benter=0

Global $capsEnabled= False

Global $holdDelay = 400     ; delay before key repeat starts (ms)
Global $repeatSpeed = 50    ; key repeat speed (ms)

Global $wasDown[4] = [False, False, False, False]
Global $firstPressTime[4] = [0, 0, 0, 0]
Global $lastRepeatTime[4] = [0, 0, 0, 0]




;Global $aKeyCodes[5] = ["25", "27", "26", "28", "20"]


Global $wasDown[5] = [False, False, False, False, False]
Global $firstPressTime[5] = [0, 0, 0, 0, 0]
Global $lastRepeatTime[5] = [0, 0, 0, 0, 0]





;$size=40
$size=$resx/48
$posx=$size
$posy=$size




;$tGui = GUICreate("On Screen Keyboard", $resx/3-($resx/65), $resy/2.25/2, -1, @DesktopHeight-$resy/2.25/2, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
			 ;$tGui = GUICreate("On Screen Keyboard", $resx/3-($resx/65), $resy/2.25/2, -1, -1, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
			 $tGui = GUICreate("On Screen Keyboard", $resx/3-($resx/65), $resy/2.25/2, -1, @DesktopHeight/2.25, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
;$tGui = GUICreate("On Screen Keyboard", $resx/3-($resx/65), $resy/2.25/2, -1, -1, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, $WS_EX_NOACTIVATE))


	$winPos = WinGetPos($tGui)
    $winX = $winPos[0]
    $winY = $winPos[1]
    $winWidth = $winPos[2]
    $winHeight = $winPos[3]



;Global $hLabelFinta=""
Global $hLabelFinta = GUICtrlCreateLabel("", -100, -100, 10, 10) ; out of the screen
$hiddenBtn = GUICtrlCreateButton("", -100, -100, 10, 10)





$lblDragZone=""
$btnclose=""




$yy=""
$yyv1=""
$xx=""
$xxv1=""
$xxv2=""
$xxv2A=""
$xxv3=""
$xxv4=""
$xxv5=""
$xxv5A=""
$tstart=$size/3

$style=0



if $style=1 then
$tstart=$size/3
$btnClose = GUICtrlCreateLabel("",$resx/3-($resx/65)-$size,0,$size,$size/3)
$lblDragZone = GUICtrlCreateLabel("", 0,0, $resx/3-($resx/65)-$size, $size/3)
GUICtrlSetBkColor(-1, -2)
		GUICtrlSetCursor(-1, 9)
GUICtrlSetBkColor($btnClose, 0x3399FF)
GUICtrlSetColor($btnClose, 0xFFFFFF)

GUICtrlSetCursor($btnClose, 0)


Else
$tstart=0

$btnClose = GUICtrlCreateLabel("",$resx/3-($resx/65)-$size,$resy/2.25/2-$size/3,$size,$size/3)
$lblDragZone = GUICtrlCreateLabel("", 0,$resy/2.25/2-$size/3, $resx/3-($resx/65)-$size, $size/3)  ;$size ; ultimi 20px in basso
GUICtrlSetBkColor(-1, -2)
		GUICtrlSetCursor(-1, 9)
GUICtrlSetBkColor($btnClose, 0x3399FF)
GUICtrlSetColor($btnClose, 0xFFFFFF)

GUICtrlSetCursor($btnClose, 0)

endif







$kEsc = GUICtrlCreateButton("Esc", $posx*0, $tstart + $posy*0, $size, $size/1.5)
$kF1 = GUICtrlCreateButton("F1", $posx*1, $tstart + $posy*0, $size, $size/1.5)
$kF2 = GUICtrlCreateButton("F2", $posx*2, $tstart + $posy*0, $size, $size/1.5)
$kF3 = GUICtrlCreateButton("F3", $posx*3, $tstart + $posy*0, $size, $size/1.5)
$kF4 = GUICtrlCreateButton("F4", $posx*4, $tstart + $posy*0, $size, $size/1.5)
$kF5 = GUICtrlCreateButton("F5", $posx*5, $tstart + $posy*0, $size, $size/1.5)
$kF6 = GUICtrlCreateButton("F6", $posx*6, $tstart + $posy*0, $size, $size/1.5)
$kF7 = GUICtrlCreateButton("F7", $posx*7, $tstart + $posy*0, $size, $size/1.5)
$kF8 = GUICtrlCreateButton("F8", $posx*8, $tstart + $posy*0, $size, $size/1.5)
$kF9 = GUICtrlCreateButton("F9", $posx*9, $tstart + $posy*0, $size, $size/1.5)
$kF10 = GUICtrlCreateButton("F10", $posx*10,$tstart + $posy*0, $size, $size/1.5)
$kF11 = GUICtrlCreateButton("F11", $posx*11,$tstart + $posy*0, $size, $size/1.5)
$kF12 = GUICtrlCreateButton("F12", $posx*12,$tstart + $posy*0, $size, $size/1.5)
$kIns = GUICtrlCreateButton("Ins", $posx*13,$tstart + $posy*0, $size, $size/1.5)
$kCanc = GUICtrlCreateButton("Canc", $posx*14,$tstart + $posy*0, $size*1.25, $size/1.5)


$yy=$posy-$posy/1.5
$yyv1=$yy
$kbackslash=GUICtrlCreateButton("\", $posx*0, -$yy+$tstart + $posy*1, $size, $size)
$k1 = GUICtrlCreateButton("1", $posx*1, -$yy+$tstart + $posy*1, $size, $size)
$k2 = GUICtrlCreateButton("2", $posx*2, -$yy+$tstart + $posy*1, $size, $size)
$k3 = GUICtrlCreateButton("3", $posx*3, -$yy+$tstart + $posy*1, $size, $size)
$k4 = GUICtrlCreateButton("4", $posx*4, -$yy+$tstart + $posy*1, $size, $size)
$k5 = GUICtrlCreateButton("5", $posx*5, -$yy+$tstart + $posy*1, $size, $size)
$k6 = GUICtrlCreateButton("6", $posx*6, -$yy+$tstart + $posy*1, $size, $size)
$k7 = GUICtrlCreateButton("7", $posx*7, -$yy+$tstart + $posy*1, $size, $size)
$k8 = GUICtrlCreateButton("8", $posx*8, -$yy+$tstart + $posy*1, $size, $size)
$k9 = GUICtrlCreateButton("9", $posx*9, -$yy+$tstart + $posy*1, $size, $size)
$k0 = GUICtrlCreateButton("0", $posx*10, -$yy+$tstart + $posy*1, $size, $size)

$kapostrofo=GUICtrlCreateButton("'",  $posx*11, -$yy+$tstart + $posy*1, $size, $size)
$ki_accentata=GUICtrlCreateButton("ì", $posx*12, -$yy+$tstart + $posy*1, $size, $size)
$kbackspace=GUICtrlCreateButton("<--",$posx*13, -$yy+$tstart + $posy*1, $size*2.25, $size)

$kTab=GUICtrlCreateButton("Tab", $posx*0, -$yy+$tstart + $posy*2, $size*1.5, $size)
$xx=$posx/2
$xxv2=$xx
$kQ=GUICtrlCreateButton("Q", $xx+$posx*1, -$yy+$tstart + $posy*2, $size, $size)
$kW=GUICtrlCreateButton("W", $xx+$posx*2, -$yy+$tstart + $posy*2, $size, $size)
$kE=GUICtrlCreateButton("E", $xx+$posx*3, -$yy+$tstart + $posy*2, $size, $size)
$kR=GUICtrlCreateButton("R", $xx+$posx*4, -$yy+$tstart + $posy*2, $size, $size)
$kT=GUICtrlCreateButton("T", $xx+$posx*5, -$yy+$tstart + $posy*2, $size, $size)
$kY=GUICtrlCreateButton("Y", $xx+$posx*6, -$yy+$tstart + $posy*2, $size, $size)
$kU=GUICtrlCreateButton("U", $xx+$posx*7, -$yy+$tstart + $posy*2, $size, $size)
$kI=GUICtrlCreateButton("I", $xx+$posx*8, -$yy+$tstart + $posy*2, $size, $size)
$kO=GUICtrlCreateButton("O", $xx+$posx*9, -$yy+$tstart + $posy*2, $size, $size)
$kP=GUICtrlCreateButton("P", $xx+$posx*10, -$yy+$tstart + $posy*2, $size, $size)
$ke_accentata=GUICtrlCreateButton("è", $xx+$posx*11, -$yy+$tstart + $posy*2, $size, $size)
$kplus=GUICtrlCreateButton("+", $xx+$posx*12, -$yy+$tstart + $posy*2, $size, $size)
$kEnterempty=GUICtrlCreateButton("", $xx+$posx*13, -$yy+$tstart + $posy*2, $size/3, $size)

$xx=$posx-$posx/4
$xxv2A=$xx
$xxv3=$xx

$kEnter=GUICtrlCreateButton("Enter", $xx+$posx*13, -$yy+$tstart + $posy*2, $size*1.5, $size*2)

$kLock=GUICtrlCreateButton("Lock", $posx*0, -$yy+$tstart + $posy*3, $size*1.75, $size)
$kA=GUICtrlCreateButton("A", $xx+$posx*1, -$yy+$tstart + $posy*3, $size, $size)
$kS=GUICtrlCreateButton("S", $xx+$posx*2, -$yy+$tstart + $posy*3, $size, $size)
$kD=GUICtrlCreateButton("D", $xx+$posx*3, -$yy+$tstart + $posy*3, $size, $size)
$kF=GUICtrlCreateButton("F", $xx+$posx*4, -$yy+$tstart + $posy*3, $size, $size)
$kG=GUICtrlCreateButton("G", $xx+$posx*5, -$yy+$tstart + $posy*3, $size, $size)
$kH=GUICtrlCreateButton("H", $xx+$posx*6, -$yy+$tstart + $posy*3, $size, $size)
$kJ=GUICtrlCreateButton("J", $xx+$posx*7, -$yy+$tstart + $posy*3, $size, $size)
$kK=GUICtrlCreateButton("K", $xx+$posx*8, -$yy+$tstart + $posy*3, $size, $size)
$kL=GUICtrlCreateButton("L", $xx+$posx*9, -$yy+$tstart + $posy*3, $size, $size)
$ko_accentata=GUICtrlCreateButton("ò", $xx+$posx*10, -$yy+$tstart + $posy*3, $size, $size)
$ka_accentata=GUICtrlCreateButton("à", $xx+$posx*11, -$yy+$tstart + $posy*3, $size, $size)
$ku_accentata=GUICtrlCreateButton("ù", $xx+$posx*12, -$yy+$tstart + $posy*3, $size, $size)
$xx=$posx/2
$xxv4=$xx

$kShift=GUICtrlCreateButton("Shift", $posx*0, -$yy+$tstart + $posy*4, $size*1.5, $size)
$kzz=GUICtrlCreateButton("<", $xx+$posx*1, -$yy+$tstart + $posy*4, $size, $size)
$kZ=GUICtrlCreateButton("Z", $xx+$posx*2, -$yy+$tstart + $posy*4, $size, $size)
$kX=GUICtrlCreateButton("X", $xx+$posx*3, -$yy+$tstart + $posy*4, $size, $size)
$kC=GUICtrlCreateButton("C", $xx+$posx*4, -$yy+$tstart + $posy*4, $size, $size)
$kV=GUICtrlCreateButton("V", $xx+$posx*5, -$yy+$tstart + $posy*4, $size, $size)
$kB=GUICtrlCreateButton("B", $xx+$posx*6, -$yy+$tstart + $posy*4, $size, $size)
$kN=GUICtrlCreateButton("N", $xx+$posx*7, -$yy+$tstart + $posy*4, $size, $size)
$kM=GUICtrlCreateButton("M", $xx+$posx*8, -$yy+$tstart + $posy*4, $size, $size)
$kcomma=GUICtrlCreateButton(",", $xx+$posx*9, -$yy+$tstart + $posy*4, $size, $size)
$kdot=GUICtrlCreateButton(".", $xx+$posx*10, -$yy+$tstart + $posy*4, $size, $size)
$kminus=GUICtrlCreateButton("-", $xx+$posx*11, -$yy+$tstart + $posy*4, $size, $size)
$kup=GUICtrlCreateButton("Up", $xx+$posx*12, -$yy+$tstart + $posy*4, $size, $size)
;$kup=GUICtrlCreateButton("â†‘", $xx+$posx*12, -$yy+$tstart + $posy*4, $size, $size)

$kRshift=GUICtrlCreateButton("Shift", $xx+$posx*13, -$yy+$tstart + $posy*4, $size*1.75, $size)
$xx=0
$xxv5=$xx


$kctrl=GUICtrlCreateButton("Ctrl", $xx+$posx*0, -$yy+$tstart + $posy*5, $size, $size)
$kfn=GUICtrlCreateButton("Fn", $xx+$posx*1, -$yy+$tstart + $posy*5, $size, $size)
$kwin=GUICtrlCreateButton("Win", $xx+$posx*2, -$yy+$tstart + $posy*5, $size, $size)
$kalt=GUICtrlCreateButton("Alt", $xx+$posx*3, -$yy+$tstart + $posy*5, $size, $size)
;$kspace=GUICtrlCreateButton("", $xx+$posx*4, -$yy+$tstart + $posy*5, $size*6, $size)
$kspace=GUICtrlCreateButton("", $xx+$posx*4, -$yy+$tstart + $posy*5, $size*6.5, $size)
;$xx=$posx*5
$xx=$posx*5.5
$xxv5A=$xx
$kaltgr=GUICtrlCreateButton("AltGr", $xx+$posx*5, -$yy+$tstart + $posy*5, $size, $size)
$kleft=GUICtrlCreateButton("Left", $xx+$posx*6, -$yy+$tstart + $posy*5, $size, $size)
;$kleft=GUICtrlCreateButton("â†", $xx+$posx*6, -$yy+$tstart + $posy*5, $size, $size)
$kdown=GUICtrlCreateButton("Down", $xx+$posx*7, -$yy+$tstart + $posy*5, $size, $size)
;$kdown=GUICtrlCreateButton("â†“", $xx+$posx*7, -$yy+$tstart + $posy*5, $size, $size)
$kright=GUICtrlCreateButton("Right", $xx+$posx*8, -$yy+$tstart + $posy*5, $size, $size)
;$kright=GUICtrlCreateButton("â†’", $xx+$posx*8, -$yy+$tstart + $posy*5, $size, $size)
;$kRCtrl=GUICtrlCreateButton("Ctrl", $xx+$posx*9, -$yy+$tstart + $posy*5, $size*1.25, $size)
$kRCtrl=GUICtrlCreateButton("Ctrl", $xx+$posx*9, -$yy+$tstart + $posy*5, $size/1.30, $size)



$led = GUICtrlCreateLabel("",$size/10,$resy/2.25/2-$size/3.5,$size/5,$size/5)

;global $led = GUICtrlCreateLabel("", $size/8, -$yy+$tstart + $posy*3+$size/1.5, $size/5,$size/5);,$GUI_ONTOP,$WS_EX_TOPMOST)
;$led = GUICtrlCreateLabel("", 0, -$yy+$tstart + $posy*3, $size/5,$size/5)
GUICtrlSetBkColor($led, 0x3399FF)
Guictrlsetstate($led,$GUI_HIDE)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Local $aButtons[15][6]
Local $bButtons[15][6]



$bButtons[0][0] = "{ESC}"
$bButtons[1][0] = "{F1}"
$bButtons[2][0] = "{F2}"
$bButtons[3][0] = "{F3}"
$bButtons[4][0] = "{F4}"
$bButtons[5][0] = "{F5}"
$bButtons[6][0] = "{F6}"
$bButtons[7][0] = "{F7}"
$bButtons[8][0] = "{F8}"
$bButtons[9][0] = "{F9}"
$bButtons[10][0] = "{F10}"
$bButtons[11][0] = "{F11}"
$bButtons[12][0] = "{F12}"
$bButtons[13][0] = "{INS}"
$bButtons[14][0] = "{DEL}"



$bButtons[0][1] = "\"
$bButtons[1][1] = "1"
$bButtons[2][1] = "2"
$bButtons[3][1] = "3"
$bButtons[4][1] = "4"
$bButtons[5][1] = "5"
$bButtons[6][1] = "6"
$bButtons[7][1] = "7"
$bButtons[8][1] = "8"
$bButtons[9][1] = "9"
$bButtons[10][1] = "0"
$bButtons[11][1] = "'"
$bButtons[12][1] = "ì"
$bButtons[13][1] = "{BACKSPACE}"
$bButtons[14][1] = ""


$bButtons[0][2] = "{TAB}"
$bButtons[1][2] = "q"
$bButtons[2][2] = "w"
$bButtons[3][2] = "e"
$bButtons[4][2] = "r"
$bButtons[5][2] = "t"
$bButtons[6][2] = "y"
$bButtons[7][2] = "u"
$bButtons[8][2] = "i"
$bButtons[9][2] = "o"
$bButtons[10][2] = "p"
$bButtons[11][2] = "è"
$bButtons[12][2] = "{+}"
$bButtons[13][2] = "{ENTER}"
$bButtons[14][2] = "{ENTER}"


$bButtons[0][3] = ""
$bButtons[1][3] = "a"
$bButtons[2][3] = "s"
$bButtons[3][3] = "d"
$bButtons[4][3] = "f"
$bButtons[5][3] = "g"
$bButtons[6][3] = "h"
$bButtons[7][3] = "j"
$bButtons[8][3] = "k"
$bButtons[9][3] = "l"
$bButtons[10][3] = "ò"
$bButtons[11][3] = "à"
$bButtons[12][3] = "ù"
$bButtons[13][3] = "{ENTER}"



$bButtons[0][4] = "{LSHIFT}"
$bButtons[1][4] = "<" ; zz?
$bButtons[2][4] = "z"
$bButtons[3][4] = "x"
$bButtons[4][4] = "c"
$bButtons[5][4] = "v"
$bButtons[6][4] = "b"
$bButtons[7][4] = "n"
$bButtons[8][4] = "m"
$bButtons[9][4] = ","
$bButtons[10][4] = "."
$bButtons[11][4] = "-"
$bButtons[12][4] = "{UP}"
$bButtons[13][4] = "{RSHIFT}"
$bButtons[14][4] = ""


$bButtons[0][5] = "{LCTRL}"
$bButtons[1][5] = ""
$bButtons[2][5] = ""
$bButtons[3][5] = "{ALT}"
$bButtons[4][5] = "{SPACE}"
$bButtons[5][5] = "{RALT}"
$bButtons[6][5] = "{LEFT}"
$bButtons[7][5] = "{DOWN}"
$bButtons[8][5] = "{RIGHT}"
$bButtons[9][5] = "{RCTRL}"
$bButtons[10][5] = ""
$bButtons[11][5] = ""
$bButtons[12][5] = ""
$bButtons[13][5] = ""
$bButtons[14][5] = ""




$aButtons[0][0] = $kEsc
$aButtons[1][0] = $kF1
$aButtons[2][0] = $kF2
$aButtons[3][0] = $kF3
$aButtons[4][0] = $kF4
$aButtons[5][0] = $kF5
$aButtons[6][0] = $kF6
$aButtons[7][0] = $kF7
$aButtons[8][0] = $kF8
$aButtons[9][0] = $kF9
$aButtons[10][0] = $kF10
$aButtons[11][0] = $kF11
$aButtons[12][0] = $kF12
$aButtons[13][0] = $kIns
$aButtons[14][0] = $kCanc




$aButtons[0][1] = $kbackslash
$aButtons[1][1] = $k1
$aButtons[2][1] = $k2
$aButtons[3][1] = $k3
$aButtons[4][1] = $k4
$aButtons[5][1] = $k5
$aButtons[6][1] = $k6
$aButtons[7][1] = $k7
$aButtons[8][1] = $k8
$aButtons[9][1] = $k9
$aButtons[10][1] = $k0
$aButtons[11][1] = $kapostrofo
$aButtons[12][1] = $ki_accentata
$aButtons[13][1] = $kbackspace
$aButtons[14][1] = ""


$aButtons[0][2] = $kTab
$aButtons[1][2] = $kQ
$aButtons[2][2] = $kW
$aButtons[3][2] = $kE
$aButtons[4][2] = $kR
$aButtons[5][2] = $kT
$aButtons[6][2] = $kY
$aButtons[7][2] = $kU
$aButtons[8][2] = $kI
$aButtons[9][2] = $kO
$aButtons[10][2] = $kP
$aButtons[11][2] = $ke_accentata
$aButtons[12][2] = $kplus
$aButtons[13][2] = $kEnter
$aButtons[14][2] = $kEnterempty


$aButtons[0][3] = $kLock
$aButtons[1][3] = $kA
$aButtons[2][3] = $kS
$aButtons[3][3] = $kD
$aButtons[4][3] = $kF
$aButtons[5][3] = $kG
$aButtons[6][3] = $kH
$aButtons[7][3] = $kJ
$aButtons[8][3] = $kK
$aButtons[9][3] = $kL
$aButtons[10][3] = $ko_accentata
$aButtons[11][3] = $ka_accentata
$aButtons[12][3] = $ku_accentata
$aButtons[13][3] = $kEnter


$aButtons[0][4] = $kShift
$aButtons[1][4] = $kzz
$aButtons[2][4] = $kZ
$aButtons[3][4] = $kX
$aButtons[4][4] = $kC
$aButtons[5][4] = $kV
$aButtons[6][4] = $kB
$aButtons[7][4] = $kN
$aButtons[8][4] = $kM
$aButtons[9][4] = $kcomma
$aButtons[10][4] = $kdot
$aButtons[11][4] = $kminus
$aButtons[12][4] = $kup
$aButtons[13][4] = $kRshift
$aButtons[14][4] = "" ; vuoto


$aButtons[0][5] = $kctrl
$aButtons[1][5] = $kfn
$aButtons[2][5] = $kwin
$aButtons[3][5] = $kalt
$aButtons[4][5] = $kspace
$aButtons[5][5] = $kaltgr
$aButtons[6][5] = $kleft
$aButtons[7][5] = $kdown
$aButtons[8][5] = $kright
$aButtons[9][5] = $kRCtrl
$aButtons[10][5] = ""
$aButtons[11][5] = ""
$aButtons[12][5] = ""
$aButtons[13][5] = ""
$aButtons[14][5] = ""





For $ay = 0 To 5
    For $ax = 0 To 14

		GUICtrlSetFont($aButtons[$ax][$ay], 9* @DesktopWidth/1920,400,0,"Segoe UI",5)
    Next
Next





  Local $idDummy = GUICtrlCreateDummy()
	Local $aAccelKeys[5][2] = [["{LEFT}", $idDummy], ["{RIGHT}", $idDummy], ["{UP}", $idDummy], ["{DOWN}", $idDummy],["{ESC}", $idDummy]]
    GUISetAccelerators($aAccelKeys, $tGui)



func drag()
	Local $mouse = GUIGetCursorInfo($tGui)

    If Not @error And $mouse[4] = $lblDragZone Then
        If _IsPressed("01") And Not $drag Then
            $drag = True
            $offset[0] = MouseGetPos(0) - WinGetPos($tGui)[0]
            $offset[1] = MouseGetPos(1) - WinGetPos($tGui)[1]
        EndIf
    EndIf

    If $drag Then
        If _IsPressed("01") Then
            Local $x = MouseGetPos(0) - $offset[0]
            Local $y = MouseGetPos(1) - $offset[1]
            WinMove($tGui, "", $x, $y)
        Else
            $drag = False
        EndIf
    EndIf

    ;Sleep(1)

	endfunc




func mouseBenteract()

	Local $mouseInfo = GUIGetCursorInfo($tGUI)
    ;If Not @error And IsArray($mouseInfo) Then
        If $mouseInfo[4] = $aButtons[13][2] or $mouseInfo[4] = $aButtons[14][2] Then
			_GUICtrlButton_SetState($aButtons[13][2],True)
			_GUICtrlButton_SetState($aButtons[14][2],True)
			$Benter=1
        Else
			if $Benter=1 then
			_GUICtrlButton_SetState($aButtons[13][2],False)
			_GUICtrlButton_SetState($aButtons[14][2],False)
			$Benter=0
			endif
        EndIf
    ;EndIf
;AdlibUnRegister(mouseBenteract)
	endfunc



$go=0




Func _HandleKeyX($isDown, $index)
	;If Not _IsPressed("12") then    ;alt key

    If $isDown And Not $wasDown[$index] Then
        _SpostaSelezioneX($index)
        $firstPressTime[$index] = TimerInit()
        $lastRepeatTime[$index] = TimerInit()
    ElseIf $isDown And $wasDown[$index] Then
        Local $heldTime = TimerDiff($firstPressTime[$index])
        Local $sinceLastRepeat = TimerDiff($lastRepeatTime[$index])
        If $heldTime >= $holdDelay And $sinceLastRepeat >= $repeatSpeed Then
            _SpostaSelezioneX($index)
            $lastRepeatTime[$index] = TimerInit()
        EndIf
    EndIf
$wasDown[$index] = $isDown
	;endif
EndFunc


Func _SpostaSelezioneX($index)
    Switch $index
        Case 2 ; sx
            If $curX = -1 Then
                EvidenziaTasto(0, 0)

			;Go to the other side
			ElseIf $curx=0 and ($cury=0) then
			EvidenziaTasto(14, 0)
			Elseif $curx=0 and ($cury=1 or $cury=2 or $cury=3 or $cury=4) Then
			EvidenziaTasto(13, $cury)
			Elseif $curx=0 and $cury=5 Then
			EvidenziaTasto(9, 5)

            ElseIf $curX > 0 Then
                EvidenziaTasto($curX - 1, $curY)

            EndIf
			if $cury=5 Then
			$recc=-1
			endif
			$reca=0
        Case 3 ; dx
            If $curX = -1 Then
                EvidenziaTasto(0, 0)
			elseif ($curX <14 and $cury=0) or ($curX <13 and ($cury=1 or $cury=4 or $cury=3)) or ($curX <13 and $cury=2) or ($curX <9 and $cury=5) then
			EvidenziaTasto($curX + 1, $curY)

			;Go to the other side
			ElseIf $curx=14 and ($cury=0) then
			EvidenziaTasto(0, 0)
			Elseif $curx=13 and ($cury=1 or $cury=2 or $cury=3 or $cury=4) Then
			EvidenziaTasto(0, $cury)
			Elseif $curx=9 and $cury=5 Then
			EvidenziaTasto(0, 5)

            EndIf
			if $cury=5 Then
			$recc=-1
			endif
        Case 0 ; up
			if $cury<4 Then
				$recc=-1
			endif
			If $curX = -1 Then
			EvidenziaTasto(0, 0)
			elseif $cury=5 and $curx=4 and $recc>0 Then
			EvidenziaTasto($recc, 4)


			elseif $cury=5 and $curx=9 Then
			$reca=1
			EvidenziaTasto(13, 4)     ;new layout

			elseif $cury=5 and ($curx>4) then
			;EvidenziaTasto($curx+4, 4)
			EvidenziaTasto($curx+5, 4)

			elseif $cury=3 and $curx=13 then
			EvidenziaTasto(13,1)

            elseIf $curY > 0 Then
                EvidenziaTasto($curX, $curY - 1)
            EndIf
        Case 1 ; down
			if $curX = -1 Then
			EvidenziaTasto(0, 0)


			elseif $curX=14 and $cury=0 then
			EvidenziaTasto(13,1)

			elseif $cury=4 and ($curx>=4 and $curx<10) then
			$recc=$curx
			EvidenziaTasto(4,5)

			elseif $cury=4 and $curx=13 Then
			if $reca=1 Then
				EvidenziaTasto(9,5)
				Else
				EvidenziaTasto(8,5)
				endif

			;elseif $cury=4 and ($curx>=9) then
			elseif $cury=4 and ($curx>=10) then
			;EvidenziaTasto($curx-4,5)
			EvidenziaTasto($curx-5,5)


			elseif $cury=2 and $curx>=13 Then
			EvidenziaTasto(13,4)

            elseIf $curY < 5 Then
                EvidenziaTasto($curX, $curY + 1)
            EndIf

		Case 4



		if ($curX=13 or $curx=14) and ($cury=2 or $cury=3) then
		;if ($curX=13) and ($cury=2) then

		senderA()
		_GUICtrlButton_SetState($aButtons[13][2],False)
		_GUICtrlButton_SetState($aButtons[14][2],False)
		 ;AdlibRegister("RipristinaFocus", 1)
		 sleep(1)
		 _GUICtrlButton_SetState($aButtons[13][2],True)
		 _GUICtrlButton_SetState($aButtons[14][2],True)



		elseif $curX >= 0 And $curY >= 0 Then

		senderA()


		_GUICtrlButton_SetState($aButtons[$curx][$cury],False)
		;GUICtrlSetState($hLabelFinta, $GUI_FOCUS)
		;AdlibRegister("setstate", 100)
		sleep(1)
		_GUICtrlButton_SetState($aButtons[$curx][$cury],True)

		endif

		if $curx=0 and $cury=3 Then
			caps()
			endif


    EndSwitch
EndFunc





Func EvidenziaTasto($ux, $uy)   ;phisical and virtual keyboard



	if $curX >= 0 And $curY >= 0 Then
	;If $curX <> -1 And $curY <> -1 Then


		_GUICtrlButton_SetFocus($aButtons[$curx][$cury],False)
		_GUICtrlButton_SetState($aButtons[$curx][$cury],False)


		_GUICtrlButton_SetFocus($aButtons[14][2],False)
		_GUICtrlButton_SetState($aButtons[14][2],False)

		_GUICtrlButton_SetFocus($aButtons[13][2],False)
		_GUICtrlButton_SetState($aButtons[13][2],False)


    EndIf


    $curX = $ux
    $curY = $uy


	if $ux=13 and ($uy=2 or $uy=3) Then
		_GUICtrlButton_SetState($aButtons[13][2],True)
		_GUICtrlButton_SetState($aButtons[14][2],True)

	else

	_GUICtrlButton_SetState($aButtons[$ux][$uy],True) ;PERFETTO

	endif

	endfunc





func senderA()
    if $capsEnabled then
        send(StringUpper($bButtons[$curx][$cury]))
    else
        send($bButtons[$curx][$cury])
    endif
endfunc




func sn($value)
	ControlFocus("Playnite","","")
	if $capsEnabled Then
	send(StringUpper($value))
	else
	send($value)
	endif

	ControlFocus("On Screen Keyboard","","")
	ControlGetFocus("[ACTIVE]")


endfunc



func sender()
Local $msg = GUIGetMsg()
	If $msg <> 0 Then
switch $msg
	Case $k1
		sn("1")
	Case $k2
		sn("2")
	Case $k3
		sn("3")
	Case $k4
		sn("4")
	Case $k5
		sn("5")
	Case $k6
		sn("6")
	Case $k7
		sn("7")
	Case $k8
		sn("8")
	Case $k9
		sn("9")
	Case $k0
        sn("0")
    Case $kQ
        sn("q")
    Case $kW
        sn("w")
    Case $kE
        sn("e")
    Case $kR
        sn("r")
    Case $kT
        sn("t")
    Case $kY
        sn("y")
    Case $kU
        sn("u")
    Case $kI
        sn("i")
    Case $kO
        sn("o")
    Case $kP
        sn("p")
    Case $kA
        sn("a")
    Case $kS
        sn("s")
    Case $kD
        sn("d")
    Case $kF
        sn("f")
    Case $kG
        sn("g")
    Case $kH
        sn("h")
    Case $kJ
        sn("j")
    Case $kK
        sn("k")
    Case $kL
        sn("l")
    Case $kZ
        sn("z")
    Case $kX
        sn("x")
    Case $kC
        sn("c")
    Case $kV
        sn("v")
    Case $kB
        sn("b")
    Case $kN
        sn("n")
    Case $kM
        sn("m")
    Case $kUp
        sn("{UP}")
    Case $kDown
        sn("{DOWN}")
    Case $kLeft
        sn("{LEFT}")
    Case $kRight
        sn("{RIGHT}")
    Case $kEnter
        sn("{ENTER}")
	Case $kEnterempty
        sn("{ENTER}")
    Case $kDot
        sn("{.}")  ; Punto
    Case $kComma
        sn("{,}")  ; Virgola
    Case $kMinus
        sn("{-}")  ; Trattino
	Case $kplus
		sn("{+}")
	Case $ke_accentata
		sn("è")
	Case $ka_accentata
		sn("à")
	Case $ku_accentata
		sn("ù")
	Case $ko_accentata
		sn("ò")
	Case $ki_accentata
		sn("ì")
	Case $kapostrofo
		sn("'")
	Case $kzz
		sn("<")
	Case $kbackslash
		sn("\")
    Case $kShift
        sn("{LSHIFT}")
    Case $kRshift
        ;sn("{+}")
		sn("{RSHIFT}")
    Case $kBackspace
        sn("{Backspace}")
	Case $kLock
		caps()
    Case $kTab
        sn("{TAB}")
    Case $kEsc
        sn("{Esc}")
    Case $kF1
        sn("{F1}")
    Case $kF2
        sn("{F2}")
    Case $kF3
        sn("{F3}")
    Case $kF4
        sn("{F4}")
    Case $kF5
        sn("{F5}")
    Case $kF6
        sn("{F6}")
    Case $kF7
        sn("{F7}")
    Case $kF8
        sn("{F8}")
    Case $kF9
        sn("{F9}")
    Case $kF10
        sn("{F10}")
    Case $kF11
        sn("{F11}")
    Case $kF12
        sn("{F12}")
	Case $kctrl
		sn("{LCTRL}")
	;Case $fn
	;Case $kwin
     ;   sn("{Lwin}")
	Case $kalt
		sn("{ALT}")
	Case $kspace
        sn("{SPACE}")
	Case $kaltgr
		sn("{RALT}")
	Case $kleft
		sn("{LEFT}")
	Case $kright
		sn("{RIGHT}")
	Case $kRCtrl
		sn("{RCTRL}")
	Case $GUI_EVENT_CLOSE
		exit
	Case $btnClose
		$showosk= False
		guisetstate(@SW_HIDE,$tgui)
EndSwitch

	endif
	;sleep(1)
;AdlibUnRegister(sender)
endfunc



func senderM($msg)
switch $msg
	Case $k1
		sn("1")
	Case $k2
		sn("2")
	Case $k3
		sn("3")
	Case $k4
		sn("4")
	Case $k5
		sn("5")
	Case $k6
		sn("6")
	Case $k7
		sn("7")
	Case $k8
		sn("8")
	Case $k9
		sn("9")
	Case $k0
        sn("0")
    Case $kQ
        sn("q")
    Case $kW
        sn("w")
    Case $kE
        sn("e")
    Case $kR
        sn("r")
    Case $kT
        sn("t")
    Case $kY
        sn("y")
    Case $kU
        sn("u")
    Case $kI
        sn("i")
    Case $kO
        sn("o")
    Case $kP
        sn("p")
    Case $kA
        sn("a")
    Case $kS
        sn("s")
    Case $kD
        sn("d")
    Case $kF
        sn("f")
    Case $kG
        sn("g")
    Case $kH
        sn("h")
    Case $kJ
        sn("j")
    Case $kK
        sn("k")
    Case $kL
        sn("l")
    Case $kZ
        sn("z")
    Case $kX
        sn("x")
    Case $kC
        sn("c")
    Case $kV
        sn("v")
    Case $kB
        sn("b")
    Case $kN
        sn("n")
    Case $kM
        sn("m")
    Case $kUp
        sn("{UP}")
    Case $kDown
        sn("{DOWN}")
    Case $kLeft
        sn("{LEFT}")
    Case $kRight
        sn("{RIGHT}")
    Case $kEnter
        sn("{ENTER}")
	Case $kEnterempty
        sn("{ENTER}")
    Case $kDot
        sn("{.}")
    Case $kComma
        sn("{,}")
    Case $kMinus
        sn("{-}")
	Case $kplus
		sn("{+}")
	Case $ke_accentata
		sn("è")
	Case $ka_accentata
		sn("à")
	Case $ku_accentata
		sn("ù")
	Case $ko_accentata
		sn("ò")
	Case $ki_accentata
		sn("ì")
	Case $kapostrofo
		sn("'")
	Case $kzz
		sn("<")
	Case $kbackslash
		sn("\")
    Case $kShift
        sn("{LSHIFT}")
    Case $kRshift
        ;sn("{+}")
		sn("{RSHIFT}")
    Case $kBackspace
        sn("{Backspace}")
	Case $kLock
		caps()
    Case $kTab
        sn("{TAB}")
    Case $kEsc
        sn("{Esc}")
    Case $kF1
        sn("{F1}")
    Case $kF2
        sn("{F2}")
    Case $kF3
        sn("{F3}")
    Case $kF4
        sn("{F4}")
    Case $kF5
        sn("{F5}")
    Case $kF6
        sn("{F6}")
    Case $kF7
        sn("{F7}")
    Case $kF8
        sn("{F8}")
    Case $kF9
        sn("{F9}")
    Case $kF10
        sn("{F10}")
    Case $kF11
        sn("{F11}")
    Case $kF12
        sn("{F12}")
	Case $kctrl
		sn("{LCTRL}")
	;Case $fn
	;Case $kwin
    ;    sn("{Lwin}")
	Case $kalt
		sn("{ALT}")
	Case $kspace
        sn("{SPACE}")
	Case $kaltgr
		sn("{RALT}")
	Case $kleft
		sn("{LEFT}")
	Case $kright
		sn("{RIGHT}")
	Case $kRCtrl
		sn("{RCTRL}")
	Case $GUI_EVENT_CLOSE
		exit
	Case $btnClose
		$showosk= False
		guisetstate(@SW_HIDE,$tgui)
EndSwitch

	;sleep(1)
;AdlibUnRegister(sender)
endfunc


func caps()
	$capsEnabled = not $capsEnabled
	if $capsEnabled Then
GUIctrlsetstate($led, $GUI_SHOW)
GUIctrlsetstate($led, $GUI_ONTOP)
	Else
	GUIctrlsetstate($led, $GUI_HIDE)
		endif
	endfunc


func setstate()
	;_GUICtrlButton_SetState($aButtons[$curx][$cury],False)
	;sleep(2000)
	_GUICtrlButton_SetState($aButtons[$curx][$cury],True)
	AdlibUnRegister("setstate")
endfunc

func sendercheck()
$msg=GUIGetMsg()
if $msg>0 then
senderM($msg)
endif
	endfunc

func esci()
	exit
	endfunc










