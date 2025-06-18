#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=wizard.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.0.1.0
#AutoIt3Wrapper_Res_ProductName=GamepadDesktop (Playnite-Extension)
#AutoIt3Wrapper_Res_ProductVersion=1.0.1
#AutoIt3Wrapper_Res_CompanyName=roob-p (author)
#AutoIt3Wrapper_Res_LegalCopyright=roob-p (author)
#AutoIt3Wrapper_Res_LegalTradeMarks=roob-p (author)
#AutoIt3Wrapper_Res_Language=1040
#AutoIt3Wrapper_Res_Description=GamepadDesktop-Wizard
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPIHObj.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <FontConstants.au3>
#include <WinAPISysWin.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
;#include <MsgBoxConstants.au3>

HotKeySet("{ESC}", "_Exit")

$inifile=@ScriptDir & "\config.ini"


$slot=IniRead($inifile,"Wizard","$currentSlot","")


Opt("MouseCoordMode", 1)

$image= @ScriptDir & "\grid.jpg"
$circle = @ScriptDir & "\circleF.bmp"
;$ok = @ScriptDir & "\ok.bmp"


$width=@DesktopWidth/2
$height=@DesktopHeight/2

;$hGui= guicreate("Wizard",$width,$height,-1,0,$WS_SYSMENU,$WS_EX_TOPMOST)
$hGui= guicreate("Wizard",$width,$height,-1,0,$WS_POPUP,$WS_EX_TOPMOST)
;$hGui= guicreate("Wizard",@DesktopWidth/1.5,@DesktopHeight/1.5,-1,0)

_GDIPlus_Startup()
Global $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
Global $imageH = _GDIPlus_ImageLoadFromFile($image)
Global $circleH = _GDIPlus_ImageLoadFromFile($circle)
;Global $okH = _GDIPlus_ImageLoadFromFile($ok)

Global $hBitmap = _GDIPlus_BitmapCreateFromScan0($width, $height)
Global $hGraphics_Bmp = _GDIPlus_ImageGetGraphicsContext($hBitmap)
;Global $hGraphics_Bmp = _GDIPlus_ImageGetGraphicsContext($hGui)





Local $scale = 0.15
Local $scaleW = $width/10000
Local $scaleH = $height/10000
Local $origW = _GDIPlus_ImageGetWidth($circleH)
Local $origH = _GDIPlus_ImageGetHeight($circleH)
;Local $newW = $origW * $scale
;Local $newH = $origH * $scale
Local $newW = $origW * $scaleW
Local $newH = $origH * $scaleW


$exit=0



$timer=TimerInit()
$timerblink=timerinit()
$visible=1




$pos1x= $width/16.551-$newW/2
$pos1y=$height/10.384-$newH/2
; 58, 52
; 16.551, 13.5


$pos2x= $width/4.615 -$newW/2
$pos2y= $height/15 -$newH/2
; 208, 36
; 4.615, 15

$pos3x= $width/1.097 -$newW/2
$pos3y=$height/11.020 -$newH/2
; 875, 49
; 1.097, 11.020

$pos4x= $width/15.551 -$newW/2
$pos4y=$height/45 -$newH/2
; 58, 12
; 15.551, 45



$pos5x= $width/6.442 -$newW/2
$pos5y=$height/15 -$newH/2
; 149, 36
; 6.442, 15

$pos6x= $width/4.593 -$newW/2
$pos6y=$height/1.018 -$newH/2

$limit1pos=$width/5.926   ;162 (coord regarding image gui area)
$limit2pos=$width/1.144   ;839



$limitpos=""
$posx=""
$posy=""



Global $positions[8][2] = [[$pos1x,$pos1y],[$pos2x,$pos2y],[$pos3x,$pos3y],[$pos4x,$pos4y],[$pos5x,$pos5y],[$pos6x,$pos6y],[$limit1pos,""],[$limit2pos,""]]
Global $keys[8][2] = [["$section1x","$section1y"],["$section2x","$section2y"],["$section3x","$section3y"],["$search_panelx","$search_panely"],["$section1panelx","$section1panely"],["$section2panelx","$section2panely"],["$limit1",""],["$limit2",""]]



