<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>组策略</title>
    [#include "/include/head.ftl"]
    <script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
    <style>
        .highlight {background-color: yellow}
        /*箭头向上*/
        .to_top {
            width: 0;
            height: 0;
            border-bottom: 10px solid #ccc;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            float: left;
        }
        /*箭头向下*/
        .to_bottom {
            width: 0;
            height: 0;
            border-top: 10px solid #ccc;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            float: left;
        }
    </style>
    <script type="text/javascript" src="${base}/resources/dsm/js/highlight.js"></script>
</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">
        <div class="mainbox">
            [#assign searchMap='{
                	"groupName":"名称",
                	"createUserAccount":"创建者",
                	"groupDesc":"描述"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <button type="button" class="btn btn-primary add-strategy-group">新增组策略</button>
            <button type="button" class="btn btn-primary delete-strategy-group">删除组策略</button>
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
                                <th>组策略名称</th>
                                <th>创建者</th>
                                <th>描述</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </form>
                    <form id="search_form" action="search.do" data-func-name="refreshPage();" data-list-formid="datalist">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="addStrategyGroup" style="display:none;">
    <div class="dsmForms">
        <form id="strategyGroupForm">
            <div class="dsm-form-item dsm-big">
                <div class="dsm-inline">
                    <label class="dsm-form-label">组策略名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="groupName" placeholder="组策略名称" class="dsm-input required groupName" >
                    </div>
                    <div class="desc"><em>*</em></div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">描述：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="groupDesc" placeholder="描述" class="dsm-input required groupDesc">
                    </div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">添加策略：</label>
                    <div class="dsm-input-inline">
                        <button type="button" class="btn btn-primary choose-strategy" style="float: left;margin-top: 10px">选择</button>
                        <button type="button" class="btn btn-primary remove-strategy" style="margin-top: 10px">删除</button>
                        <div class="table-view addStrategy" style="width: 600px;height: auto;position: relative;margin-top: 20px">
                            <table id="strategyForm" class="strategyForm table" width="100%" cellspacing="0">
                                <thead>
                                <tr style="height: 40px">
                                    <th class="w40">
                                        <div class="dsmcheckbox" style="margin-left: 10px">
                                            <input type="checkbox" value="1" id="checkboxFiveInput1"
                                                   class="js_checkboxAll1" data-allcheckfor="strategyIds">
                                            <label for="checkboxFiveInput1"></label>
                                        </div>
                                    </th>
                                    <th>策略名称</th>
                                    <th>类别</th>
                                    <th>级别</th>
                                    <th>优先级</th>
                                    <th>描述</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <input type="hidden" class="strategyId" name="strategyId">
                <input type="hidden" class="groupId" name="groupId">
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
                var _text = "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' class='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td><a onclick='getDetails(\"" + _id + "\")'>"+_data.groupName+"</a></td>\
								<td>"+_data.createUserAccount+"</td>\
								<td>"+_data.groupDesc+"\
						 	 </tr>";
                return _text;
            }});
    }

    $(function () {
        refreshPage();
    });

    //增加组策略
    $(document).on('click', '.add-strategy-group', function (e) {
        $("#strategyGroupForm")[0].reset();
        $(".strategyForm tbody").html("");
        $("input[type=hidden]").val("");
        dsmDialog.open({
            type: 1,
            area:['900px','500px'],
            title:"新增组策略",
            btn:['添加','取消'],
            content : $("#addStrategyGroup"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#strategyGroupForm').serialize(),
                    type:"post",
                    url:"addStrategyGroup.do",
                    dataType:"json",
                    success: function(data) {
                        if(data.status == "500"){
                            dsmDialog.error(data.msg);
                        }else {
                            dsmDialog.msg(data.msg);
                            dsmDialog.close(index);
                            refreshPage();
                        }
                    },
                    error: function() {
                        dsmDialog.msg("网络错误,请稍后尝试");
                    }
                });
            }
        });
    });

    //删除组策略
    $(document).on('click', '.delete-strategy-group', function (e) {
        if(noItemSelected()){//如果用户没有勾选
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除组策略"
        }, function(index){
            var ids_ = "";
            $("#list_form :checked[name='ids']").each(function(i){
                ids_ += $(this).val()+",";
            });
            $.ajax({
                dataType:"json",
                type: "post",
                url: "deleteStrategyGroup.do",
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

    //检查是否勾选组策略
    function noItemSelected(){
        var ids_ = $("#list_form :checked[name='ids']");
        if(ids_.length === 0){
            dsmDialog.error("请先选择组策略!");
            return true;
        }else{
            return false;
        }
    }

    //获取组策略详情
    function getDetails(id) {
        $.ajax({
            data: {id: id},
            dataType: "json",
            type: "get",
            url: "getStrategyGroup.do",
            success: function (data){
                $(".groupName").val(data.groupName);
                $(".groupDesc").val(data.groupDesc);
                var strategyEntities = data.strategyEntities;
                var html = "";
                console.log(strategyEntities.length);
                for(var index in strategyEntities){
                    var idPriority = strategyEntities[index].id.split(";");
                    var _id = idPriority[0];
                    var priority = parseInt(idPriority[1]);
                    var priorityHtml = "";
                    if(priority === 0 && strategyEntities.length === 1){
                        priorityHtml = "<a priority='"+priority+"'></a>";
                    }else if(priority === 0 && strategyEntities.length > 1){
                        priorityHtml = "<a class='to_bottom' priority='"+priority+"' onclick='moveDown(this)'></a>";
                    }else if(priority === strategyEntities.length - 1){
                        priorityHtml = "<a class='to_top' priority='"+priority+"' onclick='moveUp(this)'></a>";
                    }else {
                        priorityHtml = "<a class='to_top' priority='"+priority+"' onclick='moveUp(this)'></a><a class='to_bottom' onclick='moveDown(this)'></a>"
                    }
                    html += "<tr>\
								<td><div class='dsmcheckbox' style='margin-left: 10px'>\
								<input type='checkbox' name='strategyIds' class='strategyIds' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td>"+strategyEntities[index].strategyName+"</td>\
								<td>"+strategyEntities[index].dataClassifySmallEntity.classifyName+"</td>\
								<td>"+strategyEntities[index].dataGradeEntity.gradeName+"</td>\
								<td>"+priorityHtml+"</td>\
								<td>"+strategyEntities[index].strategyDesc+"</td>\
						 	 </tr>";
                }
                $(".strategyForm tbody").html(html);
                var strategyId = "";
                $(".strategyForm").find("input[name=strategyIds]").each(function (i) {
                    var priority = parseInt($(this).parents("tr").find("a:first-child").attr("priority"));
                    if(i !== priority){
                        changeNode($(this).parents("tr").get(0),$(this).parents("tbody").find("tr").eq(priority).get(0),false);
                    }
                    strategyId += $(this).val()+";"+priority+",";
                });
                $(".strategyId").val(strategyId);
                $(".groupId").val(id);
            }
        });

        dsmDialog.open({
            type: 1,
            area:['900px','500px'],
            title:"修改组策略",
            btn:['修改','取消'],
            content : $("#addStrategyGroup"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#strategyGroupForm').serialize(),
                    type:"post",
                    url:"updateStrategyGroup.do",
                    dataType:"json",
                    success: function(data) {
                        if(data.status == "500"){
                            dsmDialog.error(data.msg);
                        }else {
                            dsmDialog.msg(data.msg);
                            dsmDialog.close(index);
                            refreshPage();
                        }
                    },
                    error: function() {
                        dsmDialog.msg("网络错误,请稍后尝试");
                    }
                });
            }
        });
    }

    //选择策略
    $(document).on('click', '.choose-strategy', function (e) {
        dsmDialog.open({
            type: 2,
            area:['1050px','650px'],
            title:"选择策略",
            btn:['确认','取消'],
            content: "${base}/admin/strategy/list.do",
            yes: function(index,layero) {
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() < 1){
                    dsmDialog.error("请选择策略!");
                    return false;
                }
                var html = "";
                var isSelected = false;
                $("#layui-layer-iframe"+index).contents().find(".ids:checked").each(function (i) {
                    var _id = $(this).val();
                    $(".strategyForm").find("input[name=strategyIds]").each(function () {
                        if(_id === $(this).val()){
                            dsmDialog.error("存在策略已被选择!");
                            isSelected = true;
                            return false;
                        }
                    });
                    if(isSelected === true){
                        return false;
                    }
                    var strategyName = $(this).parents("tr").find("td").eq(1).text();
                    var strategyDesc = $(this).parents("tr").find("td").eq(5).text();
                    var classifyName = $(this).parents("tr").find("td").eq(2).text();
                    var gradeName = $(this).parents("tr").find("td").eq(3).text();
                    html += "<tr>\
								<td><div class='dsmcheckbox' style='margin-left: 10px'>\
								<input type='checkbox' name='strategyIds' class='strategyIds' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td>"+strategyName+"</td>\
								<td>"+classifyName+"</td>\
								<td>"+gradeName+"</td>\
								<td></td>\
								<td>"+strategyDesc+"</td>\
						 	 </tr>";
                });
                if(isSelected === true){
                    return false;
                }
                $(".strategyForm tbody").append(html);
                refreshPriority();
                dsmDialog.close(index);
            }
        });
    });

    /*全选策略*/
    $(document).on("click", ".js_checkboxAll1", function(){
        var vchecked=this.checked;
        $('[name='+$(this).data('allcheckfor')+']:checkbox').each(function(){
            this.checked=vchecked;
        });
    });

    //优先级上移
    function moveUp(obj) {
        var tr = obj.parentNode.parentNode;
        changeNode(tr,tr.previousSibling,true);
    }

    //优先级下移
    function moveDown(obj) {
        var tr = obj.parentNode.parentNode;
        changeNode(tr,tr.nextSibling,true);
    }

    //交换tr元素并刷新优先级
    function changeNode(node1,node2,isRefresh) {
        var _parent=node1.parentNode;
        //获取两个结点的相对位置
        var _t1=node1.nextSibling;
        var _t2=node2.nextSibling;
        //将node2插入到原来node1的位置
        if(_t1) {
            _parent.insertBefore(node2,_t1);
        } else{
            _parent.appendChild(node2);
        }
        //将node1插入到原来node2的位置
        if(_t2){
            _parent.insertBefore(node1,_t2);
        } else{
            _parent.appendChild(node1);
        }
        if(isRefresh){
            refreshPriority();
        }
    }

    //刷新优先级
    function refreshPriority() {
        var strategyIds = "";
        if($(".strategyForm").find("input[name=strategyIds]").size() === 2){
            $(".strategyForm").find("tr").eq("1").find("td").eq("4").html("<a class='to_bottom' priority='0' onclick='moveDown(this)'></a>");
            $(".strategyForm").find("tr").eq("2").find("td").eq("4").html("<a class='to_top' priority='1' onclick='moveDown(this)'></a>");
            $(".strategyForm").find("input[name=strategyIds]").each(function (i) {
                strategyIds += $(this).val()+";"+ i +",";
            });
        }else if($(".strategyForm").find("input[name=strategyIds]").size() >=3){
            $(".strategyForm").find("input[name=strategyIds]").each(function (i) {
                if(i === 0){
                    $(this).parents("tr").find("td").eq("4").html("<a class='to_bottom' priority='"+i+"' onclick='moveDown(this)'></a>");
                }else if( i === $(".strategyForm").find("input[name=strategyIds]").size() - 1){
                    $(this).parents("tr").find("td").eq("4").html("<a class='to_top' priority='"+i+"' onclick='moveUp(this)'></a>");
                }else {
                    $(this).parents("tr").find("td").eq("4").html("<a class='to_top' priority='"+i+"' onclick='moveUp(this)'></a><a class='to_bottom' onclick='moveDown(this)'></a>");
                }
                strategyIds += $(this).val()+";"+ i +",";
            });
        }else if($(".strategyForm").find("input[name=strategyIds]").size() == 1){
            $(".strategyForm").find("tr").eq("1").find("td").eq("4").html("");
            strategyIds = $(".strategyForm").find("input[name=strategyIds]").val()+";0";
        }
        $(".strategyId").val(strategyIds);
    }

    //删除策略
    $(document).on("click", ".remove-strategy", function(){
        $(".strategyForm").find("input[name=strategyIds]:checked").each(function () {
            var tr = $(this).parents("tr");
            tr.remove();
        });
        refreshPriority();
    });
</script>
</body>
</html>