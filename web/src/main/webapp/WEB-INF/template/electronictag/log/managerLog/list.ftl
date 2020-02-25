<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html class="app">
<head>
    [#include "/include/head.ftl"]

    <link rel="stylesheet" type="text/css" href="${base}/resources/dsm/css/zTreeStyle.css">
    <script src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
    <script src="${base}/resources/dsm/js/My97DatePicker/WdatePicker.js"></script>
    <script src="${base}/resources/dsm/js/page.js"></script>
    <script src="${base}/resources/dsm/js/fileupload/js/vendor/jquery.ui.widget.js"></script>
    <script src="${base}/resources/dsm/js/fileupload/js/fileupload.js"></script>
    <title>管理日志</title>
</head>

<body>
<div class="dsm-rightside">
    <div class="maincontent">
        <div class="mainbox">
            <div class="main-right" style="left: 0;">
                [#assign searchMap='{
                	"userAccount":"账号",
                	"userName":"姓名",
                	"ip":"IP地址",
                	"operateTime-Wdate":"操作时间",
                	"operationModel":"操作模块",
                	"operationType":"操作类型",
                	"operationContent":"操作内容"            
					}' /]
                [#assign form="logsearch_form"]
                [#include "/include/search.ftl"]

                <div id="deletebtn">
                    <div class="btn-toolbar">
                        <div class="btnitem imp" style="margin-left: 0px;">
                            <button type="button" class="btn btn-primary whitebg js_orderby">时间顺序排序</button>
                        </div>
                        <div class="btnitem imp" style="margin-left: 15px;">
                            <button type="button" class="btn btn-primary whitebg js_imp" isLoading="${isLogImport}"><i
                                        class="btnicon icon icon-import-blue"></i>导入
                            </button>
                        </div>
                        <div class="btnitem imp" style="margin-left: 15px;">
                            <button type="button" class="btn btn-primary whitebg dropdown-toggle-log"
                                    data-toggle="dropdown"><i class="btnicon icon icon-export-blue"></i>导出
                            </button>
                            <ul class="dropdown-menu" style="left:190px;">
                                <li><a href="#" class="js_exp_all_xml">导出到Xml文件</a></li>
                                <li><a href="#" class="js_exp_all_xls">导出到Excel文件</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="managerlog-position">
                    <div class="table-view">
                        <form id="loglistform">
                            <table id="datalist" class="table" cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th class="w40">
                                        <div class="dsmcheckbox">
                                            <input type="checkbox" value="1" id="lcjk" class="js_checkboxAll"
                                                   data-allcheckfor="ids" name="">
                                            <label for="lcjk"></label>
                                        </div>
                                    </th>
                                    <th>账号姓名</th>
                                    <th class="w180">IP地址</th>
                                    <th class="w180">操作时间</th>
                                    <th class="w180">操作模块</th>
                                    <th>操作类型</th>
                                    <th>操作内容</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </form>
                        <form id="logsearch_form" action="${base}/admin/managerLog/search.do"
                              data-func-name="refreshlogTable();" data-list-formid="datalist">
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
[#include "/log/fileimport.ftl"]
<script src="${base}/resources/dsm/js/dsm-search.js"></script>
<script>

    var departmentId = 0;

    //刷新用户分页列表
    function refreshlogTable() {
        refreshPageList({
            id: "logsearch_form",
            dataFormat: function (data) {
                var operateTime = "";
                if(data.operateTime != null){
                    operateTime = parseDate(data.operateTime);
                }

                var _id = data.id;
                var dataContent = data.operationContent == null ? "" : data.operationContent;
                var dataOperateType = data.operationType == null ? "" : data.operationType;
                var uName = (data.userAccount == null ? "" : data.userAccount) + "[" + (data.userName == null ? "" : data.userName);
                var text = "<tr>" +
                    "<td><div class='dsmcheckbox logList'><input type='checkbox' value='" + _id + "' id='m1_" + _id + "' name='ids'><label for='m1_" + _id + "'></label></div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + uName + "]'>" + uName + "]</td>" +
                    "<td>" + (data.ip == null ? "" : data.ip) + "</td>" +
                    "<td>" + operateTime + "</td>" +
                    "<td>" + (data.operationModel == null ? "" : data.operationModel) + "</td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + dataOperateType + "'>" + dataOperateType + "</td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + dataContent + "'>" + dataContent + "</td>" +
                    "</tr>";
                return text;

            }
        });
    }

    //判断终端设备复选框是否选中
    function isChecked() {
        if ($("input[name='ids']").is(":checked")) {
            return false;
        } else {
            dsmDialog.error("请选择日志");
            return true;
        }
    }


    $(document).ready(function () {

        refreshlogTable();

    });

    var fileupload_checkurl = '${base}/admin/managerLog/import_manager_log_check.do';
    var fileupload_url = '${base}/admin/managerLog/import_manager_log.do';

    //导出全部xls
    $(document).on('click', '.js_exp_all_xls', function (e) {
        var v = 0;
        var v = itemChecked2();
        if (v == 0) {
            dsmDialog.error('列表无日志信息!');
        } else {
            $frm = $("#logsearch_form");
            var datapara = $frm.serialize();
            window.open("${base}/admin/managerLog/exportlogAll.do?" + datapara);
        }
    });

    //导出全部xml
    $(document).on('click', '.js_exp_all_xml', function (e) {
        var v = 0;
        var v = itemChecked2();
        if (v == 0) {
            dsmDialog.error('列表无日志信息!');
        } else {
            $frm = $("#logsearch_form");
            var datapara = $frm.serialize();
            window.open("${base}/admin/managerLog/exportlogAllAsXml.do?" + datapara);
        }
    });
    $(document).on('click', '.js_orderby', function (e) {
        $("#logsearch_form").attr("action", "${base}/admin/managerLog/search.do?orderby=asc");
        refreshlogTable();

    });

    //删除日志
    $(document).on('click', '.js_del', function (e) {
        if (isChecked()) {
            return;
        }
        dsmDialog.toComfirm("是否删除选中日志？", {
            btn: ['确定', '取消'],
            title: "删除日志"
        }, function (index) {

            dsmDialog.close(index);
            if (isChecked()) {
                return;
            }
            var $frm = $("#loglistform");
            $.ajax({
                data: $frm.serialize(),
                dataType: "json",
                type: "post",
                url: "${base}/admin/managerLog/deleteLog.do",
                success: function (data) {
                    if (data.type = "success") {
                        refreshlogTable();
                    } else {
                        dsmDialog.error(data.content);
                    }
                }
            })

        }, function (index) {
            dsmDialog.close(index);
        });

    });

    //判断是否有日志选中
    function itemChecked() {
        //声明一个数组用于接收选中流程数
        var i = 0;
        $(".logList").find(":checkbox").each(function () {
            if ($(this).is(":checked")) {
                i = i + 1;
            }
        })
        return i;
    }

    //判断是否有日志
    function itemChecked2() {
        var i = 0;
        $(".logList").find(":checkbox").each(function () {
            i = i + 1;
        })
        return i;
    }

</script>
</body>
</html>
