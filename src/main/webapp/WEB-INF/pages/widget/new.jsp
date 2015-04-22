<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/4/21
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
    String cp = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>Online HTML/CSS/Javascript Editor</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel=stylesheet href="<%=cp%>/cme/lib/codemirror.css">
    <link rel=stylesheet href="<%=cp%>/css/font-awesome.min.css">

    <script type="text/javascript" src="<%=cp%>/js/jquery-1.11.1.js"></script>

    <script type="text/javascript" src="<%=cp%>/cme/lib/codemirror.js"></script>
    <script type="text/javascript" src="<%=cp%>/cme/mode/xml/xml.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/cme/mode/javascript/javascript.js"></script>
    <script type="text/javascript" src="<%=cp%>/cme/mode/css/css.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/cme/mode/htmlmixed/htmlmixed.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/cme/mode/htmlembedded/htmlembedded.js"></script>
    <style type="text/css">
        .overlay {
            position: absolute;
            z-index: 999999;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
        }

        .split-win {
            padding: 14px 7px;
            background: #f5f5f5;
            height: 100%;
            box-sizing: border-box;
            font-family: Monaco, Menlo, 'Ubuntu Mono', Consolas, source-code-pro, monospace;
        }

        .split-win .wrapper {
            height: 100%;
            position: relative;
            margin: 8px 7px;
            top: -8px;
        }

        .split-win .wrapper .col {
            width: 50%;
            height: 100%;
            box-sizing: border-box;
        }

        .split-win .wrapper .l {
            left: -5px;
            position: absolute;
        }

        .split-win .wrapper .r {
            right: -5px;
            position: absolute;
        }

        .split-win .wrapper .win {
            position: absolute;
            border: 1px solid #ccc;
            width: 100%;
            background: #fff;
            box-shadow: inset 0 2px 5px #eee;
        }

        .split-win .wrapper .win textarea {
            border: 0;
            padding: 0;
            margin: 0;
            outline: none;
            resize: none;
            width: 100%;
            height: 100%;
            font-family: Monaco, Menlo, 'Ubuntu Mono', Consolas, source-code-pro, monospace;
        }

        .split-win .wrapper .win .label {
            z-index: 2000;
            border: 1px solid #f0f0f0;
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 3px 5px;
            color: #888;
            background: #fff;
        }

        .split-win .wrapper .t {
            top: -6px;
            height: 40%;
        }

        .split-win .wrapper .b {
            bottom: -6px;
            height: 60%;
        }

        .split-win .wrapper .vh {
            left: 50%;
            width: 8px;
            height: 100%;
            position: absolute;
            margin-left: -3px;
            padding: 5px 0;
            top: -5px;
            z-index: 1000;
            cursor: col-resize;
            background: url("<%=cp%>/img/handle-v.png") 2px 50% no-repeat;
        }

        .split-win .wrapper .hh {
            top: 40%;
            width: 100%;
            height: 8px;
            position: absolute;
            margin-top: -3px;
            z-index: 1000;
            cursor: row-resize;
            background: url("<%=cp%>/img/handle-h.png") 50% 2px no-repeat;
        }

        .CodeMirror {
            height: 100%;
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', 'Consolas', 'source-code-pro', 'Droid Sans Mono', monospace;
        }

        .CodeMirror-gutters {
            height: 100% !important;
        }

        .preview_iframe {
            width: 100%;
            height: 100%;
        }
    </style>

    <style type="text/css">
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #eidtor_wrapper {
            position: fixed;
            top: 40px;
            bottom: 0;
            left: 0;
            right: 0;
            min-width: 400px;
            min-height: 300px;
        }

        .toolbar {
            /*line-height: 40px;*/
            background: #555;
            display: table;
            width: 100%;
            font-family: Monaco, Menlo, 'Ubuntu Mono', Consolas, source-code-pro, monospace, "微软雅黑", "宋体";
            padding: 0;
            margin: 0;
        }

        .toolbar .btn {
            color: #ccc;
            font-weight: bold;
            padding: 0 10px;
            cursor: pointer;
            text-decoration: none;
            display: table-cell;
            width: 1%;
            white-space: nowrap;
            overflow: hidden;
        }

        .toolbar .btn:hover {
            color: #f8f8f8;
        }

        .toolbar input.desc {
            padding: 0 5px;
            margin: 5px 0;
            border: 0;
            height: 30px;
            display: inline;
            display: table-cell;
            width: 100%;
            box-sizing: border-box;
            font-family: Monaco, Menlo, 'Ubuntu Mono', Consolas, source-code-pro, monospace, "微软雅黑", "宋体";
            font-size: 18px;
            background: #ffc;
            outline: none;
        }
    </style>
