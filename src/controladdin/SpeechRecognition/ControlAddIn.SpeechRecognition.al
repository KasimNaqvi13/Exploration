controladdin "SpeechRecognition"
{
    RequestedHeight = 1;
    RequestedWidth = 1;
    MinimumHeight = 1;
    MinimumWidth = 1;
    MaximumHeight = 1;
    MaximumWidth = 1;
    VerticalStretch = false;
    VerticalShrink = false;
    HorizontalStretch = false;
    HorizontalShrink = false;

    // JS files (adjust paths to your repo layout)
    StartupScript = 'src/Scripts/startup.js';
    Scripts = 'src/Scripts/speech.js';

    // Events raised from JS → AL
    event ControlReady();
    event OnStarted();
    event OnStopped(FinalText: Text);
    event OnResult(CurrentText: Text);
    event OnError(ErrorMessage: Text);

    // Procedures called from AL → JS (must match JS function names)
    procedure StartSpeechRecognition();
    procedure StopSpeechRecognition();
}
