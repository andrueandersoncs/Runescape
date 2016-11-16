#include <Misc.au3>

$loopon = True
$doShoot = False
Sleep(1000)

While $loopon

   If _IsPressed(11) Then
	  $loopon = false
   EndIf

   If _IsPressed(46) Then
	  $doShoot = Not $doShoot
	  Sleep(250)
   EndIf

   If $doShoot Then
	  MouseClick("left",Null,Null,1,0)
   EndIf

WEnd