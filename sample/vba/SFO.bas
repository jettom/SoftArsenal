Sub Add_Reference()

    Application.VBE.ActiveVBProject.References.AddFromFile "C:\Windows\System32\scrrun.dll"
'Add a reference
'「Microsoft Scripting Runtime」

End Sub

Sub Remove_Reference()

Dim oReference As Object

    Set oReference = Application.VBE.ActiveVBProject.References.Item("Scripting")

    Application.VBE.ActiveVBProject.References.Remove oReference
'Remove a reference

End Sub

