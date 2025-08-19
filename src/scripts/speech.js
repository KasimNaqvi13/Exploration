// speech.js
(function () {
    'use strict';

    var recognition;
    var isListening = false;
    var finalTranscript = '';

    // IMPORTANT: expose functions with the exact same names as AL procedures
    window.StartSpeechRecognition = function () {
        try {
            // Browser support check
            var SR = window.SpeechRecognition || window.webkitSpeechRecognition;
            if (!SR) {
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnError', [
                    'Speech recognition not supported in this browser. Please use the latest Chrome or Edge over HTTPS.'
                ]);
                return;
            }

            // (Re)create recognition each time to avoid stale state
            recognition = new SR();
            recognition.continuous = true;
            recognition.interimResults = true;
            recognition.lang = 'en-US';
            recognition.maxAlternatives = 1;

            finalTranscript = '';

            recognition.onstart = function () {
                isListening = true;
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnStarted', []);
            };

            recognition.onresult = function (event) {
                var interimTranscript = '';
                var tempFinalTranscript = '';

                for (var i = event.resultIndex; i < event.results.length; i++) {
                    var result = event.results[i];
                    var transcript = result[0].transcript;
                    if (result.isFinal) {
                        tempFinalTranscript += transcript + ' ';
                    } else {
                        interimTranscript += transcript;
                    }
                }

                // Accumulate only the final bits; preview interim live
                finalTranscript += tempFinalTranscript;

                // Send the current “best full text so far” to AL
                var fullText = (finalTranscript + interimTranscript).trim();
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnResult', [fullText]);
            };

            recognition.onerror = function (event) {
                isListening = false;
                var errorMsg = 'Speech recognition error: ' + event.error;
                if (event.error === 'not-allowed') {
                    errorMsg = 'Microphone access denied. Please allow microphone access and try again.';
                } else if (event.error === 'no-speech') {
                    errorMsg = 'No speech detected. Please try again.';
                } else if (event.error === 'audio-capture') {
                    errorMsg = 'No microphone detected. Please connect a mic and try again.';
                }
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnError', [errorMsg]);
            };

            recognition.onend = function () {
                // onend fires after stop() or on internal end
                isListening = false;
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnStopped', [finalTranscript.trim()]);
            };

            // Must be triggered by a user gesture (your Start action does that)
            recognition.start();

        } catch (error) {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnError', [
                'Failed to initialize speech recognition: ' + (error && error.message ? error.message : String(error))
            ]);
        }
    };

    window.StopSpeechRecognition = function () {
        try {
            if (recognition && isListening) {
                recognition.stop(); // triggers onend
            }
        } catch (error) {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnError', [
                'Failed to stop speech recognition: ' + (error && error.message ? error.message : String(error))
            ]);
        }
    };
})();
