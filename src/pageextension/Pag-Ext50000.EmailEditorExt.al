pageextension 50000 "Email Editor Ext" extends "Email Editor"
{

    layout
    {
        addafter("Email Details")
        {
            group(SpeechRecognition)
            {
                Caption = 'Copilot Speech Messaging';
                field("Email Editors"; EmailBodytext)
                {
                    Caption = 'Message with Copilot';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the content of the email.';
                    MultiLine = true;
                    ExtendedDatatype = RichContent;

                    trigger OnValidate()
                    begin
                    end;
                }
            }
        }
    }

    actions
    {
        addlast(Prompting)
        {
            action(EnhanceEmail)
            {
                ToolTip = 'Enhance your email with AI-powered suggestions';
                Ellipsis = true;
                Image = Sparkle;
                Caption = 'Enhance Email with Copilot';

                trigger OnAction()
                var
                    PageEnhanceEmail: page "Enhance Email";
                begin
                    PageEnhanceEmail.RunModal();
                    EmailBodytext := PageEnhanceEmail.GetEmailBody();
                end;
            }
        }

        addlast(Category_Category13)
        {
            actionref(EnhanceEmails; EnhanceEmail) { }
        }
    }
    var
        EmailBodytext: Text;

}
