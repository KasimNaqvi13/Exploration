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
        area(Prompt)
        {
            field(InputDescription; InputDescription)
            {
                ApplicationArea = All;
                ToolTip = 'Enter the description for the input.';
                MultiLine = true;
                InstructionalText = 'Describe the input for the email enhancement';
                ShowCaption = false;

                trigger OnValidate()
                begin

                end;
            }
        }
    }




    var
        InputDescription: Text;
}
