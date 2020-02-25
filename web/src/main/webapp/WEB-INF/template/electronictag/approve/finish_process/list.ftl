[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="ch" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>已办事宜</title>
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
                    "applyUser":"申请人",
                    "processName":"流程名称",
                    "applyTime-Wdate":"申请时间",
                	"status-checkb":{"0":"审批状态-审批成功","1":"审批状态-审批失败"}
					}' /]
                [#assign form="search_form"]
                [#include "/include/search.ftl"]
                <div class="btn-toolbar">
                    <div class="btnitem imp" style="margin-left: 0px;">
                        <a class="btn btn-primary js-advice"><i
                                class="btnicon icon icon-advice-white"></i>查看审批意见</a>
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
                                <th>申请人</th>
                                <th>申请时间</th>
                                <th>审批状态</th>
                                <th>审批意见</th>
                                <th>审批时间</th>
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

    </div>
    <script src="${base}/resources/dsm/js/dsm-search.js"></script>
    <script type="text/javascript">
        function statusChe(val) {
            switch (val) {
                case 0 : return "尚未处理"
                case 1 : return "审批通过";
                    break;
                case 2 : return "尚未通过";
                    break;
            }
        }
        $(document).ready(function () {
            showCircultionAddress();
            //.dsm-searchbar有显示问题
            $('.dsm-searchbar').attr('style', 'position:unset;margin-bottom: 15px;');

            //隐藏日期框
        });
        var $obj = $("#fapplyTime-Wdate");
        $obj.html("");
        var html = "<div class=\"ks-popup-content\">\n" +
                "                                <input class=\"Wdate fiterpara\" type=\"text\" data-selected-desc=\"申请时间:\" readonly\n" +
                "                                       data-request=\"applyTime\" value=\"\" onclick=\"WdatePicker()\">\n" +
                "                                <button class=\"subfiter\" type=\"button\">确定</button>\n" +
                "                            </div>"
        $obj.html(html);
        var dd = " <dd><span class=\"simulate-select\" data-sim-obj=\"fapplyTime-Wdate\"\n" +
                "                                          data-sim-z=\"applyTime\"><span\n" +
                "                                        class=\"J_simulate_value\">申请时间</span><em></em></span></dd>";
        $(".clearfix filter-selected-list").find("dl").append(dd);

        $(document).on('click', '.js-advice', function () {
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
                url: '${base}/already_done/findTask/' + id + '.do',
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
                        "    </div>\n" +
                        "    <div class=\"dsm-inline\">\n" +
                        "        <label class=\"dsm-form-label\">待处理文件:</label>\n" +
                        "        <span>" + 1 + "个</span>\n";
                    if (data.uploadFilePath != "") {
                        htmlApprove += "<img id=\"imgDownload\" src=\"${base}/resources/dsm/images/icon-dbluedown.png\" style=\"width:15px;height:15px\" onclick=\"showSrcFileUrlDiv();\"/>";
                    } else {
                        htmlApprove += "<img id=\"imgDownload\" src=\"${base}/resources/dsm/images/icon-dblueup.png\" style=\"width:15px;height:15px\" onclick=\"showSrcFileUrlDiv();\"/>";
                    }
                    htmlApprove +=
                        "&nbsp;&nbsp;&nbsp;\n" +
                        "        <div class=\"dsm-upload-button\">\n" +
                        "            <span class=\"fbtname\" onclick='downloadAll()'>全部下载</span>\n" +
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
                        "    <div class=\"dsm-inline\">\n" +
                        "        <label class=\"dsm-form-label\">审批结果:</label>\n" +
                        "        <span>" + statusChe(data.status) + "</span>\n" +
                        "    </div>\n" +
                        "    <div class=\"dsm-inline\">\n" +
                        "        <label class=\"dsm-form-label\">审批意见:</label>\n" +
                        "        <span>" + data.cause + "</span>\n" +
                        "    </div>\n";
                    if (data.status == 0) {
                        htmlApprove += "   <div class=\"dsm-inline\">\n" +
                            "        <label class=\"dsm-form-label\">已处理文件:</label>\n" +
                            "        <span>" + data.fileCount + "</span>\n";
                        if (data.downloadPath != "") {
                            htmlApprove += "<img id=\"destImgDownloa\" src=\"${base}/resources/dsm/images/icon-dbluedown.png\" style=\"width:15px;height:15px\" onclick=\"showDestFileUrlDiv();\"/>\n";
                        } else {
                            htmlApprove += "<img id=\"destImgDownloa\" src=\"${base}/resources/dsm/images/icon-dblueup.png\" style=\"width:15px;height:15px\" onclick=\"showDestFileUrlDiv();/>\n";
                        }
                        htmlApprove += "        &nbsp;&nbsp;&nbsp;\n" +
                            "        <div class=\"dsm-upload-button\">\n" +
                            "            <span class=\"fbtname\" onclick='downloadAll()'>全部下载</span>\n" +
                            "        </div>\n" +
                            "</div>\n" +
                            "<div class=\"dsm-inline\">\n" +
                            "                                <div class=\"dsm-inline\">\n" +
                            "                                    <table id=\"tableListFinishApprove\" cellpadding=\"5\" cellspacing=\"5\"\n" +
                            "                                           style=\"margin-left: 110px\"></table>\n" +
                            "                                </div>\n" +
                            "                            </div>"
                    }
                    $("#addDeptForm").html(htmlApprove);
                    var fragment1;
                    var fragment2;
                    var srcFileUrls = data.uploadFilePath.replace(";","");
                    var destFileUrls = data.downloadPath.replace(";","");
                    fragment1 += "<tr><td class='dsm-td'>" + srcFileUrls + "</td><td><span title="+data.id+" class=\"fbtname\" onclick=\'download($(this))\'>下载</span></td>" + "</tr>"
                    $("#tableList").append(fragment1);
                    fragment2 += "<tr><td class='dsm-td'>" + destFileUrls + "</td><td><span title="+data.id+" class=\"fbtname\" onclick=\'download($(this))\'>下载</span></td>" + "</tr>";
                    $("#tableListFinishApprove").append(fragment2);
                        // var strVal = document.getElementsByClassName("dsm-input dsm-textarea").innerHTML;
                        dsmDialog.open({
                            type: 1,
                            area: ['630px', '600px'],
                            btn: ['确定', '取消'],
                            title: "审批意见",
                            content: $('#addDeptForm'),
                            yes: function (index) {
                                dsmDialog.close(index);
                                refreshUserPageList();
                            }
                        });
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
            $("#search_form").attr("action", "${base}/already_done/search.do?");
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
                            "<td><label for='m_\" + _id + \"'>" + index+ "</label></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.processName + "'>" + _data.processName + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.createUserAccount + "'>" + _data.createUserAccount + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.createDateTime + "'>" + _data.createDateTime + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + statusChe(_data.status) + "'>" + statusChe(_data.status) + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.cause + "'>" + _data.cause + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.updateDateTime + "'>" + _data.updateDateTime + "</div></td>" +
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
            var ids_ = $("#list_form :checked[name='ids']");
            console.log("ids", ids_);
            if (ids_.length === 0) {
                dsmDialog.error("请先选择用户!")
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

        function download() {
            var html = $(this).parent().parent().find("td").eq(0).html();
            var url = 'download.do?file=' + encodeURIComponent(html);
            location.href = url;
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
            var html = $(obj).prop("title");
            console.log(html);
            var url = '${base}/already_done/downloadSrcFile.do?id=' + encodeURIComponent(html);
            location.href = url;
        }

        function downloadAll() {
            var $trs = $("#tableList").find("tr");
            $trs.map(function () {
                var fileName = $(this).find("td").eq(0).text();
                console.log(fileName);
                var url = "${base}/initiation_process/downloadFiles.do?id=" + encodeURIComponent(fileName);
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

        $(".subfiter1").click(function () {
            var frmId = $(".filter-selected-list").data("searchform");

            var objs = $(this).parent().find(".fiterpara");

            if ($(objs[0]).hasClass("Wdate")) {
                var paradesc = objs[0].attributes["data-selected-desc"].nodeValue;
                var request = objs[0].attributes["data-request"].nodeValue.replace(/_/, ".");
                var paraval = objs[0].value;
                if (paraval == "") {
                    paraval = '1990-01-01'
                }
                if ($("#" + frmId + " input[name='" + request + "'][value='" + paraval + "'][type='hidden']").length == 0) {
                    $(".filter-selected-list").append('<dd><span class="filter-selected" data-value="paraval" data-para="' + request + '">' + paradesc + '<span class="fiter-value">' + paraval + '</span><em class="remove J_remove"></em></span></dd>')
                    $("#" + frmId).append('<input type="hidden" class="dsmsearch-para"  name="' + request + '" value="' + paraval + '" />');
                }
            }
            $(".simulate-select").removeClass("simulate-select-hover");
            $(".simulate-list").addClass("ks-overlay-hidden");
            $(".J_remove").click(function () {
                removeFiter(this);
            });
            filter();

        });

        function showDestFileUrlDiv() {
            var srcVal = $('#destImgDownloa').attr('src');
            console.log(srcVal);
            if (srcVal != "/DZBQ/resources/dsm/images/icon-dbluedown.png") {
                $('#destImgDownloa').attr('src', "${base}/resources/dsm/images/icon-dbluedown.png");
                $('#tableListFinishApprove').hide();
            } else {
                $('#destImgDownloa').attr('src', "${base}/resources/dsm/images/icon-dblueup.png");
                $('#tableListFinishApprove').show();
            }
        }
    </script>
</body>
</html>