page 50000 "Copilot Setup"
{
    ApplicationArea = All;
    Caption = 'Copilot Setup';
    PageType = Card;
    SourceTable = "Copilot Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Model Name"; Rec."Model Name")
                {
                    ToolTip = 'Specifies the value of the Model Name field.', Comment = '%';
                }
                field("Endpoint URL"; Rec."Endpoint URL")
                {
                    ToolTip = 'Specifies the value of the Endpoint URL field.', Comment = '%';
                }
                field("API Secret Key"; APISecretKey)
                {
                    Caption = 'API Secret Key';
                    ToolTip = 'Specifies the value of the API Secret Key field.', Comment = '%';
                    ExtendedDatatype = Masked;

                    trigger onValidate()
                    begin
                        Rec.SetSecretKey(APISecretKey);
                    end;
                }
                field("Max Tokens"; Rec."Max Tokens")
                {
                    ToolTip = 'Specifies the value of the Max Tokens field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        if not Rec.GetSecretKey().IsEmpty() then
            APISecretKey := '********'
        else
            APISecretKey := '';
    end;


    var
        [NonDebuggable]
        APISecretKey: Text;
}
