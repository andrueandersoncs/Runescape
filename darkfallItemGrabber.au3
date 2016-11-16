#include <Misc.au3>

$loopon = True
Dim $dropSpot[2]
$dropSpot[0] = 0
$dropSpot[1] = 0

While($loopon)
   If(_IsPressed("1B") And _IsPressed("02")) Then
	  $loopon = False
   EndIf

   If(_IsPressed("11") And _IsPressed("01")) Then
	  $initialSpot = MouseGetPos()
	  MouseMove($dropSpot[0], $dropSpot[1], 1)
	  MouseUp("left")
	  MouseMove($initialSpot[0], $initialSpot[1], 1)
   ElseIf (_IsPressed("11") And _IsPressed("02")) Then
	  $dropSpot = MouseGetPos()
   EndIf
WEnd