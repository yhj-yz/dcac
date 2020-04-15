<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>数据标识符</title>
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
                	"identifierName":"名称",
                	"identifierType":"类别"
					}' /]
            [#assign form="search_form"]
            [#include "/include/search.ftl"]
            <button type="button" class="btn btn-primary add-grade">导入数据标识符</button>
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
                                <th>名称</th>
                                <th>类别</th>
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

<div id="addGrade" style="display:none;">
    <div class="dsmForms">
        <form id="gradeForm">
            <div class="dsm-inline">
                <label class="dsm-form-label">选择文件：</label>
                <div class="dsm-input-block">
                    <input id="fileNameShow" type="text"  autocomplete="off" placeholder=""  disabled="true" class="dsm-input w268 f-l m-r-10 " >
                    <div class="dsm-upload-button f-l m-r-f10">
                        <input type="file" name="file" class="dsm-upload-file js_file" data-fileid="fileInfo" accept=".xml">
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
            pageSize:10,
            dataFormat :function(_data){
                var _id = _data.id;
                var _text = "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' onclick='isCheck' class='ids' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td>"+_data.identifierName+"</td>\
								<td>"+_data.identifierType+"</td>\
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
    });

    $(document).on('click', '.add-grade', function (e) {
        dsmDialog.open({
            type: 1,
            area:['800px','300px'],
            title:"导入数据标识符",
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
        if(licNameArr[licNameArr.length-1]!="xml")
        {
            dsmDialog.error('请选择格式为.xml的文件！');
            return false;
        }
        else{
            $("#fileNameShow").val(fileObj[0].files[0].name);
        }
    });
</script>
</body>
</html>