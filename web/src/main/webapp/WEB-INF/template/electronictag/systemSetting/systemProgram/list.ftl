<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>系统参数设置</title>
    [#include "/include/head.ftl"]

</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">

        <div class="mainbox setform">
            <div class="dsm-nav-tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="active">
                        <a href="#safeset" data-toggle="tab" aria-expanded="false">基础管理平台设置</a>
                    </li>
                </ul>
                <form id="clientForm">
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="safeset">
                            <div class="dsmForms">
                                <div class="dsm-form-item">
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">平台IP：</label>
                                        <div class="dsm-input-inline">
                                            <input type="text" autocomplete="off" id="jcptServerTxt"
                                                   name="basisPlatformIP"
                                                   value="${JcptServer}" class="dsm-input">
                                        </div>
                                    </div>

                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">端口号：</label>
                                        <div class="dsm-input-inline">
                                            <input type="text" autocomplete="off" id="jcptPortTxt"
                                                   name="basisPlatformPort"
                                                   value="${JcptPort}" class="dsm-input">
                                        </div>
                                    </div>
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">子系统注册ID：</label>
                                        <div class="dsm-input-inline">
                                            <input type="text" autocomplete="off" id="jcptAppId"
                                                   name="basisPlatformAppId"
                                                   value="${JcptAppId}" class="dsm-input">
                                        </div>
                                    </div>
                                    <div class="dsm-inline">
                                        <label class="dsm-form-label">注册授权码：</label>
                                        <div class="dsm-input-inline">
                                            <input type="text" autocomplete="off" id="jcptAppSecret"
                                                   name="basisPlatformSecret"
                                                   value="${JcptAppSecret}" class="dsm-input">
                                        </div>
                                    </div>
                                    <div class="dsm-inline ">
                                        <button type="button" class="f-r btn btn-primary whitebg js_connect">连接测试
                                        </button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="form-btns t-l" style="padding-left:0;">
                <button type="button" class="btn btn-lg btn-primary js_savebasicinfo">保存设置</button>
                <a class="btn btn-lg btn-primary js_cancel graybtn">清除</a>
            </div>
        </div>
    </div>

</div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        if ("${list.enableLogAutoDel}" == 0) {
            $(".logList").addClass("hidden");
            $(".deleteText").addClass("hidden")
        }

        $(".logList").find("[name='logValue']").each(function () {
            var v1 = "${list.recordLogType}";
            this.checked = (v1 & this.value) == this.value;
        })
    });
    $(document).on('click', '.js_savebasicinfo', function (e) {
        var btn = $(this);
        $(btn).attr("disabled", "true")
        var $frm = $("#clientForm");
        if ($frm.valid()) {
            $.ajax({
                type: "post",
                url: "${base}/system_settings/save.do?type=1",
                data: $frm.serialize(),
                async: false,
                dataType: "json",
                success: function (data) {
                    $(btn).removeAttr("disabled");
                    dsmDialog.msg(data.msg);
                }
            });

        } else {
            $(btn).removeAttr("disabled");
        }
    });
    $(document).on('click', '.js_cancel', function (e) {
        $("#policyTimeTxt").val("");
        $("#jcptServerTxt").val("");
        $("#jcptPortTxt").val("");
        $("#jcptAppId").val("");
        $("#jcptAppSecret").val("");
        $("[name='modeVal']").prop("checked", false);

    });
    $(document).on('click', '.js_connect', function (e) {
        var btn = $(this);
        $(btn).attr("disabled", "true")
        var $frm = $("#clientForm");
        if ($frm.valid()) {
            $.ajax({
                type: "post",
                url: "${base}/system_settings/test.do",
                data: $frm.serialize(),
                async: false,
                dataType: "json",
                success: function (data) {
                    $(btn).removeAttr("disabled");
                    dsmDialog.msg(data.msg);
                }
            });

        } else {
            $(btn).removeAttr("disabled");
        }
    });
    $(document).on('click', '.js_savelogpolicy', function (e) {

        var btn = $(this);
        $(btn).attr("disabled", "true")
        var logVal = 0;
        $("#logpolicyForm").find(".logList input:checked").each(function () {
            logVal += parseInt($(this).val());
        })
        var $frm = $("#logpolicyForm");
        if ($frm.valid()) {
            $.ajax({
                type: "post",
                url: "${base}/admin/system_settings/save.do?type=3&" + "logVal=" + logVal,
                data: $frm.serialize(),
                async: false,
                dataType: "json",
                success: function (data) {
                    $(btn).removeAttr("disabled");
                    dsmDialog.msg(data.msg);
                }
            });

        } else {
            $(btn).removeAttr("disabled");
        }
    });

    $(document).on("click", "#rzsccu1", function () {
        if ($(this).is(":checked")) {
            $(".logList").removeClass("hidden");
            $(".deleteText").removeClass("hidden")
        } else {
            $(".logList").addClass("hidden");
            $(".deleteText").addClass("hidden")
        }

    })

</script>
</body>
</html>
