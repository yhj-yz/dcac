<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>策略配置</title>
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
                	"bigClassifyName":"一级分类",
                	"smallClassifyName":"子分类",
                	"createUserAccount":"创建者",
                	"classifyDesc":"描述"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <button type="button" class="btn btn-primary add-classify-one">新增一级分类</button>
            <button type="button" class="btn btn-primary delete-classify-one">删除一级分类</button>
            <button type="button" class="btn btn-primary add-classify-two">新增二级分类</button>
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
                                <th>序号</th>
                                <th>一级分类</th>
                                <th>创建者</th>
                                <th>描述</th>
                                <th>详情</th>
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
                    <label class="dsm-form-label" style="width: 150px">数据分类名称(一级)：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="classifyName" placeholder="分类名称(一级)" class="dsm-input required bigClassifyName">
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
                    <label class="dsm-form-label" style="width: 150px">数据分类名称(二级)：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="classifyName" placeholder="分类名称(二级)" class="dsm-input required smallClassifyName">
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

<!--详情 -->
<form id="detail_form" style="display: none">
    <table id="detail_list" class="table" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th class="w40">
                <div class="dsmcheckbox">
                    <input type="checkbox" id="checkbox_detail" value="1"
                           class="js_checkboxAll" data-allcheckfor="classifyIds">
                    <label for="checkbox_detail"></label>
                </div>
            </th>
            <th>二级分类</th>
            <th>创建者</th>
            <th>描述</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
        <div class="btn-toolbar">
            <button type="button" class="btn btn-primary delete-classify-two">
                <i class="btnicon icon-toolbar icon-delete"></i>删除二级分类
            </button>
[#--            <button type="button" class="btn btn-primary js_change_config">--]
[#--                <i class="btnicon icon-toolbar icon-delete"></i>修改配置--]
[#--            </button>--]
        </div>
    </table>
</form>
<script type="text/javascript">
    //刷新分页列表
    function refreshPage(){
        refreshPageList({id :"search_form",
            pageSize:10,
            dataFormat :function(_data){
                var _id = _data.id;
                var _text ="<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td></td> \
								<td><a onclick='getBigDetails(\"" + _id + "\")'>" + _data.classifyName + "</a></td>\
								<td>" + _data.createUserAccount + "</td>\
								<td>" + _data.classifyDesc + "</td>\
								<td><a onclick='getSmallDetails(\"" + _id + "\")'>详情</a></td>\
						 	</tr>";
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

    //新增二级分类
    $(document).on('click', '.add-classify-two', function (e) {
        $("#smallClassifyForm")[0].reset();
        if(noItemSelected()){//如果用户没有勾选
            return;
        }

        var isOne = true;
        $("#list_form :checked[name='ids']").each(function(i){
            if(i >= 1) {
                dsmDialog.error("不能勾选多个一级分类");
                isOne = false;
            }
        });

        if(isOne){
            $("input[name='classifyId']").val($("#list_form :checked[name='ids']").val());
            dsmDialog.open({
                type: 1,
                area:['800px','300px'],
                title:"新增二级分类",
                btn:['添加','取消'],
                content : $("#addSmallClassify"),
                yes: function(index,layero) {
                    $.ajax({
                        data:$('#smallClassifyForm').serialize(),
                        type:"post",
                        url:"addSmallClassify.do",
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
            });
            refreshPage();
        }
    });

    //检查是否勾选一级分类
    function noItemSelected(){
        var ids_ = $("#list_form :checked[name='ids']");
        if(ids_.length === 0){
            dsmDialog.error("请先选择一级分类!");
            return true;
        }else{
            return false;
        }
    }

    //新增一级分类
    $(document).on('click', '.add-classify-one', function (e) {
        $("#bigClassifyForm")[0].reset();
        dsmDialog.open({
            type: 1,
            area:['800px','300px'],
            title:"新增一级分类",
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

    //获取二级分类界面信息
    function getSmallDetails(classifyId){
        $("#detail_list tbody").html("");
        $.ajax({
            data: {id: classifyId},
            dataType: "json",
            type: "get",
            url: "showClassify.do",
            success: function (data){
                var smallClassify = data.dataClassifySmallEntities;
                var text = "";
                if (smallClassify.length > 0) {
                    for (var index in smallClassify) {
                        text += "<tr>\
									<td><div class='dsmcheckbox'>\
									<input type='checkbox' name='classifyIds' id='p_" + smallClassify[index].id + "' value='" + smallClassify[index].id + "'/><label for='p_" + smallClassify[index].id + "'></label></div></td>\
									<td><a onclick='updateSmallDetails(\"" + smallClassify[index].id + "\")'>" + smallClassify[index].classifyName + "</a></td>\
									<td>" + smallClassify[index].createUserAccount + "</td>\
									<td>" + smallClassify[index].classifyDesc + "</td>\
								 </tr>";
                    }
                }
                $("#detail_list tbody").append(text);
                $("#detail_form").css("display","block");
            }
        });
        dsmDialog.open({
            type: 1,
            area:['800px','500px'],
            btn:false,
            title:"详情",
            content: $('#detail_form')
        });
    }

    //删除一级分类
    $(document).on('click', '.delete-classify-one', function (e) {
        if(noItemSelected()){//如果用户没有勾选
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除一级分类"
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

    //删除二级分类
    $(document).on("click",".delete-classify-two",function(){
        if(noItemSelectedSmallClassify()){//如果用户没有勾选
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除二级分类"
        }, function(index){
            var ids_ = "";
            $("#detail_form :checked[name='classifyIds']").each(function(i){
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
                        setTimeout(function () {
                            window.location.reload();
                        },1500);
                    } else {
                        dsmDialog.error(data.msg);
                    }
                }
            });
        }, function(index){
            dsmDialog.close(index);
        });
    });

    //检查是否勾选二级分类
    function noItemSelectedSmallClassify(){
        var ids_ = $("#detail_form :checked[name='classifyIds']");
        if(ids_.length === 0){
            dsmDialog.error("请先选择二级分类!");
            return true;
        }else{
            return false;
        }
    }

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
            area:['800px','300px'],
            title:"修改一级分类",
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
            title:"修改二级分类",
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
                            setTimeout(function () {
                                window.location.reload();
                            },1500);
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