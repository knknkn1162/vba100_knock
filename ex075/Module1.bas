Option Explicit

Function Validate(id As String, pass As String) As Boolean
    Dim rng As Range: Set rng = Worksheets("ID").Range("A1").CurrentRegion
    Set rng = Intersect(rng, rng.Offset(1))
    Validate = False
    Dim idx As Integer
    On Error Resume Next
    idx = WorksheetFunction.match(id, rng.Columns(1), 0)
    Err.Clear
    On Error GoTo 0
    If idx = 0 Then Exit Function
    Validate = (pass = rng.Cells(idx,2))
End Function

Sub main()
    Dim retry As Integer
    For retry = 1 To 3
        Dim id As String
        Dim pass As String
        id = inputbox("IDを入力: " & retry & "回目")
        If StrPtr(id) = 0 Then GoTo Continue
        pass = inputbox("passを入力" & retry & "回目")
        If StrPtr(pass) = 0 Then GoTo Continue
        If Validate(id & "", pass &"") Then 
            Msgbox "validated"
            Exit Sub
        End If
Continue:
    Next
    Msgbox "close book"
    Dim orig As Boolean: orig = Application.DisplayAlerts
    Application.DisplayAlerts = False
    ThisWorkbook.Close SaveChanges:=False
    Application.DisplayAlerts = orig
End Sub
