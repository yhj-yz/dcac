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
                        <a class="btn btn-primary js-add-department"><i class="btnicon icon icon-add-white"></i>新增部门</a>
                    </div>
                    <div class="btnitem imp">
                        <a class="btn btn-primary js-update-department"><i class="btnicon icon icon-update-white"></i>修改部门</a>
                    </div>
                    <div class="btnitem imp">
                        <a class="btn btn-primary js-delete-department"><i class="btnicon icon icon-delete-white"></i>删除部门</a>
                    </div>
                    <div class="btnitem imp" style="margin-left: 50px">
                        <a class="btn btn-primary js-add-user"><i class="btnicon icon icon-add-white"></i>新增用户</a>
                    </div>
                    <div class="btnitem imp">
                        <a class="btn btn-primary js-delete-user"><i class="btnicon icon icon-delete-white"></i>删除用户</a>
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
                                <th>状态</th>
                                <th>账号</th>
                                <th>姓名</th>
                                <th>所属角色</th>
                                <th>密码校验方式</th>
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

<!--新增部门 -->
<div id="addDepartment" style="display:none;">
    <div class="dsmForms">
        <form id="departmentForm">
            <div class="dsm-form-item dsm-big">
                <div class="dsm-inline">
                    <label class="dsm-form-label">部门名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="departmentName" placeholder="部门名称" class="dsm-input required departmentName" >
                    </div>
                    <div class="desc"><em>*</em></div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">描述：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="departmentDesc" placeholder="描述" class="dsm-input required departmentDesc">
                    </div>
                </div>
            </div>
            <input type="hidden" name="departmentId" class="departmentId">
        </form>
    </div>
</div>

