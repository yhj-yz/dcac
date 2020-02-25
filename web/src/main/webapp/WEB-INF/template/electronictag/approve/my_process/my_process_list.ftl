[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>我的流程</title>
    [#include "/include/head.ftl"]
    <!--时间选择器-->
    <script src="${base}/resources/dsm/js/My97DatePicker/WdatePicker.js"></script>
    <!--按页码查询-->
    <script src="${base}/resources/dsm/js/page.js"></script>
    <style>

    </style>
</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">
        <div class="mainbox">
            <div class="main-right" style="left: 0;">
                [#assign searchMap='{
						"approveUser":"审批人",
						"processName":"流程名称"
                    }' /]
                [#assign form="search_form"]
                [#include "/include/search.ftl"]
                <div class="btn-toolbar">
                    <div class="btnitem imp" style="margin-left: 0px;">
                        <a href="${base}/initiation_process/add.do" class="btn btn-primary">
                            <i class="btnicon icon icon-add-white"></i>发起流程</a>
                    </div>
                    <div class="btnitem imp" style="margin-left: 15px;">
                        <a class="btn btn-primary js_down"><i class="btnicon icon icon-approves-white"></i>批量脱壳文件下载</a>
                    </div>
                    <div class="btnitem imp" style="margin-left: 15px;">
                        <a class="btn btn-primary js_delDept"><i class="btnicon icon icon-delete"></i>删除</a>
                    </div>
                </div>
                <div class="table-view">
                    <form id="list_form">
                        <table id="datalist" class="table table-bordered table-hover" cellspacing="0" width="100%">
                            <thead>
                            <tr>
                                <th class="w40">
                                    <div class="dsmcheckbox">
                                        <input type="checkbox" id="maid" class="js_checkboxAll"
                                               data-allcheckfor="id">
                                        <label for="maid"></label>
                                        <input type='hidden' name='fromId'>
                                        <input type='hidden' name='toId'>
                                        <input type='hidden' name='retain'>
                                    </div>
                                </th>
                                <th width="30%">序号</th>
                                <th>流程名称</th>
                                <th>审批人</th>
                                <th>创建者</th>
                                <th>创建时间</th>
                                <th>流程状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </form>
                </div>
                <form id="search_form" data-func-name="refreshUserPageList();" data-list-formid="datalist"
                      style="width: 100%;position: fixed;bottom: 0; background-color: #fff;height: 35px;">
                </form>
            </div>
        </div>
    </div>

    <div id="addDeptForm" style="display: none">
        <form id="addFlow" method="post" enctype="multipart/form-data">
            <input type="file" name="files" value="" style="display: none"/>
            <div class="dsmForms">
                <div class="hid">
                    <input name="oldSrcFile" type="hidden" value="">
                    <input name="id" type="hidden" value="">
                    <input name="applyUser" type="hidden" value="">
                </div>
                <div class="dsm-form-item">
                    <div class="dsm-inline">
                        <label class="dsm-form-label">流程名称：</label>
                        <div class="dsm-input-inline">
                            <input type="text" autocomplete="off" name="processName"
                                   placeholder="请填写工作流名称"
                                   class="dsm-input required specialChar">
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
                        <div class="dsm-upload-button f-l m-r-f10" style="margin-left: 90px;">
                            <span class="fbtname" id="clearButton" onclick="removeAll();">清除文件</span>
                        </div>
                        &nbsp;&nbsp;&nbsp;
                        <label>上传文件数量不超过2个</label>
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
        </form>
    </div>
</div>


<script src="${base}/resources/dsm/js/dsm-search.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        showCircultionAddress();
        //.dsm-searchbar有显示问题
        $('.dsm-searchbar').attr('style', 'position:unset;margin-bottom: 15px;');

        if(getQueryVariable('isExistFile') == '0')
            dsmDialog.error("该文件不是加签文件,请重新上传!")
    });

    function getQueryVariable(variable) { //接收带参的处理
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for(var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if(pair[0] == variable) {
                return decodeURIComponent(pair[1]);
            }
        }
        return('');
    }

    $(document).on('click', '.js_delDept', function (e) {
        if (noItemSelected()) {//如果用户没有勾选
            return;
        }
        ;
        dsmDialog.toComfirm("是否删除选中的流程？", {
            btn: ['确定', '取消'],
            title: "删除流程"
        }, function (index) {
            var $frm = $("#list_form");
            $.ajax({
                dataType: "json",
                type: "post",
                url: "${base}/initiation_process/delete.do",
                data: $frm.serialize(),
                success: function (data) {
                    // 提示
                    showToolTip({data: "删除成功"});
                    refreshUserPageList();
                }
            });
        }, function (index) {
            dsmDialog.close(index);
        });
    });

    $(document).on('click', '.js_down', function () {
        if (noItemSelected()) {//如果用户没有勾选
            return;
        }
        ;
        var $checkDom = $("#list_form").find("input[name=id]:checked");
        if ($checkDom.length < 1) {
            dsmDialog.msg("请选择流程");
            return;
        }
        var ids = new Array();
        $("#list_form").find("input[name=id]:checked").map(function () {
            var state = $(this).parent("div").parent("td").parent("tr").find("td").eq(6).text();
            console.log("state", state);
            if (state != "审批通过") {
                dsmDialog.msg("该审批流程未审批通过");
                return;
            }
            console.log($(this).val());
            ids.push($(this).val());
        });
        for (var i = 0; i < ids.length; i ++) {
            var id = ids[i];
            var destFileUrl = "${base}/initiation_process/downloadFiles.do?id=" + id;
            downloadFile(destFileUrl);
        }
    });

    function downloadFile(url) {
        const iframe = document.createElement("iframe");
        iframe.style.display = "none"; // 防止影响页面
        iframe.style.height = 0; // 防止影响页面
        iframe.src = url;
        document.body.appendChild(iframe); // 这一行必须，iframe挂在到dom树上才会发请求
        setTimeout(() => {
            iframe.remove();
        }, 5 * 1000);
    }

    $(document).on('click', '.js_submit', function (e) {
        var frm = $('#addDeptForm form');
        frm.attr("action","${base}/admin/task/update.jhtml")[0].reset();
        frm.find(".dsm-input").removeData("previousValue").removeClass("error").next("label").remove();
        var $ids_ = $(this).parent("div").parent("td").parent("tr").find("input[name=id]");
        var id = $ids_.val();
        $.ajax({
            url: '${base}/admin/task/findTask/' + id + '.jhtml',
            type: 'get',
            dataType: 'json',
            success: function (data) {
                $('#addDeptForm').find("input[name=id]").val(data.id);
                $('#addDeptForm').find("input[name=applyUser]").val(data.applyUser);
                $('input[name=processName]').val(data.processName);
                $('textarea[name=applyReason]').val(data.applyReason);
                var fragment;
                var srcFileUrls = data.srcFileUrls.split(";");
                if (srcFileUrls.length > 0) {
                    for (var i = 0; i < srcFileUrls.length; i++) {
                        var fileName = srcFileUrls[i]; // get file name
                        fragment += "<tr><td class='dsm-td'>" + fileName + "</td><td><button class=\"fbtname\" onclick=\'removeDom()\'>删除</button></td>" + "</tr>";
                    }
                    $("#tableList").append(fragment);
                }
            }
        });
        dsmDialog.open({
            type: 1,
            area: ['700px', '500px'],
            btn: ['确定', '取消'],
            title: "流程详情",
            content: $('#addDeptForm'),
            yes: function (index, layero) {
                if (frm.valid()) {
                    $("#addFlow").submit();
                    dsmDialog.close(index);
                    refreshUserPageList();
                }
            }
        });
        $("#tableList").html("");
    });

    function showToolTip(v) {
        if (v.data && v.data.type === "success") {
            dsmDialog.msg(v.data.content);
            if (typeof v.success === "function") v.success();
        } else {
            dsmDialog.error(v.data.content);
            if (typeof v.error === "function") v.error();
        }
    }

    function showCircultionAddress() {
        $("#search_form").attr("action", "${base}/initiation_process/search.do");
        refreshUserPageList();
    }

    function statusChe(val) {
        switch (val) {
            case 0 : return "尚未处理";
            break;
            case 1 : return "审批通过";
                break;
            case 2 : return "尚未通过";
                break;
        }
    }

    function refreshUserPageList() {
        var index=1;
        refreshPageList({
            id: "search_form",
            pageSize: 10,
            dataFormat: function (_data) {
                var _id = _data.id;
                var _text3 = "<tr>" +
                        "<td><div class='dsmcheckbox'>" +
                        "<input type='checkbox' name='id' id='m_" + _id + "' value='" + _id + "'/></div></td>" +
                        "<td><label for='m_\" + _id + \"'>" + index + "</label></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.processName + "'>" + _data.processName + "</a>" +
                        "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.workFlow.approveAccount + "'>" + _data.workFlow.approveAccount + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.createUserAccount + "'>" + _data.createUserAccount + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.createDateTime + "'>" + _data.createDateTime + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + statusChe(_data.status) + "'>" + statusChe(_data.status) + "</div></td>" +
                        "</tr>";
                var _text = "<tr>" +
                        "<td><div class='dsmcheckbox'>" +
                        "<input type='checkbox' name='id' id='m_" + _id + "' value='" + _id + "'/></div></td>" +
                        "<td><label for='m_\" + _id + \"'>" + index + "</label></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.processName + "'>" +
                        "<a class=\'js_submit\'>" + _data.processName + "</a>" +
                        "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.workFlow.approveAccount + "'>" + _data.workFlow.approveAccount + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.createUserAccount + "'>" + _data.createUserAccount + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.createDateTime + "'>" + _data.createDateTime + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + statusChe(_data.status) + "'>" + statusChe(_data.status) + "</div></td>" +
                        "</tr>";
                index++;
                if (_data.taskState === "待提交") {
                    return _text;
                }
                return _text3;
            }
        });
    }

    function clearValid(c) {
        var sp = $(c);
        sp.find("input:text").removeClass("error").val("");
        sp.find("label.error").remove();
        sp.find('select.dsm-select').each(function () {
            var ov = $(this).find("option:first").val();
            $(this).selectpicker('val', ov);
            $(this).selectpicker('refresh');
        });
    }

    //检查是否勾选
    function noItemSelected() {
        var ids_ = $("#list_form :checked[name='id']");
        if (ids_.length === 0) {
            dsmDialog.error("请先选择工作流!")
            return true;
        } else {
            return false;
        }
    }

    //检查是否勾选
    function oneItemSelected() {
        var ids_ = $("#list_form :checked[name='id']");
        if (ids_.length === 1) {
            return true;
        } else if (ids_.length === 0) {
            dsmDialog.error("请先选择工作流!")
            return false;
        } else {
            dsmDialog.error("所选工作流过多，该功能只支持勾选单个工作流")
            return false;
        }
    }

    function removeDom(obj) {
        var readyDeleteFile = $(obj).parent("td").parent("tr").find('td').eq(0).text();
        console.log("delete", readyDeleteFile);
        var oldSrcUrl = readyDeleteFile + ",";
        $('input[name=oldSrcFile][type=hidden]').val(oldSrcUrl);
        $(obj).parent().parent().remove();
        var trs1 = $(obj).parent().parent().parent().find("tr");
        // console.log("当前已上传的文件个数", trs1);
        // if (trs1.length < 2) {
        //     $("input[name=file]").attr("disabled", "");
        // }
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
    }

    // function browseFolder(path) {
    //     try {
    //         var Message = "\u8bf7\u9009\u62e9\u6587\u4ef6\u5939"; //选择框提示信息
    //         var Shell = new ActiveXObject("Shell.Application");
    //         var Folder = Shell.BrowseForFolder(0, Message, 64, 17); //起始目录为：我的电脑
    //         //var Folder = Shell.BrowseForFolder(0, Message, 0); //起始目录为：桌面
    //         if (Folder != null) {
    //             Folder = Folder.items(); // 返回 FolderItems 对象
    //             Folder = Folder.item(); // 返回 Folderitem 对象
    //             Folder = Folder.Path; // 返回路径
    //             if (Folder.charAt(Folder.length - 1) != "\\") {
    //                 Folder = Folder + "\\";
    //             }
    //             document.getElementById(path).value = Folder;
    //             return Folder;
    //         }
    //     }
    //     catch (e) {
    //         alert(e.message);
    //     }
    // }

    function upload() {
        var fileLength = $('#tableList').find("tr").length;
        if (fileLength == 2) {
            dsmDialog.msg("上传文件数已达上限");
            return;
        }
        var uploadFileHtml;
        if (fileLength == 0) {
            uploadFileHtml = "<div class=\"dsm-upload-button f-l m-r-f10\" style=\"display: none\">\n" +
                    "<input type=\"file\" id=\"file\" name=\"files\"\n" +
                    " class=\"dsm-upload-file js_file\"\n" +
                    " data-fileid=\"fileInfo\">\n" +
                    "<span class=\"fbtname\">新增文件</span>" +
                    "</div>";
            $("#uploadFile").append(uploadFileHtml);
            $('#file').click();
        } else if (fileLength == 1) {
            uploadFileHtml = "<div class=\"dsm-upload-button f-l m-r-f10\" style=\"display: none\">\n" +
                    "<input type=\"file\" id=\"file1\" name=\"files\"\n" +
                    " class=\"dsm-upload-file js_file\"\n" +
                    " data-fileid=\"fileInfo\">\n" +
                    "<span class=\"fbtname\">新增文件</span>" +
                    "</div>";
            $("#uploadFile").append(uploadFileHtml);
            $('#file1').click();
        }
    }

    $(document).on('change', '.js_file', function (e) {
        var fileLength = $('#tableList').find("tr").length;
        if (fileLength == 2) {
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
        fragment += "<tr><td class='dsm-td' style=\'width:60%;\'>" + fileName + "</td><td style=\'padding-left: 20px\'><button class=\"fbtname\" onclick=\'removeDom($(this))\'>删除</button></td>" + "</tr>";
        $("#tableList").append(fragment);
    });
</script>
</body>
</html>