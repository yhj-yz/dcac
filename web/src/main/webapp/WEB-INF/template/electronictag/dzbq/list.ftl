<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>电子标签列表</title>

    [#include "/dsm/include/head.ftl"]
    <script src="${base}/resources/dsm/js/My97DatePicker/WdatePicker.js"></script>
    <style>
        .highlight {
            background-color: yellow
        }

        #eTagDetail .table-view {
            height: 0;
        }


    </style>
    <!--全局通用!-->
    [#--<link rel="stylesheet" type="text/css" href="css/bootstrap.css">--]
    [#--<link rel="stylesheet" type="text/css" href="css/global.css">--]
    [#--<script src="js/jquery.js"></script>--]
    [#--<script src="js/bootstrap.js"></script>--]
    <!--全局通用end!-->

    <script type="text/javascript" src="${base}/resources/dsm/js/highlight.js"></script>
    <link href="${base}/resources/dsm/css/zTreeStyle.css" rel="stylesheet"/>
    <script type="text/javascript" src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
    <script type="text/javascript" src="${base}/resources/dsm/js/ztree.helper.js"></script>
    <script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
    <script type="text/javascript" src="${base}/resources/dsm/js/Chart.js"></script>
    <script type="text/javascript" src="${base}/resources/dsm/js/charthelper.js"></script>


</head>
<body>
<div class="dsm-rightsidedzbq">
    <div class="maincontent">
        [#assign searchMap='{
            "filePath":"文件路径"
			,"createAccount":"创建者"
			,"creatortime-Wdate":"创建时间"
			,"classlevel":"密级"          
			}' /]
        [#assign form="terminalsearch_form"]
        [#include "/dsm/include/search.ftl"]
        <div id="tabled">
            <div class="table-view">
                <form id="list_form">
                    <table id="datalist" class="table" cellspacing="0" width="100%">
                        <thead>
                        <tr>
                            <th class="w40">
                                <div class="dsmcheckbox">
                                    <input type="checkbox" value="1" id="checkboxFiveInput"
                                           class="js_checkboxAll" data-allcheckfor="ids">
                                    <label for="checkboxFiveInput"></label>
                                </div>
                            </th>
                            <th>文件名称</th>
                            <th>创建者</th>
                            <th>创建时间</th>
                            <th>密级</th>
                            <th>标签信息</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </form>
                <form id="terminalsearch_form" action="${base}/admin/dzbq/search.jhtml"
                      data-func-name="refreshTerTable();" data-list-formid="datalist">
                </form>
            </div>
            <div>
            </div>

        </div>


        <div id="eTagDetail" class="" style="padding:10px; display: none">
            <div class="dsm-nav-tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="active">
                        <a href="#tabone" data-toggle="tab" aria-expanded="true">基本信息</a></li>
                    <li class="">
                        <a href="#tabtwo" data-toggle="tab" aria-expanded="false">控制信息</a>
                    </li>
                    <li class="">
                        <a href="#tabthree" data-toggle="tab" aria-expanded="false">流转信息</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade active in" id="tabone">
                        <div class="dsmForms detailForm">
                            <div class="dsm-form-item">
                                <div class="dsm-inline">
                                    <label class="dsm-form-label">创建者：</label>
                                    <div class="dsm-input-inline">
                                        <label class="dsm-r-con"><span id="createUserName"></span> </label>
                                    </div>
                                </div>
                                <div class="dsm-inline ">
                                    <label class="dsm-form-label">创建时间：</label>
                                    <div class="dsm-input-inline">
                                        <label class="dsm-r-con"> <span id="createDate"></span></label>
                                    </div>
                                </div>
                                <div class="dsm-inline ">
                                    <label class="dsm-form-label">文件ID：</label>
                                    <div class="dsm-input-inline" style="width: 280px;">
                                        <label class="dsm-r-con"><span id="newFileId"></span></label>
                                    </div>
                                </div>
                                <div class="dsm-inline ">
                                    <label class="dsm-form-label">涉密终端编码：</label>
                                    <div class="dsm-input-inline">
                                        <label class="dsm-r-con">
                                            <span id="terminalId"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade " id="tabtwo">
                        <div class="dsmForms detailForm">
                            <div class="dsm-form-item ">
                                <div class="dsm-inline">
                                    <ul class="checkboxlist popchklist ">
                                        <li class="clearfix">
                                            <div class="dsmcheckbox ">
                                                <input type="checkbox" id="p1" data-name="permission.userAuthority"
                                                       value="1" onclick="return false;">
                                                <label for="p1"></label>
                                            </div>
                                            <label for="p1">允许打印</label>
                                        </li>
                                        <li class="clearfix">
                                            <div class="dsmcheckbox ">
                                                <input type="checkbox" id="p4" data-name="permission.userAuthority"
                                                       value="2" onclick="return false;">
                                                <label for="p4"></label>
                                            </div>
                                            <label for="p4">允许复制</label>
                                        </li>
                                        <li class="clearfix">
                                            <div class="dsmcheckbox ">
                                                <input type="checkbox" id="p2" data-name="permission.userAuthority"
                                                       value="4" onclick="return false;">
                                                <label for="p2"></label>
                                            </div>
                                            <label for="p2">允许修改</label>
                                        </li>
                                        <li class="clearfix">
                                            <div class="dsmcheckbox ">
                                                <input type="checkbox" id="p5" data-name="permission.userAuthority"
                                                       value="8" onclick="return false;">
                                                <label for="p5"></label>
                                            </div>
                                            <label for="p5">允许外发</label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="tabthree">
                        <div class="dsm-inline ">
                            <label class="dsm-form-label">流转次数：</label>
                            <div class="dsm-input-inline">
                                <label class="dsm-r-con">
                                    <span class="circulationCount"></span>
                                </label>
                            </div>
                        </div>
                        <div class="table-view">
                            <table id="datalist" class="table" cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th>操作人</th>
                                    <th>涉密终端编码</th>
                                    <th class="w180">操作时间</th>
                                    <th>操作类型</th>
                                </tr>
                                </thead>
                                <tbody class="circulation-tbody">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script src="${base}/resources/dsm/js/dsm-search.js"></script>
        <script type="text/javascript">


            function getFilelevel(level) {
                switch (level) {
                    case ("1"):
                        return "绝密";
                        break;
                    case ("2"):
                        return "机密";
                        break;
                    case ("3"):
                        return "秘密";
                        break;
                    case ("4"):
                        return "内部";
                        break;
                    case ("5"):
                        return "公开";
                        break;
                    default:
                        return "未定义";
                        break;
                }

            }

            $(document).ready(function () {
                refreshTerTable();
            });

            //刷新列表
            function refreshTerTable() {
                clearCheckbox("datalist");
                refreshPageList({
                    id: "terminalsearch_form",
                    asyncSuccess: function () {
                        $("[data-toggle='popover']").popover();
                    },
                    dataFormat: function (data) {
                        var _id = data.id;
                        var text = "<tr>" +
                            "<td><div class='dsmcheckbox'> <input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>" +
                            "<td class='hiddentd' title='" + (data.file_path == null ? "" : data.file_path) + "'><div class='hiddendiv'>" + (data.file_path == null ? "" : data.file_path) + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv'>" + (data.createAccount == null ? "" : data.createAccount) + "</div></td>" +
                            "<td>" + (data.createDate == null ? "" : parseDate(data.creatortime)) + "</td>" +
                            "<td class='hiddentd'><div class='hiddendiv'>" + (data.classlevel == null ? "无" : initmLevel(data.classlevel)) + "</td>" +
                            "<td>" + "<a  href='#' class='checkInfo' data-id='" + data.id + "'>" + "详细" + "</a>" + "</td>" +
                            "</tr>";
                        return text;

                    }
                });

                $('[data-toggle="popover"]').popover();
            }


            $(document).on('click', '.checkInfo', function (e) {

                var frm = $('#eTagDetail ');
                var id = $(this).data("id");
                $.ajax({
                    type: "get",
                    url: "${base}/admin/dzbq/checkMore.jhtml?id=" + id,
                    dataType: "json",
                    success: function (data) {
                        console.log(data);
                        var circulationList = data.traninfoEntities;
                        var nameStr = "";
                        //遍历流转记录集合
                        frm.find(".circulation-tbody").empty();
                        $(circulationList).each(function (index, content) {
                            frm.find(".circulation-tbody").append("<tr> " + "<td>" + circulationList[index].openuser + "</td>" +
                                "<td>" + circulationList[index].termcode + "</td>" +
                                "<td>" + parseDate(circulationList[index].opetime) + "</td>" +
                                "<td>" + (circulationList[index].opetype == 0 ? '导入' : '导出') + "</td>" + "</tr>")
                        });
                        var authInfo = data.operate_policy;
                        $(".clearfix :checkbox").each(function (index, content) {
                            $(this).prop("checked", (parseInt(authInfo) & this.value) !== 0);
                        });

                        frm.find("#createUserName").html(data.createAccount == null ? "" : data.createAccount);
                        frm.find("#createDate").html(parseDate(data.creatortime == null ? "" : data.creatortime));
                        frm.find("#newFileId").html(data.fileid == null ? "" : data.fileid);
                        frm.find("#terminalId").html(data.termcode == null ? "" : data.termcode);
                        frm.find(".circulationCount").text(circulationList.length == null ? "0" : circulationList.length);
                    }
                });
                dsmDialog.open({
                    type: 1,
                    area: ['600px', '560px'],
                    btn: ['确定'],
                    title: "详情",
                    content: $("#eTagDetail"),
                    yes: function (index, layero) {
                        dsmDialog.close(index);
                    }

                });

            });

            $(document).on('click', '.js_del', function (e) {
                if (noItemSelected()) {//如果用户没有勾选
                    return;
                }
                ;
                dsmDialog.toComfirm("是否执行删除操作？", {
                    btn: ['确定', '取消'],
                    title: "删除电子标签"
                }, function (index) {
                    var $frm = $("#list_form");
                    $.ajax({
                        dataType: "json",
                        type: "post",
                        url: "deleteTag.jhtml",
                        data: $frm.serialize(),
                        success: function (data) {

                            // 提示
                            if (data && data.type === "success") {
                                dsmDialog.msg(data.content);
                                refreshTerTable();
                            } else {
                                dsmDialog.error(data.content);
                            }
                        }
                    });
                }, function (index) {
                    dsmDialog.close(index);
                });

            });

            function noItemSelected() {
                var ids_ = $("#list_form :checked[name='ids']");
                if (ids_.length === 0) {
                    dsmDialog.error("请先选择电子标签!")
                    return true;
                } else {
                    return false;
                }
            }
        </script>
</body>
</html>