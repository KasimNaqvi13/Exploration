// speech.js

let recognition;
let isRecording = false;

function initRecognition() {
    if (!('webkitSpeechRecognition' in window)) {
        alert("Speech Recognition not supported in this browser.");
        return;
    }

    recognition = new webkitSpeechRecognition();
    recognition.continuous = true;
    recognition.interimResults = true;
    recognition.lang = 'en-US';

    recognition.onresult = function (event) {
        let transcript = '';
        for (let i = event.resultIndex; i < event.results.length; ++i) {
            transcript += event.results[i][0].transcript;
        }

        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnSpeechRecognized", [transcript]);
    };

    recognition.onerror = function (event) {
        console.error("Speech recognition error:", event.error);
    };
                  
    recognition.onend = function () {
        isRecording = false;
    };
}

function StartRecording() {
    if (!recognition) initRecognition();
    if (!isRecording) {
        recognition.start();
        isRecording = true;
    }
}

function StopRecording() {
    if (recognition && isRecording) {
        recognition.stop();
        isRecording = false;
    }
    
}
