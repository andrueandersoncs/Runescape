#include <Misc.au3>

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

While(Not _IsPressed(11))
   ClickBanker()
WEnd