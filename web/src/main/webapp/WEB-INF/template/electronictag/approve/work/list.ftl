[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>工作流管理</title>
    [#include "/dsm/include/head.ftl"]
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
                    "unitName":"单位名称"
                    }' /]
                [#assign form="search_form"]
                [#include "/dsm/include/search.ftl"]
                <div class="btn-toolbar">
                    <div class="btnitem imp" style="margin-left: 0px;">
                        <a class="btn btn-primary js_addDept"><i class="btnicon icon-toobar icon-add-white"></i>新增</a>
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
                                               data-allcheckfor="ids">
                                        <label for="maid"></label>
                                        <input type='hidden' name='fromId'>
                                        <input type='hidden' name='toId'>
                                        <input type='hidden' name='retain'>
                                    </div>
                                </th>
                                <th width="30%">序号</th>
                                <th>工作流名称</th>
                                <th>审批人</th>
                                <th>创建者</th>
                                <th>修改时间</th>
                                <th>状态</th>
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
        <form>
            <div class="dsmForms">
                <div class="dsm-form-item">
                    <div class="dsm-inline">
                        <label class="dsm-form-label">工作流名称：</label>
                        <div class="dsm-input-inline">
                            <input type="text" autocomplete="off" name="workFlowName" placeholder="请填写工作流名称"
                                   class="dsm-input required specialChar">
                        </div>
                    </div>
                    <div class="dsm-inline">
                        [#--iframe--]
                        <label class="dsm-form-label">审批人：</label>
                        <div class="dsm-input-inline dsm-tarea ">
                            <label class="danxuankuang_box selected">
                                <input name="approveUserType" class="danxuankuang js_receviceTypera" type="radio"
                                       value="0"><i>管理员</i>
                            </label>
                            &nbsp;&nbsp;&nbsp;
                            <label class="danxuankuang_box ">
                                <input name="approveUserType" class="danxuankuang js_receviceTypera" type="radio"
                                       value="1"><i>指定其他审批人</i>
                            </label>
                        </div>
                    </div>
                    <div class="dsm-inline">
                        <label class="dsm-form-label" style="width: 90px"></label>
                        <input id="approveUser" type="text" autocomplete="off" placeholder="" disabled="true"
                               class="dsm-input w268 f-l m-r-10 ">
                        <div class="dsm-upload-button f-l m-r-f10">
                            [#--绑定一个onclick事件--]
                            <span class="fbtname">浏览...</span>
                        </div>
                    </div>
                    <div class="dsm-inline">
                        <label class="dsm-form-label">审批时间：</label>
                        <div class="dsm-input-inline">
                            <input type="text" autocomplete="off" name="defaultApproveTime"
                                   class="dsm-input required specialChar" style="width: 40px">
                            <select class="xialakuang" name="defaultApproveUnit">
                                <option value="days" selected>天</option>
                                <option value="hours">小时</option>
                            </select>
                            仍未被处理,则自动
                            <label class="danxuankuang_box selected">
                                <input name="defaultApproveState" class="danxuankuang js_receviceTypera" type="radio"
                                       value="0"><i>同意</i>
                            </label>
                            <label class="danxuankuang_box ">
                                <input name="defaultApproveState" class="danxuankuang js_receviceTypera" type="radio"
                                       value="1"><i>不同意</i>
                            </label>
                        </div>
                    </div>
                    <div class="dsm-inline">
                        [#--iframe--]
                        <label class="dsm-form-label">状态：</label>
                        <div class="dsm-input-inline dsm-tarea ">
                            <label class="danxuankuang_box selected">
                                <input name="state" class="danxuankuang js_receviceTypera" type="radio"
                                       value="0"><i>激活</i>
                            </label>
                            <label class="danxuankuang_box ">
                                <input name="state" class="danxuankuang js_receviceTypera" type="radio"
                                       value="1"><i>挂起</i>
                            </label>
                        </div>
                        <div class="dsm-inline">
                            <label class="dsm-form-label">流程描述:</label>
                            <div class="dsm-input-inline dsm-tarea ">
                            <textarea name="description" cols="10" rows="2"
                                      class="dsm-input dsm-textarea" id="description"></textarea>
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

        function getListData() {
            var objs = $("#list_form :checked[name='ids']").closest('tr').find('.hiddendiv');
            console.log('getListData:' + objs);
            if (!objs) {
                return '';
            }

            var str = '';
            $(objs).each(function () {
                console.log($(this).text());
                str += $(this).text() + ',';
            });
            str = str.substring(0, str.length - 1);
            console.log('str:' + str);
            return str;
        }

        $(document).on('click', '.js_addDept', function (e) {
            clearValid('#addDeptForm');
            var frm = $('#addDeptForm form');
            frm.find(".dsm-input").removeData("previousValue").removeClass("error").next("label").remove();
            frm.attr("action", "${base}/admin/flow/save.jhtml")[0].reset();
            //frm.find("input[name='parentId']").val(departmentId);
            frm.find("input[name='id']").val("");
            dsmDialog.open({
                type: 1,
                area: ['600px', '500px'],
                btn: ['确定', '取消'],
                title: "新增工作流",
                content: $('#addDeptForm'),
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

        $(document).on('click', '.js_delDept', function (e) {
            if (noItemSelected()) {//如果用户没有勾选
                return;
            }
            ;
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
            $("#search_form").attr("action", "${base}/admin/flow/search.jhtml");
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
                        "<input type='checkbox' name='id' id='m_" + _id + "' value='" + _id + "'/></div></td>" +
                        "<td><label for='m_\" + _id + \"'>" + _id + "</label></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.workFlowName + "'>" + _data.workFlowName + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.approveUser + "'>" + _data.approveUser + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.owner + "'>" + _data.owner + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.createTime + "'>" + _data.createTime + "</div></td>" +
                        "<td class='hiddentd'><div class='hiddendiv' title='" + _data.state + "'>" + _data.state + "</div></td>" +
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
    </script>
</body>
</html>