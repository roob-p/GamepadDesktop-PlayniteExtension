#function OnApplicationStarted {
#Autorun
#}


	#if (-not(get-process("_XInputExample controller")-EA 0)){
	#start-process "$PSScriptRoot\_XInputExample controller.exe"
	#}
	
	$config = @{}
	Get-Content -Path "$PSScriptRoot\autorun.ini" | ForEach-Object {
	$parts = $_ -split "="
	#$content= $parts[1].Trim()
	$key = $parts[0].Trim()
    $value = $parts[1].Trim()
    $config[$key] = $value
	}
	
	if ($config["Autorun"] -eq "1"){
		$global:autorun=$True
		#$playniteapi.dialogs.showmessage("OK")
	#if ($autorun=$True){
	
	#start-process "$PSScriptRoot\PlayniteGamepadDesktop.exe"
	###start-process "$PSScriptRoot\_XInputExample controller.exe"
	
	
		if (-not(get-process("GamepadDesktop")-EA 0)){
	start-process "$PSScriptRoot\GamepadDesktop.exe"
	}

}
	
	
	
	
	
	#Autorun
	
#	try {
#    Autorun
#} catch {
#    #Write-Host "Errore durante esecuzione Autorun: $_"
#	$playniteapi.dialogs.showmessage("WARNING")
#}

#Autorun


function getGameMenuItems{
	
	param(
		$getGameMenuItemsArgs
	)
	
	$global:running="..."
	#$global:autorun="..."
	#$global:autorun=$True
	#$autorun=$True

	
	#Autorun
	#AutorunStatus
	if (get-process("GamepadDesktop")-EA 0) {
	$running="Running"
	$icon0="$PSScriptRoot"+"\run.png"
	}else{
		$running="Not Running"
		$icon0="$PSScriptRoot"+"\not.png"
		}
	$menu=$running
	#$menu="..."
	if ($autorun -eq $True){$menu_on=">On"} else {$menu_on="On"}
	#$menu1=$menu_on
	if ($autorun -eq $False){$menu_off=">Off"} else {$menu_off="Off"}
	#$menu2=$menu_off
	

    $menuItem0 = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem0.Description = "$menu"
    $menuItem0.FunctionName = "Status"
	$menuItem0.Icon = $icon0 #"$PSScriptRoot"+"\icon.png"
	$menuItem0.MenuSection = "GamepadDesktop"
	
	if ($autorun -eq $True){ $autorun_menu ="$PSScriptRoot"+"\green.png"} else {$autorun_menu ="$PSScriptRoot"+"\blue.png"}
	$menuItem8 = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem8.Description = "Autorun"
    $menuItem8.FunctionName = "AutorunToggleStatus"
	$menuItem8.Icon = $autorun_menu #"$PSScriptRoot"+"\blue.png"
	$menuItem8.MenuSection = "GamepadDesktop|Config|"
	

	$menuItem1 = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem1.Description = $menu_on #$menu1 #$menu_on #"On"
    $menuItem1.FunctionName = "On"
	#$menuItem1.Icon = "$PSScriptRoot"+"\icon.png"
	$menuItem1.MenuSection = "GamepadDesktop|Config|Autorun options"
	

	$menuItem2 = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem2.Description = $menu_off #$menu2 #$menu_off #"Off"
    $menuItem2.FunctionName = "Off"
	#$menuItem2.Icon = "$PSScriptRoot"+"\icon.png"
	$menuItem2.MenuSection = "GamepadDesktop|Config|Autorun options"
	
	$menuItem3 = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem3.Description = "Wizard"
    $menuItem3.FunctionName = "Customize"
	#$menuItem3.Icon = "$PSScriptRoot"+"\gear.png"
	$menuItem3.Icon = "$PSScriptRoot"+"\wizard.png"
	$menuItem3.MenuSection = "GamepadDesktop|Config|"
    
	$menuItem4 = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem4.Description = "Run"
    $menuItem4.FunctionName = "Run"
	$menuItem4.Icon = "$PSScriptRoot"+"\start.png"
	$menuItem4.MenuSection = "GamepadDesktop"
    
	
	$menuItem5 = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem5.Description = "Stop"
    $menuItem5.FunctionName = "Stop"
	$menuItem5.Icon = "$PSScriptRoot"+"\stop.png"
	$menuItem5.MenuSection = "GamepadDesktop"
	
	
	$menuItem7 = New-Object Playnite.SDK.Plugins.ScriptGameMenuItem
	$menuItem7.Description = "Open config.ini"
    $menuItem7.FunctionName = "Open_config.ini"
	$menuItem7.Icon = "$PSScriptRoot"+"\document.png"
	#$menuItem7.Icon = "$PSScriptRoot"+"\gear.png"
	$menuItem7.MenuSection = "GamepadDesktop|Config|"
    
	#$autorun=$True
	#Autorun
	
	
    #return $menuItem0, $menuitem8,$menuItem1,$menuItem2,$menuItem3,$menuItem4,$menuItem5
	return $menuItem0,$menuItem3,$menuItem4,$menuItem5, $menuitem8, $menuitem7
}



