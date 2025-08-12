// ALCodeDisplayscript.js

(function () {
    'use strict';

    // Global namespace for the add-in
    window.ALCodeViewer = window.ALCodeViewer || {};

    /**
     * Notify Business Central that the control add-in is ready
     */
    function notifyControlReady() {
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlAddInReady', []);
    }

    /**
     * Set up the basic HTML structure of the control
     */
    function initializeControl() {
        try {
            const container = document.createElement('div');
            container.className = 'al-code-viewer-container';
            container.innerHTML = `
                <div class="al-code-viewer-header">
                    <span class="al-code-viewer-title">AL Code Viewer</span>
                    <div class="al-code-viewer-controls">
                        <button class="al-code-viewer-btn" id="copyBtn" title="Copy Code">Copy</button>
                        <button class="al-code-viewer-btn" id="clearBtn" title="Clear Code">Clear</button>
                    </div>
                </div>
                <div class="al-code-viewer-content">
                    <pre><code class="al-code" id="codeDisplay"></code></pre>
                </div>
                <div class="al-code-viewer-status">
                    <span id="statusText">Ready</span>
                    <span id="lineCount">Lines: 0</span>
                </div>
            `;

            // Clear any existing content
            document.body.innerHTML = '';
            document.body.appendChild(container);

            // Store key elements globally
            window.ALCodeViewer.container = container;
            window.ALCodeViewer.codeDisplay = document.getElementById('codeDisplay');
            window.ALCodeViewer.statusText = document.getElementById('statusText');
            window.ALCodeViewer.lineCount = document.getElementById('lineCount');

            // Initialize helper functions
            window.ALCodeViewer.clearCode = function () {
                window.ALCodeViewer.codeDisplay.textContent = '';
                updateLineCount(0);
                window.ALCodeViewer.statusText.textContent = 'Cleared';
                setTimeout(() => window.ALCodeViewer.statusText.textContent = 'Ready', 1500);
            };

            // Event handlers
            setupEventHandlers();

            // Tell BC we are ready
            notifyControlReady();

            console.log('AL Code Viewer initialized successfully');
        } catch (error) {
            console.error('Error initializing AL Code Viewer:', error);
        }
    }

    /**
     * Sets up copy/clear button handlers
     */
    function setupEventHandlers() {
        const copyBtn = document.getElementById('copyBtn');
        const clearBtn = document.getElementById('clearBtn');

        if (copyBtn) {
            copyBtn.addEventListener('click', () => {
                const code = window.ALCodeViewer.codeDisplay.textContent;
                if (code) {
                    navigator.clipboard.writeText(code).then(() => {
                        window.ALCodeViewer.statusText.textContent = 'Code copied';
                        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('CodeCopied', []);
                        setTimeout(() => window.ALCodeViewer.statusText.textContent = 'Ready', 1500);
                    }).catch(err => {
                        console.error('Copy failed:', err);
                        window.ALCodeViewer.statusText.textContent = 'Copy failed';
                    });
                }
            });
        }

        if (clearBtn) {
            clearBtn.addEventListener('click', () => {
                window.ALCodeViewer.clearCode();
            });
        }
    }

    /**
     * Update line count display
     */
    function updateLineCount(count) {
        window.ALCodeViewer.lineCount.textContent = `Lines: ${count}`;
    }

    /**
     * AL-callable method: Set AL code text
     */
    window.SetALCode = function (alCode) {
        window.ALCodeViewer.codeDisplay.textContent = alCode || '';
        const lines = alCode ? alCode.split(/\r\n|\r|\n/).length : 0;
        updateLineCount(lines);
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('CodeFormatted', [alCode]);
    };

    /**
     * AL-callable method: Set theme
     */
    window.SetTheme = function (theme) {
        document.body.setAttribute('data-theme', theme);
    };

    /**
     * AL-callable method: Toggle line numbers
     */
    window.ShowLineNumbers = function (show) {
        if (show) {
            window.ALCodeViewer.codeDisplay.classList.add('show-line-numbers');
        } else {
            window.ALCodeViewer.codeDisplay.classList.remove('show-line-numbers');
        }
    };

    /**
     * AL-callable method: Enable/disable syntax highlighting
     */
    window.EnableSyntaxHighlighting = function (enable) {
        // If using highlight.js or Prism.js, trigger re-highlighting here
        if (enable) {
            window.ALCodeViewer.codeDisplay.classList.add('syntax-highlight');
        } else {
            window.ALCodeViewer.codeDisplay.classList.remove('syntax-highlight');
        }
    };

    /**
     * AL-callable method: Set read-only mode
     */
    window.SetReadOnly = function (readOnly) {
        if (readOnly) {
            window.ALCodeViewer.codeDisplay.setAttribute('contenteditable', 'false');
        } else {
            window.ALCodeViewer.codeDisplay.setAttribute('contenteditable', 'true');
        }
    };

    // Initialize when DOM is loaded
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initializeControl);
    } else {
        initializeControl();
    }

})();
