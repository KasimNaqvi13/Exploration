reportextension 50100 "Customer -List Ext" extends "Customer - List"
{
    requestpage
    {
        layout
        {
            addfirst(Content)
            {
                group(MergePDF)
                {
                    Caption = 'Merge PDFs';
                    field(UploadPDFField; UploadPDFText)
                    {
                        ApplicationArea = All;
                        Caption = 'Upload PDF Files';
                        ToolTip = 'Click to upload PDF files to merge with the Customer List report';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            UploadPDFFiles();
                        end;
                    }
                }
            }
        }
    }

    var
        PDFDoc: Codeunit "PDF Document";
        UploadPDFText: Text;

    local procedure UploadPDFFiles()
    var
        PDFInstream: InStream;
    begin
        UploadIntoStream('Upload PDF Files', '', '', UploadPDFText, PDFInstream);
        PDFDoc.Initialize();
        PDFDoc.AddStreamToAppend(PDFInstream);

        // Page Duplicate 
        PDFDoc.AddStreamToAppend(PDFInstream);



    end;

    trigger OnPreRendering(var RenderingPayload: JsonObject)
    var
    // TempBlobVend: Codeunit "Temp Blob";
    // VendOutStr: OutStream;
    // VendInStr: InStream;
    begin
        //-------Method 2 to merge PDFs--------
        // TempBlobVend.CreateOutStream(VendOutStr);
        // Report.SaveAs(Report::"Vendor - List", '', ReportFormat::Pdf, VendOutStr);

        // TempBlobVend.CreateInStream(VendInStr);
        // PDFDoc.Initialize();
        // PDFDoc.AddStreamToAppend(VendInStr);


        RenderingPayload := PDFDoc.ToJson(RenderingPayload);
    end;
}