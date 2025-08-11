codeunit 50002 "Enhance email AOAI Fun." implements "AOAI Function"
{

    procedure GetPrompt(): JsonObject
    var
        ToolDefinition: JsonObject;
        FunctionDefinition: JsonObject;
        ParametersDefinition: JsonObject;
    begin
        ParametersDefinition.ReadFrom(
            '{"type": "object",' +
            '"properties": {' +
                '"text": { "type": "string", "EmailBody": "A Paragraph for composing an Email."},' +
            '},"required": ["text"]}'
            );

        FunctionDefinition.Add('name', FunctionNameLbl);
        FunctionDefinition.Add('EmailBody', 'Call this function to create a new Email');
        FunctionDefinition.Add('parameters', ParametersDefinition);

        ToolDefinition.Add('type', 'function');
        ToolDefinition.Add('function', FunctionDefinition);

        exit(ToolDefinition);
    end;

    procedure Execute(Arguments: JsonObject): Variant
    var
        EmailBody: JsonToken;
    begin
        Arguments.Get('EmailBody', EmailBody);
        TempEmailBody := EmailBody.AsValue().AsText();
        exit('Completed creating payment terms');
    end;

    procedure GetName(): Text
    begin
        exit(FunctionNameLbl);
    end;


    procedure GetEmailBody(): Text
    begin
        exit(TempEmailBody);
    end;

    var
        FunctionNameLbl: Label 'enhance_email', Locked = true;

        TempEmailBody: Text;
}
