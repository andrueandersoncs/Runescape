#include <Misc.au3>

Global $step = 0

Func RotateCameraNorth()
   $pixelLocation = PixelSearch(1627, 157, 1628, 159, 0x691C14, 10)
   while(Not IsArray($pixelLocation))
	  Send("{RIGHT}")
	  $pixelLocation = PixelSearch(1627, 157, 1628, 159, 0x691C14, 10)
	  Sleep(10)
   WEnd
EndFunc

Func FindFurnaceIcon()
   $left = 1732
   $top = 137
   $right = 1788
   $bottom = 176
   Local $pixelLocation = PixelSearch($left, $top, $right, $bottom, 0xAA9864, 5)
   while(Not IsArray($pixelLocation))
	  $pixelLocation = PixelSearch($left, $top, $right, $bottom, 0xAA9864, 5)
	  Sleep(10)
   WEnd
   MouseClick("left", $pixelLocation[0] + 10, $pixelLocation[1] + 10, 1, 0)
EndFunc

Func AccessFurnace()
   MouseClick("left", 655, 975) ;Access Furnace
EndFunc

Func ClickSmelt()
   MouseClick("left", 1070, 725)
EndFunc

Func WaitForLastGold()
   $lastGold = PixelSearch(1815, 915, 1815, 915, 0xDBAD1E, 15)
   While(Not IsArray($lastGold))
	  $lastGold = PixelSearch(1815, 915, 1815, 915, 0xDBAD1E, 15)
	  Sleep(20)
   WEnd
EndFunc

Func FindBankIcon()
   $bankIcon = PixelSearch(1700, 320, 1780, 370, 0xD49C30, 10)
   While(Not IsArray($bankIcon))
	  $bankIcon = PixelSearch(1700, 320, 1780, 370, 0xD49C30, 10)
	  Sleep(20)
   WEnd
   MouseClick("left", $bankIcon[0] + 5, $bankIcon[1] + 5, 1, 0)
EndFunc

Func ClickBanker()
   $diff = 0
   $iter = 0
   $banker = PixelSearch(867, 300, 1050, 396, 0x4B5B3C, $diff)
   While(Not IsArray($banker))
	  $iter = $iter + 1
	  $banker = PixelSearch(867, 300, 1050, 396, 0x4B5B3C, $diff)
	  If(Mod($iter, 200) == 0) Then
		 $diff = $diff + 1
	  EndIf
	  If($diff > 255) Then
		 MsgBox(0, "Error", "Color Not Found.")
		 Return
	  EndIf
   WEnd
   MouseClick("left", $banker[0], $banker[1], 1, 0)
EndFunc

Func DepositBars()
   MouseClick("right", 1134, 370)
   Sleep(1000)
   MouseClick("left", 1134, 476)
EndFunc

Func WithdrawOre()
   MouseClick("right", 965, 563, 1, 0)
   Sleep(1000)
   MouseClick("left", 965, 670, 1, 0)
EndFunc

while(Not _IsPressed(11))
   if($step == 0) Then
	  RotateCameraNorth()
	  $step = 1
   EndIf
   if($step == 1) Then
	  FindFurnaceIcon()
	  Sleep(15000)
	  AccessFurnace()
	  Sleep(2000)
	  $step = 2
   EndIf
   if($step == 2) Then
	  ClickSmelt()
	  $step = 3
   EndIf
   if($step == 3) Then
	  WaitForLastGold()
	  $step = 4
   EndIf
   if($step == 4) Then
	  FindBankIcon()
	  Sleep(15000)
	  $step = 5
   EndIf
   if($step == 5) Then
	  ClickBanker()
	  Sleep(7000)
	  $step = 6
   EndIf
   if($step == 6) Then
	  DepositBars()
	  Sleep(3000)
	  WithdrawOre()
	  Sleep(3000)
	  MouseClick("left", 1088, 299, 1, 0)
	  Sleep(3000)
	  $step = 1
   EndIf
   Sleep(10)
WEnd