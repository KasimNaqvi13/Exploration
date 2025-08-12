codeunit 50001 "Generate Email"
{
    trigger OnRun()
    begin
        RunGeneration();
    end;

    procedure SetUserPrompt(InputUserPrompt: Text)
    begin
        UserPrompt := InputUserPrompt;
    end;

    procedure GetResult(var OutputPrompt: Text): Boolean
    begin
        OutputPrompt := EmailResult;
        exit(true);
    end;

    local procedure RunGeneration()
    var
        CopilotSetup: Record "Copilot Setup";
        AzureOpenAI: Codeunit "Azure OpenAI";
        EnhanceEmailImpl: Codeunit "Enhance email AOAI Fun.";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
    begin
        CopilotSetup.Get();
        CopilotSetup.TestField("Model Name");
        CopilotSetup.TestField("Endpoint URL");
        CopilotSetup.TestField("Max Tokens");

        AzureOpenAI.SetAuthorization(Enum::"AOAI Model Type"::"Chat Completions",
        CopilotSetup."Endpoint URL", CopilotSetup."Model Name", CopilotSetup.GetSecretKey());

        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"Custom Copilot Setup");

        AOAIChatCompletionParams.SetMaxTokens(CopilotSetup."Max Tokens");
        AOAIChatCompletionParams.SetTemperature(0.7);

        AOAIChatMessages.AddSystemMessage(GetSystemPrompt());
        AOAIChatMessages.AddUserMessage(UserPrompt);

        AOAIChatMessages.AddTool(EnhanceEmailImpl);
        AOAIChatMessages.SetToolInvokePreference("AOAI Tool Invoke Preference"::Automatic);
        AOAIChatMessages.SetToolChoice('auto');

        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);

        if not AOAIOperationResponse.IsSuccess() then
            Error(AOAIOperationResponse.GetError());

        EmailResult := EnhanceEmailImpl.GetEmailBody();

        // EmailResult := AOAIOperationResponse.GetResult();
    end;


    local procedure GetSystemPrompt(): Text
    var
        SystemPrompt: TextBuilder;
    begin
        SystemPrompt.AppendLine('You will help the user write and enhance emails. Your task is to take the provided email text and improve its clarity, tone, and professionalism while keeping the original intent.');
        SystemPrompt.AppendLine();
        SystemPrompt.AppendLine('**Important:**');
        SystemPrompt.AppendLine('- Correct grammar, spelling, and punctuation.');
        SystemPrompt.AppendLine('- Enhance sentence structure for better readability.');
        SystemPrompt.AppendLine('- Adjust tone to be polite, professional, and concise unless the user specifies a different style.');
        SystemPrompt.AppendLine('- Keep the meaning and intent intact without adding unrelated content.');
        SystemPrompt.AppendLine('- Preserve or add placeholders (e.g., [DATE], [NAME], [COMPANY]) if needed.');
        SystemPrompt.AppendLine('- If the email is too short or lacks context, ask the user for more information.');
        SystemPrompt.AppendLine('- If the email is too long, summarize it while maintaining key points.');
        SystemPrompt.AppendLine('- we are storing this value in Rich text format, so you can use HTML tags to format the text.'); // Important for the RichContent datatype in the EnhanceMailOutput page.
        SystemPrompt.AppendLine();
        SystemPrompt.AppendLine('Call the function "enhance_email" to provide the improved email.');
        exit(SystemPrompt.ToText());
    end;




    #region Variables
    var
        UserPrompt: Text;

        EmailResult: Text;

    #endregion Variables
}
