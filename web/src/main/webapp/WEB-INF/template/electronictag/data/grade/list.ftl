<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>数据分级定义</title>
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
                	"gradeName":"名称",
                	"createUserAccount":"创建者",
                	"gradeDesc":"描述"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <button type="button" class="btn btn-primary add-grade">新增分级</button>
            <button type="button" class="btn btn-primary delete-grade">删除分级</button>
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
                                <th>序号</th>
                                <th>名称</th>
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
                var _text = "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' class='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td></td> \
								<td><a onclick='getDetails(\"" + _id + "\")'>"+_data.gradeName+"</a></td>\
								<td>"+_data.createUserAccount+"</td>\
								<td>"+_data.gradeDesc+"\
						 	 </tr>";
                return _text;
            }});
    }

    $(function () {
        refreshPage();
    });

    $(document).on('click', '.add-grade', function (e) {
        $("#gradeForm")[0].reset();
        dsmDialog.open({
            type: 1,
            area:['750px','350px'],
            title:"新增数据分级",
            btn:['添加','取消'],
            content : $("#addGrade"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#gradeForm').serialize(),
                    type:"post",
                    url:"addGrade.do",
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
    $(document).on('click', '.delete-grade', function (e) {
        if(noItemSelected()){//如果用户没有勾选
            return;
        }
        dsmDialog.toComfirm("是否执行删除操作？", {
            btn: ['确定','取消'],
            title:"删除数据分级"
        }, function(index){
            var ids_ = "";
            $("#list_form :checked[name='ids']").each(function(i){
                ids_ += $(this).val()+",";
            });
            $.ajax({
                dataType:"json",
                type: "post",
                url: "deleteGrade.do",
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
            dsmDialog.error("请先选择数据分级!");
            return true;
        }else{
            return false;
        }
    }

    function getDetails(id) {
        $.ajax({
            data: {id: id},
            dataType: "json",
            type: "get",
            url: "getDataGrade.do",
            success: function (data){
                $(".gradeName").val(data.gradeName);
                $(".gradeDesc").val(data.gradeDesc);
                $(".gradeId").val(id);
            }
        });

        dsmDialog.open({
            type: 1,
            area:['800px','300px'],
            title:"修改数据分级",
            btn:['修改','取消'],
            content : $("#addGrade"),
            yes: function(index,layero) {
                $.ajax({
                    data:$('#gradeForm').serialize(),
                    type:"post",
                    url:"updateGrade.do",
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