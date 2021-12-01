Option Explicit
Option Base 1
Global G_Book_Name as String
Global G_Sheet_Name as String


Sub file_chech()
    G_Book_Name = ThisWorkbook.Name
    G_Sheet_Name = ActiveSheet.Name

    With Workbooks(G_Book_Name).Worksheets(G_Sheet_Name)
        debug.print .Cells(1,1).value
    End With

End Sub

