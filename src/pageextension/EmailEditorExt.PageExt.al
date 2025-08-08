pageextension 50000 "Email Editor Ext" extends "Email Editor"
{
    layout
    {
        addafter("Email Details")
        {
            usercontrol(SpeechControl; SpeechToTextAddin)
            {
                ApplicationArea = All;

                trigger OnSpeechRecognized(Text: Text)
                var
                    TempText: Text;
                begin
                    RecognizedText := RecognizedText + ' ' + Text;
                end;

            }
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
        addafter(ShowSourceRecord)
        {
            action(StartRecording)
            {
                Caption = 'Start Recording';
                Tooltip = 'Start recording speech input.';
                Image = Start;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // ListingLogo.Open('🎙️ listing #1########');
                    CurrPage.SpeechControl.StartRecording();
                end;
            }

            action(StopRecording)
            {
                Caption = 'Stop Recording';
                Tooltip = 'Stop recording speech input.';
                Image = Stop;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    CurrPage.SpeechControl.StopRecording();
                    EmailBodytext := RecognizedText;
                    // Message('Recognized Text: %1', RecognizedText);
                    // Message(EmailBodytext);
                end;
            }

            action("Enhance Mail With Copilot")
            {
                Caption = 'Enhance Mail With Copilot';
                Tooltip = 'Enhance the email with copilot features.';
                Image = MailSetup;
                Ellipsis = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Page.RunModal(Page::"Enhance Email");
                end;
            }
        }

        addlast(Promoted)
        {
            group(recordings)
            {
                Caption = 'Email with copilot';
                ShowAs = SplitButton;
                actionref(StartRecordings; StartRecording) { }
                actionref(StopRecordings; StopRecording) { }
                actionref(EnhanceMailWithCopilot; "Enhance Mail With Copilot") { }
            }
        }

        addlast(Prompting)
        {
            action("Enhance Mail With Copilots")
            {
                Caption = 'Enhance Mail With Copilot';
                Tooltip = 'Enhance the email with copilot features.';
                Image = Sparkle;
                Ellipsis = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Page.RunModal(Page::"Enhance Email");
                end;
            }
        }

        // addlast(Category_New)
        // {
        //     actionref(EnhanceMailWithCopilots; "Enhance Mail With Copilots") { }

        // }
    }

    var
        RecognizedText: Text;
        EmailBodytext: Text;
    // ListingLogo: Dialog;
}
