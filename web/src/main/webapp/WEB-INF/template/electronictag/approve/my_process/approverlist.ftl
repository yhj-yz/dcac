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
            position: fixed;
            height: 50px;
            top: 0;
            padding: 10px;
            z-index: 999;
            background-color: #eee;
            width: 100%;
            border-bottom: 1px solid #bbb;
        }
    </style>
</head>
<body>
<div class="dsm-rightside depuserslist">

        <div class="main-right" style="left: 0px;top: 0px;height:95%">
            <div class="table-view table-org">
                <form id="list_form" >
                    <table id="datalist" class="table table-bordered table-hover" cellspacing="0" width="100%">
                        <thead>
                        <tr>
                            <th  class="w40">
                                <div class="dsmcheckbox">
                                    <input type="checkbox" id="maid" class="js_checkboxAll" data-allcheckfor="ids" >
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
[#--        <form id="search_form" data-func-name="refreshUserPageList();" data-list-formid="datalist">--]
[#--            <input type="hidden" name="name" >--]
[#--            <input type="hidden" name="include" value="0">--]
[#--            <input type="hidden" name="departmentId">--]
[#--        </form>--]

</div>
</div>
<script type="text/javascript">

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

    var approveUserType = $("body", parent.document).find("input[name=approveUserType]:checked").val();
    console.log("approveUserType",approveUserType);
    var url = "${base}/process_management/findapproverlist.do?approveUserType="+approveUserType;
    $.ajax({
        type: "get",
        url: url,
        dataType: "json",
        success: function (data) {
            var val = '';
            for (var i = 0; i < data.length; i++) {
                var _data = data[i];
                var _id = _data.id;
                var levelName = _data.belongSecurity ? _data.belongSecurity.securityName : "-";
                var permissionSetName = _data.permissionSet ? _data.permissionSet.permissionSetName : "-";
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
                    "<td class='hiddentd'><div class='hiddendiv' title='" + permissionSetName + "'>" + permissionSetName + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + controlName + "'>" + controlName + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + roleName + "'>" + roleName + "</div></td>" +
                    "<td class='hiddentd'><div class='hiddendiv' title='" + isOnlineTitile + "'>" + isOnline + "</div></td>" +
                    "</tr>";
                val += _text;
            }
            $("#datalist tbody").html(val);
        },
        error: function (e) {
            dsmDialog.error("请求出错");
            if (typeof v.error === "function") {
                v.error();
            }
        }
    });

</script>
</body>
</html>