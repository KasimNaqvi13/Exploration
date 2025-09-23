reportextension 50100 "CustList + VendorList PDF" extends "Customer - List"
{
    trigger OnPreRendering(var RenderingPayload: JsonObject)
    var
        PDFDoc: Codeunit "PDF Document";
        TempBlobVend: Codeunit "Temp Blob";
        VendOutStr: OutStream;
        VendInStr: InStream;
    begin
        TempBlobVend.CreateOutStream(VendOutStr);
        Report.SaveAs(Report::"Vendor - List", '', ReportFormat::Pdf, VendOutStr);

        TempBlobVend.CreateInStream(VendInStr);
        PDFDoc.Initialize();
        PDFDoc.AddStreamToAppend(VendInStr);
        RenderingPayload := PDFDoc.ToJson(RenderingPayload);
    end;
}