// Load highlight.js library
const script = document.createElement('script');
script.src = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js';
document.head.appendChild(script);

// Load AL language support for highlight.js
const alLangScript = document.createElement('script');
alLangScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/al.min.js';
document.head.appendChild(alLangScript);

// Wait for library to load
script.onload = () => {
    hljs.highlightAll();
};

// Called from AL to set the code
window.SetCode = function (codeText) {
    const codeBlock = document.getElementById('al-code-block');
    if (codeBlock) {
        codeBlock.textContent = codeText;
        hljs.highlightElement(codeBlock);
    }
};
