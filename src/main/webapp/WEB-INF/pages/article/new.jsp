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
    String ctx = request.getContextPath();
    String cp = ".";
    String base = request.getScheme() + "://"
            + request.getServerName()
            + ":" + request.getServerPort()
            + request.getContextPath()
            + "/";
%>
<html>
<head>
    <title>Add/Edit Article</title>
    <base href="<%=base%>">
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
    <script type="text/javascript"
            src="<%=cp%>/js/modernizr.js"></script>

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
            height: 35px;
        }

        .tbl_editor td.label {
            font-weight: bold;
            font-size: 18px;
            color: #555;
            height: 20px;
        }

        #title {
            display: block;
            padding: 0 5px;
            outline: none;
            border: 0px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            height: 35px;
            width: 100%;
            box-sizing: border-box;
        }

        #tags {
            min-height: 25px;
            border-radius: 5px;
            border: 1px solid #ccc;
            padding: 5px;
        }

        #tags input {
            height: auto;
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

        .ui_menu {
            z-index: 1000;
        }

        .tool_bar {
            height: 50px;
            line-height: 50px;
            padding-left: 10px;
            background: #eee;
        }

        .tool_bar .btn {
            padding: 5px 10px;
            background: #69c;
            border-radius: 20px;
            cursor: pointer;
            color: #f8f8f8;
        }

        #overlay {
            position: fixed;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            display: none;
            z-index: 1000;
            opacity: 0.3;

            background: #000;
        }

        #images {
            position: fixed;
            left: 50px;
            right: 50px;
            top: 50px;
            bottom: 50px;
            display: none;
            z-index: 1001;
            background: #f8f8f8;
        }

        #images ul {
            padding: 0;
            margin: 0;
        }

        #images ul li {
            list-style: none;
            display: inline-block;
            border: 1px solid #ccc;
            padding: 5px;
            margin-left: 10px;
        }

        #images ul li img {
            max-width: 100px;
            max-height: 100px;
        }

        .logo {
            border-radius: 5px;
            border: 1px solid #ccc;
            cursor: pointer;
            max-height: 100px;
            max-width: 100px;
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
                var iid = $('#select_logo').attr('iid') || 0;
                if ($('#aid').length == 1) id = $('#aid').val();
                var xhr = $.ajax({
                    method: 'POST',
                    url: '<%=request.getContextPath()%>/article/' + id + '/save',
                    data: {
                        id: id,
                        iid: iid,
                        title: $('#title').val(),
                        tags: ids.join(','),
                        content: mde.getValue()
                    },
                    dataType: 'json'
                });
                xhr.done(function (data) {
                    if (data && data.error == false) {
                        location.href = "<%=request.getContextPath()%>/article/" + data.aid;
                    }
                });
                xhr.fail(function (data) {
                    console.log(data);
                });
            });

            $(window).bind("beforeunload", function (e) {
                if (Modernizr.localstorage) {
                    localStorage.newText = mde.getValue();
                }
            });
            <c:if test="${article == null}">
            if (Modernizr.localstorage) {
                mde.setValue(localStorage.newText);
            }
            </c:if>
            var img_target = null;
            $('#choose_image').click(function () {
                img_target = 'content';
                loadImages();
            });
            $('#select_logo').click(function () {
                img_target = 'logo';
                loadImages();
            });

            function loadImages() {
                var xhr = $.ajax({
                    url: '<%=ctx%>/image/json',
                    dataType: 'json'
                });
                xhr.done(function (data) {
                    console.log(data);
                    $('#overlay').show();
                    $('#images').show();

                    $('#images').html('');
                    var ul = $('<ul>').appendTo('#images');
                    $.each(data, function (i, image) {
                        var li = $('<li>').appendTo(ul);
                        var img = $('<img>')
                                .attr('src', 'image/' + image.id)
                                .attr('iid', image.id)
                                .appendTo(li);
                    });
                });
            }

            $('#images').click(function (e) {
                if (e.target.nodeName.toLowerCase() != 'img') return;
                var img = $(e.target);
                var iid = img.attr('iid');
                if (img_target == 'logo') {
                    $('#select_logo')
                            .attr('src', 'image/' + iid)
                            .attr('iid', iid);
                } else {
                    mde.replaceSelection("![Alt text](image/" + iid + ")");
                }
                img_target = null;
                $('#overlay').hide();
                $('#images').hide();
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
        <td style="height: 15px;"></td>
    </tr>
    <tr>
        <td class="label">Title of this post</td>
    </tr>
    <tr>
        <td>
            <c:choose>
                <c:when test="${article == null}">
                    <input type="text" id="title">
                </c:when>
                <c:otherwise>
                    <input type="text" id="title"
                           value="${article.title}">
                </c:otherwise>
            </c:choose>
        </td>
    </tr>


    <tr>
        <td style="height: 15px;"></td>
    </tr>
    <tr>
        <td class="label">Add tags</td>
    </tr>
    <tr>
        <td>
            <div id="tags"></div>
        </td>
    </tr>


    <tr>
        <td style="height: 15px;"></td>
    </tr>
    <tr>
        <td class="label">Logo (click to change)</td>
    </tr>
    <tr>
        <td>
            <c:choose>
                <c:when test="${article.image == null}">
                    <img src="img/no-img.png" class="logo" id="select_logo">
                </c:when>
                <c:otherwise>
                    <img src="image/${article.image.id}" class="logo"
                         id="select_logo" iid="${article.image.id}">
                </c:otherwise>
            </c:choose>
        </td>
    </tr>


    <tr>
        <td style="height: 15px;"></td>
    </tr>
    <tr>
        <td class="label">Content</td>
    </tr>
    <tr>
        <td style="border-bottom: 1px solid #ccc;">
            <div class="tool_bar">
                <a class="btn" id="choose_image">
                    <i class="fa fa-file-image-o"></i>
                    Insert Image
                </a>
            </div>
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
        <td colspan="2" style="height: 15px;"></td>
    </tr>
    <tr>
        <td>
            <button class="button blue" id="btn_submit">Save</button>
        </td>
    </tr>
</table>

<div id="preview" class="preview"></div>

<div id="overlay">
</div>
<div id="images">
</div>
</body>
</html>
