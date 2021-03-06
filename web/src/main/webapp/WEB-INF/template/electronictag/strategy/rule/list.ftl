<!DOCTYPE html>
<html lang="ch" xmlns:96 xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>检测规则定义</title>
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
                	"ruleName":"规则名称",
                	"createUserAccount":"创建者",
                	"ruleDesc":"描述"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <button type="button" class="btn btn-primary add-rule">新增规则</button>
            <button type="button" class="btn btn-primary delete-rule">删除规则</button>
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
                                <th>规则名称</th>
                                <th>创建者</th>
                                <th>描述</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </form>
                    <form id="search_form" action="search.do" data-func-name="refreshPage();" data-list-formid="datalist">
[#--                        <input type="hidden" name="strategyName">--]
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="addRule" style="display:none;">
    <div class="dsmForms">
        <form id="ruleForm">
            <div class="dsm-form-item dsm-big">
                <div class="dsm-inline">
                    <label class="dsm-form-label">检测规则名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="ruleName" placeholder="检测规则名称" class="dsm-input required ruleName">
                    </div>
                    <div class="desc"><em>*</em></div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">描述：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="ruleDesc" placeholder="描述" class="dsm-input required ruleDesc">
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">严重程度：</label>
                    <div class="dsm-input-inline">
                        <div style="border: 1px solid #e4eaec;width: 600px;height: 180px">
                            <div class="dsm-inline">
                                <label class="dsm-form-label">默认值：</label>
                                <select style="margin-top: 5px" name="levelDefault" class="levelDefault">
                                    <option value="0" selected>信息</option>
                                    <option value="1">低</option>
                                    <option value="2">中</option>
                                    <option value="3">高</option>
                                </select>
                            </div>
                            <div class="dsm-inline">
                                <label class="dsm-form-label">当匹配数：</label>
                                <select style="margin-top: 5px;float: left" name="ruleScope01" class="ruleScope01">
                                    <option value="0" selected>在两者之间</option>
                                    <option value="1">大于等于</option>
                                    <option value="2">小于等于</option>
                                </select>
                                <div class="dsm-input-inline" style="width: 150px;margin-top: 5px" id="input01">
                                    从
                                    <input type="text" autocomplete="off" name="scopeValue01" class="required scopeValue01" style="width: 50px" value="101">
                                    至
                                    <input type="text" autocomplete="off" name="scopeValue02" class="required scopeValue02" style="width: 50px;" value="500">
                                </div>
                                <div class="dsm-input-inline" style="width: 150px;margin-top: 5px;display: none;" id="input02">
                                    <input type="text" autocomplete="off" name="scopeValue03" class="required scopeValue03" style="width: 50px" value="101">
                                </div>
                                <div style="width: 170px; float: left">
                                    将严重程度设置为
                                    <select style="margin-top: 5px" name="levelValue01" class="levelValue01">
                                        <option value="0">信息</option>
                                        <option value="1" selected>低</option>
                                        <option value="2">中</option>
                                        <option value="3">高</option>
                                    </select>
                                </div>
                            </div>
                            <div class="dsm-inline">
                                <label class="dsm-form-label">当匹配数：</label>
                                <select style="margin-top: 5px;float: left" name="ruleScope02" class="ruleScope02">
                                    <option value="0" selected>在两者之间</option>
                                    <option value="1">大于等于</option>
                                    <option value="2">小于等于</option>
                                </select>
                                <div class="dsm-input-inline" style="width: 150px;margin-top: 5px" id="input03">
                                    从
                                    <input type="text" autocomplete="off" name="scopeValue04" class="required scopeValue04" style="width: 50px" value="501">
                                    至
                                    <input type="text" autocomplete="off" name="scopeValue05" class="required scopeValue05" style="width: 50px;" value="1000">
                                </div>
                                <div class="dsm-input-inline" style="width: 150px;margin-top: 5px;display: none;" id="input04">
                                    <input type="text" autocomplete="off" name="scopeValue06" class="required scopeValue06" style="width: 50px" value="101">
                                </div>
                                <div style="width: 170px; float: left">
                                    将严重程度设置为
                                    <select style="margin-top: 5px" name="levelValue02" class="levelValue02">
                                        <option value="0">信息</option>
                                        <option value="1">低</option>
                                        <option value="2" selected>中</option>
                                        <option value="3">高</option>
                                    </select>
                                </div>
                            </div>
                            <div class="dsm-inline">
                                <label class="dsm-form-label">当匹配数：</label>
                                <select style="margin-top: 5px;float: left" name="ruleScope03" class="ruleScope03">
                                    <option value="0">在两者之间</option>
                                    <option value="1" selected>大于等于</option>
                                    <option value="2">小于等于</option>
                                </select>
                                <div class="dsm-input-inline" style="width: 150px;margin-top: 5px;display: none" id="input05">
                                    从
                                    <input type="text" autocomplete="off" name="scopeValue07" class="required scopeValue07" style="width: 50px" value="1001">
                                    至
                                    <input type="text" autocomplete="off" name="scopeValue08" class="required scopeValue08" style="width: 50px;" value="5000">
                                </div>
                                <div class="dsm-input-inline" style="width: 150px;margin-top: 5px;" id="input06">
                                    <input type="text" autocomplete="off" name="scopeValue09" class="required scopeValue09" style="width: 50px" value="1001">
                                </div>
                                <div style="width: 170px; float: left">
                                    将严重程度设置为
                                    <select style="margin-top: 5px" class="levelValue03" name="levelValue03">
                                        <option value="0">信息</option>
                                        <option value="1">低</option>
                                        <option value="2">中</option>
                                        <option value="3" selected>高</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">检测规则：</label>
                    <div class="dsm-input-inline">
                        <button type="button" class="btn btn-primary add-contain">添加规则</button>
                        <button type="button" class="btn btn-primary add-except">添加例外</button>

                        <div class="dsm-inline" id="chooseRule" style="display: none;">
                            <div style="border: 1px solid #e4eaec;width: 600px;height: 150px">
                                <input type="radio" value="0" id="ruleType01" class="ruleType" name="ruleType" style="margin-top: 5px;margin-left: 10px" checked>隐私检测模板</input>
                                <input type="radio" value="1" id="ruleType02" class="ruleType" name="ruleType" style="margin-left: 10px">正则表达式</input>
                                <input type="radio" value="2" id="ruleType03" class="ruleType" name="ruleType" style="margin-left: 10px">关键字</input>
                                <input type="hidden" id="isContain" value="1"/>
                                <div class="dsm-inline">
                                    <button type="button" class="btn btn-primary choose-identifier" style="float: left;margin-left: 10px;margin-top: 10px">选择隐私检测模板</button>
                                    <input type="text" autocomplete="off" class="dsm-input required match-content" style="width: 400px;float: left;margin-top: 10px;margin-left: 10px" readonly>
                                </div>
                                <div class="dsm-inline">
                                    <button type="button" class="btn btn-primary confirm" style="margin-left: 200px;margin-top: 10px">确定</button>
                                    <button type="button" class="btn btn-primary cancel" style="margin-top: 10px">取消</button>
                                </div>
                            </div>
                        </div>

                        <div class="dsm-inline">
                            <div style="border: 1px solid #e4eaec;width: 600px;height: auto">
                                <label style="text-align: left;margin-top: 5px;margin-left: 10px;font-size: 18px;">规则</label>
                                <HR style="border: 1px solid  #e4eaec;margin-top: 10px;width: 96%;margin-left: 2%">
                                <h6 style="margin-left: 30px" id="contain">暂无定义规则</h6>
                                <label style="text-align: left;margin-top: 5px;margin-left: 10px;font-size: 18px;">例外</label>
                                <HR style="border: 1px solid  #e4eaec;margin-top: 10px;width: 96%;margin-left: 2%">
                                <h6 style="margin-left: 30px" id="except">暂无定义例外规则</h6>
                                <input type="hidden" name="containRule" class="containRule">
                                <input type="hidden" name="exceptRule" class="exceptRule">
                            </div>
                        </div>

                        <input type="hidden" name="ruleId" class="ruleId">
                    </div>


                </div>

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
								<td><a onclick='getDetails(\"" + _id + "\")'>"+_data.ruleName+"</a></td>\
								<td>"+_data.createUserAccount+"</td>\
								<td>"+_data.ruleDesc+"\
						 	 </tr>";
                return _text;
            }});
    }

    $(function () {
        refreshPage();
    });

    $(document).on('click', '.add-rule', function (e) {
        $("#ruleForm")[0].reset();
        $("#contain").html("暂无定义规则");
        $("#except").html("暂无定义例外规则");
        dsmDialog.open({
            type: 1,
            area:['900px','450px'],
            title:"新增检测规则",
            btn:['添加','取消'],
            content : $("#addRule"),
            yes: function(index,layero) {
                var containRule = "";
                $("#contain h6").each(function (i) {
                    containRule += this.innerHTML+";";
                });
                $(".containRule").val(containRule);
                var exceptRule = "";
                $("#except h6").each(function (i) {
                    exceptRule += this.innerHTML+";";
                });
                $(".exceptRule").val(exceptRule);
                $.ajax({
                    data:$('#ruleForm').serialize(),
                    type:"post",
                    url:"addStrategyRule.do",
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

    //删除规则
    $(document).on('click', '.delete-rule', function (e) {
        if(noItemSelected()){//如果用户没有勾选
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除规则"
        }, function(index){
            var ids_ = "";
            $("#list_form :checked[name='ids']").each(function(i){
                ids_ += $(this).val()+",";
            });
            $.ajax({
                dataType:"json",
                type: "post",
                url: "deleteRule.do",
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
            dsmDialog.error("请先选择规则!");
            return true;
        }else{
            return false;
        }
    }

    $(document).on('click', '.add-contain', function (e) {
        $("#chooseRule").css("display","block");
        $("#isContain").val("1");
    });

    $(document).on('click', '.add-except', function (e) {
        $("#chooseRule").css("display","block");
        $("#isContain").val("0");
    });

    $(document).on('change', '.ruleType', function (e) {
        var ruleType = $(".ruleType:checked").val();
        if(ruleType == "0"){
            $(".choose-identifier").css("display","block");
            $(".match-content").attr("readOnly",true);
        }else if(ruleType == "1"){
            $(".choose-identifier").css("display","none");
            $(".match-content").attr("readOnly",false);
        }else if(ruleType == "2"){
            $(".choose-identifier").css("display","none");
            $(".match-content").attr("readOnly",false);
        }
    });

    $(document).on('click', '.cancel', function (e) {
        $("#chooseRule").css("display","none");
    });

    $(document).on('click', '.confirm', function (e) {
        var ruleType = $(".ruleType:checked").val();
        var match_content = $(".match-content").val();
        if(match_content === ""){
            dsmDialog.error("请输入内容!");
            return false;
        }
        var html;
        if($("#isContain").val() === "1") {
            html = $("#contain").html();
        }else {
            html = $("#except").html();
        }
        if(html === "暂无定义规则" || html === "暂无定义例外规则"){
            if(ruleType === "0") {
                html = "<div style=\"position: relative\">\
                        <h6>隐私检测模板: 匹配&quot;" + match_content + "&quot;</h6>\
                        <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: -15px;left: 500px\">\
                        </div>";
            }else if(ruleType === "1"){
                html = "<div style=\"position: relative\">\
                        <h6>正则表达式: 匹配&quot;" + match_content + "&quot;</h6>\
                        <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: -15px;left: 500px\">\
                        </div>";
            }else if(ruleType === "2"){
                html = "<div style=\"position: relative\">\
                        <h6>关键字: 匹配&quot;" + match_content + "&quot;</h6>\
                        <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: -15px;left: 500px\">\
                        </div>";
            }
        }else {
            if(ruleType === "0"){
                html += "<div style=\"position: relative\">\
                            <HR style=\"border: 1px dotted #e4eaec;margin-top: 10px;\">\
                            <h6>隐私检测模板: 匹配&quot;"+match_content+"&quot;</h6>\
                            <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: 5px;left: 500px\">\
                        </div>";
            }else if(ruleType === "1"){
                html += "<div style=\"position: relative\">\
                            <HR style=\"border: 1px dotted #e4eaec;margin-top: 10px;\">\
                            <h6>正则表达式: 匹配&quot;"+match_content+"&quot;</h6>\
                            <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: 5px;left: 500px\">\
                        </div>";
            }else if(ruleType === "2"){
                html += "<div style=\"position: relative\">\
                            <HR style=\"border: 1px dotted #e4eaec;margin-top: 10px;\">\
                            <h6>关键字: 匹配&quot;"+match_content+"&quot;</h6>\
                            <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: 5px;left: 500px\">\
                        </div>";
            }
        }
        if($("#isContain").val() === "1") {
            $("#contain").html(html);
        }else {
            $("#except").html(html);
        }
        $("#chooseRule").css("display","none");
    });
    
    function deleteElement(obj) {
        obj.parentNode.parentNode.removeChild(obj.parentNode);
       if($("#contain").html() === ""){
           $("#contain").html("暂无定义规则");
       }
       if($("#except").html() === ""){
           $("#except").html("暂无定义例外规则");
       }
    }

    $(document).on('change', '.ruleScope01', function (e) {
        var ruleScope01 = $(".ruleScope01").val();
        if(ruleScope01 === "0"){
            $("#input01").css("display","block");
            $("#input02").css("display","none");
        }else {
            $("#input02").css("display","block");
            $("#input01").css("display","none");
        }
    });

    $(document).on('change', '.ruleScope02', function (e) {
        var ruleScope02 = $(".ruleScope02").val();
        if(ruleScope02 === "0"){
            $("#input03").css("display","block");
            $("#input04").css("display","none");
        }else {
            $("#input04").css("display","block");
            $("#input03").css("display","none");
        }
    });

    $(document).on('change', '.ruleScope03', function (e) {
        var ruleScope03 = $(".ruleScope03").val();
        if(ruleScope03 === "0"){
            $("#input05").css("display","block");
            $("#input06").css("display","none");
        }else {
            $("#input06").css("display","block");
            $("#input05").css("display","none");
        }
    });

    $(document).on('click', '.choose-identifier', function (e) {
        dsmDialog.open({
            type: 2,
            area:['800px','500px'],
            title:"选择隐私检测模板",
            btn:['确认','取消'],
            content: "${base}/admin/data/identifier/list.do?isChoose=1",
            yes: function(index,layero) {
                $(".match-content").val($("#layui-layer-iframe"+index).contents().find(".ids:checked").parent().parent().parent().find("td").eq(1).text());
                dsmDialog.close(index);
            }
        });
    });

    function getDetails(id) {
        $("#ruleForm")[0].reset();
        $("#contain").html("暂无定义规则");
        $("#except").html("暂无定义例外规则");
        $.ajax({
            data: {id: id},
            dataType: "json",
            type: "get",
            url: "getStrategyRule.do",
            success: function (data){
                var dataLevelRuleEntities = data.dataLevelRuleEntities;
                var strategyRuleContentEntities = data.strategyRuleContentEntities;
                $(".ruleName").val(data.ruleName);
                $(".ruleDesc").val(data.ruleDesc);
                $(".levelDefault").find("option[value='"+data.levelDefaultCode+"']").prop("selected",true);
                //严重程度第一部分
                $(".ruleScope01").find("option[value='"+dataLevelRuleEntities[0].ruleScopeCode+"']").prop("selected",true);
                if(dataLevelRuleEntities[0].ruleScopeCode === "0"){
                    var scopeValues = dataLevelRuleEntities[0].ruleScopeValue.split(",");
                    $(".scopeValue01").val(scopeValues[0]);
                    $(".scopeValue02").val(scopeValues[1]);
                    $("#input01").css("display","block");
                    $("#input02").css("display","none");
                }else {
                    $(".scopeValue03").val(dataLevelRuleEntities[0].ruleScopeValue);
                    $("#input01").css("display","none");
                    $("#input02").css("display","block");
                }
                $(".levelValue01").find("option[value='"+dataLevelRuleEntities[0].levelCode+"']").prop("selected",true);
                //严重程度第二部分
                $(".ruleScope02").find("option[value='"+dataLevelRuleEntities[1].ruleScopeCode+"']").prop("selected",true);
                if(dataLevelRuleEntities[1].ruleScopeCode === "0"){
                    var scopeValues = dataLevelRuleEntities[1].ruleScopeValue.split(",");
                    $(".scopeValue04").val(scopeValues[0]);
                    $(".scopeValue05").val(scopeValues[1]);
                    $("#input03").css("display","block");
                    $("#input04").css("display","none");
                }else {
                    $(".scopeValue06").val(dataLevelRuleEntities[1].ruleScopeValue);
                    $("#input03").css("display","none");
                    $("#input04").css("display","block");
                }
                $(".levelValue02").find("option[value='"+dataLevelRuleEntities[1].levelCode+"']").prop("selected",true);
                //严重程度第三部分
                $(".ruleScope03").find("option[value='"+dataLevelRuleEntities[2].ruleScopeCode+"']").prop("selected",true);
                if(dataLevelRuleEntities[2].ruleScopeCode === "0"){
                    var scopeValues = dataLevelRuleEntities[2].ruleScopeValue.split(",");
                    $(".scopeValue07").val(scopeValues[0]);
                    $(".scopeValue08").val(scopeValues[1]);
                    $("#input05").css("display","block");
                    $("#input06").css("display","none");
                }else {
                    $(".scopeValue09").val(dataLevelRuleEntities[2].ruleScopeValue);
                    $("#input05").css("display","none");
                    $("#input06").css("display","block");
                }
                $(".levelValue03").find("option[value='"+dataLevelRuleEntities[2].levelCode+"']").prop("selected",true);
                var containRule = "";
                var exceptRule = "";
                for(var index in strategyRuleContentEntities){
                    if(strategyRuleContentEntities[index].contain){
                        if($("#contain").html() === "暂无定义规则"){
                            if(strategyRuleContentEntities[index].ruleTypeCode === "0") {
                                containRule = "<div style=\"position: relative\">\
                        <h6>隐私检测模板: 匹配&quot;" + strategyRuleContentEntities[index].matchContent + "&quot;</h6>\
                        <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: -15px;left: 500px\">\
                        </div>";
                            }else if(strategyRuleContentEntities[index].ruleTypeCode === "1"){
                                containRule = "<div style=\"position: relative\">\
                        <h6>正则表达式: 匹配&quot;" + strategyRuleContentEntities[index].matchContent + "&quot;</h6>\
                        <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: -15px;left: 500px\">\
                        </div>";
                            }else if(strategyRuleContentEntities[index].ruleTypeCode === "2"){
                                containRule = "<div style=\"position: relative\">\
                        <h6>关键字: 匹配&quot;" + strategyRuleContentEntities[index].matchContent + "&quot;</h6>\
                        <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: -15px;left: 500px\">\
                        </div>";
                            }
                        }else {
                            if(strategyRuleContentEntities[index].ruleTypeCode === "0"){
                                containRule += "<div style=\"position: relative\">\
                            <HR style=\"border: 1px dotted #e4eaec;margin-top: 10px;\">\
                            <h6>隐私检测模板: 匹配&quot;"+strategyRuleContentEntities[index].matchContent+"&quot;</h6>\
                            <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: 5px;left: 500px\">\
                        </div>";
                            }else if(strategyRuleContentEntities[index].ruleTypeCode === "1"){
                                containRule += "<div style=\"position: relative\">\
                            <HR style=\"border: 1px dotted #e4eaec;margin-top: 10px;\">\
                            <h6>正则表达式: 匹配&quot;"+strategyRuleContentEntities[index].matchContent+"&quot;</h6>\
                            <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: 5px;left: 500px\">\
                        </div>";
                            }else if(strategyRuleContentEntities[index].ruleTypeCode === "2"){
                                containRule += "<div style=\"position: relative\">\
                            <HR style=\"border: 1px dotted #e4eaec;margin-top: 10px;\">\
                            <h6>关键字: 匹配&quot;"+strategyRuleContentEntities[index].matchContent+"&quot;</h6>\
                            <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: 5px;left: 500px\">\
                        </div>";
                            }
                        }
                    }else {
                        if($("#except").html() === "暂无定义例外规则"){
                            if(strategyRuleContentEntities[index].ruleTypeCode === "0") {
                                exceptRule = "<div style=\"position: relative\">\
                        <h6>隐私检测模板: 匹配&quot;" + strategyRuleContentEntities[index].matchContent + "&quot;</h6>\
                        <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: -15px;left: 500px\">\
                        </div>";
                            }else if(strategyRuleContentEntities[index].ruleTypeCode === "1"){
                                exceptRule = "<div style=\"position: relative\">\
                        <h6>正则表达式: 匹配&quot;" + strategyRuleContentEntities[index].matchContent + "&quot;</h6>\
                        <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: -15px;left: 500px\">\
                        </div>";
                            }else if(strategyRuleContentEntities[index].ruleTypeCode === "2"){
                                exceptRule = "<div style=\"position: relative\">\
                        <h6>关键字: 匹配&quot;" + strategyRuleContentEntities[index].matchContent + "&quot;</h6>\
                        <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: -15px;left: 500px\">\
                        </div>";
                            }
                        }else {
                            if(strategyRuleContentEntities[index].ruleTypeCode === "0"){
                                exceptRule += "<div style=\"position: relative\">\
                            <HR style=\"border: 1px dotted #e4eaec;margin-top: 10px;\">\
                            <h6>隐私检测模板: 匹配&quot;"+strategyRuleContentEntities[index].matchContent+"&quot;</h6>\
                            <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: 5px;left: 500px\">\
                        </div>";
                            }else if(strategyRuleContentEntities[index].ruleTypeCode === "1"){
                                exceptRule += "<div style=\"position: relative\">\
                            <HR style=\"border: 1px dotted #e4eaec;margin-top: 10px;\">\
                            <h6>正则表达式: 匹配&quot;"+strategyRuleContentEntities[index].matchContent+"&quot;</h6>\
                            <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: 5px;left: 500px\">\
                        </div>";
                            }else if(strategyRuleContentEntities[index].ruleTypeCode === "2"){
                                exceptRule += "<div style=\"position: relative\">\
                            <HR style=\"border: 1px dotted #e4eaec;margin-top: 10px;\">\
                            <h6>关键字: 匹配&quot;"+strategyRuleContentEntities[index].matchContent+"&quot;</h6>\
                            <input type=\"button\" value=\"×\" onclick=\"deleteElement(this)\" style=\"position: absolute;top: 5px;left: 500px\">\
                        </div>";
                            }
                        }
                    }
                }
                if(containRule != ""){
                    $("#contain").html(containRule);
                }
                if(exceptRule != ""){
                    $("#except").html(exceptRule);
                }
                $(".ruleId").val(data.id);
            }
        });

        dsmDialog.open({
            type: 1,
            area:['900px','450px'],
            title:"修改检测规则",
            btn:['修改','取消'],
            content : $("#addRule"),
            yes: function(index,layero) {
                var containRule = "";
                $("#contain h6").each(function (i) {
                    containRule += this.innerHTML+";";
                });
                $(".containRule").val(containRule);
                var exceptRule = "";
                $("#except h6").each(function (i) {
                    exceptRule += this.innerHTML+";";
                });
                $(".exceptRule").val(exceptRule);
                $.ajax({
                    data:$('#ruleForm').serialize(),
                    type:"post",
                    url:"updateRule.do",
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
</script>
</body>
</html>