<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/1/19
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title>Add/Edit Article</title>
    <link rel="stylesheet" type="text/css"
          href="<%=cp%>/css/jquery-plugins.css">
    <link rel="stylesheet" type="text/css"
          href="<%=cp%>/cme/lib/codemirror.css">

    <script type="text/javascript"
            src="<%=cp%>/js/marked.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/js/jquery-ui-core.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/js/jquery-plugins.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/cme/lib/codemirror.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/cme/addon/edit/continuelist.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/cme/mode/xml/xml.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/cme/mode/markdown/markdown.js"></script>

    <style type="text/css">
        .tbl_editor {
            width: 100%;
            border-spacing: 0;
        }

        .tbl_editor td {
            vertical-align: top;
            padding: 0;
            margin: 0;
            border: 0;
            height: 40px;
        }

        .tbl_editor .h {
            width: 1%;
            background: #ccc;
            padding: 5px;
        }

        #editor {
            height: 250px;
        }

        #title {
            width: 100%;
            height: 100%;
            outline: none;
            border: 0px;
        }

        #preview {
            max-height: 250px;
            overflow-y: auto;
            font-size: 12px;
            margin: 10px 0;
        }

        .CodeMirror {
            height: 100%;
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', 'Consolas', 'source-code-pro', 'Droid Sans Mono', monospace;
        }

        .CodeMirror-gutters {
            height: 100% !important;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            var mde = CodeMirror(document.getElementById("editor"), {
                lineNumbers: true,
                mode: "markdown",
                indentUnit: 4,
                indentWithTabs: true,
                extraKeys: {"Enter": "newlineAndIndentContinueMarkdownList"}
            });
        });
    </script>
</head>
<body>
<table class="tbl_editor">
    <tr>
        <td colspan="2" style="height: 5px;"></td>
    </tr>

    <tr>
        <td class="h">Title:</td>
        <td style="border-bottom: 1px solid #ccc; padding: 0 5px;">
            <input type="text" id="title">
        </td>
    </tr>

    <tr>
        <td colspan="2" style="height: 5px;"></td>
    </tr>

    <tr>
        <td class="h">Tags:</td>
        <td style="border-bottom: 1px solid #ccc; padding: 0 5px;">
            <div id="tags"></div>
        </td>
    </tr>

    <tr>
        <td colspan="2" style="height: 5px;"></td>
    </tr>

    <tr>
        <td class="h">Content:</td>
        <td style="border-bottom: 1px solid #ccc;">
            <div id="editor"></div>
        </td>
    </tr>

    <tr>
        <td colspan="2" style="height: 5px;"></td>
    </tr>

    <tr>
        <td colspan="2" style="text-align: right;">
            <button class="button">Save</button>
        </td>
    </tr>
</table>

<div id="preview"></div>


<script type="text/javascript">

    marked.setOptions({
        renderer: new marked.Renderer(),
        gfm: true,
        tables: true,
        breaks: false,
        pedantic: false,
        sanitize: true,
        smartLists: true,
        smartypants: false
    });

    $(function () {
    });
</script>
</body>
</html>
