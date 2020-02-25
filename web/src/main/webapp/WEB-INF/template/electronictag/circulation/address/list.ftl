[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>通讯录管理</title>
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
[#--                [#assign searchMap='{--]
[#--                    "unitName":"单位证书"--]
[#--                    }' /]--]
[#--                [#assign form="search_form"]--]
[#--                [#include "/dsm/include/search.ftl"]--]
                <div class="btn-toolbar">
                    <div class="btnitem imp" style="margin-left: 0px;">
                        <a class="btn btn-primary js_addDept"><i class="btnicon icon icon-add-white"></i>离线导入单位证书</a>
                    </div>
                    <div class="btnitem imp" style="margin-left: 15px;">
                        <a class="btn btn-primary js_delDept"><i class="btnicon icon icon-delete"></i>删除单位证书</a>
                    </div>
                    <div class="btnitem imp" style="margin-left: 15px;">
                        <a class="btn btn-primary js_syncDept"><i class="btnicon icon icon-add-white"></i>立即同步单位证书</a>
                    </div>
                    <div class="btnitem imp" style="margin-left: 15px;">
                        <a class="btn btn-primary js_exportDept"><i class="btnicon icon icon-export"></i>离线导出单位证书</a>
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
                                               data-allcheckfor="ids">
                                        <label for="maid"></label>
                                        <input type='hidden' name='fromId'>
                                        <input type='hidden' name='toId'>
                                        <input type='hidden' name='retain'>
                                    </div>
                                </th>
                                <th width="30%">序号</th>
                                <th width="50%">证书</th>
                                <th width="20%">更新时间</th>
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
        <form  method="post"  class="btnitem imp" id="uploadForm" action="${base}/admin/circulation/import.jhtml" enctype="multipart/form-data">
            <div class="dsmForms">
                <label class="dsm-form-label">选择证书文件：</label>
                <div class="dsm-input-block" style="height: 40px;">
                    <input id="fileNameShow1" type="text"  autocomplete="off" placeholder=""  disabled="true" class="dsm-input w268 f-l m-r-10 " style="width: 150px;">
                    <div class="dsm-upload-button f-l m-r-f10">
                        <input type="file" name="importFile" class="dsm-upload-file js_file" data-fileid="fileInfo">
                        <span class="fbtname">浏览...</span>
                </div>
                    <button id="insert" type="button" value="导入" class="btn btn-primary btn" style="margin-left:35px;height:35px">导入</button>
            </div>
        </form>
    </div>
[#--    <script src="${base}/resources/dsm/js/dsm-search.js"></script>--]
    <script type="text/javascript">
        $(document).ready(function () {

            $(document).on('change', '.js_file', function (e) {
                var filePath = $(this).val();
                var licNameArr = filePath.lastIndexOf('.');
                if (filePath.substring(licNameArr + 1) != "pem") {
                    dsmDialog.error('请选择格式为.pem的文件！');
                    $("#fileNameShow1").val("");
                    return false;
                } else {
                    $("#fileNameShow1").val(filePath);
                }
            });


            showCircultionAddress();
            //.dsm-searchbar有显示问题
            // $('.dsm-searchbar').attr('style', 'position:unset;margin-bottom: 15px;');
        });

        function getListData() {
            var objs = $("#list_form :checked[name='ids']").closest('tr').find('.hiddendiv');
            console.log('getListData:'+objs);
            if(!objs){
                return '';
            }

            var str = '';
            $(objs).each(function(){
                console.log($(this).text());
                str += $(this).text() + ',';
            });
            str = str.substring(0, str.length - 1);
            console.log('str:'+str);
            return str;
        }

        $(document).on('click', '.js_addDept', function (e) {
            dsmDialog.open({
                type: 1,
                area: ['700px', '250px'],
                btn: ['取消'],
                title: "新增单位证书",
                content: $('#addDeptForm'),
                yes: function (index, layero) {
                    dsmDialog.close(index);
                }
            });
        });

        $(document).on('click', '.js_syncDept', function(e) {
            var $frm = $("#list_form");
            $.ajax({
                dataType: "json",
                type: "get",
                url: "${base}/admin/circulation/syncUnitCert.jhtml",
                data: $frm.serialize(),
                success: function (data) {
                    // 提示
                    showToolTip({data: data});
                    refreshUserPageList();
                }
            });
        })

        $(document).on('click', '.js_delDept', function (e) {
            if (noItemSelected()) {//如果用户没有勾选
                return;
            };
            dsmDialog.toComfirm("是否删除选中的通讯录？", {
                btn: ['确定', '取消'],
                title: "删除通讯录"
            }, function (index) {
                var $frm = $("#list_form");
                $.ajax({
                    dataType: "json",
                    type: "post",
                    url: "${base}/admin/circulation/deleteAddress.jhtml",
                    data: $frm.serialize(),
                    success: function (data) {
                        // 提示
                        showToolTip({data: data});
                        refreshUserPageList();
                    }
                });
            }, function (index) {
                dsmDialog.close(index);
            });


        });

        $(document).on('click', '.js_exportDept', function (e) {
            if (noItemSelected()) {//如果用户没有勾选
                return;
            };
            var ids = new Array();
            $("#list_form").find("input[name='ids']:checked").map(function () {
                ids.push($(this).val());
            });
            for(var i = 0; i < ids.length; i ++) {
                var id = ids[i];
                var url = "${base}/admin/circulation/export.jhtml?id=" + id;
                downloadFile(url);
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
            $("#search_form").attr("action", "${base}/admin/circulation/getCirculationList.jhtml");
            refreshUserPageList();
        }

        function refreshUserPageList() {
            refreshPageList({
                id: "search_form",
                pageSize: 10,
                dataFormat: function (_data) {
                    var _id = _data.id;
                    // var _result = function (v) {
                    //     return v === true ? "是" : "否";
                    // }
                    var _text = "<tr>" +
                            "<td><div class='dsmcheckbox'>" +
                            "<input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/></div></td>" +
                            "<td><label for='m_\" + _id + \"'>" + _id + "</label></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.cert + "'>" + '---' + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + parseDate(_data.modifyDate) + "'>" + parseDate(_data.modifyDate) + "</div></td>" +
                            "</tr>";
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
                dsmDialog.error("请先选择数据!")
                return true;
            } else {
                return false;
            }
        }

        $(document).on('click', '#insert', function (e) {
            var formData = new FormData();
            formData.append("importFile",$(".js_file")[0].files[0]);
            $.ajax({
                url:'${base}/admin/circulation/import.jhtml',
                dataType:'json',
                type:'POST',
                async: false,
                data: formData,
                processData : false, // 使数据不做处理
                contentType : false, // 不要设置Content-Type请求头
                success: function(data){
                    dsmDialog.msg(data.content);
                    setTimeout(function(){window.location.reload();},1000);
                },
                error:function(data){
                    dsmDialog.error("上传失败");
                }
            });
        });
    </script>
</body>
</html>