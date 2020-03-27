<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>策略配置</title>
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
            <button type="button" class="btn btn-primary">删除策略</button>
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
        <form id="formCustom">
            <div class="dsm-form-item dsm-big">
                <div class="dsm-inline">
                    <label class="dsm-form-label">策略名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="strategyName" placeholder="策略名称" class="dsm-input required" dzbqSpecialChar="true" >
                    </div>
                    <div class="desc"><em>*</em></div>
                    <div class="line-tip error" >*软件名称不能为空</div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">描述：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="strategyDesc" placeholder="描述" class="dsm-input required" dzbqSpecialChar="true">
                    </div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">数据分类：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="strategyDesc" placeholder="数据分类" class="dsm-input required" dzbqSpecialChar="true">
                    </div>
                    <div class="desc"><em>*</em></div>
                    <button type="button" >
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">数据分级：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="strategyDesc" placeholder="数据分级" class="dsm-input required" dzbqSpecialChar="true">
                    </div>
                    <div class="desc"><em>*</em></div>
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
								<input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td class='hiddentd'><div class='hiddendiv' title='" + _data.strategyName + "'>" + _data.strategyName + "</div></td> \
								<td><div>"+_data.strategyDesc+"</td></div>\
								<td><a onclick='getDetails(\""+_id+"\")'>详情</a></td>\
						 	 </tr>";
                return _text;
            }});
    }

   $(function () {
       refreshPage();
   });

    $(document).on('click', '.add-strategy', function (e) {
        console.log(111);
        dsmDialog.open({
            type: 1,
            area:['800px','300px'],
            title:"新增策略规则",
            btn:['添加','取消'],
            content : $("#addStrategy"),
            yes: function(index,layero) {
                submitForm({
                    frm : $('#editForm'),
                    success: function(data) {
                        dsmDialog.close(index);
                        setTimeout(go,2000);
                    },
                    error: function() {
                        dsmDialog.close(index);
                        setTimeout(go,2000);
                    }
                });
            } ,
            no : function(index,layero) {
                dsmDialog.close(index);
            }
        });
        refreshPage();
    });
</script>
</body>
</html>