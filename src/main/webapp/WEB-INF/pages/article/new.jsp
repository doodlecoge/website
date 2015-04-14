<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/1/19
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String cp = request.getContextPath();
%>
<html>
<head>
    <title>Add/Edit Article</title>
    <link rel="stylesheet" type="text/css"
          href="<%=cp%>/jqp/menu/jquery-menu.css">
    <link rel="stylesheet" type="text/css"
          href="<%=cp%>/jqp/inputs/jquery-inputs.css">
    <link rel="stylesheet" type="text/css"
          href="<%=cp%>/cme/lib/codemirror.css">

    <script type="text/javascript"
            src="<%=cp%>/js/marked.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/jqp/lib/jquery-ui-core.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/jqp/menu/jquery-menu.js"></script>
    <script type="text/javascript"
            src="<%=cp%>/jqp/inputs/jquery-inputs.js"></script>
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
            height: 30px;
        }

        .tbl_editor .h {
            width: 1%;
            background: #ccc;
            padding: 5px;
        }

        #title {
            width: 100%;
            height: 100%;
            outline: none;
            border: 0px;
            font-size: 16px;
        }

        #preview {
            overflow-y: auto;
            margin: 10px 0;
        }

        .CodeMirror {
            height: 100%;
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', 'Consolas', 'source-code-pro', 'Droid Sans Mono', monospace;
        }

        .CodeMirror-gutters {
            height: 100% !important;
        }

        #tags {
            min-height: 30px;
        }

        .ui_menu {
            z-index: 1000;
        }
    </style>

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
            var mde = CodeMirror.fromTextArea(document.getElementById('raw'), {
                lineNumbers: true,
                lineWrapping: true,
                mode: "markdown",
                indentUnit: 4,
                indentWithTabs: true,
                extraKeys: {"Enter": "newlineAndIndentContinueMarkdownList"}
            });
            mde.on("change", function (Editor, changes) {
                var txt = mde.getValue();
                var html = marked(txt);
                $("#preview").html(html);
            });
            var tags;
            $('#tags').inputs().inputs('autocomplete', function (filter, cb) {
                if (!tags) {
                    var xhr = $.ajax({
                        url: '<%=request.getContextPath()%>/tag/json',
                        dataType: 'json'
                    });
                    xhr.done(function (data) {
                        tags = data;
                        var source = foo();
                        cb(source);
                    });
                } else cb(foo());
                function foo() {
                    if (!tags) return [];
                    var reg = new RegExp(filter);
                    var source = $.map(tags, function (tag) {
                        if (reg.test(tag.text)) return tag;
                    });
                    return source;
                }
            });
            $('#btn_submit').click(function () {
                var tags = $('#tags').inputs('getValues');
                var ids = [];
                $.each(tags, function (i, tag) {
                    ids.push(tag.id);
                });
                var id = 0;
                if ($('#aid').length == 1) id = $('#aid').val();
                var xhr = $.ajax({
                    method: 'POST',
                    url: '<%=request.getContextPath()%>/article/' + id + '/save',
                    data: {
                        id: id,
                        title: $('#title').val(),
                        tags: ids.join(','),
                        content: mde.getValue()
                    },
                    dataType: 'json'
                });
                xhr.done(function (data) {
                    console.log(data.error);
                    console.log(data);
                    if (data && data.error == false) {
                        location.href = "<%=request.getContextPath()%>/article/" + data.aid;
                    }
                });
                xhr.fail(function (data) {
                    console.log(data);
                });
            });
        });
    </script>


</head>
<body>
<c:if test="${article != null}">
    <script type="text/javascript">
        $(function () {
            <c:forEach items="${article.tags}" var="tag">
            $('#tags').inputs('addItem', {id:${tag.id}, text: '${tag.name}'});
            </c:forEach>
        });
    </script>
    <input id="aid" type="hidden" value="${article.id}">
</c:if>
<table class="tbl_editor">
    <tr>
        <td colspan="2" style="height: 5px;"></td>
    </tr>

    <tr>
        <td class="h">Title:</td>
        <td style="border-bottom: 1px solid #ccc; padding: 0 5px;">
            <c:choose>
                <c:when test="${article == null}">
                    <input type="text" id="title" style="font-size: 24px;">
                </c:when>
                <c:otherwise>
                    <input type="text" id="title" style="font-size: 24px;" value="${article.title}">
                </c:otherwise>
            </c:choose>
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
            <div id="editor" style="height: 300px">
                <c:choose>
                    <c:when test="${article == null}">
                        <textarea id='raw'></textarea>
                    </c:when>
                    <c:otherwise>
                        <textarea id='raw'>${article.content}</textarea>
                    </c:otherwise>
                </c:choose>
            </div>
        </td>
    </tr>

    <tr>
        <td colspan="2" style="height: 5px;"></td>
    </tr>

    <tr>
        <td colspan="2" style="text-align: right;">
            <button class="button" id="btn_submit">Save</button>
        </td>
    </tr>
</table>

<div id="preview" class="preview"></div>
</body>
</html>
