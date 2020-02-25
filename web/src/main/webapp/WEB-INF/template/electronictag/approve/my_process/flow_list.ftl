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
                	"flowName":"工作流名称"
					}' /]
					[#assign form="search_form"]
                	[#include "/include/search.ftl"]
                <div class="btn-toolbar">
                    <div class="btnitem imp" style="margin-left: 0px;">
                        <a href="${base}/process_management/add.do" class="btn btn-primary">
                            <i class="btnicon icon-toolbar icon-add-white"></i>新增工作流</a>
                    </div>
                    <div class="btnitem imp" style="margin-left: 15px;">
                        <a class="btn btn-primary js_updateFlow"><i class="btnicon icon icon-update-white"></i>修改工作流</a>
                    </div>
                    <div class="btnitem imp" style="margin-left: 15px;">
                        <a class="btn btn-primary js_delFlow"><i class="btnicon icon icon-delete"></i>删除工作流</a>
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
                            <input type="text" class="dsm-input" autocomplete="off" name="defaultApproveTime"
                                   style="width: 40px">
                            <div class="dsm-input-block" style="width: 50px">
                                <select class="dsm-select" name="defaultApproveUnit">
                                    <option value="days" selected>天</option>
                                    <option value="hours">小时</option>
                                </select>
                            </div>
                            仍未被处理,则自动
                            <label class="danxuankuang_box selected">
                                <input name="defaultApproveState" class="danxuankuang js_receviceTypera" type="radio"
                                       value="0"><i>同意</i>
                            </label>
                            &nbsp;&nbsp;&nbsp;
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


        /*给修改按钮绑定点击事件*/
        $(document).on('click', '.js_updateFlow', function (e) {
            if (noItemSelected()) {//如果用户没有勾选
                return;
            }
            if (!oneItemSelected()) {
                return;
            }
            var $frm = $("#list_form :checked[name='ids']");
            var ids = $frm.serialize();
            console.log("当前修改的数据id:", ids);
            location.href = "${base}/process_management/add.do?" + ids;
        })

        /*给删除按钮绑定删除事件*/
        $(document).on('click', '.js_delFlow', function (e) {
            if (noItemSelected()) {//如果用户没有勾选
                return;
            }
            ;
            dsmDialog.toComfirm("是否删除选中的工作流？", {
                btn: ['确定', '取消'],
                title: "删除工作流"
            }, function (index) {
                var $frm = $("#list_form");
                $.ajax({
                    dataType: "json",
                    type: "post",
                    url: "${base}/process_management/remove.do",
                    data: $frm.serialize(),
                    success: function (data) {
                        // 提示
                        dsmDialog.msg(data.msg);
                        refreshUserPageList();
                    }
                });
            }, function (index) {
                dsmDialog.close(index);
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
            $("#search_form").attr("action", "${base}/process_management/search.do?");
            refreshUserPageList();
        }

        function refreshUserPageList() {
            var index = 1;
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
                            "<input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/></div></td>" +
                            "<td><label for='m_\" + _id + \"'>" + index + "</label></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.flowName + "'>" + _data.flowName + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.approveAccount + "'>" + _data.approveAccount + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.createUserAccount + "'>" + _data.createUserAccount + "</div></td>" +
                            "<td class='hiddentd'><div class='hiddendiv' title='" + _data.createDateTime + "'>" + _data.createDateTime + "</div></td>" +
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
            if (ids_.length === 0) {
                dsmDialog.error("请先选择工作流!")
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
                dsmDialog.error("请先选择工作流!")
                return false;
            } else {
                dsmDialog.error("所选工作流过多，该功能只支持勾选单个工作流")
                return false;
            }
        }
    </script>
</body>
</html>