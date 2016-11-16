#include <Misc.au3>

Sleep(5000)

Global $frames = 0

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
	  Local $d = DirectionTo($to, $m)
	  Local $dist = Distance($to, $m)
	  If($dist < 5) Then
		 MouseMove($x, $y, 0)
		 $frames = 0
		 Return
	  Else
		 If($dist < 45 And $dist > 15) Then
			MouseMove($m[0] + ($d[0] * 10), $m[1] + ($d[1] * 10), 1)
			$frames = 0
		 ElseIf($dist < 15) Then
			MouseMove($m[0] + ($d[0] * 3), $m[1] + ($d[1] * 3), 1)
			$frames = 0
		 Else
			MouseMove($m[0] + $d[0] + Random(-1, 1), $m[1] + $d[1] + Random(-1, 1), 0)
			$frames = 0
		 EndIf
	  EndIf
   WEnd
EndFunc

Func Pickpocket()
   Local $m = MouseGetPos()
   MouseClick("right")
   Sleep(50)
   Local $yellow = PixelSearch($m[0]-50, $m[1]+20, $m[0]+50, $m[1]+70, 0xFFFF00, 5)
   If(IsArray($yellow)) Then
	  uMouseMove($m[0], $m[1] + Random(60, 67))
	  Sleep(Random(75, 425))
	  MouseClick("left")
	  Sleep(Random(75, 125))
	  uMouseMove($m[0] + Random(-5, 5), $m[1] + Random(0, 5))
	  Sleep(10)
   Else
	  Return
   EndIf
EndFunc

Func MoveToArrow()
   Local $blueArrow = PixelSearch(1572, 57, 1915, 418, 0x60D2F9, 3)
   Local $blueArrow2 = PixelSearch(1572, 57, 1915, 418, 0x0F9EC1, 3)
   Local $centerMinimap[2] = [1745, 240]

   If(IsArray($blueArrow)) Then
	  Local $direction = DirectionTo($blueArrow, $centerMinimap)
	  Local $distance = Distance($blueArrow, $centerMinimap)
	  If($distance < 10) Then
		 Return True
	  EndIf
	  uMouseMove($centerMinimap[0] + ($direction[0]*Random(5, $distance)), $centerMinimap[1] + ($direction[1]*Random(5, $distance)))
	  MouseClick("left")
	  Sleep(Random(1000, 2750))
   ElseIf(IsArray($blueArrow2)) Then
	  Local $direction = DirectionTo($blueArrow2, $centerMinimap)
	  Local $distance = Distance($blueArrow2, $centerMinimap)
	  If($distance < 10) Then
		 Return True
	  EndIf
	  uMouseMove($centerMinimap[0] + ($direction[0]*Random(5, $distance)), $centerMinimap[1] + ($direction[1]*Random(5, $distance)))
	  MouseClick("left")
	  Sleep(Random(2000, 3750))
   EndIf

   Return False
EndFunc

Func ClickLadder()
   Local $ladder = PixelSearch(736, 298, 1210, 806, 0x2CB7DC, 3)
   If(IsArray($ladder)) Then
	  uMouseMove($ladder[0], $ladder[1])
	  MouseClick("left")
	  Return True
   EndIf
   Return False
EndFunc

Func GoToBankerDot()
   Local $bd = PixelSearch(1746, 263, 1766, 284, 0xF7F701, 5)
   If(IsArray($bd)) Then
	  uMouseMove($bd[0] - Random(5, 10), $bd[1])
	  MouseClick("left")
	  Sleep(Random(4000, 8000))
	  Return True
   EndIf
   Return False
EndFunc

Func AccessBank()
   Local $b = PixelGetColor(41, 32)
   Local $a = PixelGetColor(53, 37)
   Local $n = PixelGetColor(58, 34)
   Local $p[2] = [961, 539]

   For $x = 0 To 100 Step Random(1, 5)
	  uMouseMove($p[0] + $x, $p[1] + Random(-1, 1))
	  $b = PixelGetColor(41, 32)
	  $a = PixelGetColor(53, 37)
	  $n = PixelGetColor(58, 34)
	  If($b == 0x00FFFF And $a == 0x00FFFF And $n == 0x00FFFF) Then
		 MouseClick("left")
		 Sleep(Random(2000, 4000))
		 Return True
	  EndIf
   Next

   Return False
EndFunc

Func DepositInventory()
   uMouseMove(Random(978, 986), Random(805, 813))
   Sleep(Random(15, 750))
   MouseClick("left")
   Sleep(10)
   uMouseMove(Random(1084, 1092), Random(249, 257))
   Sleep(Random(150, 750))
   Sleep(Random(100, 350))
EndFunc

Func Bank()
   $frames = 0
   While(Not MoveToArrow())
	  $frames = $frames + 1
	  If($frames > 500) Then
		 Exit 5
	  EndIf
   WEnd
   Sleep(Random(1000, 5000))
   While(Not ClickLadder())
	  $frames = $frames + 1
	  If($frames > 500) Then
		 Exit 5
	  EndIf
   WEnd
   Sleep(Random(5000, 7500))
   While(Not GoToBankerDot())
	  $frames = $frames + 1
	  If($frames > 500) Then
		 Exit 5
	  EndIf
   WEnd
   If(Not AccessBank()) Then
	  Return Bank()
   EndIf
   DepositInventory()
   While(Not MoveToArrow())
	  $frames = $frames + 1
	  If($frames > 500) Then
		 Exit 5
	  EndIf
   WEnd
   While(Not ExitBank())
	  $frames = $frames + 1
	  If($frames > 500) Then
		 Exit 5
	  EndIf
   WEnd
