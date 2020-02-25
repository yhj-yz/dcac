<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>发起流程</title>
    [#include "/include/head.ftl"]

</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">

        <div class="mainbox setform">
            <div class="dsm-nav-tabs" >
                <form id="clientForm">
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="safeset" >
                            <div class="dsmForms">
                                <div class="dsm-form-item">
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">流程名称：</label>
                                        <div class="dsm-input-inline">
                                            <input type="text" autocomplete="off" id="jcptServerTxt" name="processName"  class="dsm-input">
                                        </div>
                                    </div>

                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">申请原因：</label>
                                        <div class="dsm-input-inline">
                                            <input type="text" autocomplete="off" id="jcptPortTxt" name="jcptPort" value="${JcptPort}"  class="dsm-input">
                                        </div>
                                    </div>
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">待发起文件:</label>
                                        <input id="fileNameShow" type="text"  autocomplete="off" placeholder=""  disabled="true" class="dsm-input w268 f-l m-r-10 " >
                                        <div class="dsm-upload-button f-l m-r-f10">
                                            <input type="file" name="file" class="dsm-upload-file js_file" data-fileid="fileInfo">
                                            <span class="fbtname">添加文件</span> &nbsp;<span class="fbtname">清空文件</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </form>
            </div>
            <div class="form-btns t-l" style="padding-left:0;">
                <button type="button" class="btn btn-lg btn-primary js_savebasicinfo">新增</button>
                <button type="button" class="btn btn-lg btn-primary js_savebasicinfo">保存</button>
                <button type="button" class="btn btn-lg btn-primary js_cancel">取消</button>
            </div>
        </div>
    </div>

</div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        [#--if("${list.enableLogAutoDel}"==0){--]
            [#--$(".logList").addClass("hidden");--]
            [#--$(".deleteText").addClass("hidden")--]
        [#--}--]

        [#--$(".logList").find("[name='logValue']").each(function(){--]
            [#--var v1 = "${list.recordLogType}";--]
            [#--this.checked = (v1&this.value) == this.value;--]
        [#--})--]
    });
    $(document).on('click', '.js_savebasicinfo', function (e) {
        var btn=$(this);
        $(btn).attr("disabled",""true)
        var $frm = $("#clientForm");
        if($frm.valid()){
            $.ajax({
                type: "post",
                url: "${base}/initiation_process/save.do?type=1",
                data: $frm.serialize(),
                async: false,
                dataType: "json",
                success: function(data){
                    $(btn).removeAttr("disabled");
                    if(data.type="success"){
                        dsmDialog.msg(data.content);
                    }else{
                        dsmDialog.error(data.content);
                    }
                }
            });

        }else{
            $(btn).removeAttr("disabled");
        }
    });
    $(document).on('click', '.js_cancel', function (e) {
       //返回任务列表页面
       location.href = "task/list.jhtml";

    });
    $(document).on('click', '.js_connect', function (e) {
        var btn=$(this);
        $(btn).attr("disabled","true")
        var $frm = $("#clientForm");
        if($frm.valid()){
            $.ajax({
                type: "post",
                url: "${base}/initiation_process/save.do",
                data: $frm.serialize(),
                async: false,
                dataType: "json",
                success: function(data){
                    $(btn).removeAttr("disabled");
                    if(data.type="success"){
                        dsmDialog.msg(data.content);
                    }else{
                        dsmDialog.error(data.content);
                    }
                }
            });

        }else{
            $(btn).removeAttr("disabled");
        }
    });
</script>
</body>
</html>
