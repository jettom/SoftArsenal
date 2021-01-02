Option Explicit

'//----------------------------------------------------------------------------
'// 構造体：クラス内ではPrivate指定必須
'//----------------------------------------------------------------------------
'// SYSTEMTIME構造体
Private Type SYSTEMTIME
    wYear           As Integer    '// 年
    wMonth          As Integer    '// 月
    wDayOfWeek      As Integer    '// 曜日（0:日曜、1:月、2:火、3:水、4:木、5:金、6:土）
    wDay            As Integer    '// 日
    wHour           As Integer    '/  時
    wMinute         As Integer    '// 分
    wSecond         As Integer    '// 秒
    wMilliseconds   As Integer    '// ミリ秒
End Type

'//----------------------------------------------------------------------------
'// DLL参照：クラス内ではPrivate指定必須
'//----------------------------------------------------------------------------
'// GetLocalTime：システム日時取得
'64bit 版
Private Declare PtrSafe Sub GetLocalTime Lib "kernel32" (lpSystemTime As SYSTEMTIME)
'32bit 版
'Private Declare Sub GetLocalTime Lib "kernel32" (lpSystemTime As SYSTEMTIME)

'//----------------------------------------------------------------------------
'// モジュール変数
'//----------------------------------------------------------------------------
Private m_Fs        As FileSystemObject     '// FileSystemObject変数
Private m_Ts        As TextStream           '// TextStream変数
Private m_Path      As String               '// ログファイルパス
Private m_LogFile   As File                 '// ログファイル制御用File変数
Private m_lMaxSize  As Double               '// ログファイル最大サイズ（超えた場合はバックアップ化）

'//----------------------------------------------------------------------------
'// 関数名  ：Class_Initialize
'// 引数    ：なし
'// 戻り値  ：なし
'// 機能    ：コンストラクタ
'// 備考    ：
'//----------------------------------------------------------------------------
Private Sub Class_Initialize()
End Sub

'//----------------------------------------------------------------------------
'// 関数名  ：Class_Terminate
'// 引数    ：なし
'// 戻り値  ：なし
'// 機能    ：デストラクタ
'// 備考    ：
'//----------------------------------------------------------------------------
Private Sub Class_Terminate()
End Sub

'//----------------------------------------------------------------------------
'// 関数名  ：Init
'// 引数    ：(I)   sLogFilePath As String  ：ログファイルパス
'//         ：(I)   iMaxSize = 1000000      ：ログファイル最大サイズ（省略時は約1MB）
'// 戻り値  ：なし
'// 機能    ：Logクラスを利用するための初期処理を行う
'// 備考    ：
'//----------------------------------------------------------------------------
Public Sub Init(sLogFilePath As String, Optional iMaxSize = 1000000)
    '// FileSystemObjectの初期化
    Set m_Fs = New FileSystemObject
    
    '// ログファイルパス保持
    m_Path = sLogFilePath
    
    '// ログファイル最大サイズ指定
    m_lMaxSize = iMaxSize
End Sub

'//----------------------------------------------------------------------------
'// 関数名  ：WriteLog
'// 引数    ：(I)   sMsg As String          ：書き込む内容
'// 戻り値  ：なし
'// 機能    ：ログファイルに文字列を書き込む
'// 備考    ：書き込み内容の後ろで改行を行う
'//----------------------------------------------------------------------------
Public Sub WriteLog(sMsg As String)
    On Error Resume Next
    
    Dim sNowDateTime    As String   '// システム日時
    Dim sWriteLine      As String   '// 書き込みログ
    
    '// ログファイルのフォルダが存在しない場合
    If (m_Fs.FolderExists(m_Fs.GetParentFolderName(m_Path)) = False) Then
        Debug.Print "ログファイルのフォルダが存在しないためログファイルを作成できません。[" & m_Path & "]"
        Exit Sub
    End If
    
    '// ログファイルが存在する場合
    If (m_Fs.FileExists(m_Path) = True) Then
        '// ログファイルのFileオブジェクト取得
        Set m_LogFile = m_Fs.GetFile(m_Path)
        
        '// ログファイルサイズが最大サイズに達している場合
        If (m_LogFile.Size > m_lMaxSize) Then
            Call Rename
        End If
    End If
    
    '// ファイルオープン
    '// 第一引数：ログファイルのパス
    '// 第二引数：追加書き込みモード
    '// 第三引数：ファイルが無い場合は新規作成
    '// 第四引数：ASCIIファイルとして扱う
    Set m_Ts = m_Fs.OpenTextFile(m_Path, ForAppending, True, TristateFalse)
    
    If Err.Number <> 0 Then
        Debug.Print "エラー発生：No." & Err.Number & "[" & Err.Description & "]"
        Exit Sub
    End If
    
    '// 現在日時取得
    Call GetDateTime(sNowDateTime)
    
    '// 書き込み内容編集
    sWriteLine = sNowDateTime & " " & sMsg
    
    '// 書き込み
    Call m_Ts.WriteLine(sWriteLine)
    
    '// ファイルを閉じる
    m_Ts.Close
End Sub

'//----------------------------------------------------------------------------
'// 関数名  ：GetDateTime
'// 引数    ：(I)   sNowDateTime As String      ：現在日時（YYYY/MM/DD hh:mm:ss.mmm）
'// 戻り値  ：なし
'// 機能    ：現在日時を取得する
'// 備考    ：
'//----------------------------------------------------------------------------
Private Function GetDateTime(sNowDateTime As String)
    Dim t   As SYSTEMTIME
    
    '// システム日時取得
    Call GetLocalTime(t)
    
    sNowDateTime = CStr(t.wYear) & "/" & Format(t.wMonth, "00") & "/" & Format(t.wDay, "00") & " " & Format(t.wHour, "00") & ":" & Format(t.wMinute, "00") & ":" & Format(t.wSecond, "00") & "." & Format(t.wMilliseconds, "000")
End Function

'//----------------------------------------------------------------------------
'// 関数名  ：Rename
'// 引数    ：なし
'// 戻り値  ：なし
'// 機能    ：ログファイルの名前を現在日時を付与した名前に変更する
'// 備考    ：変更前　a.log　変更後　a_YYYYMMDD_hhmmss.mmm.log
'//----------------------------------------------------------------------------
Private Sub Rename()
    Dim sNowDateTime    As String   '// システム日時
    Dim sEditDt         As String   '// バックアップファイル用の日時文字列
    
    '// 現在日時取得
    Call GetDateTime(sNowDateTime)
    
    sEditDt = Replace(sNowDateTime, "/", "")
    sEditDt = Replace(sEditDt, ":", "")
    sEditDt = Replace(sEditDt, " ", "_")
    
    '// ログファイル名変更
    Name m_LogFile.Path As m_LogFile.ParentFolder & "\" & m_Fs.GetBaseName(m_LogFile.Path) & "_" & sEditDt & "." & m_Fs.GetExtensionName(m_LogFile.Path)
End Sub
