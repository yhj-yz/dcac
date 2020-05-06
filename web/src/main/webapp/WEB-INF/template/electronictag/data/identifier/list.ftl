<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
    <title>隐私检测模板</title>
    [#include "/include/head.ftl"]
    <script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
    <style>
        .highlight {background-color: yellow}

        .table1 tbody {
            display:block;
            height:412px;
            overflow-y:scroll;
        }

        .table1 thead,.table1 tbody tr {
            display:table;
            width:100%;
            table-layout:fixed;
        }

        .table1 thead {
            width: calc( 100% - 1em )
        }
    </style>
    <script type="text/javascript" src="${base}/resources/dsm/js/highlight.js"></script>
</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">
        <div class="mainbox">
            [#assign searchMap='{
                	"identifierName":"名称",
                	"identifierType":"类别"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <button type="button" class="btn btn-primary add-Identifier">导入隐私检测模板</button>
            <div id="managerContent" style="margin-top: 10px">
                <div class="table-view">
                    <form id="list_form" >
                        <table id="datalist" class="table table1" cellspacing="0" width="100%">
                            <thead>
                            <tr>
                                <th class="w40">
                                    <div class="dsmcheckbox">
                                        <input type="checkbox" value="1" id="checkboxFiveInput"
                                               class="js_checkboxAll" data-allcheckfor="ids">
                                        <label for="checkboxFiveInput"></label>
                                    </div>
                                </th>
                                <th>名称</th>
                                <th>类别</th>
                                <th>描述</th>
                                <th>检测规则</th>
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

<div id="addIdentifier" style="display:none;">
    <div class="dsmForms">
        <form id="identifierForm" enctype="multipart/form-data" method="post">
            <div class="dsm-inline">
                <label class="dsm-form-label">选择文件：</label>
                <div class="dsm-input-block">
                    <input id="fileNameShow" type="text"  autocomplete="off"  disabled="true" class="dsm-input w268 f-l m-r-10 " >
                    <div class="dsm-upload-button f-l m-r-f10">
                        <input type="file" name="file" class="dsm-upload-file js_file" data-fileid="fileInfo" accept=".csv">
                        <span class="fbtname">浏览</span>
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
            asyncSuccess:"function",
            pageSize:10,
            dataFormat :function(_data){
                var _id = _data.id;
                var _text = "<tr>\
								<td class='idList'><div class='dsmcheckbox'>\
								<input type='checkbox' class='ids' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td>"+_data.identifierName+"</td>\
								<td>"+_data.identifierType+"</td>\
								<td>"+_data.identifierDesc+"</td>\
								<td>"+_data.identifierRule+"</td>\
						 	 </tr>";
                return _text;
            }});
    }

    function getQueryString(name) {
        var reg = new RegExp('(?:(?:&|\\?)' + name + '=([^&]*))|(?:/' + name + '/([^/]*))', 'i');
        var r = window.location.href.match(reg);
        if (r != null)
            return decodeURI(r[1] || r[2]);
        return null;
    }

    $(function () {
        refreshPage();

        $(this).bind('DOMNodeInserted', function(e) {
            if (getQueryString("isChoose") == null) {
                $(".w40").css("display", "none");
                $(".idList").css("display", "none");
            }
        });
    });

    $(document).on('click', '.add-Identifier', function (e) {
        $("#identifierForm")[0].reset();
        dsmDialog.open({
            type: 1,
            area:['800px','300px'],
            title:"导入隐私检测模板",
            btn:['添加','取消'],
            content : $("#addIdentifier"),
            yes: function(index,layero) {
                if($(".js_file")[0].files[0] == null){
                    dsmDialog.error("请选择导入文件!");
                    return;
                }
                var data = new FormData();
                data.append("file",$(".js_file")[0].files[0]);
                $.ajax({
                    data:data,
                    type:"post",
                    url:"importIdentifier.do",
                    dataType:"json",
                    processData: false,
                    contentType: false,
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

    $(document).on('change', '.js_file', function (e) {
        var fileObj  = $(this);
        var filePath=$(this).val();
        var licNameArr=filePath.split('.');
        if(licNameArr[licNameArr.length-1]!="csv")
        {
            dsmDialog.error('请选择格式为.csv的文件！');
            return false;
        }
        else{
            $("#fileNameShow").val(fileObj[0].files[0].name);
        }
    });
</script>
</body>
</html>