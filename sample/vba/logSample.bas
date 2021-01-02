Sub LogUseTest()
    Dim oLog    As New Log      '// Logクラス
    
    '// ログファイルパスの指定（と、必要な場合はログファイル最大サイズの指定）
'    Call oLog.Init("C:\web\test\logtest.log", 1000)
    Call oLog.Init("C:\web\test\logtest.log")
    
    '// ログファイルに書き込み
    Call oLog.WriteLog("ここにログファイルに書き込む内容の文字列を指定します")
    Call oLog.WriteLog("ああああ")
    Call oLog.WriteLog("いいい")
    Call oLog.WriteLog("")
    Call oLog.WriteLog("ええ")
    Call oLog.WriteLog(CStr(12345))
    
    '// 書き込み先変更
    Call oLog.Init("C:\web\test\b.log")
    Call oLog.WriteLog("ああああ")
    Call oLog.WriteLog("いいい")
    Call oLog.WriteLog("")
End Sub