$n=3

$timerT=timerinit()

SplashTextOn("Wizard","Please look at the picture and move the mouse cursor where indicated." & @CRLF  & @CRLF & $n,450,150,-1,0,$DLG_NOTITLE, "Trebuchet MS",15);,$FW_BOLD)
sleep(1000)
$n=2
ControlSetText("Wizard","","Static1","Please look at the picture and move the mouse cursor where indicated." &@CRLF  & @CRLF & $n)
sleep(1000)
$n=1
ControlSetText("Wizard","","Static1","Please look at the picture and move the mouse cursor where indicated." &@CRLF  & @CRLF & $n)
sleep(1000)
splashoff()




WinActivate("Playnite")
WinWaitActive("Playnite")
guisetstate(@SW_SHOW,$hGui)


while 1


for $i=0 to 5
$posx=$positions[$i][0]
$posy=$positions[$i][1]
circle()
getpos($i)

next


for $i=6 to 7
$limitpos=$positions[$i][0]
rect()
getpos($i)
	next


exit
	sleep(16)




wend



func getpos($index)
	Opt("MouseCoordMode", 1)
	$aPos=MouseGetPos()
	;sleep(500)
	if $index<=5 then
	IniWrite($inifile,$slot,$keys[$index][0],$aPos[0])
	IniWrite($inifile,$slot,$keys[$index][1],$aPos[1])
	Else
	Iniwrite($inifile,$slot,$keys[$index][0],Round(@DesktopWidth/$aPos[0],3))
	endif
	Tooltip("OK",$aPos[0],$aPos[1],"","")
	sleep(500)
	Tooltip("")
	endfunc

func circle()
_GDIPlus_GraphicsSetInterpolationMode($hGraphics_Bmp, $GDIP_INTERPOLATIONMODE_HIGHQUALITYBICUBIC)

WinSetTrans($hGui,"",250)
$timerC=TimerInit()


while TimerDiff($timerC)<2000
_GDIPlus_GraphicsDrawImageRect($hGraphics_Bmp, $imageH, 0, 0,$width,$height)

_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)

	if $visible=1 then

	_GDIPlus_GraphicsDrawImageRect($hGraphics_Bmp, $circleH, $posx, $posy,$newW,$newH )
	endif

	sleep(200)
	$visible=0



	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)

	sleep(200)
	$visible=1

wend
;guisetstate(@SW_HIDE)
WinSetTrans($hGui,"",100)
sleep(1000)


sleep(1000)


	endfunc


Func rect()
    _GDIPlus_GraphicsSetInterpolationMode($hGraphics_Bmp, $GDIP_INTERPOLATIONMODE_HIGHQUALITYBICUBIC)

    WinSetTrans($hGui, "", 250)
    Local $timerC = TimerInit()

    Local $hBrush = _GDIPlus_BrushCreateSolid(0xFFFFFFFF)

    While TimerDiff($timerC) < 2000
        ; Background
        _GDIPlus_GraphicsDrawImageRect($hGraphics_Bmp, $imageH, 0, 0, $width, $height)

        ; Copy to the output graphics
        _GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)

        If $visible = 1 Then
            ; Draw primitive
            _GDIPlus_GraphicsFillRect($hGraphics_Bmp, $limitpos-($newW/4)/2, 0, $newW/4, $height, $hBrush)
        EndIf

        Sleep(200)
        $visible = 0

        ; Redraw (without primitive)
        _GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)
        Sleep(200)
        $visible = 1
    WEnd

    ; Reset transparency
    WinSetTrans($hGui, "", 100)
    Sleep(1000)


    _GDIPlus_BrushDispose($hBrush)

    Sleep(1000)
EndFunc



; cleanup
_GDIPlus_ImageDispose($imageH)
_GDIPlus_ImageDispose($circleH)
_GDIPlus_GraphicsDispose($hGraphics)
_GDIPlus_GraphicsDispose($hGraphics_Bmp)
_GDIPlus_Shutdown()

Func _Exit()
    Exit
EndFunc


