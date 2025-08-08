codeunit 50000 "Register Copilot"
{
    Subtype = Install;
    InherentEntitlements = X;
    InherentPermissions = X;
    Access = Internal;


    trigger OnInstallAppPerDatabase()
    begin
        this.RegisterCopilotCapability();
    end;


    local procedure RegisterCopilotCapability()
    var
        CopilotCapability: Codeunit "Copilot Capability";
        LearnMoreUrlTxt: Label 'https://in.linkedin.com/in/mir-kasim-ali-naqvi-04971a236', Locked = true;
    begin
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Custom Copilot Setup") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Custom Copilot Setup", Enum::"Copilot Availability"::Preview, LearnMoreUrlTxt);
    end;
}
