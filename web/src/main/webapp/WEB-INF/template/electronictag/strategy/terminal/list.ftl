<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>终端策略</title>
    [#include "/include/head.ftl"]
    <script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
    <style>
        .highlight {background-color: yellow}
    </style>
    <script type="text/javascript" src="${base}/resources/dsm/js/highlight.js"></script>
</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">
        <div class="mainbox">
            [#assign searchMap='{
                	"deviceName":"名称",
                	"ipAddress":"ip地址",
                	"systemVersion":"系统版本",
                	"versionInform":"版本信息",
                	"connectStatus":"连接状态",
                	"scanStatus":"扫描状态"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <div id="position">
                <div class="btn-toolbar">
                    <div class="btnitem imp">
                        <a class="btn btn-primary js-delete-terminal"><i
                                    class="btnicon icon icon-delete-white"></i>删除终端信息</a>
                    </div>
                    <div class="btnitem imp">
                        <a class="btn btn-primary js-relate-user"><i
                                    class="btnicon icon icon-relate-white"></i>关联人员信息</a>
                    </div>
                    <div class="btnitem imp">
                        <a class="btn btn-primary js-relate-group"><i class="btnicon icon icon-relate-white"></i>关联策略信息</a>
                    </div>
                </div>
            </div>
            <div id="managerContent" style="margin-top: 10px">
                <div class="table-view">
                    <form id="list_form" >
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
                                <th>设备名称</th>
                                <th>IP地址</th>
                                <th>系统版本</th>
                                <th>账号信息</th>
                                <th>部门信息</th>
                                <th>版本信息</th>
                                <th>连接状态</th>
                                <th>策略信息</th>
                                <th>扫描状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </form>
                    <form id="search_form" action="search.do" data-func-name="refreshPage();" data-list-formid="datalist">
                        <input type="hidden" name="strategyName">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="addGrade" style="display:none;">
    <div class="dsmForms">
        <form id="gradeForm">
            <div class="dsm-form-item dsm-big">
                <div class="dsm-inline">
                    <label class="dsm-form-label">数据分级名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="gradeName" placeholder="数据分级名称" class="dsm-input required gradeName" >
                    </div>
                    <div class="desc"><em>*</em></div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">描述：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="gradeDesc" placeholder="描述" class="dsm-input required gradeDesc">
                    </div>
                </div>
                <input type="hidden" name="gradeId" class="gradeId">
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    //刷新分页列表
    function refreshPage(){
        refreshPageList({id :"search_form",
            pageSize:10,
            dataFormat :function(_data){
                var _id = _data.id;
                var computerName = _data.computerName == null ? "":_data.computerName;
                var systemVersion = _data.systemVersion == null ? "":_data.systemVersion;
                var clientVersion = _data.clientVersion == null ? "":_data.clientVersion;
                var connectStatus = _data.connectStatus == null ? "":_data.connectStatus;
                var scanStatus = _data.scanStatus == null ? "":_data.scanStatus;
                var userId = _data.userId == null ? "":_data.userId;
                var groupId = _data.groupId == null ? "":_data.groupId;
                var account = "";
                var department = "";
                var groupName = "";
                if(userId != ""){
                    $.ajax({
                        data: {userId: userId},
                        dataType: "json",
                        type: "get",
                        async: false,
                        url: "${base}/organization_management/user/getUserById.do",
                        success: function (_data) {
                            if (_data.account != null) {
                                account = _data.account;
                            }
                            if(_data.department != null){
                                department = _data.department.name;
                            }
                        }
                    });
                }

                if(groupId != ""){
                    $.ajax({
                        data: {id: groupId},
                        dataType: "json",
                        type: "get",
                        async: false,
                        url: "${base}/admin/strategy/group/getStrategyGroup.do",
                        success: function (_data) {
                            if (_data.groupName != null) {
                                groupName = _data.groupName;
                            }
                        }
                    });
                }

                var _text = "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' class='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td>"+computerName+"</td>\
								<td>"+_data.ip+"</td>\
								<td>"+systemVersion+"</td>\
				                <td>"+account+"</td>\
				                <td>"+department+"</td>\
				                <td>"+clientVersion+"</td>\
				                <td>"+connectStatus+"</td>\
				                <td>"+groupName+"</td>\
				                <td>"+scanStatus+"</td>\
						 	 </tr>";
                return _text;
            }});
    }

    $(function () {
        refreshPage();
    });

    //终端关联用户
    $(document).on('click', '.js-relate-user', function (e) {
        if(noItemSelected()){//如果终端没有勾选
            return;
        }
        dsmDialog.open({
            type: 2,
            area:['1200px','600px'],
            btn:['确定','取消'],
            content : "${base}/admin/permissionset/show.do",
            yes: function(index,layero) {
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() < 1){
                    dsmDialog.error("请选择用户!");
                    return false;
                }
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() > 1){
                    dsmDialog.error("用户只能选择一个!");
                    return false;
                }
                $.ajax({
                    dataType:"json",
                    type: "post",
                    url: "${base}/strategy/terminal/setUser.do",
                    data: {terminalId : $(".ids:checked").val(),
                           userId: $("#layui-layer-iframe"+index).contents().find(".ids:checked").val()},
                    success: function(data){
                        if(data && data.status === "200"){
                            dsmDialog.msg(data.msg);
                            refreshPage();
                        } else {
                            dsmDialog.error(data.msg);
                            refreshPage();
                        }
                    }
                });
                dsmDialog.close(index);
            }
        });
    });

    //终端关联组策略
    $(document).on('click', '.js-relate-group', function (e) {
        if(noItemSelected()){//如果终端没有勾选
            return;
        }
        dsmDialog.open({
            type: 2,
            area:['1200px','600px'],
            btn:['确定','取消'],
            content : "${base}/admin/strategy/group/list.do",
            yes: function(index,layero) {
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() < 1){
                    dsmDialog.error("请选择组策略!");
                    return false;
                }
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() > 1){
                    dsmDialog.error("组策略只能选择一个!");
                    return false;
                }
                $.ajax({
                    dataType:"json",
                    type: "post",
                    url: "${base}/strategy/terminal/setStrategyGroup.do",
                    data: {terminalId : $(".ids:checked").val(),
                           groupId : $("#layui-layer-iframe"+index).contents().find(".ids:checked").val()},
                    success: function(data){
                        if(data && data.status === "200"){
                            dsmDialog.msg(data.msg);
                            refreshPage();
                        } else {
                            dsmDialog.error(data.msg);
                            refreshPage();
                        }
                    }
                });
                dsmDialog.close(index);
            }
        });
    });

    //删除终端信息
    $(document).on('click', '.js-delete-terminal', function (e) {
        if(noItemSelected()){//如果用户没有勾选
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除终端"
        }, function(index){
            var ids_ = "";
            $("#list_form :checked[name='ids']").each(function(i){
                ids_ += $(this).val()+",";
            });
            $.ajax({
                dataType:"json",
                type: "post",
                url: "deleteTerminal.do",
                data: {ids : ids_},
                success: function(data){
                    if(data && data.status === "200"){
                        dsmDialog.msg(data.msg);
                        refreshPage();
                    } else {
                        dsmDialog.error(data.msg);
                        refreshPage();
                    }
                }
            });
        }, function(index){
            dsmDialog.close(index);
        });
    });

    //检查是否勾选数据分级
    function noItemSelected(){
        var ids_ = $("#list_form :checked[name='ids']");
        if(ids_.length === 0){
            dsmDialog.error("请先选择终端!");
            return true;
        }else{
            return false;
        }
    }
</script>
</body>
</html>