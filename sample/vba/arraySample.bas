dim keyArray() as String
public const tragetArray as String = "aa,bb,cc,dd"

Sub test()
    keyArray = Split(tragetArray, ",")
    for i = 0 to UBound(keyArray)
        debug.print keyArray(i)
    next i
End Sub

