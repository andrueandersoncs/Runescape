#include <Misc.au3>

AutoItSetOption("SendKeyDownDelay", 100)

Func SearchForWatchman()
   Local $colors[3] = [0x000543, 0x460001, 0x7B512E]
   Local $colorTrues[3] = [0, 0, 0]

   $w1 = PixelSearch(565, 50, 1515, 945, $colors[0], 3)
   If(IsArray($w1)) Then
	  $w2 = PixelSearch($w1[0] - 75, $w1[1] - 75, $w1[0] + 75, $w1[1] + 75, $colors[1], 3)
	  If(IsArray($w2)) Then
		 $w3 = PixelSearch($w2[0] - 75, $w2[1] - 75, $w2[0] + 75, $w2[1] + 75, $colors[2], 3)
		 If(IsArray($w3)) Then
			uMouseMove(($w1[0] + $w2[0] + $w3[0])/3, ($w1[1] + $w2[1] + $w3[1])/3)
			$m = MouseGetPos()
			MouseMove($m[0] + Random(0, 3), $m[1] + Random(0, 3))
			Return
		 EndIf
	  EndIf
   EndIf
EndFunc

Func IsWatchman()
   $yellow = 0xFFFF00
   $w = PixelGetColor(58, 35)
   $a = PixelGetColor(69, 35)
   $t = PixelGetColor(74, 32)
   $c = PixelGetColor(80, 35)

   Return ($w == $yellow And $a == $yellow And $t == $yellow And $c == $yellow)
EndFunc

Func Distance($to, $from)
   Return Sqrt((($to[0] - $from[0])*($to[0] - $from[0]))+(($to[1] - $from[1])*($to[1] - $from[1])))
EndFunc

Func DirectionTo($to, $from)
   Local $ret[2] = [0, 0]
   Local $dist = 0
   $dist = Distance($to, $from)
   If($dist > 0 Or $dist < 0) Then
	  $ret[0] = ($to[0] - $from[0]) / $dist
	  $ret[1] = ($to[1] - $from[1]) / $dist
   EndIf
   Return $ret
EndFunc

Func uMouseMove($x, $y)
   Local $to[2] = [$x, $y]
   Local $m = MouseGetPos()

   While($m[0] <> $x Or $m[1] <> $y And Not _IsPressed(11))
	  $m = MouseGetPos()
	  $d = DirectionTo($to, $m)
	  $dist = Distance($to, $m)
	  If($dist < 5) Then
		 MouseMove($x, $y, 0)
		 Return
	  Else
		 If($dist < Random(15, 45)) Then
			MouseMove($m[0] + ($d[0] * 2), $m[1] + ($d[1] * 2), 1)
		 Else
			MouseMove($m[0] + $d[0] + Random(-1, 1), $m[1] + $d[1] + Random(-1, 1), 0)
		 EndIf
	  EndIf
   WEnd
EndFunc

Func HpTooLow()
   If(PixelGetColor(761, 987) == 0x23292C) Then
	  Return True
   EndIf
EndFunc

Func GatherAdrenaline()
   While(PixelGetColor(955, 988) == 0x23292C And Not _IsPressed(11))
	  SearchForWatchman()
	  If(IsWatchman()) Then
		 MouseClick("left")
		 Sleep(Random(5421, 7193))
	  EndIf
   WEnd
   Sleep(Random(892, 1736))
   Send("9")
EndFunc

Func MissingHP()
   Return PixelGetColor(810 - Random(0, 10), 987) == 0x23292C
EndFunc

Func EatBread()
   Local $l = 1750
   Local $r = 1908
   Local $t = 667
   Local $b = 918
   Local $bread = PixelSearch(1750 + Random(0, $r - $l), 667 + Random(0, $b - $t), 1908, 918, 0xB79110, 3)
   If(IsArray($bread)) Then
	  Sleep(Random(0, 354))
	  uMouseMove($bread[0] + Random(0, 5), $bread[1] + Random(0, 5))
	  MouseClick("left")
	  Sleep(Random(1000, 2000))
	  Return $bread
   EndIf
EndFunc

Func Pickpocket()
   Local $m = MouseGetPos()
   MouseClick("right")
   uMouseMove($m[0], $m[1] + Random(40, 50))
   Sleep(Random(75, 425))
   MouseClick("left")
   Sleep(Random(75, 125))
   uMouseMove($m[0] + Random(-5, 5), $m[1] + Random(-5, 5))
   Sleep(10)
EndFunc

Sleep(5000)

Local $count = 0
Local $maxCount = 5
While(Not _IsPressed(11))
   If(HpTooLow()) Then
	  GatherAdrenaline()
   EndIf

   If(MissingHP()) Then
	  EatBread()
   ElseIf($count > $maxCount) Then
	  EatBread()
	  $count = 0
	  $maxCount = Random(7, 15)
   EndIf

   SearchForWatchman()
   If(IsWatchman()) Then
	  Pickpocket()
	  If(Random(0, 10) > 5) Then
		 EatBread()
	  EndIf
   EndIf
WEnd