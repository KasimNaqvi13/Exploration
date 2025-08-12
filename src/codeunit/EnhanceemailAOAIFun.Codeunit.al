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
                '"content": { "type": "string", "description": "The enhanced email text in the required format."}' +
            '},"required": ["content"]}'
        );

        FunctionDefinition.Add('name', FunctionNameLbl);
        FunctionDefinition.Add('description', 'Call this function to return the enhanced email JSON');
        FunctionDefinition.Add('parameters', ParametersDefinition);

        ToolDefinition.Add('type', 'function');
        ToolDefinition.Add('function', FunctionDefinition);

        exit(ToolDefinition);
    end;

    procedure Execute(Arguments: JsonObject): Variant
    var
        EmailContent: JsonToken;
    begin
        Arguments.Get('content', EmailContent);
        TempEmailBody := EmailContent.AsValue().AsText();
        exit('Completed creating enhanced email');
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
