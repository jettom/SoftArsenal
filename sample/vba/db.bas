Option Explicit

    private Const CONN_SCHEMA_ROW = 1
    private Const CONN_PASSWORD_ROW = 2
    private Const CONN_ORASID_ROW = 3

    private OraDB as ADODB.Connection

public sub conn(id as String, schema as String, passwd as String)
On Error Goto Err
    set OraDB = New ADODB.Connection
    With OraDB
        .open "Provider=OraOLEDB.Oracle;Data Source=" & id & ";" , schema, passwd
        .CursorLocation = adUseClient
    End With

Err:
    debug.print id,schema,passwd
End Sub

Public Sub Init()
    Set OraDB = Nothing
End Sub

Public Function getOraDB() as ADODB.Connection

    set getOraDB = OraDB

End Function

Public Function  getData(oraDb as ADODB.Connection, strTbl as String, strWhere as String , strOrder as String) as ADODB.Recordset
    dim strSql as String

    On Error GoTo Err
    
    strSql = "select * " & _
            strTbl & _
            " WHERE " & _
            strWhere & _
            " ORDER BY " & _
            strOrder
    set getData = oraDb.Execute(strSql)
Err:
    debug.print strSql
End Function


public Sub setData(ds as ADODB.Recordset, row as long)
    dim colNames as ADODB.Fields
    set colNames = ds.Fields
    for column = 0 to ds.Fields.Count - 1
        Select Case ds(column).Type
        Case adDBTimeStamp 
            debug.print ds(column).Name
        Case adNumeric
            debug.print ds(column).Precision,ds(column).NumericScale
        Case Else
            'char
        End Select

    next

    Do While ds.EOF <> True
        for column = 0 to colNames.Count - 1 
            If IsNull(colNames(column).Value) Then
                'null
            Else 
                debug.print colNames(column).Value
            End If
  

        next
        ds.MoveNext
        rowNum = rowNum + 1
    Loop
End Sub


sub main()

On Error GoTo Err
    ' start
    startTime = time


    Init()
    conn()
    set database = getOraDB()
    set dataset = getData(database,"tbl","where","order")
    setData(dataset, act_row)
    act_row = act_row + clng(dataset.RecordCount) + 5
    dataset.Close
    set dataset = Nothing

    database.Close
    set database = Nothing

    'end 
    endTime = time

Err:
    If dataset.Status = adStateOpen Then
        dataset.Close
        set dataset = Nothing
    End If

    If database.Status = adStateOpen Then
        database.Close
        set database = Nothing
    End If

    Exit Sub
end sub