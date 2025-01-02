// Keyword colors are from https://protesilaos.com/emacs/modus-themes-colors

function highlightStatusKeywords() {
    const keywords = {
        'TODO': '#a60000',
        'DOING': '#d00000',
        'DONE': '#006800'
    };
    const keywordPattern = /\b(TODO|DOING|DONE)\b/g;


    function createColoredSpan(text, color) {
        const span = document.createElement('span');
        span.style.color = color;
        span.style.fontWeight = 'bold';
        span.textContent = text;
        return span;
    }

    function processTextNode(textNode) {
        const text = textNode.nodeValue;
        const matches = [...text.matchAll(keywordPattern)];
        
        if (matches.length === 0) return;

        const fragment = document.createDocumentFragment();
        let lastIndex = 0;

        matches.forEach(match => {

            if (match.index > lastIndex) {
                fragment.appendChild(document.createTextNode(text.slice(lastIndex, match.index)));
            }


            const keyword = match[0];
            fragment.appendChild(createColoredSpan(keyword, keywords[keyword]));

            lastIndex = match.index + keyword.length;
        });


        if (lastIndex < text.length) {
            fragment.appendChild(document.createTextNode(text.slice(lastIndex)));
        }

        textNode.parentNode.replaceChild(fragment, textNode);
    }

    function walkTextNodes(node) {
        if (node.nodeType === Node.TEXT_NODE) {
            processTextNode(node);
            return;
        }
        

        if (node.nodeName === 'SCRIPT' || node.nodeName === 'STYLE') {
            return;
        }

        // Create a static array of child nodes to avoid live NodeList issues
        const children = Array.from(node.childNodes);
        children.forEach(walkTextNodes);
    }

    walkTextNodes(document.body);
}

document.addEventListener('DOMContentLoaded', highlightStatusKeywords);
