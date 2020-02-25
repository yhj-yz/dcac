<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>发起流程</title>
    [#include "/include/head.ftl"]
    <link rel="stylesheet" type="text/css" href="${base}/resources/dsm/css/zTreeStyle.css">
    <script src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
    <script src="${base}/resources/dsm/js/uploadfile.js"></script>
</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">
        <div class="mainbox setform" id="setform">
            <div class="dsm-nav-tabs">
                <ul class="nav nav-tabs" role="tablist" id="perTab">
                    <li class="active"><a href="#basicinfo" data-toggle="tab" aria-expanded="true">工作流基本信息</a></li>
                </ul>
                <form id="programSerForm" action="${base}/initiation_process/save.do" method="post"
                      enctype="multipart/form-data">
                    <div class="tab-content">
                        <input name="submitType" type="hidden" value="1">
                        <input name="isRepeat" type="hidden" value="">
                        <input name="oldSrcFile" type="hidden" value="">
                        <div role="tabpanel" class="tab-pane fade active in" id="basicinfo">
                            <div class="dsmForms" style="width:600px;height: auto">
                                <div class="dsm-form-item">
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">工作流名称：</label>
                                        <div class="dsm-input-inline">
                                            <input type="text" autocomplete="off" name="processName"
                                                   placeholder="请填写流程名称"
                                                   onchange="validateRepeat()"
                                                   class="dsm-input required specialChar"/>
                                        </div>
                                    </div>
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label" style="width:110px"></label>
                                        <div class="dsm-input-block">
                                            <div class="syserror" style='color:red;'></div>
                                        </div>
                                    </div>
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">申请原因:</label>
                                        <div class="dsm-input-inline dsm-tarea ">
                                            <textarea name="applyReason" cols="10" rows="2"
                                                      class="dsm-input dsm-textarea"></textarea>
                                            <span class="txt-limit">（限2048个字）</span>
                                        </div>
                                    </div>
                                    <div id="uploadFile" class="dsm-inline">
                                        <label class="dsm-form-label">待发起文件:</label>
                                        <div class="dsm-upload-button f-l m-r-f10">
                                            <span class="fbtname" onclick="upload();">新增文件</span>
                                        </div>
                                        <div style="width: 90px"></div>
                                        <div class="dsm-upload-button f-l m-r-f10" style="margin-left: 90px">
                                            <span class="fbtname" onclick="removeAll();">清除文件</span>
                                        </div>
                                        &nbsp;&nbsp;&nbsp;
                                        <label>上传文件数量不超过1个</label>
                                    </div>
                                    [#--待上传文件列表--]
                                    <div class="dsm-inline">
                                        <div class="dsm-inline">
                                            <table id="tableList" cellpadding="5" cellspacing="5"
                                                   style="margin-left: 110px"></table>
                                        </div>
                                    </div>
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">审批工作流:</label>
                                        <div class="dsm-input-block" style="width: 120px">
                                            <select name="flowId" class="dsm-select" style="width: 100px">
                                                [#list roles as q]
                                                    <option value="${q.id}">${q.workFlowName}</option>
                                                [/#list]
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="form-btns t-l" style="padding-left:0;">
                <button class="btn btn-lg btn-primary js_button">提交</button>
                <a href="${base}/initiation_process/show.do" class="btn btn-lg btn-primary">取消</a>
            </div>
        </div>


    </div>
</div>
<script type="text/javascript">


    $(document).ready(function () {
        if ("${error}" != "") {
            dsmDialog.msg('${error}');
        }
        if ("${data}" != "") {
            if ("${data.type}" == "erro") {
                dsmDialog.msg('${data.content}');
            }
        }

        //每次隐藏时，清除数据。确保点击时，重新加载
        $("#showModal").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
        });

        if ("${list.enableLogAutoDel}" == 0) {
            $(".logList").addClass("hidden");
            $(".deleteText").addClass("hidden")
        }

        $(".logList").find("[name='logValue']").each(function () {
            var v1 = "${list.recordLogType}";
            this.checked = (v1 & this.value) == this.value;
        });

        // $(document).on('change', '.js_secondFile', function (e) {
        //     var fileName;
        //     var fragment = "";
        //     fragment += "<tr><td class='dsm-td' style=\'width:60%;\'>" + fileName + "</td><td style=\'padding-left: 20px\'><button class=\"fbtname\" onclick=\'removeDom($(this))\'>删除</button></td>" + "</tr>";
        //     $("#tableList").append(fragment);
        // }


        $(document).on('change', '.js_file', function (e) {
            var fileLength = $('#tableList').find("tr").length;
            if (fileLength == 1) {
                dsmDialog.msg("上传文件数已达上限");
                return;
            }
            var fileName;
            if (fileLength == 1) {
                var $file = $("#uploadFile").find('#file1');
                console.log("$file", $file[0]);
                var $items = $file.val();
                console.log("$items", $items);
                fileName = $items;
            } else if (fileLength == 0) {
                var $file = $("#uploadFile").find('#file');
                console.log("$file", $file);
                var $items = $file.val();
                console.log("$items", $items);
                fileName = $items;
            }
            var fragment = "";
            var fileName = fileName.substring(fileName.lastIndexOf('\\') + 1, fileName.length);
            fragment += "<tr><td class='dsm-td' style=\'width:60%;\'>" + fileName + "</td><td style=\'padding-left: 20px\'></td>" + "</tr>";
            $("#tableList").append(fragment);
        });


        $(document).on("click", ".js_button", function () {
            //console.log($(this).text());
            if ($(this).text() === "保存") {
                $("input[name=submitType][type=hidden]").val("0");
            }
            if ($(this).text() === "提交") {
                $("input[name=submitType][type=hidden]").val("1");
            }
            var $processName = $("#programSerForm").find("input[name=processName]").val();
            if ($processName == undefined || $processName == "") {
                $(".syserror").html("流程名必填");
                return false;
            }
            $(".syserror").html("");
            var validateResult = beforeValidateSubmit();
            if (!validateResult) {
                return false;
            }
            var fileLength = $('#tableList').find("tr").length;
            if (fileLength == 0) {
                dsmDialog.msg("请上传文件");
                return;
            }
            $("#programSerForm").submit();
        })
    });

    function upload() {

        var fileLength = $('#tableList').find("tr").length;
        if (fileLength == 1) {
            dsmDialog.msg("上传文件数已达上限");
            return;
        }
        $('input[name=oldSrcFile][type=hidden]').val("");
        var uploadFileHtml;
        if (fileLength == 0) {
            uploadFileHtml = "<div class=\"dsm-upload-button f-l m-r-f10\" style=\"display: none\">\n" +
                "<input type=\"file\" id=\"file\" name=\"file\"\n" +
                " class=\"dsm-upload-file js_file\"\n" +
                " data-fileid=\"fileInfo\">\n" +
                "<span class=\"fbtname\">新增文件</span>" +
                "</div>";
            $("#uploadFile").append(uploadFileHtml);
            $('#file').click();
        }
    }


    function removeDom(obj) {
        var readyDeleteFile = $(obj).parent("td").parent("tr").find('td').eq(0).text();
        console.log("delete", readyDeleteFile);
        var oldSrcUrl = readyDeleteFile + ",";
        $(obj).parent().parent().remove();
        $('input[name=oldSrcFile][type=hidden]').val(oldSrcUrl);
        $("#uploadFile").find("input[name=file]").map(function () {
            var filePath = $(this).val();
            var fileName = filePath.substring(filePath.lastIndexOf('\\') + 1, filePath.length);
            if (fileName == readyDeleteFile) {
                console.log("删除input file");
                $(this).parent().remove();
            }
        });
    }


    function removeAll() {
        var oldSrcUrl = "";
        $('#tableList').find("tr").map(function () {
            var readyDeleteFile = $(this).find("td").eq(0).text();
            console.log("delete", readyDeleteFile);
            oldSrcUrl += readyDeleteFile + ",";
            $(this).remove();
        })
        $('input[name=oldSrcFile][type=hidden]').val(oldSrcUrl);
        $("#uploadFile").find("input[name=file]").map(function () {
            $(this).parent().remove();
        });
    }

    function beforeValidateSubmit() {
        var isRepeat = $("#programSerForm").find("input[name=isRepeat]").val();
        if (isRepeat == "false") {
            dsmDialog.msg("工作流名称已重复，请重新填写");
            return false;
        }
        return true;
    }

    function validateRepeat() {
        $(".syserror").html();
        var $processName = $("#programSerForm").find("input[name=processName]").val();
        console.log($processName);
        $.ajax({
            url: '${base}/admin/task/findTaskByName.jhtml?processName=' + encodeURI(encodeURI($processName)),
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf8',
            success: function (data) {
                if (data.id != null) {
                    $(".syserror").html("工作流名称重复");
                    $("#programSerForm").find("input[name=isRepeat]").val("false");
                } else {
                    $(".syserror").html("");
                    $("#programSerForm").find("input[name=isRepeat]").val("true");
                }
            }
        })

    }
</script>
</body>
</html>

