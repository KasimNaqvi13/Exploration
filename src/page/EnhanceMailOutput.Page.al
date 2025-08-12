page 50003 "Enhance Mail Output"
{
    ApplicationArea = All;
    // Caption = '';
    PageType = CardPart;
    ShowFilter = false;
    // RefreshOnActivate = true;


    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;
                field(EnhancedMailOutput; EnhancedMailOutput)
                {
                    ShowCaption = false;
                    MultiLine = true;
                    ExtendedDatatype = RichContent;

                }

            }
        }
    }

    internal procedure Load(EnhanceMail: Text)
    begin
        Clear(EnhancedMailOutput);
        EnhancedMailOutput := EnhanceMail;
        CurrPage.Update(false);
    end;

    var
        EnhancedMailOutput: Text;
}