<!--新增用户-->
<div id="addUser" style="display: none">
    <form id="userForm">
        <div class="dsmForms">
            <div class="dsm-form-item dsm-big">
                <input type="hidden" id="departmentId" name="departmentId">
                <input type="hidden" name="userId" id="userId">
                <div class="dsm-inline">
                    <label class="dsm-form-label">账号：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="account" id="account" placeholder="账号"
                               class="dsm-input required account">
                    </div>
                    <div class="desc"><em>*</em></div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">姓名：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="name" id="name" placeholder="姓名"
                               class="dsm-input required name">
                    </div>
                    <div class="desc"><em>*</em></div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">密码：</label>
                    <div class="dsm-input-inline">
                        <input type="password" autocomplete="off" name="password" id="password"
                               class="dsm-input required password">
                    </div>
                    <div class="desc"><em>*</em></div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">确认密码：</label>
                    <div class="dsm-input-inline">
                        <input type="password" autocomplete="off" name="passwordSure" id="passwordSure"
                               class="dsm-input required passwordSure">
                    </div>
                    <div class="desc"><em>*</em></div>
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
    var departmentId = 0, departmentId2 = 2, zTree;

    //点击部门显示用户
    function showUsersByDepartmentId() {
        $("#search_form").attr("action", "${base}/organization_management/user/dept.do?deptId=" + departmentId);
        refreshUserPageList();
    }

    //检查是否勾选
    function noItemSelected() {
        var ids_ = $("#list_form :checked[name='ids']");
        if (ids_.length === 0) {
            dsmDialog.error("请先选择用户!");
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
            dsmDialog.error("请先选择用户!");
            return false;
        } else {
            dsmDialog.error("所选用户过多，该功能只支持勾选单个用户");
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

    //刷新用户分页列表
    function refreshUserPageList() {
        refreshPageList({
            id: "search_form",
            pageSize: 10,
            dataFormat: function (_data) {
                var _id = _data.id;
                var _result = function (v) {
                    return v === true ? "是" : "否";
                }
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
                    "<input type='checkbox' name='ids' class='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + isOnlineTitile + "'>" + isOnline + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + _data.account + "'><a onclick='getUserDetail(\""+_id+"\")'>" + _data.account + "</a></div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + _data.name + "'>" + _data.name + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + roleName + "'>" + roleName + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + backupName + "'>" + backupName + "</div></td>" +
                    "</tr>";
                return _text;
            }
        });

    }

    //删除用户
    $(document).on('click', '.js-delete-user', function (e) {
        if (noItemSelected()) {//如果用户没有勾选
            return;
        }
        dsmDialog.toComfirm("是否删除选中的用户？", {
            btn: ['确定', '取消'],
            title: "删除用户"
        }, function (index) {
            var ids_ = "";
            $("#list_form :checked[name='ids']").each(function(i){
                ids_ += $(this).val()+",";
            });
            $.ajax({
                dataType: "json",
                type: "post",
                url: "${base}/organization_management/user/deleteUser.do",
                data: {ids : ids_},
                success: function (data) {
                    if(data && data.status === "200"){
                        dsmDialog.msg(data.msg);
                        refreshUserPageList();
                    } else {
                        dsmDialog.error(data.msg);
                        refreshUserPageList();
                    }
                }
            });

        }, function (index) {
            dsmDialog.close(index);
        });

    });

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

    //新增用户
    $(document).on('click', '.js-add-user', function (e) {
        if (noDeptSelected()) {
            return;
        }
        $("#userForm")[0].reset();
        $("#departmentId").val(departmentId);
        dsmDialog.open({
            type: 1,
            area: ['750px', '440px'],
            title: "新增用户",
            content: $('#addUser'),
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                $.ajax({
                    data:$('#userForm').serialize(),
                    type:"post",
                    url:"${base}/organization_management/user/addUser.do",
                    dataType:"json",
                    success: function(data) {
                        if(data.status == "500"){
                            dsmDialog.error(data.msg);
                        }else {
                            dsmDialog.msg(data.msg);
                            dsmDialog.close(index);
                            refreshUserPageList();
                        }
                    },
                    error: function() {
                        dsmDialog.msg("网络错误,请稍后尝试");
                    }
                });
            }
        });

    });
    //修改用户
    function getUserDetail(userId){
        $.ajax({
            data: {userId: userId},
            dataType: "json",
            type: "get",
            url: "${base}/organization_management/user/getUserById.do",
            success: function (data) {
                $("#account").val(data.account);
                $("#name").val(data.name);
                $("#password").val(data.password);
                $("#passwordSure").val(data.password);
                $("#userId").val(userId);
            }
        });
        dsmDialog.open({
            type: 1,
            area: ['750px', '440px'],
            title: "修改用户",
            content: $('#addUser'),
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                $.ajax({
                    data:$('#userForm').serialize(),
                    type:"post",
                    url:"${base}/organization_management/user/updateUser.do",
                    dataType:"json",
                    success: function(data) {
                        if(data.status == "500"){
                            dsmDialog.error(data.msg);
                        }else {
                            dsmDialog.msg(data.msg);
                            dsmDialog.close(index);
                            refreshUserPageList();
                        }
                    },
                    error: function() {
                        dsmDialog.msg("网络错误,请稍后尝试");
                    }
                });
            }
        });

    }

    //新增部门
    $(document).on('click', '.js-add-department', function (e) {
        if (noDeptSelected()) {
            return;
        }
        $("#departmentForm")[0].reset();
        $(".departmentId").val(departmentId);
        dsmDialog.open({
            type: 1,
            area: ['750px', '350px'],
            btn: ['确定', '取消'],
            title: "新增部门",
            content: $('#addDepartment'),
            yes: function (index, layero) {
                $.ajax({
                    data:$('#departmentForm').serialize(),
                    type:"post",
                    url:"${base}/organization_management/department/addDepartment.do",
                    dataType:"json",
                    success: function(data) {
                        if(data.status == "500"){
                            dsmDialog.error(data.msg);
                        }else {
                            dsmDialog.msg(data.msg);
                            dsmDialog.close(index);
                            refreshDept(true);
                        }
                    },
                    error: function() {
                        dsmDialog.msg("网络错误,请稍后尝试");
                    }
                });
            }
        });

    });
    //修改部门
    $(document).on('click', '.js-update-department', function (e) {
        if (noDeptSelected()) {
            return;
        }
        $(".departmentId").val(departmentId);
        $.ajax({
            data: {id: departmentId},
            dataType: "json",
            type: "get",
            url: "${base}/organization_management/department/getDepartmentById.do",
            success: function (data){
                $(".departmentName").val(data.name);
                $(".departmentDesc").val(data.desc);
            }
        });
        dsmDialog.open({
            type: 1,
            area: ['750px', '350px'],
            btn: ['确定', '取消'],
            title: "修改部门",
            content: $('#addDepartment'),
            yes: function (index, layero) {
                $.ajax({
                    data:$('#departmentForm').serialize(),
                    type:"post",
                    url:"${base}/organization_management/department/updateDepartment.do",
                    dataType:"json",
                    success: function(data) {
                        if(data.status == "500"){
                            dsmDialog.error(data.msg);
                        }else {
                            dsmDialog.msg(data.msg);
                            dsmDialog.close(index);
                            refreshDept(false);
                        }
                    },
                    error: function() {
                        dsmDialog.msg("网络错误,请稍后尝试");
                    }
                });
            }
        });

    });
    //删除部门
    $(document).on('click', '.js-delete-department', function (e) {
        if (noDeptSelected()) {
            return;
        }
        dsmDialog.toComfirm("是否删除选中的部门？", {
            btn: ['确定', '取消'],
            title: "删除部门"
        }, function (index) {
            //删除操作代码
            $.ajax({
                dataType: "json",
                type: "post",
                data: {id: departmentId},
                url: "${base}/organization_management/department/deleteDepartment.do",
                success: function (data) {
                    if(data.status == "500"){
                        dsmDialog.error(data.msg);
                    }else {
                        dsmDialog.msg(data.msg);
                        dsmDialog.close(index);
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

    //刷新zTree树(add：是否新增部门)
    function refreshDept(add) {
        var nodes = zTree.getSelectedNodes();
        console.log(nodes);
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
            },
            zTreeOnAsyncSuccess: function (event, treeId, treeNode, msg) {
                var node = zTrees['dsmOrgTree'].getNodeByParam("id", departmentId);
                zTrees['dsmOrgTree'].selectNode(node);
                zTree = zTrees['dsmOrgTree'];
                console.log(node);
                // var nodes = zTree.getNodes();
                // for(var i=0;i<nodes.length;i++){
                //     var node1=nodes[i];
                //     zTree.expandNode(node1);
                // }
            },
            rMenu: {
                show: true,
                id: 'rDeptMenu'
            },
        });
        $('#departmentForm input[name="parentId"]').val(departmentId);

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
            dsmDialog.error("请先选择一个部门");
            return true;
        } else {
            return false;
        }
    }
</script>
</body>
</html>