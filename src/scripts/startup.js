// startup.js
(function () {
    'use strict';

    // Optional: create a namespace (not required, but keeps global scope tidy)
    window.SpeechRecognitionControl = window.SpeechRecognitionControl || {};

    // Let AL know the control is ready to receive calls
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
})();
