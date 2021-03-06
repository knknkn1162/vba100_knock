Option Explicit

Function createDBSheet() As Worksheet
    Dim ws As Worksheet, elem_ws As Worksheet
    Dim cur_ws As Worksheet
    Set cur_ws = Worksheets("売上")
    For Each elem_ws In Worksheets
        If elem_ws.Name = "売上DB" Then
            Set ws = elem_ws
        End If
    Next

    If ws Is Nothing Then
        Set ws = Worksheets.Add(After:=cur_ws)
    End If
    With ws
        .Name = "売上DB"
        .Cells(1, 1).Resize(1,4) = _
            Array("部門", "区分", "日付", "金額")
    End With
    cur_ws.Activate
    Set createDBSheet = ws
End Function

Sub main()
    Dim ws As Worksheet
    Set ws = createDBSheet()

    Dim pos As Integer
    pos = 2
    Dim i As Integer, j As Integer
    ws.Columns("C").NumberFormatLocal = Cells(1,3).NumberFormatLocal
    For i = 3 To Cells(Rows.Count, 1).End(xlUp).Row
        For j = 3 To Cells(1, Columns.Count).End(xlToLeft).Column
            ws.Cells(pos,1).Resize(1,4) = _
                Array(Cells(Int(i/2)*2, 1), Cells(i,2), Cells(1,j), Cells(i, j))
            pos = pos + 1
        Next
    Next
    ws.UsedRange.EntireColumn.AutoFit
End Sub
