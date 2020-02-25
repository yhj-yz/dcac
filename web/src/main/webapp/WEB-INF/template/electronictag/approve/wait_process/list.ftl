[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>待办事宜</title>
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
                <div class="dsm-searchbar">
                    <div class="filter" id="search">
                        <div id="ffileName" class="simulate-list ks-overlay ks-overlay-hidden">
                            <div class="ks-popup-content">
                                <input data-selected-desc="申请人:" data-request="applyUser" class="fiterpara" type="text"
                                       value="">
                                <button class="subfiter" type="button">确定</button>
                            </div>
                        </div>
                        <div id="fcreateDate" class="simulate-list ks-overlay ks-overlay-hidden">
                            <div class="ks-popup-content">
                                <input class="Wdate fiterpara" type="text" data-selected-desc="申请时间:" readonly
                                       data-request="applyTime" value="" onclick="WdatePicker()">
                                <button class="subfiter" type="button">确定</button>
                            </div>
                        </div>
                        <div id="fcreateUserAccount" class="simulate-list ks-overlay ks-overlay-hidden">
                            <div class="ks-popup-content">
                                <input data-selected-desc="流程名称:" data-request="processName" class="fiterpara"
                                       type="text" value="">
                                <button class="subfiter" type="button">确定</button>
                            </div>
                        </div>
                        <div class="clearfix">
                            <dl>
                                <dt>筛选条件：</dt>
                                <dd><span class="simulate-select" data-sim-obj="ffileName" data-sim-z="applyUser"><span
                                        class="J_simulate_value">申请人</span><em></em></span></dd>
                                <dd><span class="simulate-select" data-sim-obj="fcreateUserAccount"
                                          data-sim-z="processName"><span
                                        class="J_simulate_value">流程名称</span><em></em></span></dd>
                                <dd><span class="simulate-select" data-sim-obj="fcreateDate"
                                          data-sim-z="applyTime"><span
                                        class="J_simulate_value">申请时间</span><em></em></span></dd>
                            </dl>
                        </div>
                        <dl class="clearfix filter-selected-list" data-searchform="search_form">
                            <dt>已选条件：</dt>
                            <button type="button" class="btn btn-primary f-r whitebg js_clearall">清除筛选条件</button>
                        </dl>
                    </div>
                </div>
                <div class="btn-toolbar">
                    <div class="btnitem imp" style="margin-left: 0px;">
                        <a class="btn btn-primary js_approve"><i
                                class="btnicon icon icon-add-white"></i>审批</a>
                    </div>
[#--                    <div class="btnitem imp" style="margin-left: 15px;">--]
[#--                        <a class="btn btn-primary js_approve_count"><i class="btnicon icon icon-approves-white"></i>批量审批</a>--]
[#--                    </div>--]
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
                                <th>申请人</th>
                                <th>申请原因</th>
                                <th>申请时间</th>
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
</div>
<div id="addDeptForm" style="display: none">

</div>

<div id="approveTasksForm" style="display: none">
    <form>
        <input name="id" type="hidden" value="">
        <div class="dsmForms">
            <div class="dsm-form-item">
                <div class="dsm-inline">
                    <label class="dsm-form-label">审批结果: </label>
                    <div class="dsm-input-inline dsm-tarea">
                        <label class="danxuankuang_box selected">
                            <input name="approveState" class="danxuankuang js_receviceTypera" type="radio" value="0"
                                   checked><i>同意</i>
                        </label>
                        <label class="danxuankuang_box">
                            <input name="approveState" class="danxuankuang js_receviceTypera" type="radio" value="1"><i>不同意</i>
                        </label>
                    </div>
                    <div class="dsm-inline">
                        <label class="dsm-form-label">审批意见:</label>
                        <div class="dsm-input-inline dsm-tarea">
                            <textarea name=applyReason" cols="10" rows="2" + class="dsm-input dsm-textarea"
                                      id="description"></textarea>
                            <span class="txt-limit">（限2048个字）</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>


<script src="${base}/resources/dsm/js/dsm-search.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        showCircultionAddress();
        //.dsm-searchbar有显示问题
        $('.dsm-searchbar').attr('style', 'position:unset;margin-bottom: 15px;');
    });


    $(document).on('click', '.js_approve', function () {
        var $checked = $("#list_form").find("input[name=id]:checked");
        if ($checked.length == 0) {
            dsmDialog.msg("请选择流程后,选择审批");
            return;
        }
        if ($checked.length > 1) {
            dsmDialog.msg("所选流程过多，该功能只支持勾选单个流程");
            return;
        }
        var id = $checked.val();
        $.ajax({
            url: '${base}/affairs_be_dealt_with/find/' + id + '.do',
            type: 'get',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                var htmlApprove = "<div class=\"dsm-inline\">\n" +
                        "<label class=\"dsm-form-label\">申请人：</label>\n" +
                        "<span>" + data.createUserAccount + "</span></div>" +
                        "<div class=\"dsm-inline\">\n" +
                        "        <label class=\"dsm-form-label\">申请时间：</label>\n" +
                        "        <span>" + data.createDateTime + "</span>\n" +
                        "    </div>\n" +
                        "    <div class=\"dsm-inline\">\n" +
                        "        <label class=\"dsm-form-label\">申请原因:</label>\n" +
                        "        <span>" + data.applyReason + "</span>\n" +
                        "    </div>\n";
                if (data.uploadFilePath != "") {
                    htmlApprove += "<img id=\"imgDownload\" src=\"${base}/resources/dsm/images/icon-dbluedown.png\" style=\"width:15px;height:15px\" onclick=\"showSrcFileUrlDiv();\"/>";
                } else {
                    htmlApprove += "<img id=\"imgDownload\" src=\"${base}/resources/dsm/images/icon-dblueup.png\" style=\"width:15px;height:15px\" onclick=\"showSrcFileUrlDiv();\"/>";
                }
                htmlApprove += "&nbsp;&nbsp;&nbsp;\n" +
                        "        <div class=\"dsm-upload-button\">\n" +
                        "            <span class=\"fbtname\" onclick='downloadAll();'>全部下载</span>\n" +
                        "        </div>\n" +
                        "    </div>\n" +
                        "<div class=\"dsm-inline\">\n" +
                        "                                <div class=\"dsm-inline\">\n" +
                        "                                    <table id=\"tableList\" cellpadding=\"5\" cellspacing=\"5\"\n" +
                        "                                           style=\"margin-left: 110px\"></table>\n" +
                        "                                </div>\n" +
                        "                            </div>" +
                        "    <div class=\"dsm-inline\">\n" +
                        "        <label class=\"dsm-form-label\">审批工作流:</label>\n" +
                        "        <span>" + data.workFlow.flowName + "</span>\n" +
                        "    </div>\n" +
                        "    <div class=\"dsm-inline\">\n" +
                        "        <img src=\"${base}/resources/dsm/images/approve.png\" class=\"btnicon icon icon-approve\">\n" +
                        "        <span>审批信息</span>\n" +
                        "    </div>\n" +
                        "    <hr>\n" +
                        "    <form>\n" +
                        "        <input name=\"id\" type=\"hidden\" value=" + data.id + ">\n" +
                        "        <input name=\"srcFileUrls\" type=\"hidden\" value='" + data.uploadFilePath + "'>\n" +
                        "        <input name=\"applyUser\" type=\"hidden\" value=" + data.createUserAccount + ">\n" +
                        "        <div class=\"dsmForms\">\n" +
                        "            <div class=\"dsm-form-item\">\n" +
                        "                <div class=\"dsm-inline\">\n" +
                        "                    <label class=\"dsm-form-label\">审批结果: </label>\n" +
                        "                    <div class=\"dsm-input-inline dsm-tarea \">\n" +
                        "                        <label class=\"danxuankuang_box selected\">\n" +
                        "                            <input name=\"approveState\" class=\"danxuankuang js_receviceTypera\" type=\"radio\"\n" +
                        "                                   value=\"0\" checked><i>同意</i>\n" +
                        "                        </label>\n" +
                        "                        <label class=\"danxuankuang_box \">\n" +
                        "                            <input name=\"approveState\" class=\"danxuankuang js_receviceTypera\" type=\"radio\"\n" +
                        "                                   value=\"1\"><i>不同意</i>\n" +
                        "                        </label>\n" +
                        "                    </div>\n" +
                        "                    <div class=\"dsm-inline\">\n" +
                        "                        <label class=\"dsm-form-label\">审批意见:</label>\n" +
                        "                        <div class=\"dsm-input-inline dsm-tarea \">\n" +
                        "                            <textarea name=\"advice\" cols=\"10\" rows=\"2\"\n" +
                        "                                      class=\"dsm-input dsm-textarea\" id=\"description\"></textarea>\n" +
                        "                            <span class=\"txt-limit\">（限2048个字）</span>\n" +
                        "                        </div>\n" +
                        "                    </div>\n" +
                        "                </div>\n" +
                        "            </div>\n" +
                        "        </div>\n" +
                        "    </form>";
                $("#addDeptForm").html(htmlApprove);
                var fragment;
                var srcFileUrls = data.uploadFilePath.split(";");
                if (srcFileUrls.length > 0) {
                    for (var i = 0; i < srcFileUrls.length; i++) {
                        var fileName = srcFileUrls[i]; // get file name
                        fragment += "<tr><td class='dsm-td'>" + fileName + "</td><td><span class=\"fbtname\" onclick=\'download($(this))\'>下载</span></td>" + "</tr>";
                    }
                    $("#tableList").append(fragment);
                }
                var strVal = document.getElementsByClassName("dsm-input dsm-textarea").innerHTML;
                console.log("str", strVal);
                var frm = $('#addDeptForm form');
                frm.find(".dsm-input").removeData("previousValue").removeClass("error").next("label").remove();
                frm.attr("action", "${base}/affairs_be_dealt_with/approve.do")[0].reset();
                dsmDialog.open({
                    type: 1,
                    area: ['630px', '600px'],
                    btn: ['确定', '取消'],
                    title: "流程详情",
                    content: $('#addDeptForm'),
                    yes: function (index1, layero) {
                        dsmDialog.toComfirm("审批大文件时可能需要较长时间,待审批成功后刷新即可!", {
                            btn: ['确定','取消'],
                            title:"文件审批"
                        }, function(index) {
                            if (frm.valid()) {
                                submitForm({
                                    frm: frm, success: function () {
                                        dsmDialog.close(index1);
                                        refreshUserPageList();
                                    }
                                });
                            }
                        },function (index) {
                            dsmDialog.close(index);
                        })
                    }
                });
            }
        });
    });


    $(document).on('click', '.js_approve_count', function () {
        if (noItemSelected()) {//如果用户没有勾选
            return;
        }
        ;
        var ids = "";
        $("#list_form").find("input[name=id]:checked").map(function () {
            console.log($(this).val())
            ids += $(this).val() + ",";
        });

        var strVal = document.getElementsByClassName("dsm-input dsm-textarea").innerHTML;
        console.log("str", strVal);
        var frm = $('#approveTasksForm form');
        frm.find(".dsm-input").removeData("previousValue").removeClass("error").next("label").remove();
        frm.attr("action", "${base}/affairs_be_dealt_with/approve.do")[0].reset();
        frm.find("input[name=id][type=hidden]").val(ids);
        dsmDialog.open({
            type: 1,
            area: ['630px', '600px'],
            btn: ['确定', '取消'],
            title: "批量审批",
            content: $('#approveTasksForm'),
            yes: function (index, layero) {
                if (frm.valid()) {
                    submitForm({
                        frm: frm, success: function () {
                            dsmDialog.close(index);
                            refreshUserPageList();
                        }
                    });
                }
            }
        });


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
        $("#search_form").attr("action", "${base}/affairs_be_dealt_with/search.do");
        refreshUserPageList();
    }

    function refreshUserPageList() {
        var index =1;
        refreshPageList({
            id: "search_form",
            pageSize: 10,
            dataFormat: function (_data) {
                console.log(_data);
                var _id = _data.id;
                // var _result = function (v) {
                //     return v === true ? "是" : "否";
                // }
                var _text = "<tr>" +
                        "<td><div class='dsmcheckbox'>" +
                        "<input type='checkbox' name='id' id='m_" + _id + "' value='" + _id + "'/></div></td>" +
                        "<td><label for='m_\" + _id + \"'>" + _id + "</label></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.processName + "'>" + _data.processName + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.workFlow.createUserAccount + "'>" + _data.workFlow.createUserAccount + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.applyReason + "'>" + _data.applyReason + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.workFlow.createDateTime + "'>" + _data.workFlow.createDateTime + "</div></td>" +
                        "</tr>";
                index++;
                return _text;
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
            dsmDialog.error("请先选择流程!");
            return true;
        } else {
            return false;
        }
    }

    //检查是否勾选
    function oneItemSelected() {
        var ids_ = $("#list_form :checked[name='ids']");
        if (ids_.length === 1) {
            return true;
        } else if (ids_.length === 0) {
            dsmDialog.error("请先选择用户!")
            return false;
        } else {
            dsmDialog.error("所选用户过多，该功能只支持勾选单个用户")
            return false;
        }
    }

    function removeDom(obj) {
        $(obj).parent().parent().remove();
        var trs1 = $(obj).parent().parent().parent().find("tr");
        if (trs1.length < 2) {
            $("input[name=file]").attr("disabled", "");
        }
    }

    function removeAll() {
        $('#tableList').find("tr").map(function () {
            $(this).remove();
        })
    }

    function downloadAll() {
        var $trs = $("#tableList").find("tr");
        $trs.map(function () {
            var fileName = $(this).find("td").eq(0).text();
            console.log(fileName);
            var url = "${base}/admin/task/download.jhtml?file=" + encodeURIComponent(fileName);
            console.log(url);
            downloadFile(url);
        })
    }

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


    function showSrcFileUrlDiv() {
        var srcVal = $('#imgDownload').attr('src');
        console.log(srcVal);
        if (srcVal != "/DZBQ/resources/dsm/images/icon-dbluedown.png") {
            $('#imgDownload').attr('src', "${base}/resources/dsm/images/icon-dbluedown.png");
            $('#tableList').hide();
        } else {
            $('#imgDownload').attr('src', "${base}/resources/dsm/images/icon-dblueup.png");
            $('#tableList').show();
        }
    }

    function download(obj) {
        var html = $(obj).parent().parent("tr").find("td").eq(0).text();
        console.log(html);
        var url = 'download.jhtml?file=' + encodeURIComponent(html);
        location.href = url;
    }

    // $(".subfiter1").click(function () {
    //     var frmId = $(".filter-selected-list").data("searchform");
    //
    //     var objs = $(this).parent().find(".fiterpara");
    //
    //     if ($(objs[0]).hasClass("Wdate")) {
    //         var paradesc = objs[0].attributes["data-selected-desc"].nodeValue;
    //         var request = objs[0].attributes["data-request"].nodeValue.replace(/_/, ".");
    //         var paraval = objs[0].value;
    //         if (paraval == "") {
    //             paraval = '1990-01-01'
    //         }
    //         if ($("#" + frmId + " input[name='" + request + "'][value='" + paraval + "'][type='hidden']").length == 0) {
    //             $(".filter-selected-list").append('<dd><span class="filter-selected" data-value="paraval" data-para="' + request + '">' + paradesc + '<span class="fiter-value">' + paraval + '</span><em class="remove J_remove"></em></span></dd>')
    //             $("#" + frmId).append('<input type="hidden" class="dsmsearch-para"  name="' + request + '" value="' + paraval + '" />');
    //         }
    //     }
    //     $(".simulate-select").removeClass("simulate-select-hover");
    //     $(".simulate-list").addClass("ks-overlay-hidden");
    //     $(".J_remove").click(function () {
    //         removeFiter(this);
    //     });
    //     filter();
    //
    // });
</script>
</body>
</html>