EndFunc

Func ExitBank()
   uMouseMove(960, 495)
   For $left = 0 To 100 Step Random(1, 5)
	  uMouseMove(960 - $left, 495)
	  If(ConfirmGnome()) Then
		 Local $m = MouseGetPos()
		 uMouseMove($m[0], $m[1] - 5)
	  EndIf
	  If(ConfirmStairs()) Then
		 MouseClick("left")
		 Sleep(Random(3000, 7000))
		 Return True
	  EndIf
   Next
   $m = MouseGetPos()
   uMouseMove($m[0], $m[1] - 5)
   Return False
EndFunc

Func ConfirmStairs()
   Local $s = PixelGetColor(89, 36)
   Local $t = PixelGetColor(94, 33)
   Local $a = PixelGetColor(104, 37)

   Return ($s == 0x00FFFF And $t == 0x00FFFF And $a == 0x00FFFF)
EndFunc

Func ConfirmGnome()
   Local $y = 0x00FFFF00
   Local $g = PixelGetColor(58, 34)
   Local $n = PixelGetColor(67, 37)
   Local $m = PixelGetColor(83, 37)
   Local $e = PixelGetColor(93, 37)

   Return ($g == $y And $n == $y And $m == $y And $e == $y)
EndFunc

Func InventoryFull()
   Local $slot = PixelGetColor(1888, 896)
   If($slot <> 0x0B1C24) Then
	  Return True
   EndIf
   Return False
EndFunc

Func HpBank()
   $frames = 0
   While(Not MoveToArrow())
	  $frames = $frames + 1
	  If($frames > 500) Then
		 Exit 5
	  EndIf
   WEnd
   While(Not ClickLadder())
	  $frames = $frames + 1
	  If($frames > 500) Then
		 Exit 5
	  EndIf
   WEnd
EndFunc

Func HpTooLow()
   If(PixelGetColor(761, 987) == 0x23292C) Then
	  Return True
   EndIf
   Return False
EndFunc

Func FindGnome()
   Local $cshirt = 0x67953E
   Local $chead = 0x4B723F
   Local $chands = 0xE0AF87

   Local $shirt = PixelSearch(705, 451, 1174, 599, $cshirt, 10)
   If(IsArray($shirt)) Then
	  Local $head = PixelSearch($shirt[0]+75, $shirt[1]+75, $shirt[0]-75, $shirt[1]-75, $chead, 10)
	  If(IsArray($head)) Then
		 Local $hands = PixelSearch($head[0]+75, $head[1]+75, $head[0]-75, $head[1]-75, $chands, 10)
		 If(IsArray($hands)) Then
			Local $xy[2] = [($hands[0]+$head[0]+$shirt[0])/3, ($hands[1]+$head[1]+$shirt[1])/3]
			Local $direction = DirectionTo($xy, MouseGetPos())
			uMouseMove($xy[0] + $direction[0]*Random(10, 15), $xy[1] + $direction[1]*Random(10, 15))
			Return True
		 EndIf
	  EndIf
   EndIf

   Local $shirt = PixelSearch(405, 151, 1474, 899, $cshirt, 10)
   If(IsArray($shirt)) Then
	  Local $head = PixelSearch($shirt[0]+75, $shirt[1]+75, $shirt[0]-75, $shirt[1]-75, $chead, 10)
	  If(IsArray($head)) Then
		 Local $hands = PixelSearch($head[0]+75, $head[1]+75, $head[0]-75, $head[1]-75, $chands, 10)
		 If(IsArray($hands)) Then
			Local $xy[2] = [($hands[0]+$head[0]+$shirt[0])/3, ($hands[1]+$head[1]+$shirt[1])/3]
			Local $direction = DirectionTo($xy, MouseGetPos())
			uMouseMove($xy[0] + $direction[0]*Random(10, 15), $xy[1] + $direction[1]*Random(10, 15))
			Return True
		 EndIf
	  EndIf
   EndIf

   Return False
EndFunc

While(Not _IsPressed(11))
   ;if idle for too long
   If($frames > 100) Then
	  ;	go in direction of bank
	  uMouseMove(1745 + (Cos(Random(0, 6.28)) * Random(5, 45)), 240 + (Sin(Random(0, 6.28)) * Random(5, 45)))
	  MouseClick("left")
	  MoveToArrow()
	  $frames = 0
   EndIf

   ;if hp is too low
   If(HpTooLow()) Then
	  ;	go to bank
	  HpBank()
	  ;	wait randomly
	  Sleep(Random(5000, 10000))
	  ;	exit bank
	  ExitBank()
   EndIf

   ;if inventory is full
   If(InventoryFull()) Then
	  ;	go to bank
	  Bank()
   EndIf

   ;if already on a gnome
   If(ConfirmGnome()) Then
	  ;	pickpocket
	  Pickpocket()
	  ;search for gnome
   ElseIf(FindGnome()) Then
	  ;	make sure its a gnome
	  If(ConfirmGnome()) Then
		 Pickpocket()
	  EndIf
   EndIf

   ;increase idle count
   $frames = $frames + 1
   ToolTip($frames)

WEnd