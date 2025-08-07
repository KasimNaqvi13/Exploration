table 50000 "Copilot Setup"
{
    Caption = 'Copilot Setup';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Model Name";

    fields
    {
        field(1;
        "Primary Key";
        Integer)
        {
            Caption = 'Primary Key';
        }
        field(2; "Endpoint URL"; Text[1024])
        {
            Caption = 'Endpoint URL';
            DataClassification = CustomerContent;
        }
        field(3; "Model Name"; Text[200])
        {
            Caption = 'Model Name';
            DataClassification = CustomerContent;
        }
        field(4; "Max Tokens"; Integer)
        {
            Caption = 'Max Tokens';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }


    #region Secret Key Function
    procedure SetSecretKey(Secretkey: SecretText)
    begin
        if IsolatedStorage.Contains(CopilotStorageApiKeyLbl, DataScope::Company) then
            IsolatedStorage.Delete(CopilotStorageApiKeyLbl, DataScope::Company);

        IsolatedStorage.Set(CopilotStorageApiKeyLbl, Secretkey, DataScope::Company);
    end;

    procedure GetSecretKey(): SecretText
    var
        SecretText: SecretText;
    begin
        if IsolatedStorage.Contains(CopilotStorageApiKeyLbl, DataScope::Company) then begin
            IsolatedStorage.Get(CopilotStorageApiKeyLbl, DataScope::Company, SecretText);
            exit(SecretText);
        end;
    end;
    #endregion Secret Key Function

    var
        CopilotStorageApiKeyLbl: Label 'CopilotSetupAPISecretKey';

}
