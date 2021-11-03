For i = 2 To 37204’数据行数  
    k = Val(Sheet1.Cells(i, 18))  
    For z = 0 To k  
        Sheet1.Cells(i, 21 + z) = "│"  
    Next  
    If Sheet1.Cells(i, 13) <> Sheet1.Cells(i - 1, 13) Then  
        strCell = Split(Sheet1.Cells(i, 13), "/")  
        If UBound(strCell) >= 1 Then Sheet1.Cells(i, 21 + k) = "├" & strCell(UBound(strCell) - 1) Else Sheet1.Cells(i, 21 + k) = "├" & Sheet1.Cells(i, 13)  
        ' If UBound(strCell) >= 1 Then Sheet1.Cells(i, 21 + k) = strCell(UBound(strCell) - 1) Else Sheet1.Cells(i, 21 + k) = Sheet1.Cells(i, 13)  
        'Worksheets("Sheet1").Range(Cells(i, 21 + k), Cells(i, 21 + k)).Font.FontStyle = "Bold"  
        ‘如果是文件夹则设置成红色显示  
        Worksheets("Sheet1").Range(Cells(i, 21 + k), Cells(i, 21 + k)).Font.ColorIndex = 3  
        Worksheets("Sheet1").Range(Cells(i, 21 + k), Cells(i, 21 + k)).Select  
        Selection.Columns.AutoFit  
    End If  
    If Sheet1.Cells(i, 7) = 0 Then  
        Sheet1.Cells(i, 21 + k + 1) = "├" & Sheet1.Cells(i, 3)  
        If Val(Sheet1.Cells(i, 4)) >= 1048576 Then’文件大小，小于1M的以K表示  
            Sheet1.Cells(i, 20) = Format(CStr(Val(Sheet1.Cells(i, 4) / 1024 / 1024)), "######0.##")& "M"  
        Else  
            Sheet1.Cells(i, 20) = Format(CStr(Val(Sheet1.Cells(i, 4) / 1024)), "######0.##") & "K"  
        End If  
        'Sheet1.Cells(i, 21 + k + 1) = Sheet1.Cells(i, 3)  
    Else  
        'Sheet1.Cells(i, 21 + k + 1) = Sheet1.Cells(i, 3)  
        'Worksheets("Sheet1").Range(Cells(i, 21 + k + 1), Cells(i, 21 + k + 1)).Font.ColorIndex = 5  
    End If  
Next  