</head>
<body>
<div class="toolbar">
    <a class="btn" href="<%=cp%>/">
        <i class="fa fa-reply"></i>
        Exit
    </a>
    <c:if test="${widget != null}">
        <input type="text" class="desc" id="title" value="${widget.title}"
               placeholder="type description of this widget here ...">
    </c:if>
    <c:if test="${widget == null}">
        <input type="text" class="desc" id="title"
               placeholder="type description of this widget here ...">
    </c:if>
    <sec:authorize access="isAuthenticated()">
        <a class="btn" id="save">
            <i class="fa fa-save"></i>
            Save
        </a>
    </sec:authorize>
    <sec:authorize access="isAnonymous()">
        <a class="btn" href="<%=cp%>/login">
            <i class="fa fa-key"></i>
            Login to save
        </a>
    </sec:authorize>

</div>
<c:if test="${widget != null}">
    <input type="hidden" id="wid" value="${widget.id}">
</c:if>
<div id="eidtor_wrapper">
    <div class="split-win">
        <div class="wrapper">
            <div class="col l">
                <div class="win t">
                    <span class="label">CSS</span>
                    <c:if test="${widget != null}">
                        <textarea id="cm_css">${widget.css}</textarea>
                    </c:if>
                    <c:if test="${widget == null}">
                        <textarea id="cm_css"></textarea>
                    </c:if>
                </div>
                <div class="hh"></div>
                <div class="win b">
                    <span class="label">HTML</span>
                    <c:if test="${widget != null}">
                        <textarea id="cm_html">${widget.html}</textarea>
                    </c:if>
                    <c:if test="${widget == null}">
                        <textarea id="cm_html"></textarea>
                    </c:if>
                </div>
            </div>
            <div class="vh"></div>
            <div class="col r">
                <div class="win t">
                    <span class="label">JAVASCRIPT</span>
                    <c:if test="${widget != null}">
                        <textarea id="cm_js">${widget.js}</textarea>
                    </c:if>
                    <c:if test="${widget == null}">
                        <textarea id="cm_js"></textarea>
                    </c:if>
                </div>
                <div class="hh"></div>
                <div class="win b rst">
                    <span class="label">RESULT</span>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var dragging = false;
    var cssEditor;
    var htmlEditor;
    var jsEditor;

    $(function () {
        buildSplitWin();

        cssEditor = CodeMirror.fromTextArea($("#cm_css").get(0), {
            lineNumbers: true,
            mode: "text/css",
            indentUnit: 4,
            indentWithTabs: true
        });

        htmlEditor = CodeMirror.fromTextArea($("#cm_html").get(0), {
            lineNumbers: true,
            mode: "text/html",
            indentUnit: 4,
            indentWithTabs: true
        });

        jsEditor = CodeMirror.fromTextArea($("#cm_js").get(0), {
            lineNumbers: true,
            mode: "javascript",
            indentUnit: 4,
            indentWithTabs: true
        });

        cssEditor.on('change', updatePreivew);
        htmlEditor.on('change', updatePreivew);
        jsEditor.on('change', updatePreivew);

        var timer = null;

        function updatePreivew(ins, chgs) {
            clearTimeout(timer);
            timer = setTimeout(delay, 1000);
        }

        updatePreivew();


        $('#save').click(function () {
            var html = htmlEditor.getValue();
            var css = cssEditor.getValue();
            var js = jsEditor.getValue();
            var id = $('#wid').val() || 0;
            var title = $('#title').val();
            var data = {id: id, html: html, css: css, js: js, title: title};

            var xhr = $.ajax({
                url: '<%=cp%>/widget/save',
                method: 'post',
                data: data,
                dataType: 'json'
            });

            xhr.done(function (data) {
                if (data.error == false) {
                    location.href = '<%=cp%>/widget';
                }
            });

            xhr.fail(function (data) {
                alert('fail');
            });
        });
    });

    function delay() {
        var css = cssEditor.getValue();
        var html = htmlEditor.getValue();
        var js = jsEditor.getValue();

        $(".preview_iframe").remove();
        var iframe = $('<iframe>')
                .addClass('preview_iframe')
                .attr('frameborder', '0')
                .appendTo('.rst').get(0);
        var doc = iframe.contentDocument || iframe.contentWindow.document;

        var html = '\
                  <!doctype html>\
                  <html>\
                      <head>\
                          <style type="text/css">' + css + '<\/style>\
                      <\/head>\
                      <body>' + html + '<\/body>\
                  <\/html>';

        doc.write(html);
        doc.close();

        var head = doc.getElementsByTagName('head')[0];
        var script, prefix = '<%=cp%>';

        function addScripts(scripts) {
            if (scripts.length == 0) return;
            var t = scripts.shift();
            script = doc.createElement("script");
            script.type = "text/javascript";
            if (t.type == 'url') script.src = t.data;
            else if (t.type == 'text') script.text = t.data;
            head.appendChild(script);
            script.onload = script.onreadystatechange = function () {
                addScripts(scripts);
            }
        }

        addScripts([
            {
                type: 'url',
                data: prefix + '/js/jquery-1.11.1.js'
            },
            {
                type: 'text',
                data: js
            }
        ]);
    }

    function buildSplitWin() {
        $(".vh").on('mousedown', function () {
            dragging = 'v';

            var that = $(this);
            var offset = that.parent().offset();
            var pwidth = that.parent().width();
            var siblings;
            var pos, lwidth, rwidth;

            $(document).on("mousemove.split_window", function (e) {
                if (!dragging) return;
                pos = e.pageX - offset.left;
                if (pos < 100 || pwidth - pos < 100) return;
                lwidth = 100 * pos / pwidth;
                rwidth = 100 - lwidth;
                that.css('left', pos + 'px');
                siblings = that.siblings();
                $(siblings.get(0)).css('width', lwidth + '%');
                $(siblings.get(1)).css('width', rwidth + '%');
            });

            disableSelection();
            return false;
        });

        $(".hh").on('mousedown', function () {
            dragging = 'h';

            var that = $(this);
            var offset = that.parent().offset();
            var pheight = that.parent().height();
            var siblings;
            var pos, theight;

            $(document).on("mousemove.split_window", function (e) {
                if (!dragging) return;
                pos = e.pageY - offset.top;
                if (pos < 100 || pheight - pos < 100) return;
                theight = 100 * pos / pheight;
                that.css('top', pos + 'px');
                siblings = that.siblings();
                $(siblings.get(0)).css('height', theight + '%');
                $(siblings.get(1)).css('height', (100 - theight) + '%');
            });

            disableSelection();
            return false;
        });

        $(document).on("mouseup", function () {
            $(document).off('.split_window');
            dragging = null;
            enableSelection();
        });
    }

    function disableSelection() {
        var overlay = $('.overlay');
        if (overlay.length == 0) {
            overlay = $('<div class="overlay">').appendTo(document.body);
        }
        overlay.css('cursor', dragging == 'v' ? 'col-resize' : 'row-resize').show();
    }

    function enableSelection() {
        $('.overlay').hide();
    }
</script>
<jsp:include page="../../decorators/ga.jsp"></jsp:include>
</body>
</html>
