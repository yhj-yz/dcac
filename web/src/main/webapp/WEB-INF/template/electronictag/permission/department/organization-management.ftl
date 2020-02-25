[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>部门与用户管理</title>
    [#include "/include/head.ftl"]
    <link href="${base}/resources/dsm/css/zTreeStyle.css" rel="stylesheet"/>
    <script type="text/javascript" src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
    <script type="text/javascript" src="${base}/resources/dsm/js/ztree.helper.js"></script>
    <script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
    <script type="text/javascript" src="${base}/resources/dsm/js/Chart.js"></script>
    <script type="text/javascript" src="${base}/resources/dsm/js/charthelper.js"></script>
    <style>
        table {
            border-collapse: collapse;
            table-layout: fixed;
            display: table;
        }

        th, td {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        #position {
            z-index: 10;
            position: fixed;
            height: 100%;
            top: 0;
            padding: 10px;
            background-color: #eee;
            width: 100%;
            border-bottom: 1px solid #bbb;
        }
    </style>
</head>
<body>
<div class="dsm-rightside depuserslist">
    <div class="maincontent">
        <div class="mainbox clearfix">
            <div id="position">
                <div class="btn-toolbar">
                    <div class="btnitem imp">
                        <a class="btn btn-primary js_setlotspermission"><i class="btnicon icon icon-export"></i>设置权限集</a>
                    </div>
                    <div class="btnitem imp">
                        <a class="btn btn-primary js_setlotscontrol"><i class="btnicon icon icon-export"></i>设置受控策略</a>
                    </div>
                    <div class="btnitem imp">
                        <a class="btn btn-primary js_setlotsrole"><i class="btnicon icon icon-export"></i>设置角色</a>
                    </div>
                    <div class="btnitem imp">
                        <a class="btn btn-primary js_export"><i class="btnicon icon icon-export"></i>离线策略导出</a>
                    </div>
                    <div class="searchbox">
                        <input class="dsm-input js_search_txt on" type="text">
                        <i class="icon icon-search js_search" title="搜索"></i>
                    </div>
                    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
                         aria-labelledby="myLargeModalLabel">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="dsm-inline m-t-30p">
                                    <form action="${base}/admin/organization_management/import.do" method="post"
                                          enctype="multipart/form-data" class="btnitem imp" id="uploadForm">
                                        <label class="dsm-form-label">选择文件：</label>
                                        <div class="dsm-input-block" style="height: 40px;">
                                            <input id="fileNameShow1" type="text" autocomplete="off" placeholder=""
                                                   disabled="true" class="dsm-input w268 f-l m-r-10 ">
                                            <div class="dsm-upload-button f-l m-r-f10">
                                                <input type="file" name="importFile" class="dsm-upload-file js_file"
                                                       data-fileid="fileInfo">
                                                <span class="fbtname">浏览...</span>
                                            </div>
                                            <button type="buttom" id="uploadFilebtn" class="btn btn-primary"
                                                    style="margin: 1px 0 0 28px;height: 35px; width: 67px;">导入
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="main-left">
                <div class="orglist">
                    <div class="treedata">
                        <ul id="dsmOrgTree" class="ztree"></ul>
                    </div>
                </div>
            </div>
            <div class="main-right">
                <div class="table-view table-org">
                    <form id="list_form">
                        <table id="datalist" class="table table-bordered table-hover" cellspacing="0" width="100%">
                            <thead>
                            <tr>
                                <th class="w40">
                                    <div class="dsmcheckbox">
                                        <input type="checkbox" id="maid" class="js_checkboxAll" data-allcheckfor="ids">
                                        <label for="maid"></label>
                                        <input type='hidden' name='fromId'>
                                        <input type='hidden' name='toId'>
                                        <input type='hidden' name='retain'>
                                    </div>
                                </th>
                                <th>账号</th>
                                <th>姓名</th>
                                <th>密级等级</th>
                                <th>权限集</th>
                                <th>受控策略</th>
                                <th>角色</th>
                                <th>客户端用户在线状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
            <form id="search_form" data-func-name="refreshUserPageList();" data-list-formid="datalist">
                <input type="hidden" name="name">
                <input type="hidden" name="include" value="0">
                <input type="hidden" name="departmentId">
            </form>
        </div>
    </div>
</div>

[@shiro.hasPermission name = "admin:dept:multi"]
    <!--批量设置用户-设置角色-->
    <div id="setUserRolesForm" style="display: none">
        <div class="dsmForms">
            <form action="${base}/admin/department/set_user_role.do">
                <div class="dsm-form-item">
                    <div class="dsm-inline">
                        <label class="dsm-form-label">所属角色：</label>
                        <div class="dsm-input-block">
                            <select name="roleId" class="dsm-select">
                                [#list roles as q]
                                    <option value="${q.id}"
                                            [#if user.role.id == q.id]selected="true"[/#if]>${q.name}</option>
                                [/#list]
                            </select>
                        </div>
                    </div>
                    <div class="dsm-inline">
                        <label class="dsm-form-label" for="cct5"></label>
                        <div class="dsmcheckbox m-t-10p">
                            <input type="checkbox" value="1" id="cct5" name="containStatus">
                            <label for="cct5"></label>
                        </div>
[#--                        <label class="m-t-10p" for="cct5">包括子部门</label>--]
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!--批量设置用户-权限集-->
    <div id="setUserPermission" style="display: none">
        <div class="dsmForms">
            <form>
                <div class="dsm-form-item">
                    <div class="dsm-inline">
                        <label class="dsm-form-label">权限集：</label>
                        <div class="dsm-input-block">
                            <select class="dsm-select" name="id">
                                <option value="">-</option>
                                [#list permissions as q]
                                    <option value="${q.id}">${q.permissionName}</option>
                                [/#list]
                            </select>
                        </div>
                    </div>
[#--                    <div class="dsm-inline">--]
[#--                        <label class="dsm-form-label" for="qxj1"></label>--]
[#--                        <div class="dsmcheckbox m-t-10p">--]
[#--                            <input type="checkbox" value="1" id="qxj1" name="containStatus">--]
[#--                            <label for="qxj1"></label>--]
[#--                        </div>--]
[#--                        <label class="m-t-10p" for="qxj1">包括子部门</label>--]
[#--                    </div>--]
                </div>
            </form>
        </div>
    </div>
    <!--批量设置用户-受控策略-->
    <div id="setUserControl" style="display: none">
        <div class="dsmForms">
            <form>
                <div class="dsm-form-item">
                    <div class="dsm-inline">
                        <label class="dsm-form-label">受控策略：</label>
                        <div class="dsm-input-block">
                            <select class="dsm-select" name="id">
                                <option value="">-</option>
                                [#list controls as q]
                                    <option value="${q.id}">${q.name}</option>
                                [/#list]
                            </select>
                        </div>
                    </div>
                    <div class="dsm-inline">
                        <label class="dsm-form-label" for="skcl1"></label>
                        <div class="dsmcheckbox m-t-10p">
                            <input type="checkbox" value="1" id="skcl1" name="containStatus">
                            <label for="skcl1"></label>
                        </div>
                        <label class="m-t-10p" for="skcl1">包括子部门</label>
                    </div>
                </div>
            </form>
        </div>
    </div>
[/@shiro.hasPermission]

<!--移动成员-->
<div id="ydUserForm" class="ydform" style="display: none">
    <form>
        <div class="dsmForms">
            <div class="dsm-form-item">

                <div class="dsm-inline">
                    <label class="dsm-form-label" for="bl"></label>
                    <div class="dsmcheckbox m-t-10p">
                        <input type="checkbox" value="1" id="bl" name="retain">
                        <label for="bl"></label>
                    </div>
                    <label class="m-t-10p" for="bl">保留原用户部门关系</label>
                </div>

                <div class="ydorglist">
                    <div class="treedata">
                        <ul id="dsmYdOrgTree" class="ztree"></ul>

                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    $(function () {
        $(document).on('change', '.js_file', function (e) {
            var filePath = $(this).val();
            var licNameArr = filePath.lastIndexOf('.');
            if (filePath.substring(licNameArr + 1) != "json") {
                dsmDialog.error('请选择格式为.json的文件！');
                $("#fileNameShow1").val("");
                return false;
            } else {
                $("#fileNameShow1").val(filePath);
            }
        });
        $("td").on("mouseenter", function () {
            if (this.offsetWidth < this.scrollWidth) {
                var that = this;
                var text = $(this).text();
                layer.tips(text, that, {
                    tips: [1, '#aaa'],
                    time: 2000
                });
            }
        });
    });
    var departmentId = 1, departmentId2 = 2, zTree;

    function checkDelDeptBtnStatus() {
        var sNodes = zTree.getSelectedNodes();
        if (sNodes.length > 0) {
            var node = sNodes[0].getParentNode();
            if (node) {
                [@shiro.hasPermission name = "admin:dept:mono"]
                $('.js_delDept,.js_editDept').removeAttr('disabled');
                $('.deptrightmenu').find('.js_delDept,.js_editDept').show();
                $('.deptrightmenu').find('.setuserbox').css('top', '20px');
                return false;
                [/@shiro.hasPermission]
            } else {
                $('.js_delDept,.js_editDept').attr('disabled', 'disabled');
                $('.deptrightmenu').find('.js_delDept,.js_editDept').hide();
                $('.deptrightmenu').find('.setuserbox').css('top', '20px');
            }
            return true;
        }
    }

    [@shiro.lacksPermission name = "admin:dept:multi"]
    $(".js_setlots,.js_export").attr("disabled", "disabled");
    [/@shiro.lacksPermission]
    [@shiro.lacksPermission name = "admin:dept:mono"]
    $(".js_addDept,.js_editDept,.js_delDept,.js_ydUser,.js_addUser,.js_delUser").attr("disabled", "disabled");
    [/@shiro.lacksPermission]

    [@shiro.hasPermission name = "admin:dept:mono"]
    //删除部门
    function deleteDeptById(id) {
        $.ajax({
            dataType: "json",
            type: "post",
            data: {id: id},
            url: "${base}/admin/department/delete.do",
            success: function (data) {
                // 提示
                showToolTip({
                    data: data,
                    success: function () {
                        var sNodes = zTree.getSelectedNodes();
                        if (sNodes.length > 0) {
                            var node = sNodes[0].getParentNode();
                            if (node) {
                                departmentId = node.id;
                                zTree.removeNode(sNodes[0]);
                                zTree.selectNode(node);
                                refreshUserPageList();
                            }
                        }
                    },
                });
            }
        });
    }

    [/@shiro.hasPermission]
    //点击部门显示用户
    function showUsersByDepartmentId() {
        $("#search_form").attr("action", "${base}/organization_management/user/dept.do?deptId=" + departmentId);
        refreshUserPageList();
    }

    //检查是否勾选
    function noItemSelected() {
        var ids_ = $("#list_form :checked[name='ids']");
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

    //根据用户名/账号搜索
    function search(search_name) {
        if (search_name.length > 32) {
            dsmDialog.error("搜索框最多输入32位");
            return;
        }
        $("#search_form input[name='name']").val(search_name);
        //$('#search_form input[name="include"]').val("1");
        $("#search_form").attr("action", "${base}/organization_management/user/dept.do?deptId=" + departmentId);
        refreshUserPageList();
    }

    function initLevelType(type) {
        switch (type) {
            case (1):
                return "绝密";
                break;
            case (2):
                return "机密";
                break;
            case (3):
                return "秘密";
                break;
            case (4):
                return "内部";
                break;
            case (5):
                return "公开";
                break;
            default:
                return "未定义";
        }
    }

    function initCertLevelType(type) {
        switch (type) {
            case 1:
                return "一级证书";
                break;
            case 2:
                return "二级证书";
                break;
            case 3:
                return "三级证书";
                break;
            default:
                return "未定义";
        }
    }

    function initStatusType(type) {
        switch (type) {
            case (0):
                return "启用";
                break;
            case (1):
                return "禁用";
                break;
            case (2):
                return "删除";
                break;
            default:
                return "未定义";
        }
    }

    function initmLevel(type) {
        switch (type) {
            case (1):
                return "绝密";
                break;
            case (2):
                return "机密";
                break;
            case (3):
                return "秘密";
                break;
            case (4):
                return "内部";
                break;
            case (5):
                return "公开";
                break;
            default:
                return "未定义";
        }
    }

    //刷新用户分页列表
    function refreshUserPageList() {
        refreshPageList({
            id: "search_form",
            pageSize: 10,
            dataFormat: function (_data) {
                console.log(_data);
                var _id = _data.id;
                var _result = function (v) {
                    return v === true ? "是" : "否";
                }
                var levelName = _data.belongSecurity ? _data.belongSecurity.securityName : "-";
                var permissionName = _data.permissions ? _data.permissions.permissionName : "-";
                var backupName = _data.backupManagerEntity ? _data.backupManagerEntity.strategyName : "-";
                var controlName = _data.control ? _data.control.name : "-";
                var roleName = _data.role ? _data.role.name : "-";
                var isOnlineTitile = "";
                var isOnline = "";
                if (_data.isOnline == 1) {
                    isOnline = '<span style="color: green">' + "在线" + '</span>';
                    isOnlineTitile = "在线";
                } else {
                    isOnline = "离线";
                    isOnlineTitile = "离线";
                }
                var _text = "<tr>" +
                    "<td><div class='dsmcheckbox'>" +
                    "<input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + _data.account + "'><a href='#' class='js_editUser' data-id='" + _data.id + "'>" + _data.account + "</a></div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + _data.name + "'>" + _data.name + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + initmLevel(_data.mLevel) + "'>" + initmLevel(_data.mLevel) + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + permissionName + "'>" + permissionName + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + controlName + "'>" + controlName + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + roleName + "'>" + roleName + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + isOnlineTitile + "'>" + isOnline + "</div></td>" +
                    "</tr>";
                return _text;
            }
        });

    }

    [@shiro.hasPermission name = "admin:dept:mono"]
    //删除用户
    $(document).on('click', '.js_delUser', function (e) {
        if (noItemSelected()) {//如果用户没有勾选
            return;
        }
        ;
        dsmDialog.toComfirm("是否删除选中的用户？", {
            btn: ['确定', '取消'],
            title: "删除用户"
        }, function (index) {
            var $frm = $("#list_form");
            $.ajax({
                dataType: "json",
                type: "post",
                url: "${base}/admin/user/delete.do",
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
    [/@shiro.hasPermission]
    /*//导出
    $(document).on('click', '.js_export', function (e) {
        var frm = $('#list_form');
        alert(frm.serialize())
        window.open('${base}/admin/user/offlines.do?' + frm.serialize());
        });*/
    //导出
    $(document).on('click', '.js_export', function (e) {
        if (oneItemSelected()) {
            var id = $('#list_form input[name="ids"]:checked').val();
            window.location = '${base}/admin/user/offline.do?id=' + id;
            //window.open('${base}/admin/user/offline.do?id=' + id);
        }
    });


    $(document).on('click', '#uploadFilebtn', function (e) {
        var val = $('#fileNameShow1').val();

        if (val.trim() == "" || val.substring(val.lastIndexOf(".") + 1) != "json") {
            alert("请选择文件后再导入");
            return false;
        } else {
            $('#uploadForm').submit();
        }
    });

    $(document).on('click', '.organization_export', function (e) {
        window.location = '${base}/admin/organization_management/export.do';
        //window.open('${base}/admin/user/offline.do?id=' + id);
    });

    //搜索
    $(document).on('click', '.js_search', function (e) {
        search($(this).prev().val());
    });
    //搜索栏绑定键盘keyup事件
    $(document).on("keyup", ".js_search_txt", function (event) {
        $("#search_form input[name='name']").val(this.value);
        if (event.which === 13) {
            search(this.value);
        }
    });
    [@shiro.hasPermission name = "admin:dept:multi"]
    //批量设置用户-设置密级
    $(document).on('click', '.js_setlotsmj', function (e) {
        var frm = $('#setUserSafemj form');
        if ($(this).parent().parent().hasClass('dropdown-menu')) {
            if (noItemSelected()) {
                return;
            }
            prepareForm({frm: frm, url: '${base}/admin/user/set_user_level.do', show: false});
        } else {
            frm.find("input[name='departmentId']").remove();
            frm.append('<input type="hidden" name="departmentId" value="' + departmentId + '" >');
            prepareForm({frm: frm, url: '${base}/admin/department/set_user_level.do', show: true});
        }
        dsmDialog.open({
            type: 1,
            area: ['500px', '300px'],
            btn: ['确定', '取消'],
            title: "批量设置用户-设置密级",
            content: $('#setUserSafemj'),
            yes: function (index, layero) {
                submitForm({
                    frm: frm, success: function () {
                        dsmDialog.close(index);
                    }
                });
            }
        });

    });

    //批量设置用户-设置角色
    $(document).on('click', '.js_setlotsrole', function (e) {
        var frm = $('#setUserRolesForm form');
        if ($(this).parent().parent().hasClass('dropdown-menu')) {
            if (noItemSelected()) {
                return;
            }
            prepareForm({frm: frm, url: '${base}/admin/user/set_user_role.do', show: false});
        } else {
            frm.find("input[name='departmentId']").remove();
            frm.append('<input type="hidden" name="departmentId" value="' + departmentId + '" >');
            prepareForm({frm: frm, url: '${base}/admin/department/set_user_role.do', show: true});
        }
        dsmDialog.open({
            type: 1,
            area: ['500px', '300px'],
            btn: ['确定', '取消'],
            title: "批量设置用户-设置角色",
            content: $('#setUserRolesForm'),
            yes: function (index, layero) {
                submitForm({
                    frm: frm, success: function () {
                        dsmDialog.close(index);
                    }
                });
            }
        });

    });

    //批量设置用户-设置权限集
    $(document).on('click', '.js_setlotspermission', function (e) {
        var frm = $('#setUserPermission form');
        if (noItemSelected()) {
            return;
        }
        prepareForm({frm: frm, url: '${base}/admin/permissionset/set_user_permission.do', show: false});
        dsmDialog.open({
            type: 1,
            area: ['500px', '300px'],
            btn: ['确定', '取消'],
            title: "批量设置用户-设置权限集",
            content: $('#setUserPermission'),
            yes: function (index, layero) {
                submitForm({
                    frm: frm, success: function () {
                        dsmDialog.close(index);
                    }
                });
            }
        });

    });
    //批量设置用户-设置备份策略
    $(document).on('click', '.js_setlotsbackup', function (e) {
        var frm = $('#setUserBackup form');
        if ($(this).parent().parent().hasClass('dropdown-menu')) {
            if (noItemSelected()) {
                return;
            }
            prepareForm({frm: frm, url: '${base}/admin/user/set_user_backup.do', show: false});
        } else {
            frm.find("input[name='departmentId']").remove();
            frm.append('<input type="hidden" name="departmentId" value="' + departmentId + '" >');
            prepareForm({frm: frm, url: '${base}/admin/department/set_user_backup.do', show: true});
        }

        dsmDialog.open({
            type: 1,
            area: ['500px', '300px'],
            btn: ['确定', '取消'],
            title: "批量设置用户-设置备份策略",
            content: $('#setUserBackup'),
            yes: function (index, layero) {
                submitForm({
                    frm: frm, success: function () {
                        dsmDialog.close(index);
                    }
                });
            }
        });

    });
    //批量设置用户-设置受控策略
    $(document).on('click', '.js_setlotscontrol', function (e) {
        var frm = $('#setUserControl form');
        if ($(this).parent().parent().hasClass('dropdown-menu')) {
            if (noItemSelected()) {
                return;
            }
            prepareForm({frm: frm, url: '${base}/admin/user/set_user_control.do', show: false});
        } else {
            frm.find("input[name='departmentId']").remove();
            frm.append('<input type="hidden" name="departmentId" value="' + departmentId + '" >');
            prepareForm({frm: frm, url: '${base}/admin/department/set_user_control.do', show: true});
        }

        dsmDialog.open({
            type: 1,
            area: ['500px', '300px'],
            btn: ['确定', '取消'],
            title: "批量设置用户-设置受控策略",
            content: $('#setUserControl'),
            yes: function (index, layero) {
                submitForm({
                    frm: frm, success: function () {
                        dsmDialog.close(index);
                    }
                });
            }
        });

    });
    [/@shiro.hasPermission]

    [@shiro.hasPermission name = "admin:dept:mono"]
    //新增用户
    $(document).on('click', '.js_addUser', function (e) {
        //window.location.href="${base}/admin/user/add.do?departmentId="+departmentId;
    });

    //新增用户
    $(document).on('click', '.js_addUser', function (e) {
        clearValid('#addUserForm');
        $("#addUserForm input").each(function (index, element) {
            $(this).val("").removeData("previousValue").removeClass("error").next("label").remove();
            $(this).removeAttr("readOnly");
        });
        var frm = $('#addUserForm form');
        frm.attr("action", "${base}/admin/user/save.do")[0].reset();
        frm.find("input[name='departmentId']").val(departmentId);
        //frm.find("input[name='password']").parent().next("div.desc").find("em").text("*");
        //frm.find("input[name='rePassword']").parent().next("div.desc").find("em").text("*");
        //frm.find("input[name='password']").rules("add",{required: true,maxlength: 32,});
        //frm.find("input[name='rePassword']").rules("add",{required: true,equalTo: "#password"});

        dsmDialog.open({
            type: 1,
            area: ['750px', '440px'],
            title: "新增用户",
            content: $('#addUserForm'),
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                if (frm.valid()) {
                    submitForm({
                        frm: frm, success: function () {
                            dsmDialog.close(index);
                        }
                    });
                }
            }
        });

    });
    //修改用户
    $(document).on('click', '.js_editUser', function (e) {
        clearValid('#addUserForm');
        var frm = $('#addUserForm form');
        var id = $(this).data("id");
        frm.attr("action", "${base}/admin/user/update.do")[0].reset();
        $.ajax({
            type: "get",
            url: "${base}/admin/user/find/" + id + ".do",
            dataType: "json",
            success: function (data) {
                var depst = data.departments;
                var deptStr = "";
                $(depst).each(function (i, ele) {
                    if (i != depst.length - 1) {
                        deptStr += ele.name + ",";
                    } else {
                        deptStr += ele.name;
                    }

                })
                frm.find('select.dsm-select').selectpicker('refresh');
                frm.find("input[name='id']").val(data.id);
                $("#account").val(data.account == null || data.account.trim() == "" ? "-" : data.account);
                $("#name").val(data.name == null || data.name.trim() == "" ? "-" : data.name);
                $("#sex").val(data.sex);
                $("#telephone").val(data.telephone == null || data.telephone.trim() == "" ? "-" : data.telephone);
                $("#post").val(data.post == null || data.post.trim() == "" ? "-" : data.post);
                $("#userDepartment").val(deptStr == null || deptStr.trim() == "" ? "-" : deptStr);
                $("#mLevel").val(initmLevel(data.mLevel));
                $("#certLevel").val(data.certLevel);
                $("#keyuser").val(data.keyuser == null || data.keyuser.trim() == "" ? "-" : data.keyuser);
                $("#militaryId").val(data.militaryId == null || data.militaryId.trim() == "" ? "-" : data.militaryId);
                $("#status").val(data.status);
                $("#description").val(data.description == null ? "-" : data.description);
            }
        });
        var _title = "用户详情";
        var _btn = [];
        if ($("#isSolo").val() == "true") {
            _title = "修改用户";
            _btn.push("确定");
            _btn.push("取消");
            $("#addUserForm input").each(function (index, element) {
                if ($(this).attr("name") !== "account") {
                    $(this).removeAttr("readOnly");
                }

            });
        }

        dsmDialog.open({
            type: 1,
            area: ['750px', '440px'],
            btn: _btn,
            title: _title,
            content: $('#addUserForm'),
            yes: function (index, layero) {
                if (frm.valid()) {

                    submitForm({
                        frm: frm, success: function () {
                            dsmDialog.close(index);
                        }
                    });
                }
            }
        });

    });

    //新增部门
    $(document).on('click', '.js_addDept', function (e) {
        clearValid('#addDeptForm');
        var frm = $('#addDeptForm form');
        frm.find(".dsm-input").removeData("previousValue").removeClass("error").next("label").remove();
        frm.attr("action", "${base}/admin/department/save.do")[0].reset();
        frm.find("input[name='parentId']").val(departmentId);
        frm.find("input[name='id']").val("");
        dsmDialog.open({
            type: 1,
            area: ['420px', '300px'],
            btn: ['确定', '取消'],
            title: "新增部门",
            content: $('#addDeptForm'),
            yes: function (index, layero) {
                if (frm.valid()) {
                    submitForm({
                        frm: frm, success: function () {
                            dsmDialog.close(index);
                            refreshDept(true);
                        }
                    });
                }
            }
        });

    });
    //修改部门
    $(document).on('click', '.js_editDept', function (e) {
        clearValid('#addDeptForm');
        if (noDeptSelected()) {
            return;
        }
        var frm = $('#addDeptForm form');
        frm.attr("action", "${base}/admin/department/update.do")[0].reset();
        $.ajax({
            type: "get",
            url: "${base}/admin/department/find/" + departmentId + ".do",
            dataType: "json",
            success: function (data) {
                frm.find("input[name='parentId']").val(data.parentId);
                frm.find("input[name='id']").val(data.id);
                frm.find("input[name='name']").val(data.name);
                frm.find("textarea[name='desc']").val(data.desc === null ? "" : data.desc);
                frm.valid();
            }
        });
        dsmDialog.open({
            type: 1,
            area: ['420px', '300px'],
            btn: ['确定', '取消'],
            title: "修改部门",
            content: $('#addDeptForm'),
            yes: function (index, layero) {
                if (frm.valid()) {
                    submitForm({
                        frm: frm, success: function () {
                            dsmDialog.close(index);
                            refreshDept();
                        }
                    });
                }
            }
        });

    });
    //删除部门
    $(document).on('click', '.js_delDept', function (e) {
        if (noDeptSelected()) {
            return;
        }
        if (checkDelDeptBtnStatus()) {
            return;
        }
        dsmDialog.toComfirm("是否删除选中的部门？", {
            btn: ['确定', '取消'],
            title: "删除部门"
        }, function (index) {
            //删除操作代码
            $.ajax({
                dataType: "json",
                type: "get",
                data: {id: departmentId},
                url: "${base}/admin/department/has_child.do",
                success: function (result) {
                    if (result === true) {
                        dsmDialog.toComfirm("部门下包含子部门和用户，是否全部删除？", {
                            btn: ['是', '否'],
                            title: "删除部门"
                        }, function (i) {
                            //删除操作代码
                            deleteDeptById(departmentId);
                            dsmDialog.close(i);
                        }, function (i) {
                            dsmDialog.close(i);
                        });
                    } else {
                        deleteDeptById(departmentId);
                    }
                }
            });

        }, function (index) {
            dsmDialog.close(index);
        });

    });
    //移动用户
    $(document).on('click', '.js_ydUser', function (e) {
        if (noItemSelected()) {
            return;
        }
        dsmDialog.open({
            type: 1,
            area: ['500px', '500px'],
            btn: ['确定', '取消'],
            title: "请选择部门",
            content: $('#ydUserForm'),
            success: function () {
                zTreeInit({
                    id: 'dsmYdOrgTree',
                    url: '${base}/organization_management/department/tree.do',
                    zTreeOnClick: function (event, treeId, treeNode) {
                        departmentId2 = treeNode.id;
                    },
                });
            },
            yes: function (index, layero) {
                var frm = $('#list_form');
                var retain = $('#ydUserForm :checked[name="retain"]').val();
                var url = "${base}/admin/user/move.do";
                frm.attr("action", "${base}/admin/user/move.do");
                frm.find("input[name='fromId']").val(departmentId);
                frm.find("input[name='toId']").val(departmentId2);
                frm.find("input[name='retain']").val(retain);
                $.ajax({
                    dataType: "json",
                    type: "post",
                    url: url,
                    data: frm.serialize(),
                    success: function (data) {
                        // 提示
                        showToolTip({
                            data: data,
                            success: showUsersByDepartmentId(),
                        });
                    }
                });
                dsmDialog.close(index);
            }
        });

    });
    [/@shiro.hasPermission]

    //异步提交表单
    function submitForm(v) {
        var index_0 = layer.load(2, {
            shade: [0.4, '#fff'] //0.1透明度的白色背景
        });
        var $frm = $(v.frm);
        $.ajax({
            type: "post",
            url: $frm.attr("action"),
            data: $frm.serialize(),
            dataType: "json",
            success: function (data) {
                layer.close(index_0);
                //提示
                if (data.type === "success") {
                    showToolTip({data: data});
                    refreshUserPageList();
                    v.success();//参数中传回来的函数
                } else {
                    dsmDialog.error(data.content);
                }

            },
            error: function (e) {
                dsmDialog.error("请求出错");
                if (typeof v.error === "function") {
                    v.error();
                }
            }
        })
    }

    //刷新zTree树(add：是否新增部门)
    function refreshDept(add) {
        var nodes = zTree.getSelectedNodes();
        if (nodes.length > 0) {
            if (nodes[0].id === 0) {
                zTree.reAsyncChildNodes(nodes[0], "refresh");
            } else {
                if (add) {//新增部门时刷新选中部门，否则刷新选中部门的父部门；
                    nodes[0].isParent = true;
                    zTree.reAsyncChildNodes(nodes[0], "refresh");
                } else {
                    zTree.reAsyncChildNodes(nodes[0].getParentNode(), "refresh");
                }
            }
        }
    }

    //
    function prepareForm(v) {

        var frm = $(v.frm);
        frm.attr('action', v.url)[0].reset();
        frm.find("input[name='ids']").remove();
        $("#list_form").find("input[name='ids']:checked").each(function () {
            frm.append('<input name="' + this.name + '" value="' + this.value + '" type="hidden" />');
        });
        if (v.show) {
            frm.find("input[name='containStatus']").parent().parent().show();
        } else {
            frm.find("input[name='containStatus']").parent().parent().hide();
        }
        frm.find('select.dsm-select').selectpicker('refresh');
    }

    $(document).ready(function () {
        zTreeInit({
            id: 'dsmOrgTree',
            url: '${base}/organization_management/department/tree.do',
            zTreeOnClick: function (event, treeId, treeNode) {
                departmentId = treeNode.id;
                $('#search_form input[name="include"]').val('0');
                //$('input.js_search_txt').removeClass('on').val('');
                showUsersByDepartmentId();
                checkDelDeptBtnStatus();
            },
            OnRightClick: function (event, treeId, treeNode, msg) {
                if (treeNode) {
                    departmentId = treeNode.id;
                    var node = zTrees['dsmOrgTree'].getNodeByParam("id", departmentId);
                    zTrees['dsmOrgTree'].selectNode(node);
                    $('#search_form input[name="include"]').val('0');
                    //$('input.js_search_txt').removeClass('on').val('');
                    showUsersByDepartmentId();
                }
                checkDelDeptBtnStatus();
            },
            zTreeOnAsyncSuccess: function (event, treeId, treeNode, msg) {
                var node = zTrees['dsmOrgTree'].getNodeByParam("id", departmentId);
                zTrees['dsmOrgTree'].selectNode(node);
                zTree = zTrees['dsmOrgTree'];
                checkDelDeptBtnStatus();
            },
            rMenu: {
                show: true,
                id: 'rDeptMenu',
            },
        });
        $('#addDeptForm input[name="parentId"]').val(departmentId);

        zTreeInit({
            id: 'dsmYdOrgTree',
            url: '${base}/organization_management/department/tree.do',
            zTreeOnClick: function (event, treeId, treeNode) {
                departmentId2 = treeNode.id;
            },
        });
    });
    $(document).ready(function () {

        //报表自适应宽度
        //window.onresize = adChartJust;
        showUsersByDepartmentId();

        $("#addDeptForm form").validate({
            rules: {
                name: {
                    required: true,
                    specialChar: true,
                    maxlength: 32
                },
                desc: {
                    maxlength: 256,
                },
            }
        });

        $("#addUserForm form").validate({
            ignore: ".ignore",
            rules: {
                name: {
                    required: true,
                    specialChar: true,
                    maxlength: 32,
                },
                account: {
                    required: true,
                    specialChar: true,
                    maxlength: 32,
                    /*remote: {
                        url: "${base}/admin/user/check_username.do",
							cache: false
						}*/
                },
                telephone: {
                    required: true,
                    telephoneChar: true,
                },
                post: {
                    maxlength: 64,
                },
                description: {
                    maxlength: 256,
                },
                /*rePassword: {
                    required: true,
                    equalTo: "#password"
                },*/
            },
            messages: {
                rePassword: {
                    equalTo: "*两次填写的密码不一致"
                }
            }
        });

        //jquery.validator.js表单验证--用户
        //现在是跳转页面了
    });

    function noDeptSelected() {
        var zNodes = zTree.getSelectedNodes();
        if (zNodes.length === 0) {
            dsmDialog.error("请先选择一个部门")
            return true;
        } else {
            return false;
        }
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


    function getCurrnetUser() {
        var $checked = $("#list_form :checked[name='ids']");
        if ($checked.length == 0 || $checked == undefined) {
            dsmDialog.msg("请选择审批人");
            return;
        }
        if ($checked.length > 1) {
            dsmDialog.msg("当前操作无法选择多个审批人");
            return;
        }
        var aprpoveName = $checked.parent("div").parent("td").parent().find('td').eq(1).text();
        return aprpoveName;
    }
</script>
</body>
</html>