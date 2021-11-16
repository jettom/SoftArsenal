''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 処理高速化用:関数開始時に実行する処理セット
' .ScreenUpdating = False」:画面更新の停止
' .EnableEvents = False」:イベントを無効
' .Calculation = xlCalculationManual」:自動計算の停止
''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function startFunc()
    With Application
        .ScreenUpdating = False
        .EnableEvents = False
        .Calculation = xlCalculationManual
    End With
End Function
''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 処理高速化用:関数終了時に実行する処理セット
''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function endFunc()
    With Application
        .ScreenUpdating = True
        .EnableEvents = True
        .Calculation = xlCalculationAutomatic
    End With
End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''
' コピー処理
''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function book2bookCopy(srcSheet As String, srcRange As String, _
                dstBook As String, dstSheet As String, dstRange As String)
    ' 処理高速化用:開始処理
    Call startFunc
    With Workbooks.Open(ThisWorkbook.Path & "\" & dstBook)
        ' コピー
        ThisWorkbook.Worksheets(srcSheet).Range(srcRange).Copy
        .Worksheets(dstSheet).Range(dstRange).PasteSpecial _
            xlPasteValuesAndNumberFormats
        ' コピー中状態を解除
        Application.CutCopyMode = False
        ' 処理高速化用:終了処理
        Call endFunc
        ' 保存して閉じる
        '.Close True
        ' 保存しなし閉じる
        .Close False
    End With
End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''
' テスト実行用
''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function test()
    Call book2bookCopy("Sheet1", "A1:E5", "b.xlsx", "Sheet1", "A1")
End Function

'to open the workbook that is saved in a folder on your system _
change the path according to the location you have in your _
system
Workbooks.Open "C:\Users\Dell\Desktop\myFile.xlsx"

'copies cell from the book1 workbook and copy and paste _
it to the workbook myFile
Workbooks("Book1").Worksheets("Sheet1").Range("A1").Copy _
Workbooks("myFile").Worksheets("Sheet1").Range("A1")

'close the workbook and after saving
Workbooks("myFile").Close SaveChanges:=True

''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''
Sub マスターデータ取込01()  '指定したファイルを取り込み、別のファイルに貼り付ける。

    Dim SetFile As String
    Dim wbMoto, wbSaki As Workbook
    

    Set wbMoto = ActiveWorkbook  'マスターデータ取り込み元をブック名をセット（取り込み元）

    Application.DisplayAlerts = False
       
    SetFile = "C:\DATA\Master.xlsx"  'マスターデータファイルの取り込み場所をセット（取り込み先）
    
    Workbooks.Open fileName:=SetFile, ReadOnly:=True, UpdateLinks:=0 'マスターデータファイルを読み取り専用で開きます（）
    Set wbSaki = Workbooks.Open(SetFile) '開いたマスターブック名とセット（取り込み先）
    

        wbSaki.Worksheets("項目M").Range("A1:B20").Copy  '取り込み先のシート名の「項目M」セルA1:B20の範囲をコピー
        
        wbMoto.Worksheets("項目").Range("A1").PasteSpecial xlPasteFormulasAndNumberFormats  '取り込み元　シート名「項目」A1から貼り付け
        
        Application.CutCopyMode = False  'コピー切り取りを解除
        
        wbSaki.Close False  'マスターデータ取り込み先のファイルを閉じる
    
    Application.DisplayAlerts = True

End Sub


''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''
Sub マスターデータ取込02()  '選択したファイルを取り込み、別のファイルに貼り付ける。

    Dim RC As Integer
    Dim OpenFileName, fileName, Path, SetFile As String
    Dim wbMoto, wbSaki As Workbook

    Set wbMoto = ActiveWorkbook  'マスターデータ取り込み元をセット

    Application.DisplayAlerts = False
    
    RC = MsgBox("マスターデータ取込みますか？", vbYesNo + vbQuestion, "確認")
    
    If RC = vbYes Then
            
            OpenFileName = Application.GetOpenFilename("Microsoft Excelブック,*.xls?")
            'ダイアログボックスを表示して、マスターデータファイルを指定します。
            
            If OpenFileName <> "False" Then
                 SetFile = OpenFileName
            Else
                MsgBox "キャンセルされました"
                Exit Sub  'マスターデータの取り込みをキャンセル
            End If
    
            
            Workbooks.Open fileName:=SetFile, ReadOnly:=True, UpdateLinks:=0
            'ダイアログボックスで指定したマスターデータファイルを開きます。
            
            Set wbSaki = Workbooks.Open(Path & SetFile)
            
                'ワークブック間のシート「項目」をコピーします。
                wbSaki.Worksheets("項目M").Range("A1:B20").Copy
                wbMoto.Worksheets("項目").Range("A1").PasteSpecial xlPasteFormulasAndNumberFormats
                
                'ワークブック間のシート「顧客データ」をコピーします。
                wbSaki.Worksheets("顧客データM").Range("A1:G20").Copy
                wbMoto.Worksheets("顧客データ").Range("A1").PasteSpecial xlPasteFormulasAndNumberFormats
                
                
                Application.CutCopyMode = False  'コピー切り取りを解除
                wbSaki.Close False  'マスターデータ取り込み先のファイルを閉じる
  
        Else
        
        MsgBox "処理を中断します"
    
    End If
    
    Application.DisplayAlerts = True

End Sub
'
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''
' open folder all excel files(workbooks)
''''''''''''''''''''''''''''''''''''''''''''''''''''''
Sub openDirWorkbooks()
    
    Dim A, B
    'フォルダパスを指定
    A = ThisWorkbook.Path & "\保存"
    'CSVのファイル名を取得
    B = Dir(A & "\*.csv")
    
    i = 0
    Do While B <> ""
        'ファイルを開く
        Workbooks.Open Filename:=A & "\" & B
        i = i + 1
        'ファイル名を取得
        ThisWorkbook.ActiveSheet.Cells(i, 1) = ActiveWorkbook.Name
        'ファイルの値を取得
        ThisWorkbook.ActiveSheet.Cells(i, 2) = ActiveWorkbook.ActiveSheet.Cells(1, 1)
        'ファイルを閉じる
        ActiveWorkbook.Close
        B = Dir() '次のファイル名を取得
    Loop
    
End Sub