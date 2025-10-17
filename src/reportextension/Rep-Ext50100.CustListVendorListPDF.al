reportextension 50100 "CustList + VendorList PDF" extends "Customer - List"
{

    requestpage
    {
        layout
        {
            addfirst(Content)
            {
                group(MeargePDF)
                {
                    Caption = 'Merge PDFs';


                }
            }
        }
    }

    var
        FieldUploadVar: FileUpload;
        UploadPDF: Text;
        PDFDoc: Codeunit "PDF Document";


    trigger OnPreRendering(var RenderingPayload: JsonObject)
    var

        TempBlobVend: Codeunit "Temp Blob";
        VendOutStr: OutStream;
        VendInStr: InStream;
    begin
        // TempBlobVend.CreateOutStream(VendOutStr);
        // Report.SaveAs(Report::"Vendor - List", '', ReportFormat::Pdf, VendOutStr);

        // TempBlobVend.CreateInStream(VendInStr);
        // PDFDoc.Initialize();
        // PDFDoc.AddStreamToAppend(VendInStr);

        RenderingPayload := PDFDoc.ToJson(RenderingPayload);
    end;



}