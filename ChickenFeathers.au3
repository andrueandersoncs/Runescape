#include <Misc.au3>

Func CheckPosition()
   Local $farLeft = PixelSearch(1817, 165, 1824, 170, 0x978978, 20)
   Local $farRight = PixelSearch(1829, 165, 1835, 170, 0x6F6D61, 20)
   Local $farDown = PixelSearch(1824, 165, 1830, 177, 0x83847C, 20)
   Local $farUp = PixelSearch(1824, 184, 1828, 190, 0x7A7977, 20)
   If(IsArray($farLeft)) Then
	  MouseClick("left", 1020, 545, 1, 0)
	  Sleep(2000)
   EndIf
   If(IsArray($farRight)) Then
	  MouseClick("left", 900, 545, 1, 0)
	  Sleep(2000)
   EndIf
   If(IsArray($farUp)) Then
	  MouseClick("left", 960, 592, 1, 0)
	  Sleep(2000)
   EndIf
   If(IsArray($farDown)) Then
	  MouseClick("left", 960, 490, 1, 0)
	  Sleep(2000)
   EndIf
EndFunc

Func SearchAttackTooltip()
   $mouse = MouseGetPos()
   $a1 = PixelSearch($mouse[0] + 48, $mouse[1] + 40, $mouse[0] + 52, $mouse[1] + 44, 0xDDD2B1, 15)
   $t = PixelSearch($mouse[0] + 60, $mouse[1] + 42, $mouse[0] + 64, $mouse[1] + 46, 0xEBE0BC, 15)
   $a2 = PixelSearch($mouse[0] + 70, $mouse[1] + 45, $mouse[0] + 74, $mouse[1] + 49, 0xDAD0AF, 15)
   If(IsArray($a1) And IsArray($t) And IsArray($a2)) Then
	  Return True
   EndIf
   Return False
EndFunc

Func SearchChicken($v)
   $chicken = PixelSearch(730, 430, 1135, 780, 0xAF2B15, $v)
   If(IsArray($chicken)) Then
	  MouseMove($chicken[0], $chicken[1], 0)
	  Sleep(150)
	  If(SearchAttackTooltip()) Then
		 MouseClick("left")
		 Return True
	  EndIf
   EndIf
   Return False
EndFunc

Func ClickSelf()
   MouseClick("left", 958, 530, 3, 0)
EndFunc

Func ClickLoot()
   $loot = PixelSearch(160, 258, 231, 270, 0xF5F5F5, 15)
   If(IsArray($loot)) Then
	  MouseClick("left", $loot[0], $loot[1], 1, 0)
   Else
	  ClickSelf()
   EndIf
EndFunc

$unfound = 0
$loot = False
Sleep(5000)
While(Not _IsPressed(11))
   CheckPosition()
   If($unfound > 40 Or SearchChicken($unfound)) Then
	  Sleep(750)
	  $unfound = 10
	  ClickLoot()
   Else
	  $unfound = $unfound + 5
   EndIf
WEnd