;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;					 ;;
;;  _XInput UDF for use with AutoIt Beta ;;
;;					 ;;
;;	Created by Oxin8		 ;;
;;      email: xoxinx@gmail.com		 ;;
;;					 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Function _XInputInit()
;	Opens the dll
;	returns - a handle to open dll

Func _XInputInit()
	Local $thedll
	$thedll = DllOpen("xinput9_1_0.dll")
	Return $thedll
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Function _XInputVibrate($thedll, $lmotor, $rmotor)
;	Sets the controller's vibration for the left and right motors
;	$thedll - dll handle returned by _XInputInit()
;	$lmotor - desired left motor power level. 0 being none and 100 being full
;	$rmotor - desired left motor power level. 0 being none and 100 being full
;	returns - nothing

Func _XInputVibrate($thedll,$lmotor,$rmotor)
	$xinputvibration = DllStructCreate("short;short")
	DllStructSetData($xinputvibration,1,round(($lmotor / 100) * 32767))
	DllStructSetData($xinputvibration,2,round(($rmotor / 100) * 32767))
	DllCall($thedll,"long","XInputSetState","long",0,"ptr",DllStructGetPtr($xinputvibration))
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Function _XInputGetInput($thedll)
;	Returns an array of the current controller input
;	$thedll - dll handle returned by _XInputInit()
;	returns - an array with info (see below)
;		1-PacketNumber - indicates change
;		2-Buttons
;		3-Left Trigger - 0 to 255
;		4-Right Trigger - 0 to 255
;		5-Left X - -32768 to 32767
;		6-Left Y - -32768 to 32767
;		7-Right X - -32768 to 32767
;		8-Right Y - -32768 to 32767

Func _XInputGetInput($thedll)
	Local $temp[9]
	$xinputgamepad = DllStructCreate("dword;short;ubyte;ubyte;short;short;short;short")
	If DllCall($thedll,"long","XInputGetState","long",0,"ptr",DllStructGetPtr($xinputgamepad))=0 Then Return
	For $i = 1 to 8
		$temp[$i] = DllStructGetData($xinputgamepad,$i)
	Next
	Return $temp
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Function _XInputButtons($buttons)
;	Returns an array indicating the pressed buttons
;	$buttons - use the second element of the array returned by _XInputGetInput
;	returns - an array of pressed buttons. 1 indicating pressed
;
;	   Array Element
;               v
;Y    -32768	14
;X     16384    13
;B      8192    12
;A      4096    11
;RButton 512    10
;LButton 256     9
;RJoy    128     8
;LJoy     64     7
;Back     32     6
;Start    16     5
;Right     8     4
;Left      4     3
;Down      2     2
;Up        1     1

Func _XInputButtons($buttons)
	Local $pressed[15]
	If $buttons < 0 Then
		$buttons = $buttons + 32768
		$pressed[14] = 1
	EndIf
	For $i = 14 to 12 Step -1
		If $buttons >= (2^$i) Then
			$buttons = $buttons - (2^$i)
			$pressed[($i-1)] = 1
		EndIf
	Next
	For $i = 9 to 0 Step -1
		If $buttons >= (2^$i) Then
			$buttons = $buttons - (2^$i)
			$pressed[($i + 1)] = 1
		EndIf
	Next
	Return $pressed
EndFunc