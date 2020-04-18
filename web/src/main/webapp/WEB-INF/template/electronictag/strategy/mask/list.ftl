<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>脱敏规则定义</title>
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
                	"ruleName":"规则名称",
                	"ruleType":"规则类型",
                	"maskType":"脱敏方式",
                	"maskEffect":"脱敏效果",
                	"createUserAccount":"创建者",
                	"ruleDesc":"描述"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <button type="button" class="btn btn-primary add-rule">新增规则</button>
            <button type="button" class="btn btn-primary delete-rule">删除规则</button>
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
                                <th>规则名称</th>
                                <th>规则类型</th>
                                <th>脱敏方式</th>
                                <th>脱敏效果</th>
                                <th>创建者</th>
                                <th>描述</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </form>
                    <form id="search_form" action="search.do" data-func-name="refreshPage();" data-list-formid="datalist">
                        <input type="hidden" name="ruleName">
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
                    <label class="dsm-form-label">规则名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="ruleName" placeholder="规则名称" class="dsm-input required ruleName" >
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
                    <label class="dsm-form-label">脱敏规则：</label>
                    <div class="dsm-input-inline" style="border: 1px solid #e4eaec;width: 600px;height: auto">
                        <table class="table-a" cellpadding="0" width="100%" cellspacing="0">
                            <tr style="height: 40px">
                                <td style="width: 50%;text-align: center">待脱敏内容</td>
                                <td style="width: 20%;text-align: center">脱敏方式</td>
                                <td style="width: 30%;text-align: center">脱敏后内容</td>
                            </tr>
                            <tr style="height: 40px">
                                <td>
                                    <select style="margin-top: 5px;float: left;margin-left: 5px" name="ruleType" class="ruleType">
                                        <option value="0">隐私检测模板</option>
                                        <option value="1" selected>正则表达式</option>
                                        <option value="2">关键字</option>
                                    </select>
                                    <input type="text" autocomplete="off" name="maskContent" style="margin-left: 5px;margin-top: 5px" class="required maskContent">
                                </td>
                                <td>
                                    <select style="margin-top: 5px;float: left;margin-left: 5px" name="maskType" class="maskType" onfocus="this.defaultIndex=this.selectedIndex;"
                                            onchange="this.selectedIndex=this.defaultIndex;">>
                                        <option value="0" selected>掩码屏蔽</option>
                                        <option value="1">内容替换</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="text" autocomplete="off" name="maskEffect" style="margin-left: 5px;margin-top: 5px" class="required maskEffect" value="******" readonly>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <input type="hidden" class="ruleId" name="ruleId">
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
                var ruleTypeName = "";
                if(_data.ruleTypeCode === "0"){
                    ruleTypeName = "隐私检测模板";
                }else if(_data.ruleTypeCode === "1"){
                    ruleTypeName = "正则表达式";
                }else if(_data.ruleTypeCode === "2"){
                    ruleTypeName = "关键字";
                }
                var maskTypeName = "";
                if(_data.maskTypeCode === "0"){
                    maskTypeName = "掩码屏蔽";
                }else if(_data.maskTypeCode === "1"){
                    maskTypeName = "内容替换";
                }
                var _text = "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' class='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td><a onclick='getDetails(\"" + _id + "\")'>"+_data.ruleName+"</a></td> \
								<td>"+ ruleTypeName+"</td>\
								<td>"+ maskTypeName+"</td>\
								<td>"+_data.maskEffect+"</td>\
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
        dsmDialog.open({
            type: 1,
            area:['900px','400px'],
            title:"新增脱敏规则",
            btn:['添加','取消'],
            content : $("#addRule"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#ruleForm').serialize(),
                    type:"post",
                    url:"addRule.do",
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

    //删除一级分类
    $(document).on('click', '.delete-rule', function (e) {
        if(noItemSelected()){//如果用户没有勾选
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除脱敏规则"
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
            dsmDialog.error("请先选择脱敏规则!");
            return true;
        }else{
            return false;
        }
    }

    $(document).on('change', '.ruleType', function (e) {
        if($(".ruleType").val() === "2"){
            $(".maskType").val("1");
            $(".maskEffect").val("");
            $(".maskEffect").attr("readOnly",false);
            $(".maskContent").attr("readOnly",false);
        }else if($(".ruleType").val() === "0"){
            $(".maskType").val("0");
            $(".maskEffect").val("******");
            $(".maskEffect").attr("readOnly",true);
            $(".choose-identifier").css("display","block");
            $(".maskContent").attr("readOnly",true);
            dsmDialog.open({
                type: 2,
                area:['800px','500px'],
                title:"选择隐私检测模板",
                btn:['确认','取消'],
                content: "${base}/admin/data/identifier/list.do?isChoose=1",
                yes: function(index,layero) {
                    $(".maskContent").val($("#layui-layer-iframe2").contents().find(".ids:checked").parent().parent().parent().find("td").eq(1).text());
                    dsmDialog.close(index);
                }
            });
        }else if($(".ruleType").val() === "1"){
            $(".maskType").val("0");
            $(".maskEffect").val("******");
            $(".maskEffect").prop("readOnly",true);
            $(".choose-identifier").css("display","none");
            $(".maskContent").prop("readOnly",false);
        }
    });

    function getDetails(id) {
        $.ajax({
            data: {id: id},
            dataType: "json",
            type: "get",
            url: "getMaskRule.do",
            success: function (data){
                $(".ruleName").val(data.ruleName);
                $(".ruleDesc").val(data.ruleDesc);
                $(".ruleType").find("option[value='"+data.ruleTypeCode+"']").prop("selected",true);
                $(".maskContent").val(data.maskContent);
                $(".maskType").find("option[value='"+data.maskTypeCode+"']").prop("selected",true);
                $(".maskEffect").val(data.maskEffect);
                $(".ruleId").val(id);
                if(data.maskTypeCode === "0"){
                    $(".maskEffect").prop("readOnly",true);
                }else if(data.maskTypeCode === "1"){
                    $(".maskEffect").prop("readOnly",false);
                }
            }
        });

        dsmDialog.open({
            type: 1,
            area:['900px','400px'],
            title:"修改脱敏规则",
            btn:['修改','取消'],
            content : $("#addRule"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#ruleForm').serialize(),
                    type:"post",
                    url:"updateMaskRule.do",
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