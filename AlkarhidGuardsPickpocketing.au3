#include <Misc.au3>

Sleep(5000)

Func Distance($a, $b)
   Local $return = -1
   $return = Sqrt((($b[0] - $a[0]) * ($b[0] - $a[0])) + (($b[1] - $a[1]) * ($b[1] - $a[1])))
   Return $return
EndFunc

Func FindGuard($prev)
   ;arms, pants, helm, knight
   Local $colors[4] = [0x010465, 0x4D0001, 0xA99384, 0x49059E]
   Local $areas[4] = [400, 100, 1550, 900]
   Local $return[2] = [-1, -1]
   Local $player[2] = [958, 539]

   If(IsGuard()) Then
	  Pickpocket()
	  Return $prev
   EndIf

   If($prev[0] > 0) Then
	  For $repeat = 0 To 5
		 For $color = 0 To UBound($colors)-1
			$pixel = PixelSearch($prev[0] - 100, $prev[1] - 100, $prev[0] + 100, $prev[1] + 100, $colors[$color], 1)
			If(IsArray($pixel)) Then
			   MouseMove($pixel[0], $pixel[1], Random(1, 3))
			   ;Sleep(50)
			   If(IsGuard() ) Then
				  Pickpocket()
				  Return $pixel
			   EndIf
			EndIf
		 Next
	  Next
   EndIf

   For $color = 0 To UBound($colors)-1
	  $pixel = PixelSearch($areas[0], $areas[1], $areas[0]+(($areas[2]-$areas[0])/2), $areas[1]+(($areas[3]-$areas[1])/2), $colors[$color], 1)
	  If(IsArray($pixel)) Then
		 MouseMove($pixel[0], $pixel[1], Random(5, 10))
		 ;Sleep(50)
		 If(IsGuard() ) Then
			Pickpocket()
			Return $pixel
		 EndIf
	  EndIf
   Next

   For $color = 0 To UBound($colors)-1
	  $pixel = PixelSearch($areas[0]+(($areas[2]-$areas[0])/2), $areas[1], $areas[2], $areas[1]+(($areas[3]-$areas[1])/2), $colors[$color], 1)
	  If(IsArray($pixel)) Then
		 MouseMove($pixel[0], $pixel[1], Random(5, 10))
		 ;Sleep(50)
		 If(IsGuard() ) Then
			Pickpocket()
			Return $pixel
		 EndIf
	  EndIf
   Next

   For $color = 0 To UBound($colors)-1
	  $pixel = PixelSearch($areas[0], $areas[1]+(($areas[3]-$areas[1])/2), $areas[0]+(($areas[2]-$areas[0])/2), $areas[3], $colors[$color], 1)
	  If(IsArray($pixel)) Then
		 MouseMove($pixel[0], $pixel[1], Random(5, 10))
		 ;Sleep(50)
		 If(IsGuard() ) Then
			Pickpocket()
			Return $pixel
		 EndIf
	  EndIf
   Next

   For $color = 0 To UBound($colors)-1
	  $pixel = PixelSearch($areas[0]+(($areas[2]-$areas[0])/2), $areas[1]+(($areas[3]-$areas[1])/2), $areas[2], $areas[3], $colors[$color], 1)
	  If(IsArray($pixel)) Then
		 MouseMove($pixel[0], $pixel[1], Random(5, 10))
		 ;Sleep(50)
		 If(IsGuard() ) Then
			Pickpocket()
			Return $pixel
		 EndIf
	  EndIf
   Next

   Return $return
EndFunc

Func IsGuard()
   $g = PixelSearch(54, 35, 54, 35, 0xFFFF00, 3)
   $u = PixelSearch(63, 36, 63, 36, 0xFFFF00, 3)
   $a = PixelSearch(75, 37, 75, 37, 0xFFFF00, 3)
   $r = PixelSearch(79, 35, 79, 35, 0xFFFF00, 3)
   $d = PixelSearch(89, 31, 89, 31, 0xFFFF00, 3)

   Return (IsArray($g) And IsArray($u) And IsArray($a) And IsArray($r) And IsArray($d))
EndFunc

Func IsKnight()
   $g = PixelSearch(54, 34, 54, 34, 0xFFFF00, 3)
   $u = PixelSearch(62, 38, 62, 38, 0xFFFF00, 3)
   $a = PixelSearch(70, 36, 70, 36, 0xFFFF00, 3)
   $r = PixelSearch(78, 38, 78, 38, 0xFFFF00, 3)
   $d = PixelSearch(82, 37, 82, 37, 0xFFFF00, 3)

   Return (IsArray($g) And IsArray($u) And IsArray($a) And IsArray($r) And IsArray($d))
EndFunc

Func Pickpocket()
   Local $m = MouseGetPos()
   MouseClick("right")
   MouseClick("left", $m[0], $m[1] + 45, 1, 3)
   MouseMove($m[0], $m[1], 0)
EndFunc

Func FindBank()
   $b = PixelSearch(1600, 210, 1808, 405, 0xD6AD27, 7)

   If(IsArray($b)) Then
	  MouseClick("left", $b[0] - 10, $b[1] + 5, 1, 0)
	  Sleep(20000)
	  MouseClick("left", 1780, 155, 1, 0)
	  Sleep(15000)
   EndIf
EndFunc

Func EnoughHP2()
   $noHP = PixelSearch(826, 946, 826, 946, 0x23292C, 3)
   If(IsArray($noHP)) Then
	  Sleep(7000)
	  FindBank()
	  Return False
   Else
	  Return True
   EndIf
EndFunc

Func EnoughHP()
   $noHP = PixelSearch(732, 988, 732, 988, 0x23292C, 3)
   If(IsArray($noHP)) Then
	  Sleep(7000)
	  FindBank()
	  Return False
   Else
	  Return True
   EndIf
EndFunc

Local $prev[2] = [-1, -1]
Local $cur[2] = [-1, -1]
While(Not _IsPressed(11))
   If(EnoughHP2()) Then
	  $cur = FindGuard($prev)
	  If($cur[0] > 0) Then
		 $prev = $cur
	  EndIf
   EndIf
   Sleep(Random(100, 200))
WEnd