#RunStop


function Run()
{
	param(
		$getGameMenuItemsArgs
	)
	
	if (-not(get-process("GamepadDesktop")-EA 0)){
	start-process "$PSScriptRoot\GamepadDesktop.exe"
	}
	

} #endfunc

function Stop()
{
	param(
		$getGameMenuItemsArgs
	)
	
	Stop-Process -Name "GamepadDesktop" -EA 0

} #endfunc

function Autorun()
{
	#param(
	#	$getGameMenuItemsArgs
	#)
	
	$config = @{}
	Get-Content -Path "$PSScriptRoot\autorun.ini" | ForEach-Object {
	$parts = $_ -split "="
	#$content= $parts[1].Trim()
	$key = $parts[0].Trim()
    $value = $parts[1].Trim()
    $config[$key] = $value
	}
	
	if ($config["Autorun"] -eq "1"){
		$global:autorun=$True

		if (-not(get-process("GamepadDesktop")-EA 0)){
	start-process "$PSScriptRoot\GamepadDesktop.exe"
	}
	}
}

function On()
{
	param(
		$getGameMenuItemsArgs
	)
	
	
	$config = @{}
	Get-Content -Path "$PSScriptRoot\autorun.ini" | ForEach-Object {
	$parts = $_ -split "="
	#$content= $parts[1].Trim()
	$key = $parts[0].Trim()
    $value = $parts[1].Trim()
    $config[$key] = $value
	}
	
	$config["Autorun"] = "1"
	$config.GetEnumerator() |
	ForEach-Object { "$($_.Key) = $($_.Value)" } | Set-Content -Path "$PSScriptRoot\autorun.ini"
	$autorun=$True

} #endfunc

function Off()
{
	param(
		$getGameMenuItemsArgs
	)
	
	
	
	$config = @{}
	Get-Content -Path "$PSScriptRoot\autorun.ini" | ForEach-Object {
	$parts = $_ -split "="
	#$content= $parts[1].Trim()
	$key = $parts[0].Trim()
    $value = $parts[1].Trim()
    $config[$key] = $value
	}
	
	$config["Autorun"] = "0"
	$config.GetEnumerator() |
	ForEach-Object { "$($_.Key) = $($_.Value)" } | Set-Content -Path "$PSScriptRoot\autorun.ini"
	
	$autorun=$False

} #endfunc





function Status()
{
	param(
		$getGameMenuItemsArgs
	)
	
	
} #endfunc


function AutorunToggleStatus()
{
	param(
		$getGameMenuItemsArgs
	)
	
	$config = @{}
	Get-Content -Path "$PSScriptRoot\autorun.ini" | ForEach-Object {
	$parts = $_ -split "="
	#$content= $parts[1].Trim()
	$key = $parts[0].Trim()
    $value = $parts[1].Trim()
    $config[$key] = $value
	}
	
	if ($config["Autorun"] -eq "0") {$config["Autorun"] = "1"}else{$config["Autorun"] = "0"}
	$config.GetEnumerator() |
	ForEach-Object { "$($_.Key) = $($_.Value)" } | Set-Content -Path "$PSScriptRoot\autorun.ini"
	
	$autorun=!$autorun
	
	

} #endfunc


function AutorunStatus()
{
	$config = @{}
	Get-Content -Path "$PSScriptRoot\autorun.ini" | ForEach-Object {
	$parts = $_ -split "="
	#$content= $parts[1].Trim()
	$key = $parts[0].Trim()
    $value = $parts[1].Trim()
    $config[$key] = $value
	}
	
	if ($config["Autorun"] -eq "1") {$global:autorun= $True}else{$global:autorun=$False}
	
}


function Open_config.ini()
{
	param(
		$getGameMenuItemsArgs
	)
	start-process "notepad" "$PSScriptRoot\config.ini"
}





function Customize()
{
	param(
		$getGameMenuItemsArgs
	)
	
	start-process "$PSScriptRoot\GamepadDesktop-Wizard.exe"
} 