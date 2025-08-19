pageextension 50000 "Email Editor Ext" extends "Email Editor"
{
    layout
    {
        addafter("Email Details")
        {
            group(SpeechGroup)
            {
                Caption = 'Speech Recognition';
                field(StatusField; RecordingStatus)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Attention;
                    ToolTip = 'status field of speech recognition';
                    StyleExpr = IsRecording; // highlights while recording
                }
                // Invisible control add-in, loaded in the background
                usercontrol(SpeechControl; "SpeechRecognition")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger ControlReady()
                    begin
                        // Ready to receive Start/Stop calls
                    end;

                    trigger OnStarted()
                    begin
                        IsRecording := true;
                        RecordingStatus := 'Recording... Speak now.';
                        CurrPage.Update(false);
                    end;

                    trigger OnStopped(FinalText: Text)
                    begin
                        IsRecording := false;
                        if FinalText <> '' then
                            EmailBodytext := FinalText;
                        RecordingStatus := 'Recording stopped.';
                        CurrPage.Update(false);
                    end;

                    trigger OnResult(CurrentText: Text)
                    begin
                        // Live updates while speaking
                        EmailBodytext := CurrentText;
                        CurrPage.Update(false);
                    end;

                    trigger OnError(ErrorMessage: Text)
                    begin
                        IsRecording := false;
                        RecordingStatus := 'Error: ' + ErrorMessage;
                        Message(ErrorMessage);
                        CurrPage.Update(false);
                    end;
                }
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
        addlast(Processing)
        {
            group(SpeechActions)
            {
                Caption = 'Speech Recognition';

                action(StartRecording)
                {
                    Caption = 'Start Recording';
                    ApplicationArea = All;
                    Image = Start;
                    Enabled = not IsRecording;

                    trigger OnAction()
                    begin
                        RecordingStatus := 'Starting recording...';
                        CurrPage.Update(false);

                        // Calls JS function StartSpeechRecognition()
                        CurrPage.SpeechControl.StartSpeechRecognition();
                    end;
                }

                action(StopRecording)
                {
                    Caption = 'Stop Recording';
                    ApplicationArea = All;
                    Image = Stop;
                    Enabled = IsRecording;

                    trigger OnAction()
                    begin
                        // Calls JS function StopSpeechRecognition()
                        CurrPage.SpeechControl.StopSpeechRecognition();
                    end;
                }

                action(ClearText)
                {
                    Caption = 'Clear Text';
                    ApplicationArea = All;
                    Image = ClearLog;

                    trigger OnAction()
                    begin
                        Clear(EmailBodytext);
                        RecordingStatus := 'Text cleared.';
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    var
        IsRecording: Boolean;
        RecordingStatus: Text;

    trigger OnOpenPage()
    begin
        IsRecording := false;
        RecordingStatus := 'Ready for speech recognition.';
    end;


    var
        EmailBodytext: Text;
}
