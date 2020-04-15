<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>策略规则配置</title>
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
                	"strategyName":"策略名称",
                	"strategyClassify":"类别",
                	"strategyLevel":"级别",
                	"createUserAccount":"创建者",
                	"strategyDesc":"描述"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <button type="button" class="btn btn-primary add-strategy">添加策略</button>
            <button type="button" class="btn btn-primary delete-strategy">删除策略</button>
[#--            <button type="button" class="btn btn-primary">修改策略</button>--]
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
                                <th>策略名称</th>
                                <th>类别</th>
                                <th>级别</th>
                                <th>创建者</th>
                                <th>描述</th>
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

<div id="addStrategy" style="display:none;">
    <div class="dsmForms">
        <form id="strategyForm">
            <div class="dsm-form-item dsm-big">
                <div class="dsm-inline">
                    <label class="dsm-form-label">策略名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="strategyName" placeholder="策略名称" class="dsm-input required strategyName">
                    </div>
                    <div class="desc"><em>*</em></div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">描述：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="strategyDesc" placeholder="描述" class="dsm-input required strategyDesc">
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">数据分类：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="dataClassifyName" placeholder="请选择数据分类" class="dsm-input required dataClassifyName">
                    </div>
                    <button type="button" class="btn btn-primary">选择</button>
                    <button type="button" class="btn btn-primary">清除</button>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">数据分级：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="dataGradeName" placeholder="请选择数据分级" class="dsm-input required dataGradeName">
                    </div>
                    <button type="button" class="btn btn-primary">选择</button>
                    <button type="button" class="btn btn-primary">清除</button>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">扫描类型：</label>
                    <div class="dsm-input-inline">
                        <input id="scanType01" type="radio" value="0" class="scanType" name="scanType" style="margin-top: 5px;margin-left: 10px" checked>落地扫描</input>
                        <input id="scanType02" type="radio" value="1" class="scanType" name="scanType" style="margin-left: 10px">全盘扫描</input>
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">检测规则：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="ruleName" class="dsm-input required ruleName">
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">响应规则：</label>
                    <div class="dsm-input-inline">
                        <input id="responseType01" type="radio" value="0" class="responseType" name="responseType" style="margin-top: 5px;margin-left: 10px" checked>发现审计</input><br>
                        <input id="responseType02" type="radio" value="2" class="responseType" name="responseType" style="margin-left: 10px">文件加密</input><br>
                        <input id="responseType03" type="radio" value="1" class="responseType" name="responseType" style="margin-left: 10px">内容脱敏</input>
                        <input type="text" autocomplete="off" name="maskRuleName" class="dsm-input required maskRuleName">
                    </div>
                </div>

                <input type="hidden" id="strategyId" name="strategyId"/>
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
                var dataClassifyName = "";
                $.ajax({
                    data: {id: _data.dataClassifyId},
                    dataType: "json",
                    type: "get",
                    async: false,
                    url: "${base}/admin/data/classify/getSmallClassify.do",
                    success: function (data) {
                        if(data.classifyName != null) {
                            dataClassifyName = data.classifyName;
                        }
                    }
                });
                var dataGradeName = "";
                $.ajax({
                    data: {id: _data.dataGradeId},
                    type: "get",
                    async: false,
                    url: "${base}/admin/data/grade/getDataGrade.do",
                    success: function (data) {
                        if(data.gradeName != null){
                            dataGradeName = data.gradeName;
                        }
                    }
                });
                var _text = "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td><a onclick='getDetails(\"" + _id + "\")'>"+_data.strategyName+"</a></td> \
								<td><div>"+ dataClassifyName +"</td></div>\
								<td><div>"+ dataGradeName+"</td></div>\
								<td><div>"+_data.createUserAccount+"</td></div>\
								<td>"+_data.strategyDesc+"</td>\
						 	 </tr>";
                return _text;
            }});
    }

   $(function () {
       refreshPage();
   });

    $(document).on('click', '.add-strategy', function (e) {
        $("#strategyForm")[0].reset();
        $("#scanType01").prop("checked","checked");
        $("#responseType01").prop("checked","checked");
        dsmDialog.open({
            type: 1,
            area:['1000px','600px'],
            title:"新增策略规则",
            btn:['添加','取消'],
            content : $("#addStrategy"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#strategyForm').serialize(),
                    type:"post",
                    url:"addStrategy.do",
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
            } ,
            no : function(index,layero) {
                dsmDialog.close(index);
            }
        });
        refreshPage();
    });

    //删除规则
    $(document).on('click', '.delete-strategy', function (e) {
        if(noItemSelected()){//如果用户没有勾选
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除策略"
        }, function(index){
            var ids_ = "";
            $("#list_form :checked[name='ids']").each(function(i){
                ids_ += $(this).val()+",";
            });
            $.ajax({
                dataType:"json",
                type: "post",
                url: "deleteStrategy.do",
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

    //检查是否勾选策略
    function noItemSelected(){
        var ids_ = $("#list_form :checked[name='ids']");
        if(ids_.length === 0){
            dsmDialog.error("请先选择策略!");
            return true;
        }else{
            return false;
        }
    }

    //获取策略详细信息
    function getDetails(strategyId){
        $.ajax({
            data: {id: strategyId},
            dataType: "json",
            type: "get",
            url: "showStrategy.do",
            success: function (data){
                var strategyRuleEntities = data.strategyRuleEntities;
                var strategyMaskRuleEntities = data.strategyMaskRuleEntities;
                $(".strategyName").val(data.strategyName);
                $(".strategyDesc").val(data.strategyDesc);
                $.ajax({
                    data: {id: data.dataClassifyId},
                    dataType: "json",
                    type: "get",
                    url: "${base}/admin/data/classify/getSmallClassify.do",
                    success: function (data) {
                        $(".dataClassifyName").val(data.classifyName);
                    }
                });
                $.ajax({
                    data: {id: data.dataGradeId},
                    dataType: "json",
                    type: "get",
                    url: "${base}/admin/data/grade/getDataGrade.do",
                    success: function (data) {
                        $(".dataGradeName").val(data.gradeName);
                    }
                });
                if(data.scanTypeCode === "0"){
                    $("#scanType01").prop("checked","checked");
                }else {
                    $("#scanType02").prop("checked","checked");
                }
                if(data.responseTypeCode === "0"){
                    $("#responseType01").prop("checked","checked");
                }else if(data.responseTypeCode === "1"){
                    $("#responseType03").prop("checked","checked");
                }else {
                    $("#responseType02").prop("checked","checked");
                }
                $(".ruleName").val(strategyRuleEntities[0].ruleName);
                $(".maskRuleName").val(strategyMaskRuleEntities[0].ruleName);
                $("#strategyId").val(data.id);
            }
        });
        dsmDialog.open({
            type: 1,
            area:['1000px','600px'],
            btn:['修改','取消'],
            title:"修改策略",
            content : $("#addStrategy"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#strategyForm').serialize(),
                    type:"post",
                    url:"updateStrategy.do",
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
            } ,
            no : function(index,layero) {
                dsmDialog.close(index);
            }
        });
    }

</script>
</body>
</html>