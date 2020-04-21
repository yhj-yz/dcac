<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>策略规则配置</title>
    [#include "/include/head.ftl"]
    <script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
    <style>
        .highlight {background-color: yellow}
        .table-a td{border: 1px solid #e4eaec}
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
                        <input type="text" autocomplete="off" placeholder="请选择数据分类" class="dsm-input required dataClassifyName" readonly>
                        <input type="hidden" class="dataClassifyId" name="dataClassifyId">
                    </div>
                    <button type="button" class="btn btn-primary choose-dataClassify">选择</button>
                    <button type="button" class="btn btn-primary remove-dataClassify">清除</button>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">数据分级：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" placeholder="请选择数据分级" class="dsm-input required dataGradeName" readonly>
                        <input type="hidden" name="dataGradeId" class="dataGradeId">
                    </div>
                    <button type="button" class="btn btn-primary choose-dataGrade">选择</button>
                    <button type="button" class="btn btn-primary remove-dataGrade">清除</button>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">扫描类型：</label>
                    <div class="dsm-input-inline" style="width: auto">
                        <input id="scanType01" type="radio" value="0" class="scanType" name="scanType" style="margin-top: 5px;margin-left: 10px" checked>落地扫描</input>
                        <input id="scanType02" type="radio" value="1" class="scanType" name="scanType" style="margin-left: 10px">全盘扫描</input>
                        <input id="scanType03" type="radio" value="2" class="scanType" name="scanType" style="margin-left: 10px">指定路径</input>
                        <input type="text" autocomplete="off" name="scanPath" class="dsm-input required scanPath" style="width: auto;float: right;height:22px;display: none">
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">检测规则：</label>
                    <button type="button" class="btn btn-primary choose-rule" style="float: left;margin-left: 20px">选择</button>
                    <button type="button" class="btn btn-primary remove-rule" style="float: left;">删除</button>
                    <div class="dsm-input-inline table-view" style="width: 600px;height: auto;right: 150px;top:50px;position: relative">
                        <table class="table ruleForm" width="100%" cellspacing="0">
                            <thead>
                            <tr style="height: 40px">
                                <th>规则名称</th>
                                <th>描述</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="dsm-inline" style="top: 40px">
                    <label class="dsm-form-label">响应规则：</label>
                    <div class="dsm-input-inline">
                        <input id="responseType01" type="radio" value="0" class="responseType" name="responseType" style="margin-top: 5px;margin-left: 10px" checked>发现审计</input><br>
                        <input id="responseType02" type="radio" value="2" class="responseType" name="responseType" style="margin-left: 10px">文件加密</input><br>
                        <input id="responseType03" type="radio" value="1" class="responseType" name="responseType" style="margin-left: 10px">内容脱敏</input><br>
                        <button type="button" class="btn btn-primary choose-maskRule" style="display: none;float: left;margin-top: 10px">选择</button>
                        <button type="button" class="btn btn-primary remove-maskRule" style="display: none;margin-top: 10px">删除</button>
                        <div class="table-view addMaskRule" style="width: 600px;height: auto;display: none;position: relative;margin-top: 20px">
                            <table class="maskRuleForm table"  width="100%" cellspacing="0">
                                <thead>
                                <tr style="height: 40px">
                                    <th class="w40">
                                        <div class="dsmcheckbox" style="margin-left: 10px">
                                            <input type="checkbox" value="1" id="checkboxFiveInput1"
                                                   class="js_checkboxAll1" data-allcheckfor="maskRuleIds">
                                            <label for="checkboxFiveInput1"></label>
                                        </div>
                                    </th>
                                    <th style="width: 100px">脱敏规则名称</th>
                                    <th>规则类型</th>
                                    <th>待脱敏内容</th>
                                    <th>脱敏方式</th>
                                    <th>脱敏后内容</th>
                                    <th>描述</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div style="width: auto;margin-top: 10px">
                            <input type="checkbox" class="isMatch" style="float: left;zoom: 150%">
                            <div class="dsm-input-inline" style="float:left;bottom: 20px">匹配数大于
                                <input type="text" class="matchValue" name="matchValue" style="width: 50px;height: 22px" value="0" readonly>
                                0表示不限制
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" class="maskRuleId" name="maskRuleId">
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
                var _text = "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' class='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td><a onclick='getDetails(\"" + _id + "\")'>"+_data.strategyName+"</a></td> \
								<td><div>"+ _data.dataClassifySmallEntity.classifyName +"</td></div>\
								<td><div>"+ _data.dataGradeEntity.gradeName +"</td></div>\
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
        $("input[type=hidden]").val("");
        $(".ruleForm tbody").html("");
        $(".maskRuleForm tbody").html("");
        $(".addMaskRule").css("display","none");
        $(".choose-maskRule").css("display","none");
        $(".remove-maskRule").css("display","none");
        $(".scanPath").css("display","none");
        var maskRuleId = "";
        $(".maskRuleForm :checked[name='maskRuleIds']").each(function(i){
            maskRuleId += $(this).val()+",";
        });
        $(".maskRuleId").val(maskRuleId);
        dsmDialog.open({
            type: 1,
            area:['950px','550px'],
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
                $(".dataClassifyName").val(data.dataClassifySmallEntity.classifyName);
                $(".dataClassifyId").val(data.dataClassifySmallEntity.id);
                $(".dataGradeName").val(data.dataGradeEntity.gradeName);
                $(".dataGradeId").val(data.dataGradeEntity.id);

                if(data.scanTypeCode === "0"){
                    $("#scanType01").prop("checked","checked");
                    $(".scanPath").css("display","none");
                }else if(data.scanTypeCode === "1"){
                    $("#scanType02").prop("checked","checked");
                    $(".scanPath").css("display","none");
                }else if(data.scanTypeCode === "2"){
                    $("#scanType03").prop("checked","checked");
                    $(".scanPath").css("display","block");
                    $(".scanPath").val(data.scanPath);
                }
                if(data.responseTypeCode === "0"){
                    $("#responseType01").prop("checked","checked");
                    $(".choose-maskRule").css("display","none");
                    $(".remove-maskRule").css("display","none");
                    $(".addMaskRule").css("display","none");
                }else if(data.responseTypeCode === "1"){
                    $("#responseType03").prop("checked","checked");
                    $(".addMaskRule").css("display","block");
                    $(".choose-maskRule").css("display","block");
                    $(".remove-maskRule").css("display","block");
                }else if(data.responseTypeCode === "2"){
                    $("#responseType02").prop("checked","checked");
                    $(".choose-maskRule").css("display","none");
                    $(".remove-maskRule").css("display","none");
                    $(".addMaskRule").css("display","none");
                }
                var ruleHtml = "<tr>\
								    <td>"+strategyRuleEntities[0].ruleName+"</td>\
								    <td>"+strategyRuleEntities[0].ruleDesc+"</td>\
								    <input type='hidden' class='ruleId' name='ruleId' value='"+strategyRuleEntities[0].id+"'>\
                                </tr>";
                $(".ruleForm tbody").html(ruleHtml);
                var maskRuleHtml = "";
                var maskRuleId = "";
                for(var index in strategyMaskRuleEntities){
                    var ruleType = "";
                    if(strategyMaskRuleEntities[index].ruleTypeCode === "0"){
                        ruleType = "隐私检测模版";
                    }else if(strategyMaskRuleEntities[index].ruleTypeCode === "1"){
                        ruleType = "正则表达式";
                    }else if(strategyMaskRuleEntities[index].ruleTypeCode === "2"){
                        ruleType = "关键字";
                    }
                    var maskType = "";
                    if(strategyMaskRuleEntities[index].maskTypeCode === "0"){
                        maskType = "掩码屏蔽";
                    }else if(strategyMaskRuleEntities[index].maskTypeCode === "1"){
                        maskType = "内容替换";
                    }
                    maskRuleId += strategyMaskRuleEntities[index].id+",";
                    maskRuleHtml += "<tr>\
								        <td><div class='dsmcheckbox' style='margin-left: 10px'>\
								        <input type='checkbox' name='maskRuleIds' class='maskRuleIds' id='m_" + strategyMaskRuleEntities[index].id + "' value='" + strategyMaskRuleEntities[index].id + "'/><label for='m_" + strategyMaskRuleEntities[index].id + "'></label></div></td>\
								        <td>"+strategyMaskRuleEntities[index].ruleName+"</td>\
								        <td>"+ruleType+"</td>\
								        <td>"+strategyMaskRuleEntities[index].maskContent+"</td>\
								        <td>"+maskType+"</td>\
								        <td>"+strategyMaskRuleEntities[index].maskEffect+"</td>\
								        <td>"+strategyMaskRuleEntities[index].ruleDesc+"</td>\
						 	        </tr>";
                }
                $(".maskRuleId").val(maskRuleId);
                if(data.matchValue != "0"){
                    $(".isMatch").prop("checked","checked");
                }else {
                    $(".isMatch").removeAttr("checked");
                }
                $(".matchValue").val(data.matchValue);
                $(".maskRuleForm tbody").html(maskRuleHtml);
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

    //选择数据分级
    $(document).on('click', '.choose-dataClassify', function (e) {
        dsmDialog.open({
            type: 2,
            area:['800px','500px'],
            title:"选择数据分类",
            btn:['确认','取消'],
            content: "${base}/admin/data/classify/list.do",
            yes: function(index,layero) {
                if($("#layui-layer-iframe"+index).contents().find(".classifyIds:checked").size() < 1){
                    dsmDialog.error("请选择二级数据分类!");
                    return false;
                }
                if($("#layui-layer-iframe"+index).contents().find(".classifyIds:checked").size() > 1){
                    dsmDialog.error("数据分类只能选择一条!");
                    return false;
                }
                $(".dataClassifyName").val($("#layui-layer-iframe"+index).contents().find(".classifyIds:checked").parents("tr").find("td").eq(1).text());
                $(".dataClassifyId").val($("#layui-layer-iframe"+index).contents().find(".classifyIds:checked").val());
                dsmDialog.close(index);
            }
        });
    });

    //选择数据分级
    $(document).on('click', '.choose-dataGrade', function (e) {
        dsmDialog.open({
            type: 2,
            area:['800px','500px'],
            title:"选择数据分类",
            btn:['确认','取消'],
            content: "${base}/admin/data/grade/list.do",
            yes: function(index,layero) {
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() < 1){
                    dsmDialog.error("请选择数据分级!");
                    return false;
                }
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() > 1){
                    dsmDialog.error("数据分级只能选择一条!");
                    return false;
                }
                $(".dataGradeName").val($("#layui-layer-iframe"+index).contents().find(".ids:checked").parents("tr").find("td").eq(2).text());
                $(".dataGradeId").val($("#layui-layer-iframe"+index).contents().find(".ids:checked").val());
                dsmDialog.close(index);
            }
        });
    });

    //删除数据分类
    $(document).on('click', '.remove-dataClassify', function (e) {
        $(".dataClassifyName").val("");
        $(".dataClassifyId").val("");
    });

    //删除数据分级
    $(document).on('click', '.remove-dataGrade', function (e) {
        $(".dataGradeName").val("");
        $(".dataGradeId").val("");
    });

    //选择检测规则
    $(document).on('click', '.choose-rule', function (e) {
        dsmDialog.open({
            type: 2,
            area:['950px','550px'],
            title:"选择检测规则",
            btn:['确认','取消'],
            content: "${base}/admin/strategy/rule/list.do",
            yes: function(index,layero) {
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() < 1){
                    dsmDialog.error("请选择检测规则!");
                    return false;
                }
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() > 1){
                    dsmDialog.error("检测规则只能选择一条!");
                    return false;
                }
                var ruleId = $("#layui-layer-iframe"+index).contents().find(".ids:checked").val();
                var ruleName = $("#layui-layer-iframe"+index).contents().find(".ids:checked").parents("tr").find("td").eq(1).text();
                var ruleDesc = $("#layui-layer-iframe"+index).contents().find(".ids:checked").parents("tr").find("td").eq(3).text();
                var html = "<tr>\
								<td>"+ruleName+"</td>\
								<td>"+ruleDesc+"</td>\
								<input type='hidden' class='ruleId' name='ruleId' value='"+ruleId+"'>\
                            </tr>";
                $(".ruleForm tbody").html(html);
                dsmDialog.close(index);
            }
        });
    });

    //删除检测规则
    $(document).on('click', '.remove-rule', function (e) {
        $(".ruleForm tbody").html("");
    });

    //动态显示脱敏规则
    $(document).on('change', '.responseType', function (e) {
        if($(".responseType:checked").val() === "1"){
            $(".choose-maskRule").css("display","block");
            $(".remove-maskRule").css("display","block");
            $(".addMaskRule").css("display","block");
        }else {
            $(".choose-maskRule").css("display","none");
            $(".remove-maskRule").css("display","none");
            $(".addMaskRule").css("display","none");
            $(".maskRuleId").val("");
        }
    });

    //选择脱敏规则
    $(document).on('click', '.choose-maskRule', function (e) {
        dsmDialog.open({
            type: 2,
            area:['950px','550px'],
            title:"选择脱敏规则",
            btn:['确认','取消'],
            content: "${base}/admin/strategy/mask/list.do",
            yes: function(index,layero) {
                if($("#layui-layer-iframe"+index).contents().find(".ids:checked").size() < 1){
                    dsmDialog.error("请选择脱敏规则!");
                    return false;
                }
                var html = "";
                var isSelected = false;
                $("#layui-layer-iframe"+index).contents().find(".ids:checked").each(function () {
                    var _id = $(this).val();
                    $(".maskRuleForm").find("input[name=maskRuleIds]").each(function () {
                        if(_id === $(this).val()){
                            dsmDialog.error("存在脱敏规则已被选择!");
                            isSelected = true;
                            return false;
                        }
                    });
                    if(isSelected === true){
                        return false;
                    }
                    var maskRuleName = $(this).parents("tr").find("td").eq(1).text();
                    var ruleType = $(this).parents("tr").find("td").eq(2).text();
                    var maskContent = $(this).parents("tr").find("td").eq(3).text();
                    var maskType = $(this).parents("tr").find("td").eq(4).text();
                    var maskEffect = $(this).parents("tr").find("td").eq(5).text();
                    var ruleDesc = $(this).parents("tr").find("td").eq(7).text();
                    html += "<tr>\
								<td><div class='dsmcheckbox' style='margin-left: 10px'>\
								<input type='checkbox' name='maskRuleIds' class='maskRuleIds' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td>"+maskRuleName+"</td>\
								<td>"+ruleType+"</td>\
								<td>"+maskContent+"</td>\
								<td>"+maskType+"</td>\
								<td>"+maskEffect+"</td>\
								<td>"+ruleDesc+"</td>\
						 	 </tr>";
                });
                if(isSelected === true){
                    return false;
                }
                $(".maskRuleForm tbody").append(html);
                var maskRuleId = "";
                $(".maskRuleForm").find("input[name=maskRuleIds]").each(function () {
                    maskRuleId += $(this).val()+",";
                });
                $(".maskRuleId").val(maskRuleId);
                dsmDialog.close(index);
            }
        });
    });

    /*全选脱敏规则*/
    $(document).on("click", ".js_checkboxAll1", function(){
        var vchecked=this.checked;
        $('[name='+$(this).data('allcheckfor')+']:checkbox').each(function(){
            this.checked=vchecked;
        });
    });

    //删除脱敏规则
    $(document).on("click", ".remove-maskRule", function(){
        $(".maskRuleForm").find("input[name=maskRuleIds]:checked").each(function () {
            var tr = $(this).parents("tr");
            tr.remove();
        });
        var maskRuleId = "";
        $(".maskRuleForm").find("input[name=maskRuleIds]").each(function () {
            maskRuleId += $(this).val()+",";
        });
        $(".maskRuleId").val(maskRuleId);
    });

    $(document).on("change", ".scanType", function(){
        if($(".scanType:checked").val() === "2"){
            $(".scanPath").css("display","block");
        }else {
            $(".scanPath").css("display","none");
        }
    });

    $(document).on("change", ".isMatch", function(){
        if($(".isMatch").prop("checked")){
            $(".matchValue").prop("readOnly",false);
        }else {
            $(".matchValue").prop("readOnly",true);
            $(".matchValue").val(0);
        }
    });


</script>
</body>
</html>