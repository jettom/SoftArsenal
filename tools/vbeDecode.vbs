'VBE decoder
'
'Decode all files encoded (original version) with screnc.exe
'This script give you a decoded listing from an encoded file.
'Supports *,je, ,vbe, .asp, .hta, .htm, .html…
'If used under cscript, puts the result to stdout.
'The file can be multi-encoded (many scripts in the file, for ex. in an html file)
'Used under wscript, pops up the decoded file in a message box.
'
'http://www.interclasse.com/scripts/decovbe.php
'http://demon.tw/programming/vbe-decoder.html

option explicit
Dim oArgs, NomFichier
'Optional argument : the encoded filename
NomFichier=""
Set oArgs = WScript.Arguments
Select Case oArgs.Count
Case 0 'No Arg, popup a dialog box to choose the file
    NomFichier=BrowseForFolder("Choose an encoded file", &H4031, &H0011)
Case 1
    If Instr(oArgs(0),"?")=0 Then '-? ou /? => aide
        NomFichier=oArgs(0)
    End If
Case Else
    WScript.Echo "Too many parameters"
End Select
Set oArgs = Nothing

If NomFichier<>"" Then
    Dim fso
    Set fso=WScript.CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(NomFichier) Then
        Dim fic,contenu
        Set fic = fso.OpenTextFile(NomFichier, 1)
        Contenu=fic.readAll
        fic.close
        Set fic=Nothing

        Const TagInit="#@~^" '#@~^awQAAA==
        Const TagFin="==^#~@" '& chr(0)
        Dim DebutCode, FinCode
        Do
            FinCode=0
            DebutCode=Instr(Contenu,TagInit)
            If DebutCode>0 Then
                If (Instr(DebutCode,Contenu,"==")-DebutCode)=10 Then 'If "==" follows the tag
                    FinCode=Instr(DebutCode,Contenu,TagFin)
                    If FinCode>0 Then
                        Contenu=Left(Contenu,DebutCode-1) & _
                        Decode(Mid(Contenu,DebutCode+12,FinCode-DebutCode-12-6)) & _
                        Mid(Contenu,FinCode+6)
                    End If
                End If
            End If
        Loop Until FinCode=0
        WScript.Echo Contenu
    Else
        WScript.Echo Nomfichier & " not found"
    End If
    Set fso=Nothing
Else
    WScript.Echo "Please give a filename"
    WScript.Echo "Usage : " & wscript.fullname  & " " & WScript.ScriptFullName & " <filename>"
End If

Function Decode(Chaine)
    Dim se,i,c,j,index,ChaineTemp
    Dim tDecode(127)
    Const Combinaison="1231232332321323132311233213233211323231311231321323112331123132"

    Set se=WSCript.CreateObject("Scripting.Encoder")
    For i=9 to 127
        tDecode(i)="JLA"
    Next
    For i=9 to 127
        ChaineTemp=Mid(se.EncodeScriptFile(".vbs",string(3,i),0,""),13,3)
        For j=1 to 3
            c=Asc(Mid(ChaineTemp,j,1))
            tDecode(c)=Left(tDecode(c),j-1) & chr(i) & Mid(tDecode(c),j+1)
        Next
    Next
    'Next line we correct a bug, otherwise a ")" could be decoded to a ">"
    tDecode(42)=Left(tDecode(42),1) & ")" & Right(tDecode(42),1)
    Set se=Nothing

    Chaine=Replace(Replace(Chaine,"@&",chr(10)),"@#",chr(13))
    Chaine=Replace(Replace(Chaine,"@*",">"),"@!","<")
    Chaine=Replace(Chaine,"@$","@")
    index=-1
    For i=1 to Len(Chaine)
        c=asc(Mid(Chaine,i,1))
        If c<128 Then index=index+1
        If (c=9) or ((c>31) and (c<128)) Then
            If (c<>60) and (c<>62) and (c<>64) Then
                Chaine=Left(Chaine,i-1) & Mid(tDecode(c),Mid(Combinaison,(index mod 64)+1,1),1) & Mid(Chaine,i+1)
            End If
        End If
    Next
    Decode=Chaine
End Function

Function BrowseForFolder(ByVal pstrPrompt, ByVal pintBrowseType, ByVal pintLocation)
    Dim ShellObject, pstrTempFolder, x
    Set ShellObject=WScript.CreateObject("Shell.Application")
    On Error Resume Next
    Set pstrTempFolder=ShellObject.BrowseForFolder(&H0,pstrPrompt,pintBrowseType,pintLocation)
    BrowseForFolder=pstrTempFolder.ParentFolder.ParseName(pstrTempFolder.Title).Path
    If Err.Number<>0 Then BrowseForFolder=""
    Set pstrTempFolder=Nothing
    Set ShellObject=Nothing
End Function
