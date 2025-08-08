controladdin "SpeechToTextAddin"
{
    Scripts = '.\src\SpeechToText\speech.js';  // Refers to the main logic script (speech.js) containing functions like StartRecording, StopRecording.
    StartupScript = '.\src\SpeechToText\speech.start.js'; //This script (speech.start.js) is executed first when the add-in loads. It signals BC that the control is ready.

    //No visible UI is shown for the control add-in (zero height/width). This makes it invisible and functionally embedded
    RequestedHeight = 0;
    RequestedWidth = 0;

    Event OnSpeechRecognized(Text: Text); //Declares a custom event that is raised when speech is recognized. This is called from JS using InvokeExtensibilityMethod.
    //Declares AL-callable methods. From AL, you can call CurrPage.ControlName.StartRecording() or StopRecording() to trigger the respective JS functions.
    Procedure StartRecording();
    Procedure StopRecording();
}
