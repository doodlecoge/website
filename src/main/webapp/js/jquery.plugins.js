''.endsWith || (String.prototype.endsWith = function (suffix) {
    return this.indexOf(suffix, this.length - suffix.length) !== -1;
});

(function ($) {
    /**
     *
     * @param options = {
     *      appendTo,
     *      html,
     *      js,
     *      css,
     *      dependencies: [
     *          http://.../a.css,
     *          http://.../jquery.js
     *      ]
     * }
     */
    $.fn.loadWidget = function (options) {
        if (options.html && options.appendTo) {
            $(options.appendTo).html(options.html);
        }
        var depJSs = [];
        var depCSSs = [];
        if (options.dependencies) {
            $.each(options.dependencies, function (i, dep) {
                if (dep.endsWith('.js')) {
                    depJSs.push(dep);
                } else if (dep.endsWith('.css')) {
                    depCSSs.push(dep);
                }
            });
        }

        var doc = document;
        var head = doc.getElementsByTagName('head')[0];

        if (options.css) {
            addCssText(options.css);
        }

        function addCssText(cssText) {
            try { // IE
                doc.createStyleSheet().cssText = cssText;
            } catch (e) { //Firefox, Opera, Safari, Chrome
                var style = doc.createElement("style");
                style.type = "text/css";
                style.textContent = cssText;
                head.appendChild(style);
            }
        }

        $.each(depCSSs, function (i, css) {
            var css = doc.createElement('link');
            css.type = 'text/css';
            css.rel = 'stylesheet';
            css.href = css;
            head.appendChild(css);
        });

        var JSs = $.map(depJSs, function (js) {
            return {data: js, tyep: 'url'};
        });

        if (options.js) {
            JSs.push({
                data: options.js,
                type: 'text'
            });
        }

        addScripts(JSs)

        function addScripts(scripts) {
            if (scripts.length == 0) return;
            var t = scripts.shift();
            var script = doc.createElement("script");
            script.type = "text/javascript";
            if (t.type == 'url') script.src = t.data;
            else if (t.type == 'text') script.text = t.data;
            document.body.appendChild(script);
            script.onload = script.onreadystatechange = function () {
                addScripts(scripts);
            }
        }
    };
})(jQuery);