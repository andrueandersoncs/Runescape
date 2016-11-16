#include <Misc.au3>

Func Pickpocket()
   Local $m = MouseGetPos()
   MouseClick("right")
   MouseClick("left", $m[0], $m[1] + 45, 1, 3)
   MouseMove($m[0], $m[1], 0)
EndFunc

While(Not _IsPressed(11))
   If(_IsPressed(01)) Then
	  Pickpocket()
	  Sleep(100)
   EndIf
WEnd