page 50002 "Enhance Email"
{
    ApplicationArea = All;
    Caption = 'Enhance Email with Copilot';
    PageType = PromptDialog;
    Extensible = false;
    IsPreview = true;
    // DataCaptionExpression = 

    layout
    {

        #region Input
        area(Prompt)
        {
            field(InputDescription; InputDescription)
            {
                InstructionalText = 'Describe the input for the email enhancement';
                ApplicationArea = All;
                MultiLine = true;
                ShowCaption = false;

                trigger OnValidate()
                begin

                end;
            }
        }
        #endregion Input


        #region Output
        area(Content)
        {
            part(EnhanceMailOutput; "Enhance Mail Output")
            {
                Caption = 'Enhanced Mail Output';
                ShowFilter = false;
                ApplicationArea = all;
            }
        }
        #endregion Output
    }

    actions
    {
        #region Prompt Guide

        area(PromptGuide)
        {
            action(SickLeave)
            {
                Caption = 'Sick Leave';
                ToolTip = 'Request sick leave';
                trigger OnAction()
                begin
                    InputDescription := 'I am feeling unwell and would like to take sick leave on [DATE].';
                end;
            }

            // action()
            // {

            // }
        }
        #endregion Prompt Guide



        #region system actions
        area(SystemActions)
        {
            systemaction(Generate)
            {
                Caption = 'Generate';
                ToolTip = 'Generate a payment terms with Dynamics 365 Copilot.';

                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }
            systemaction(OK)
            {
                Caption = 'Keep it';
                ToolTip = 'Save the Payment Terms proposed by Dynamics 365 Copilot.';
            }
            systemaction(Cancel)
            {
                Caption = 'Discard it';
                ToolTip = 'Discard the Payment Terms proposed by Dynamics 365 Copilot.';
            }
            systemaction(Regenerate)
            {
                Caption = 'Regenerate';
                ToolTip = 'Regenerate the Payment Terms proposed by Dynamics 365 Copilot.';

                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }
        }

        #endregion system actions
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = CloseAction::OK then
            Save();
    end;

    local procedure RunGeneration()
    var
        GenerateEmail: Codeunit "Generate Email";
        ProgressDialog: Dialog;
        Attempts: Integer;
    begin
        if InputDescription = '' then
            Error(EmailDescriptionEmptyErr);

        if StrLen(InputDescription) < 20 then
            Error(DescriptionTooShortMsg);

        ProgressDialog.Open(GeneratingTextDialogTxt);
        GenerateEmail.SetUserPrompt(InputDescription);

        Clear(TempEnhancedOutput);

        for Attempts := 0 to 3 do
            if GenerateEmail.Run() then
                if GenerateEmail.GetResult(TempEnhancedOutput) then begin
                    CurrPage.EnhanceMailOutput.Page.Load(TempEnhancedOutput);
                    exit;
                end;

        if GetLastErrorText() = '' then
            Error(SomethingWentWrongErr)
        else
            Error(SomethingWentWrongWithLatestErr, GetLastErrorText());
    end;

    local procedure save()
    begin
        if TempEnhancedOutput <> '' then
            EmailBody := TempEnhancedOutput;
    end;

    procedure GetEmailBody(): Text
    begin
        exit(EmailBody);
    end;

    var
        InputDescription: Text;
        EmailDescriptionEmptyErr: Label 'Email description cannot be empty.';
        DescriptionTooShortMsg: Label 'Email description is too short.';
        GeneratingTextDialogTxt: Label 'Generating with Copilot...';
        SomethingWentWrongErr: Label 'Something went wrong. Please try again.';
        SomethingWentWrongWithLatestErr: Label 'Something went wrong. Please try again. The latest error is: %1', Comment = '%1 = Latest Error';
        TempEnhancedOutput: Text;
        EmailBody: Text;


}
