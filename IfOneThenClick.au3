#include <Misc.au3>

While(Not _IsPressed(11))
   If(_IsPressed(31)) Then
	  Do
		 Sleep(10)
	  Until Not _IsPressed(31)
	  MouseClick("left")
   EndIf
   Sleep(10)
WEnd