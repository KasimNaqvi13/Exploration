page 50004 "Publish Code"
{
    ApplicationArea = All;
    Caption = 'Publish Code';
    PageType = Card;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(UserInputForCode; UserInputForCode)
                {
                    Caption = 'User Input Code Generation';
                    ToolTip = 'Input text for generating the code';
                }
            }

            group("Generated Code")
            {
                // usercontrol(ALViewer; ALCodeViewer)
                // {
                //     ApplicationArea = All;
                // }


                usercontrol(ALCodeDisplay; ALCodeDisplay)
                {
                    ApplicationArea = all;

                    trigger ControlAddInReady()
                    begin
                        CurrPage.ALCodeDisplay.SetALCode(SampleCode);
                    end;

                    trigger CodeCopied()
                    begin
                        Message('Code copied to clipboard!');
                    end;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(LoadSampleCode)
            {
                Caption = 'Load AL Code';
                ApplicationArea = All;
                trigger OnAction()
                var
                    sampleCode: Text;
                begin
                    // Example usage in AL page
                    sampleCode := 'table 50000 "My Table" { \n applicationarea = all; }';

                    CurrPage.ALCodeDisplay.SetALCode(sampleCode);
                    CurrPage.ALCodeDisplay.SetTheme('dark');
                    CurrPage.ALCodeDisplay.ShowLineNumbers(true);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        sampleCode := 'table 50000 "My Table" { }';
    end;

    var
        UserInputForCode: Text;

        sampleCode: Text;

}


