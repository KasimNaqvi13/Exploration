page 50100 "AL Code Viewer Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'AL Code Viewer Demo';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Code Display Settings';

                field(ThemeSelection; ThemeOption)
                {
                    ApplicationArea = All;
                    Caption = 'Theme';
                    ToolTip = 'Select the theme for code display';

                    trigger OnValidate()
                    begin
                        case ThemeOption of
                            ThemeOption::Light:
                                CurrPage.CodeViewer.SetTheme('Light');
                            ThemeOption::Dark:
                                CurrPage.CodeViewer.SetTheme('Dark');
                            ThemeOption::Blue:
                                CurrPage.CodeViewer.SetTheme('Blue');
                        end;
                    end;
                }

                field(ReadOnlyMode; IsReadOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Read Only';
                    ToolTip = 'Enable or disable read-only mode';

                    trigger OnValidate()
                    begin
                        CurrPage.CodeViewer.SetReadOnly(IsReadOnly);
                    end;
                }
            }

            group(CodeDisplay)
            {
                Caption = 'AL Code Display';
                ShowCaption = false;

                usercontrol(CodeViewer; ALCodeViewer)
                {
                    ApplicationArea = All;

                    trigger OnControlReady()
                    begin
                        ControlReady := true;
                        LoadSampleCode();
                    end;

                    trigger OnCodeDisplayed(CodeLength: Integer)
                    begin
                        Message('Code displayed successfully. Length: %1 characters', CodeLength);
                    end;

                    trigger OnError(ErrorMessage: Text)
                    begin
                        Message('Error in code viewer: %1', ErrorMessage);
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LoadSample1)
            {
                ApplicationArea = All;
                Caption = 'Load Table Sample';
                Image = Table;

                trigger OnAction()
                begin
                    LoadTableSample();
                end;
            }

            action(LoadSample2)
            {
                ApplicationArea = All;
                Caption = 'Load Page Sample';
                Image = Page;

                trigger OnAction()
                begin
                    LoadPageSample();
                end;
            }

            action(LoadSample3)
            {
                ApplicationArea = All;
                Caption = 'Load Codeunit Sample';
                Image = CodesList;

                trigger OnAction()
                begin
                    LoadCodeunitSample();
                end;
            }

            action(ClearCode)
            {
                ApplicationArea = All;
                Caption = 'Clear Code';
                Image = ClearLog;

                trigger OnAction()
                begin
                    CurrPage.CodeViewer.ClearCode();
                end;
            }
        }
    }

    var
        ThemeOption: Option Light,Dark,Blue;
        IsReadOnly: Boolean;
        ControlReady: Boolean;

    local procedure LoadSampleCode()
    var
        SampleCode: Text;
    begin
        if not ControlReady then
            exit;

        SampleCode := 'table 50100 "Sample Table"' + '\' +
                     '{' + '\' +
                     '    DataClassification = CustomerContent;' + '\' +
                     '    Caption = ''Sample Table'';' + '\' +
                     '' + '\' +
                     '    fields' + '\' +
                     '    {' + '\' +
                     '        field(1; "No."; Code[20])' + '\' +
                     '        {' + '\' +
                     '            Caption = ''No.'';' + '\' +
                     '            DataClassification = CustomerContent;' + '\' +
                     '        }' + '\' +
                     '        field(2; Description; Text[100])' + '\' +
                     '        {' + '\' +
                     '            Caption = ''Description'';' + '\' +
                     '            DataClassification = CustomerContent;' + '\' +
                     '        }' + '\' +
                     '    }' + '\' +
                     '}';

        CurrPage.CodeViewer.SetALCode(SampleCode);
    end;

    local procedure LoadTableSample()
    var
        SampleCode: Text;
    begin
        if not ControlReady then
            exit;

        SampleCode := 'table 50101 "Customer Extended"' + '\' +
                     '{' + '\' +
                     '    DataClassification = CustomerContent;' + '\' +
                     '    Caption = ''Customer Extended'';' + '\' +
                     '' + '\' +
                     '    fields' + '\' +
                     '    {' + '\' +
                     '        field(1; "Customer No."; Code[20])' + '\' +
                     '        {' + '\' +
                     '            Caption = ''Customer No.'';' + '\' +
                     '            DataClassification = CustomerContent;' + '\' +
                     '            TableRelation = Customer."No.";' + '\' +
                     '        }' + '\' +
                     '        field(2; "Extended Info"; Text[250])' + '\' +
                     '        {' + '\' +
                     '            Caption = ''Extended Information'';' + '\' +
                     '            DataClassification = CustomerContent;' + '\' +
                     '        }' + '\' +
                     '        field(3; "Credit Rating"; Option)' + '\' +
                     '        {' + '\' +
                     '            Caption = ''Credit Rating'';' + '\' +
                     '            OptionMembers = " ",Excellent,Good,Fair,Poor;' + '\' +
                     '            DataClassification = CustomerContent;' + '\' +
                     '        }' + '\' +
                     '        field(4; "Last Updated"; DateTime)' + '\' +
                     '        {' + '\' +
                     '            Caption = ''Last Updated'';' + '\' +
                     '            DataClassification = CustomerContent;' + '\' +
                     '        }' + '\' +
                     '    }' + '\' +
                     '' + '\' +
                     '    keys' + '\' +
                     '    {' + '\' +
                     '        key(PK; "Customer No.")' + '\' +
                     '        {' + '\' +
                     '            Clustered = true;' + '\' +
                     '        }' + '\' +
                     '    }' + '\' +
                     '}';

        CurrPage.CodeViewer.SetALCode(SampleCode);
    end;

    local procedure LoadPageSample()
    var
        SampleCode: Text;
    begin
        if not ControlReady then
            exit;

        SampleCode := 'page 50102 "Customer Extended Card"' + '\' +
                     '{' + '\' +
                     '    PageType = Card;' + '\' +
                     '    SourceTable = "Customer Extended";' + '\' +
                     '    ApplicationArea = All;' + '\' +
                     '    UsageCategory = Documents;' + '\' +
                     '    Caption = ''Customer Extended Card'';' + '\' +
                     '' + '\' +
                     '    layout' + '\' +
                     '    {' + '\' +
                     '        area(Content)' + '\' +
                     '        {' + '\' +
                     '            group(General)' + '\' +
                     '            {' + '\' +
                     '                Caption = ''General'';' + '\' +
                     '                ' + '\' +
                     '                field("Customer No."; Rec."Customer No.")' + '\' +
                     '                {' + '\' +
                     '                    ApplicationArea = All;' + '\' +
                     '                    ToolTip = ''Specifies the customer number'';' + '\' +
                     '                }' + '\' +
                     '                field("Extended Info"; Rec."Extended Info")' + '\' +
                     '                {' + '\' +
                     '                    ApplicationArea = All;' + '\' +
                     '                    ToolTip = ''Extended customer information'';' + '\' +
                     '                }' + '\' +
                     '                field("Credit Rating"; Rec."Credit Rating")' + '\' +
                     '                {' + '\' +
                     '                    ApplicationArea = All;' + '\' +
                     '                    ToolTip = ''Customer credit rating'';' + '\' +
                     '                }' + '\' +
                     '            }' + '\' +
                     '        }' + '\' +
                     '    }' + '\' +
                     '' + '\' +
                     '    actions' + '\' +
                     '    {' + '\' +
                     '        area(Processing)' + '\' +
                     '        {' + '\' +
                     '            action(UpdateInfo)' + '\' +
                     '            {' + '\' +
                     '                ApplicationArea = All;' + '\' +
                     '                Caption = ''Update Information'';' + '\' +
                     '                Image = Refresh;' + '\' +
                     '                ' + '\' +
                     '                trigger OnAction()' + '\' +
                     '                begin' + '\' +
                     '                    Rec."Last Updated" := CurrentDateTime;' + '\' +
                     '                    Rec.Modify(true);' + '\' +
                     '                    Message(''Information updated successfully'');' + '\' +
                     '                end;' + '\' +
                     '            }' + '\' +
                     '        }' + '\' +
                     '    }' + '\' +
                     '}';

        CurrPage.CodeViewer.SetALCode(SampleCode);
    end;

    local procedure LoadCodeunitSample()
    var
        SampleCode: Text;
    begin
        if not ControlReady then
            exit;

        SampleCode := 'codeunit 50100 "Customer Management"' + '\' +
                     '{' + '\' +
                     '    procedure ValidateCustomerCredit(CustomerNo: Code[20]): Boolean' + '\' +
                     '    var' + '\' +
                     '        Customer: Record Customer;' + '\' +
                     '        CustomerExt: Record "Customer Extended";' + '\' +
                     '    begin' + '\' +
                     '        if not Customer.Get(CustomerNo) then' + '\' +
                     '            Error(''Customer %1 does not exist'', CustomerNo);' + '\' +
                     '        ' + '\' +
                     '        if CustomerExt.Get(CustomerNo) then begin' + '\' +
                     '            case CustomerExt."Credit Rating" of' + '\' +
                     '                CustomerExt."Credit Rating"::Excellent,' + '\' +
                     '                CustomerExt."Credit Rating"::Good:' + '\' +
                     '                    exit(true);' + '\' +
                     '                CustomerExt."Credit Rating"::Fair:' + '\' +
                     '                    exit(Confirm(''Customer has fair credit. Continue?''));' + '\' +
                     '                CustomerExt."Credit Rating"::Poor:' + '\' +
                     '                    exit(false);' + '\' +
                     '            end;' + '\' +
                     '        end;' + '\' +
                     '        ' + '\' +
                     '        // Default to true if no extended info' + '\' +
                     '        exit(true);' + '\' +
                     '    end;' + '\' +
                     '    ' + '\' +
                     '    procedure CalculateRiskScore(CustomerNo: Code[20]): Decimal' + '\' +
                     '    var' + '\' +
                     '        Customer: Record Customer;' + '\' +
                     '        CustomerExt: Record "Customer Extended";' + '\' +
                     '        RiskScore: Decimal;' + '\' +
                     '    begin' + '\' +
                     '        RiskScore := 0.0;' + '\' +
                     '        ' + '\' +
                     '        if not Customer.Get(CustomerNo) then' + '\' +
                     '            exit(100.0); // Maximum risk for non-existent customer' + '\' +
                     '        ' + '\' +
                     '        if CustomerExt.Get(CustomerNo) then begin' + '\' +
                     '            case CustomerExt."Credit Rating" of' + '\' +
                     '                CustomerExt."Credit Rating"::Excellent:' + '\' +
                     '                    RiskScore := 10.0;' + '\' +
                     '                CustomerExt."Credit Rating"::Good:' + '\' +
                     '                    RiskScore := 25.0;' + '\' +
                     '                CustomerExt."Credit Rating"::Fair:' + '\' +
                     '                    RiskScore := 50.0;' + '\' +
                     '                CustomerExt."Credit Rating"::Poor:' + '\' +
                     '                    RiskScore := 85.0;' + '\' +
                     '                else' + '\' +
                     '                    RiskScore := 40.0; // Default for unrated' + '\' +
                     '            end;' + '\' +
                     '        end else' + '\' +
                     '            RiskScore := 40.0; // Default when no extended info' + '\' +
                     '        ' + '\' +
                     '        exit(RiskScore);' + '\' +
                     '    end;' + '\' +
                     '}';

        CurrPage.CodeViewer.SetALCode(SampleCode);
    end;
}