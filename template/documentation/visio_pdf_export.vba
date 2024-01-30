Sub exportPdf()

    Dim formatExtension As String
    formatExtension = ".pdf"

    ' initializations
    folder = ThisDocument.Path
    Set doc = Visio.ActiveDocument
    folder = doc.Path
    
    ' for each page
    For Each pg In doc.Pages

        ' set filename
        FileName = pg.Name

        ' skip background pages
        If (Not (pg.Background)) Then
            ' add extension
            FileName = folder & "\img\" & FileName & formatExtension

            ' save
            ActiveWindow.Page = pg
            ActiveDocument.ExportAsFixedFormat visFixedFormatPDF, FileName, visDocExIntentPrint, visPrintCurrentPage, IncludeStructureTags:=False
        End If
    Next
End Sub