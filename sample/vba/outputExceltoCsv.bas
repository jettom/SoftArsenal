Sub BrowseFolders()
    Dim FileSystem As Object
    Set FileSystem = CreateObject("Scripting.FileSystemObject")
    
    Application.ScreenUpdating = False ' 关闭屏幕更新以加快宏的运行速度
    
    ' 开始递归遍历
    BrowseFoldersRecursive FileSystem.GetFolder(ThisWorkbook.Path), FileSystem
    
    Application.ScreenUpdating = True ' 重新打开屏幕更新
    
    Set FileSystem = Nothing
End Sub

Sub BrowseFoldersRecursive(ByVal TargetFolder As Object, ByRef FileSystem As Object)
    Dim File As Object
    Dim SubFolder As Object
    Dim wb As Workbook
    
    ' 遍历目标文件夹中的所有文件
    For Each File In TargetFolder.Files
        If FileSystem.GetExtensionName(File.Path) = "xlsx" Or FileSystem.GetExtensionName(File.Path) = "xls" Then
            Set wb = Workbooks.Open(File.Path)
            
            ' 遍历工作簿中的所有工作表
            Dim ws As Worksheet
            For Each ws In wb.Worksheets
                ' 输出工作表数据到文件
                SaveWorksheetData ws, FileSystem.GetParentFolderName(wb.Path)
            Next ws
            
            wb.Close False ' 关闭工作簿，不保存更改
        End If
    Next File
    
    ' 递归遍历所有子文件夹
    For Each SubFolder In TargetFolder.SubFolders
        BrowseFoldersRecursive SubFolder, FileSystem
    Next SubFolder
End Sub

Sub SaveWorksheetData(ws As Worksheet, outputPath As String)
    Dim r As Range
    Dim c As Range
    Dim outputLine As String
    Dim outputFileName As String
    Dim fileNumber As Integer
    
    ' 构建输出文件的完整路径
    outputFileName = outputPath & "\" & ws.Name & ".csv"
    
    ' 获得一个可用的文件编号
    fileNumber = FreeFile
    
    ' 创建新文件并打开
    Open outputFileName For Output As #fileNumber

    ' 读取表头信息
    Dim headers As Variant
    headers = Application.Transpose(ws.Range("A2", ws.Cells(2, ws.Columns.Count).End(xlToLeft)).Value)
    
    ' 读取数据类型信息
    Dim dataTypes As Variant
    dataTypes = Application.Transpose(ws.Range("A3", ws.Cells(3, ws.Columns.Count).End(xlToLeft)).Value)
    
    ' 读取长度信息
    Dim lengths As Variant
    lengths = Application.Transpose(ws.Range("A4", ws.Cells(4, ws.Columns.Count).End(xlToLeft)).Value)
    
    ' 写入表头名称
    For i = LBound(headers) To UBound(headers)
        outputLine = outputLine & headers(i) & ","
    Next i
    outputLine = Left(outputLine, Len(outputLine) - 1)
    Print #fileNumber, outputLine
    
    ' 遍历工作表中的数据行（从第5行开始）
    For Each r In ws.Range("A5", ws.Cells(ws.Rows.Count, ws.Columns.Count).End(xlUp)).Rows
        outputLine = ""
        ' 遍历每个单元格
        For i = 1 To r.Cells.Count
            If dataTypes(i) = "date" Then
                ' 只输出年月日
                outputLine = outputLine & Format(r.Cells(i).Value, "yyyy-mm-dd") & ","
            ElseIf dataTypes(i) = "char" Then
                ' 按长度补齐空格
                outputLine = outputLine & Left(r.Cells(i).Text & String(lengths(i), " "), lengths(i)) & ","
            Else
                ' 其他类型直接输出
                outputLine = outputLine & r.Cells(i).Text & ","
            End If
        Next i
        ' 移除行尾的逗号
        outputLine = Left(outputLine, Len(outputLine) - 1)
        ' 写入到文件
        Print #fileNumber, outputLine
    Next r
    
    ' 关闭文件
    Close #fileNumber
End Sub

Sub SaveWorksheetDataWithJapaese(ws As Worksheet, outputPath As String)
    Dim r As Range
    Dim c As Range
    Dim outputLine As String
    Dim outputFileName As String
    Dim fileNumber As Integer
    
    ' 出力ファイルのパスを作成します
    outputFileName = outputPath & "\" & ws.Name & ".csv"
    
    ' 利用可能なファイル番号を取得します
    fileNumber = FreeFile
    
    ' 新しいファイルを作成して開きます
    Open outputFileName For Output As #fileNumber

    ' ヘッダ情報を読み込みます
    Dim headers As Variant
    headers = Application.Transpose(ws.Range("A2", ws.Cells(2, ws.Columns.Count).End(xlToLeft)).Value)
    
    ' データタイプ情報を読み込みます
    Dim dataTypes As Variant
    dataTypes = Application.Transpose(ws.Range("A3", ws.Cells(3, ws.Columns.Count).End(xlToLeft)).Value)
    
    ' 長さ情報を読み込みます
    Dim lengths As Variant
    lengths = Application.Transpose(ws.Range("A4", ws.Cells(4, ws.Columns.Count).End(xlToLeft)).Value)
    
    ' ヘッダ名を書き込みます
    For i = LBound(headers) To UBound(headers)
        outputLine = outputLine & headers(i) & ","
    Next i
    outputLine = Left(outputLine, Len(outputLine) - 1)
    Print #fileNumber, outputLine
    
    ' データ行を処理します（5行目から開始）
    For Each r In ws.Range("A5", ws.Cells(ws.Rows.Count, ws.Columns.Count).End(xlUp)).Rows
        outputLine = ""
        ' 各セルを処理します
        For i = 1 To r.Cells.Count
            If dataTypes(i) = "date" Then
                ' 日付のみを出力します（年月日）
                outputLine = outputLine & Format(r.Cells(i).Value, "yyyy-mm-dd") & ","
            ElseIf dataTypes(i) = "char" Then
                ' 長さに応じて空白で埋めます
                outputLine = outputLine & Left(r.Cells(i).Text & String(lengths(i), " "), lengths(i)) & ","
            Else
                ' その他のタイプは直接出力します
                outputLine = outputLine & r.Cells(i).Text & ","
            End If
        Next i
        ' 行の末尾のコンマを削除します
        outputLine = Left(outputLine, Len(outputLine) - 1)
        ' ファイルに書き込みます
        Print #fileNumber, outputLine
    Next r
    
    ' ファイルを閉じます
    Close #fileNumber
End Sub
