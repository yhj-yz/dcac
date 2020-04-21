<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>数据分类定义</title>
    [#include "/include/head.ftl"]
    <script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
    <style type="text/css">
        .highlight {background-color: yellow}
    </style>
    <script type="text/javascript" src="${base}/resources/dsm/js/highlight.js"></script>
</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">
        <div class="mainbox">
            [#assign searchMap='{
                	"bigClassifyName":"分类",
                	"smallClassifyName":"子类",
                	"createUserAccount":"创建者",
                	"classifyDesc":"描述"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <button type="button" class="btn btn-primary add-classify-one">新增分类</button>
            <button type="button" class="btn btn-primary add-classify-two">新增子类</button>
            <button type="button" class="btn btn-primary delete-classify-one">删除分类</button>
            <button type="button" class="btn btn-primary delete-classify-two">删除子类</button>

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
[#--                                <th>序号</th>--]
                                <th>分类名称</th>
                                <th>父类名称</th>
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

<div id="addBigClassify" style="display:none;">
    <div class="dsmForms">
        <form id="bigClassifyForm">
            <div class="dsm-form-item dsm-big">
                <div class="dsm-inline">
                    <label class="dsm-form-label" style="width: 150px">分类名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="classifyName" placeholder="分类名称" class="dsm-input required bigClassifyName">
                    </div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label dsm-form" style="width: 150px">描述：</label>
                    <div class="dsm-input-inline" >
                        <input type="text" autocomplete="off" name="classifyDesc" placeholder="描述" class="dsm-input required bigClassifyDesc">
                    </div>
                </div>
                <input type="hidden" name="classifyId" class="bigClassifyId">
            </div>
        </form>
    </div>
</div>

<div id="addSmallClassify" style="display:none;">
    <div class="dsmForms">
        <form id="smallClassifyForm">
            <div class="dsm-form-item dsm-big">
                <div class="dsm-inline">
                    <label class="dsm-form-label" style="width: 150px">子类名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="classifyName" placeholder="子类名称" class="dsm-input required smallClassifyName">
                    </div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label dsm-form" style="width: 150px">描述：</label>
                    <div class="dsm-input-inline" >
                        <input type="text" autocomplete="off" name="classifyDesc" placeholder="描述" class="dsm-input required smallClassifyDesc">
                    </div>
                </div>
                <input type="hidden" name="classifyId" class="smallClassifyId">
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
                var _text = "";
                var _id = _data.id;
                _text += "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td><a onclick='getBigDetails(\"" + _id + "\")'>" + _data.classifyName + "</a></td>\
								<td></td>\
								<td>" + _data.createUserAccount + "</td>\
								<td>" + _data.classifyDesc + "</td>\
						 	</tr>";
                for(var index in _data.dataClassifySmallEntities){
                    _text +="<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' id='m_" + _data.dataClassifySmallEntities[index].id + "' value='" + _data.dataClassifySmallEntities[index].id + "'/><label for='m_" + _data.dataClassifySmallEntities[index].id + "'></label></div></td>\
								<td><a onclick='updateSmallDetails(\"" + _data.dataClassifySmallEntities[index].id + "\")'>" + _data.dataClassifySmallEntities[index].classifyName + "</a></td>\
								<td>" +_data.classifyName+"</td>\
								<td>" + _data.dataClassifySmallEntities[index].createUserAccount + "</td>\
								<td>" + _data.dataClassifySmallEntities[index].classifyDesc + "</td>\
						 	</tr>";
                }
                return _text;
            }});
    }

    $(function () {
        refreshPage();

        $.ajax({
            url:'getClassify.do',
            dataType:"json",
            success: function(data) {
                for(var idx in data){
                    $("#bigClassifyNameList").append('<option>'+data[idx].classifyName+'</option>')
                }
            }
        });
    });

    //新增子类
    $(document).on('click', '.add-classify-two', function (e) {
        $("#smallClassifyForm")[0].reset();
        if($("#list_form :checked[name='ids']").parents("tr").find("td").eq(2).html() !== ""){
            dsmDialog.error("请勾选父类!");
            return;
        }

        if($("#list_form :checked[name='ids']").size() > 1){
            dsmDialog.error("不能勾选多个分类");
            return;
        }

        $("input[name='classifyId']").val($("#list_form :checked[name='ids']").val());
        dsmDialog.open({
            type: 1,
            area: ['750px', '350px'],
            title: "新增子类",
            btn: ['添加', '取消'],
            content: $("#addSmallClassify"),
            yes: function (index, layero) {
                $.ajax({
                    data: $('#smallClassifyForm').serialize(),
                    type: "post",
                    url: "addSmallClassify.do",
                    dataType: "json",
                    success: function (data) {
                        if (data.status == "500") {
                            dsmDialog.error(data.msg);
                        } else {
                            dsmDialog.msg(data.msg);
                            dsmDialog.close(index);
                            refreshPage();
                        }
                    },
                    error: function () {
                        dsmDialog.msg("网络错误,请稍后尝试");
                    }
                });
            },
        });
        refreshPage();
    });

    //检查是否勾选分类
    function noItemSelected(){
        var ids_ = $("#list_form :checked[name='ids']");
        if(ids_.length === 0){
            dsmDialog.error("请先选择分类!");
            return true;
        }else{
            return false;
        }
    }

    //新增分类
    $(document).on('click', '.add-classify-one', function (e) {
        $("#bigClassifyForm")[0].reset();
        dsmDialog.open({
            type: 1,
            area:['750px','350px'],
            title:"新增分类",
            btn:['添加','取消'],
            content : $("#addBigClassify"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#bigClassifyForm').serialize(),
                    type:"post",
                    url:"addBigClassify.do",
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

    //删除分类
    $(document).on('click', '.delete-classify-one', function (e) {
        if(noItemSelected()){//如果用户没有勾选
            return;
        }
        var isContinue = true;
        $("#list_form :checked[name='ids']").each(function () {
            if($(this).parents("tr").find("td").eq(2).html() !== ""){
                dsmDialog.error("请不要勾选子类!");
                isContinue = false;
                return false;
            }
        });
        if(!isContinue){
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除分类"
        }, function(index){
            var ids_ = "";
            $("#list_form :checked[name='ids']").each(function(i){
                ids_ += $(this).val()+",";
            });
            $.ajax({
                dataType:"json",
                type: "post",
                url: "deleteBigClassify.do",
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

    //删除子类
    $(document).on("click",".delete-classify-two",function(){
        if(noItemSelected()){//如果用户没有勾选
            return;
        }
        var isContinue = true;
        $("#list_form :checked[name='ids']").each(function () {
            if($(this).parents("tr").find("td").eq(2).html() === ""){
                dsmDialog.error("请不要勾选父类!");
                isContinue = false;
                return false;
            }
        });
        if(!isContinue){
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除子类"
        }, function(index){
            var ids_ = "";
            $("#list_form :checked[name='ids']").each(function(i){
                ids_ += $(this).val()+",";
            });
            $.ajax({
                dataType:"json",
                type: "post",
                url: "deleteSmallClassify.do",
                data: {ids : ids_},
                success: function(data){
                    if(data && data.status === "200"){
                        dsmDialog.msg(data.msg);
                        refreshPage();
                    } else {
                        dsmDialog.error(data.msg);
                    }
                }
            });
        }, function(index){
            dsmDialog.close(index);
        });
    });

    function getBigDetails(id) {
        $.ajax({
            data: {id: id},
            dataType: "json",
            type: "get",
            url: "showClassify.do",
            success: function (data){
                $(".bigClassifyName").val(data.classifyName);
                $(".bigClassifyDesc").val(data.classifyDesc);
                $(".bigClassifyId").val(id);
            }
        });

        dsmDialog.open({
            type: 1,
            area:['750px','350px'],
            title:"修改分类",
            btn:['修改','取消'],
            content : $("#addBigClassify"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#bigClassifyForm').serialize(),
                    type:"post",
                    url:"updateBigClassify.do",
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

    function updateSmallDetails(id) {
        $.ajax({
            data: {id: id},
            dataType: "json",
            type: "get",
            url: "getSmallClassify.do",
            success: function (data){
                $(".smallClassifyName").val(data.classifyName);
                $(".smallClassifyDesc").val(data.classifyDesc);
                $(".smallClassifyId").val(id);
            }
        });

        dsmDialog.open({
            type: 1,
            area:['700px','300px'],
            title:"修改子类",
            btn:['修改','取消'],
            content : $("#addSmallClassify"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#smallClassifyForm').serialize(),
                    type:"post",
                    url:"updateSmallClassify.do",
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