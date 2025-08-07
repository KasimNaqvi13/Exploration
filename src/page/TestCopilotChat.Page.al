page 50001 "Test Copilot Chat"
{
    ApplicationArea = All;
    Caption = 'Copilot Chat';
    PageType = Card;
    UsageCategory = Administration;


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(UserMessage; UserMessage)
                {
                    ApplicationArea = All;
                    Caption = 'User Message';
                    ToolTip = 'Enter your message to the copilot.';
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Response := GetResponseFromCopilot();
                        CurrPage.Update(false);
                    end;
                }
                field(Response; Response)
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    ToolTip = 'Response from the copilot based on the user message.';
                    Editable = false;
                    MultiLine = true;
                }
            }
        }
    }

    local procedure GetResponseFromCopilot(): text
    var
        CopilotSetupRec: Record "Copilot Setup";
        CopilotCapability: Codeunit "Copilot Capability";
        AzureOpenAI: Codeunit "Azure OpenAI";
        AzureOpenAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AzureOpenAIChatMessages: Codeunit "AOAI Chat Messages";
        AzureOpenAIResponse: Codeunit "AOAI Operation Response";

    begin
        if CopilotCapability.IsCapabilityActive(Enum::"Copilot Capability"::"Custom Copilot Setup") then begin
            CopilotSetupRec.Get();
            AzureOpenAI.SetAuthorization(Enum::"AOAI Model Type"::"Chat Completions", CopilotSetupRec."Endpoint URL", CopilotSetupRec."Model Name", CopilotSetupRec.GetSecretKey());
            AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"Custom Copilot Setup");

            AzureOpenAIChatCompletionParams.SetMaxTokens(CopilotSetupRec."Max Tokens");
            AzureOpenAIChatCompletionParams.SetTemperature(0.7);

            AzureOpenAIChatMessages.AddSystemMessage(SystemMessage);
            AzureOpenAIChatMessages.AddUserMessage(UserMessage);

            AzureOpenAI.GenerateChatCompletion(AzureOpenAIChatMessages, AzureOpenAIResponse);

            if AzureOpenAIResponse.IsSuccess() then
                exit(AzureOpenAIChatMessages.GetLastMessage())
            else
                Error(AzureOpenAIResponse.GetError());
        end;
    end;




    var
        UserMessage: Text;
        Response: Text;

        SystemMessage: Label 'You are a helpful assistant. You will answer the user questions based on the information provided by the user.';
}
