<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>新增工作流</title>
    [#include "/include/head.ftl"]
    <link rel="stylesheet" type="text/css" href="${base}/resources/dsm/css/zTreeStyle.css">
    <script src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
    <style type="text/css">
        .btn-group.bootstrap-select.dsm-select {
            display: inline-block;
            width: 70px !important;
        }
    </style>

</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">
        <div class="mainbox setform" id="setform">
            <div class="dsm-nav-tabs">
                <ul class="nav nav-tabs" role="tablist" id="perTab">
                    <li class="active"><a href="#basicinfo" data-toggle="tab" aria-expanded="true">工作流基本信息</a></li>
                </ul>
                <form id="programSerForm" action="${base}/process_management/save.do" method="post"
                      enctype="multipart/form-data">
                    <input name="id" type="hidden" value="${flow.id}"/>
                    <input type="hidden" name="isRepeat" value=""/>
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="basicinfo">
                            <div class="dsmForms">
                                <div class="dsm-form-item">
                                    <div class="dsm-inline" style="padding-bottom: 20px;">
                                        <label class="dsm-form-label">工作流名称：</label>
                                        <div class="dsm-input-inline">
                                            <input type="text" autocomplete="off" name="workFlowName"
                                                   placeholder="请填写工作流名称" value="${flow.flowName}"
                                                   onchange="validateRepeat()"
                                                   class="dsm-input required specialChar" style="width:50%;display:inline"/>
                                            <span class="syserror" style='color:red;'></span>
                                        </div>
                                    </div>
                                    <div class="dsm-inline">
                                            <div class="dsm-input-inline dsm-tarea " style="width:100%;position: absolute;top: -30px; left: 20%;">
                                                <label>
                                                    <input name="approveUserType" class="danxuankuang js_receviceTypera"
                                                           type="radio" checked="checked"
                                                           value="1"><i>管理员</i>
                                                </label>
                                                &nbsp;&nbsp;&nbsp;
                                                <label>
                                                    <input name="approveUserType" class="danxuankuang js_receviceTypera"
                                                           type="radio"
                                                           value="0"><i>指定其他审批人</i>
                                                </label>
                                            </div>
                                        <div>
                                        <label class="dsm-form-label">审批人：</label>
                                            <input type="text" autocomplete="off" placeholder="" name="approveUser"
                                                   readonly="true" value="${flow.approveAccount}"
                                                   class="dsm-input w268 f-l m-r-10 ">
                                            <div class="dsm-upload-button f-l m-r-f10">
                                                [#--绑定一个onclick事件--]
                                                <span class="fbtname" onclick="choiceOrg();">浏览...</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">流程描述:</label>
                                        <div class="dsm-input-inline dsm-tarea ">
                                            <textarea name="description" cols="10" rows="2"
                                                      class="dsm-input dsm-textarea"
                                            ></textarea>
                                            <span class="txt-limit">（限2048个字）</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-btns t-l" style="padding-left:0;">
                            [#if "${action}"=="edit"]
                                <button type="button" class="btn btn-lg btn-primary js_edit">修改</button>
                            [#else]
                                <button type="submit" class="btn btn-lg btn-primary js_add">新增</button>
                            [/#if]
                        <a href="${base}/process_management/show.do" class="btn btn-lg btn-primary"
                           style="margin-left: 20px">取消</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bd-example-modal-lg" id="showModal" tabindex="-1" role="dialog"
     aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="height: 550px">
            <div class="modal-body" style="height: 80%;">
                <iframe id="addressIframe" width="100%" height="100%" frameborder="0"></iframe>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" onclick="getAddress(this);">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function choiceOrg() {
        var url = "${base}/process_management/approverlist.do";
        $("#addressIframe").attr("src", url);
        $('#showModal').modal({show: true, backdrop: 'static'});
    }

    function getAddress() {
        var objs = document.getElementById('addressIframe').contentWindow.getCurrnetUser();
        if(undefined == objs)
            dsmDialog.error("审批人只能选择一个");
        console.log(objs);
        $('input[name=approveUser]').val(objs);
        console.log("11", $('input[name=approveUser]').val());
        close();
    }

    function close() {
        //$("#showModal").hide();
        $('#showModal').modal('hide');
    }

    $(document).ready(function () {
        if ("${repeatError}" != "") {
            dsmDialog.msg('"${repeatError}"');
        }
        if ("${error}" != "") {
            dsmDialog.msg('"${error}"');
        }
        if ("${data}" != "") {
            if ("${data.type}" == "error") {
                dsmDialog.msg('${data.content}');
            }
        }
        if("${flow.description}" != ""){
            $("textarea[name=description]").text("${flow.description}");
        }
        //每次隐藏时，清除数据。确保点击时，重新加载
        $("#showModal").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
        });

    });

    $(document).on('click', '.js_edit', function () {
        var validateResult = beforeValidateSubmit();
        if (!validateResult) {
            return false;
        }
        $("#programSerForm").attr("action", "${base}/process_management/update.do");
        $("#programSerForm").submit();
    });

    $(document).on('click', '.js_add', function () {
        var validateResult = beforeValidateSubmit();
        if (!validateResult) {
            return false;
        }
    })

    function beforeValidateSubmit() {
        var isRepeat = $("#programSerForm").find("input[name=isRepeat]").val();
        if (isRepeat == "false") {
            dsmDialog.msg("工作流名称已重复，请重新填写");
            return false;
        }
        return true;
    }

    $(document).on('change', '.js_file', function (e) {
        var filePath = $(this).val();
        $("#fileNameShow").val(filePath);
    });

    function otherValid() {
        if ($("[name='strategyName']").val() == "") {
            $('#perTab a:first').tab('show');
            $("#programSerForm").validate().element($("[name='strategyName']"))
            return false;
        } else {
            return true;
        }
    }


    function validateRepeat() {
        var $workName = $("#programSerForm").find("input[name=workFlowName]").val();
        console.log($workName);
        $.ajax({
            url: '${base}/admin/flow/findFlow.jhtml?flowName=' + encodeURI(encodeURI($workName)),
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf8',
            success: function (data) {
                console.log(data);
                if (data.id != null) {
                    $(".syserror").html("工作流名称重复");
                    $("#programSerForm").find("input[name=isRepeat]").val("false");
                } else {
                    $(".syserror").html("");
                    $("#programSerForm").find("input[name=isRepeat]").val("true");
                }
            }
        })

    }


</script>
</body>
</html>
