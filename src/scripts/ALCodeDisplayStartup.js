// ALCodeDisplayStartup.js
// Initializes the ControlAddIn UI and fires the ControlAddInReady event

(function() {
    'use strict';

    window.ALCodeViewer = window.ALCodeViewer || {};

    function initializeControl() {
        try {
            const container = document.createElement('div');
            container.className = 'al-code-viewer-container theme-light';

            container.innerHTML = `
                <div class="al-code-viewer-header">
                    <span class="al-code-viewer-title">AL Code Viewer</span>
                    <div class="al-code-viewer-controls">
                        <button class="al-code-viewer-btn" id="copyBtn" title="Copy Code">Copy</button>
                        <button class="al-code-viewer-btn" id="clearBtn" title="Clear Code">Clear</button>
                    </div>
                </div>
                <div class="al-code-viewer-content">
                    <pre><code class="al-code" id="codeDisplay" aria-label="AL code display" tabindex="0"></code></pre>
                </div>
                <div class="al-code-viewer-status">
                    <span id="statusText">Ready</span>
                    <span id="lineCount">Lines: 0</span>
                </div>
            `;

            // Reset document body safely inside the add-in iframe
            while (document.body.firstChild) document.body.removeChild(document.body.firstChild);
            document.body.appendChild(container);

            // Store references
            window.ALCodeViewer.container = container;
            window.ALCodeViewer.codeDisplay = document.getElementById('codeDisplay');
            window.ALCodeViewer.statusText = document.getElementById('statusText');
            window.ALCodeViewer.lineCount = document.getElementById('lineCount');

            setupEventHandlers();

            console.log('AL Code Viewer initialized successfully');

            // Fire correct event AFTER UI has been created
            if (typeof Microsoft !== 'undefined' && Microsoft.Dynamics && Microsoft.Dynamics.NAV && Microsoft.Dynamics.NAV.InvokeExtensibilityMethod) {
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlAddInReady', []);
            }

        } catch (error) {
            console.error('Error initializing AL Code Viewer:', error);
            if (typeof Microsoft !== 'undefined' && Microsoft.Dynamics && Microsoft.Dynamics.NAV && Microsoft.Dynamics.NAV.InvokeExtensibilityMethod) {
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnError', [error.message]);
            }
        }
    }

    function setupEventHandlers() {
        const copyBtn = document.getElementById('copyBtn');
        if (copyBtn) {
            copyBtn.addEventListener('click', function() {
                const code = window.ALCodeViewer.codeDisplay.textContent;
                if (code) {
                    navigator.clipboard.writeText(code).then(function() {
                        window.ALCodeViewer.statusText.textContent = 'Code copied to clipboard';
                        if (typeof Microsoft !== 'undefined' && Microsoft.Dynamics && Microsoft.Dynamics.NAV && Microsoft.Dynamics.NAV.InvokeExtensibilityMethod) {
                            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('CodeCopied', []);
                        }
                        setTimeout(() => {
                            if (window.ALCodeViewer.statusText) window.ALCodeViewer.statusText.textContent = 'Ready';
                        }, 2000);
                    }).catch(function(err) {
                        console.error('Could not copy text: ', err);
                        if (window.ALCodeViewer.statusText) window.ALCodeViewer.statusText.textContent = 'Copy failed';
                    });
                }
            });
        }

        const clearBtn = document.getElementById('clearBtn');
        if (clearBtn) {
            clearBtn.addEventListener('click', function() {
                if (window.ALCodeViewer && typeof window.ALCodeViewer.clearCode === 'function') {
                    window.ALCodeViewer.clearCode();
                }
            });
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initializeControl);
    } else {
        initializeControl();
    }

})();