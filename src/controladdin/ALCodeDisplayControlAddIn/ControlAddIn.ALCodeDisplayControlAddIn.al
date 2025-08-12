controladdin ALCodeDisplayControlAddIn
{
    RequestedHeight = 600;
    RequestedWidth = 800;
    MinimumHeight = 300;
    MinimumWidth = 400;
    MaximumHeight = 1000;
    MaximumWidth = 1200;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    StartupScript = 'src/scripts/ALCodeDisplayStartup.js';
    Scripts = 'src/scripts/ALCodeDisplayScript.js';
    StyleSheets = 'src/styles/ALCodeDisplay.css';

    /// <summary>
    /// Event triggered when the control add-in is ready
    /// </summary>
    event ControlAddInReady();

    /// <summary>
    /// Event triggered when the AL code is formatted and ready to display
    /// </summary>
    event CodeFormatted(FormattedCode: Text);

    /// <summary>
    /// Event triggered when user copies code to clipboard
    /// </summary>
    event CodeCopied();

    /// <summary>
    /// Event triggered when an error occurs inside the add-in
    /// </summary>
    event OnError(ErrorMessage: Text);

    /// <summary>
    /// Procedure to set the AL code content
    /// </summary>
    /// <param name="ALCode">The AL code to display</param>
    procedure SetALCode(ALCode: Text);

    /// <summary>
    /// Procedure to set the theme (light/dark/blue)
    /// </summary>
    /// <param name="Theme">Theme name: 'light' or 'dark' or 'blue'</param>
    procedure SetTheme(Theme: Text);

    /// <summary>
    /// Procedure to enable/disable line numbers
    /// </summary>
    /// <param name="ShowLineNumbers">Boolean to show/hide line numbers</param>
    procedure ShowLineNumbers(ShowLineNumbers: Boolean);

    /// <summary>
    /// Procedure to enable/disable syntax highlighting
    /// </summary>
    /// <param name="EnableHighlighting">Boolean to enable/disable highlighting</param>
    procedure EnableSyntaxHighlighting(EnableHighlighting: Boolean);

    /// <summary>
    /// Procedure to set read-only mode
    /// </summary>
    /// <param name="ReadOnly">Boolean to set read-only mode</param>
    procedure SetReadOnly(ReadOnly: Boolean);
}