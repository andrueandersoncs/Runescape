#include <Misc.au3>

Sleep(5000)

Func SearchDoor()
   $d = PixelSearch(895, 475, 1025, 575, 0x231B11)
   If(IsArray($d)) Then
	  MouseClick("left", $d[0], $d[1], 1, 0)
	  Pickpocket()
   EndIf
EndFunc

Func Pickpocket()
   Local $m = MouseGetPos()
   MouseClick("right")
   MouseClick("left", $m[0], $m[1] + 45, 1, 3)
   MouseMove($m[0], $m[1], 0)
EndFunc

While(Not _IsPressed(11))
   SearchDoor()
   Sleep(750)
WEnd