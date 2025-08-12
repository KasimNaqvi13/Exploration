controladdin ALCodeViewer
{
    // Control Add-in for displaying AL code with syntax highlighting
    RequestedHeight = 400;
    MinimumHeight = 200;
    RequestedWidth = 800;
    MinimumWidth = 400;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;

    // JavaScript files
    // Scripts = 'Scripts/ALCodeViewer.Script.js';
    // StartupScript = 'Scripts/ALCodeViewer.Startup.js';
    // CSS files
    // StyleSheets = 'Styles/ALCodeViewer.css';

    // Events that can be raised from JavaScript to AL
    event OnControlReady();
    event OnCodeDisplayed(CodeLength: Integer);
    event OnError(ErrorMessage: Text);

    // Procedures that can be called from AL to JavaScript
    procedure SetALCode(ALCode: Text);
    procedure ClearCode();
    procedure SetTheme(Theme: Text);
    procedure SetReadOnly(ReadOnly: Boolean);
}