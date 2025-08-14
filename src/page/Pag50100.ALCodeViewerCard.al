page 50100 "AL Code Viewer Card"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'AL Code Viewer';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(CodeInput; CodeInput)
                {
                    ApplicationArea = All;
                    Caption = 'AL Code Input';
                    MultiLine = true;
                    ToolTip = 'Enter or paste AL code here';
                }

                field(ThemeChoice; ThemeChoice)
                {
                    ApplicationArea = All;
                    Caption = 'Theme';
                    ToolTip = 'Choose the theme for the code viewer';
                }

                field(ShowLineNums; ShowLineNums)
                {
                    ApplicationArea = All;
                    Caption = 'Show Line Numbers';
                    ToolTip = 'Toggle line number display in the code viewer';
                }

                field(SyntaxHighlight; SyntaxHighlight)
                {
                    ApplicationArea = All;
                    Caption = 'Syntax Highlighting';
                    ToolTip = 'Enable or disable syntax highlighting';
                }

                field(ReadOnlyMode; ReadOnlyMode)
                {
                    ApplicationArea = All;
                    Caption = 'Read-Only Mode';
                    ToolTip = 'Toggle whether the code viewer is editable';
                }
            }

            group(Viewer)
            {
                usercontrol(ALCodeViewer; ALCodeDisplayControlAddIn)
                {
                    ApplicationArea = All;

                    trigger ControlAddInReady();
                    begin
                        // Sync UI state with control when it's ready
                        CurrPage.ALCodeViewer.SetTheme(Format(ThemeChoice));
                        CurrPage.ALCodeViewer.ShowLineNumbers(ShowLineNums);
                        CurrPage.ALCodeViewer.EnableSyntaxHighlighting(SyntaxHighlight);
                        CurrPage.ALCodeViewer.SetReadOnly(ReadOnlyMode);

                        if CodeInput <> '' then
                            CurrPage.ALCodeViewer.SetALCode(CodeInput);
                    end;

                    trigger CodeFormatted(FormattedCode: Text);
                    begin
                        Message('Code formatted:\%1', FormattedCode);
                    end;

                    trigger CodeCopied();
                    begin
                        Message('Code copied to clipboard.');
                    end;

                    trigger OnError(ErrorMessage: Text);
                    begin
                        Error('Control Add-in error: %1', ErrorMessage);
                    end;

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(LoadCode)
            {
                Caption = 'Load Code to Viewer';
                ApplicationArea = All;
                trigger OnAction();
                begin
                    CurrPage.ALCodeViewer.SetALCode(CodeInput);
                end;
            }

            action(ApplySettings)
            {
                Caption = 'Apply Settings';
                ApplicationArea = All;
                trigger OnAction();
                begin
                    CurrPage.ALCodeViewer.SetTheme(Format(ThemeChoice));
                    CurrPage.ALCodeViewer.ShowLineNumbers(ShowLineNums);
                    CurrPage.ALCodeViewer.EnableSyntaxHighlighting(SyntaxHighlight);
                    CurrPage.ALCodeViewer.SetReadOnly(ReadOnlyMode);
                end;
            }

            // action(ClearViewer)
            // {
            //     Caption = 'Clear Viewer';
            //     ApplicationArea = All;
            //     trigger OnAction();
            //     begin
            //         CurrPage.ALCodeViewer.ClearCode();
            //     end;
            // }
        }
    }

    var
        CodeInput: Text;
        ThemeChoice: Option Light,Dark;
        ShowLineNums: Boolean;
        SyntaxHighlight: Boolean;
        ReadOnlyMode: Boolean;
}
