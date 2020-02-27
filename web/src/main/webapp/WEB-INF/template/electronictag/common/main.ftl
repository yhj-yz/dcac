[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html>
<head>
    [#include "/include/head.ftl"]
    <title>${systemName!}</title>
</head>
<body class="dsmbgblue">
<div class="dsm-admin">
    <!--dsm头部-->
    <div class="dsm-header dsmbgblue">
        <div class="dsm-banner">
            <a class="dsm-logo">
                <img src="${base}/resources/dsm/images/logo_vamtoo_white2.png" height="80" width="210"/>
            </a>

            <div class="dsm-title">
                <span class="companyname">${companyName!}</span>
                <span class="productname">${systemName!}</span>
            </div>
            <div class="dsm-headbtn">
                <a class="btn dsm-client"></a>
                <a class="btn dsm-client"></a>
            </div>
            <div class="topbar-nav">
                <a href="javascript:void(0);" class="topbar-btn"><i class="icon icon-packagedownload m-r-10"></i>下载客户端安装包</a>
            </div>
            <div class="topbar-nav-help-doc">
                <a href="javascript:void(0);" class="topbar-btn"><i class="icon icon-packagedownload m-r-10"></i>下载离线帮助文档</a>
            </div>
            <div class="topbar-nav-help">
                <a href="javascript:void(0);" class="topbar-btn"></i>打开帮助</a>
            </div>
            [@shiro.hasPermission name = "admin:system:paramset"]
                <div class="topbar-nav-update">
                    <a href="javascript:void(0);" class="topbar-btn"></i>在线升级</a>
                </div>
            [/@shiro.hasPermission]
        </div>
    </div>
    <div class="topbar-download-proc-help-doc" style="right: 224px;width: 202px">
        <div class="proc-item">
            <label>帮助文档</label>
            <div>
                <img class="proc-pic" src="${base}/resources/dsm/images/pic_help_icon.png" alt="">
            </div>
            <div class="item-desc"><a href="../file/helpmanualdownload.do?type=pdf">下载</a></div>
        </div>
    </div>
    <div class="topbar-download-proc" style="right: 10px;">
        <div class="proc-item">
            <label>Linux客户端</label>
            <div>
                <img class="proc-pic" src="${base}/resources/dsm/images/pic_linux_icon.png" alt="">
            </div>
            <div class="item-desc"><a href="../file/download.jhtml?os=linux-x86&bit=64">下载</a></div>
        </div>
    </div>

    <!--dsm左侧导航-->
    <div>
        <div class="dsm-side dsmbgblue">
            <div class="logininfo dsmbgblue hiddentd">
                <a><img class="userimg" src="${base}/resources/dsm/images/user.png"></a>
                <a><span class="username" title="${adminName}">${adminName}</span></a>
                <i class="icon icon-wright"></i>
            </div>
            <div class="closeinfo">
                <hr class="whiteline"/>
                <span class="closebtn js_closeBtn"><i class="icon icon-20 icon-dleft"></i></span>
                <hr class="whiteline rightline"/>
            </div>
            <div class="navbar">
                [#list ["admin:system:paramset", "admin:system:whitelist", "admin:system:backup"] as permission]
                    [@shiro.hasPermission name = permission]
                        <ul class="nav menu">
                            <li class="navitem bottomline">
                                <a class="auto cur" data-toggle="collapse" href="#collapseOne">
                                    <i class="icon icon-nav-sysSet"></i>
                                    <span class="ptitle">系统设置</span>
                                </a>
                                <ul id="collapseOne" class="nav subnav collapse">
                                    [@shiro.hasPermission name = "admin:system:paramset"]
                                        <li>
                                            <a href="${base}/system_settings/list.do" target="electronicTagIframe"
                                               class="auto cur">
                                                <span>系统参数设置</span>
                                            </a>
                                        </li>
                                    [/@shiro.hasPermission]
                                    [@shiro.hasPermission name = "admin:system:whitelist"]
                                        <li>
                                            <a href="${base}/ip_authentication/list.do" target="electronicTagIframe"
                                               class="auto cur">
                                                <span>IP白名单</span>
                                            </a>
                                        </li>
                                    [/@shiro.hasPermission]
                                    [@shiro.hasPermission name = "admin:system:backup"]
                                        <li>
                                            <a href="${base}/admin/backUp/backUpView.do"
                                               data-urlindex="authorizationManagerList" target="electronicTagIframe"
                                               class="auto">
                                                <span>系统备份与还原</span>
                                            </a>
                                        </li>
                                    [/@shiro.hasPermission]
                                </ul>
                            </li>
                        </ul>
                        [#break /]
                    [/@shiro.hasPermission]
                [/#list]

                [@shiro.hasPermission name = "admin:org"]
                    <ul class="nav menu">
                        <li class="navitem bottomline">
                            <a class="auto cur" data-toggle="collapse" href="#collapseTwo">
                                <i class="icon icon-nav-org"></i>
                                <span class="ptitle">组织架构管理</span>
                            </a>
                            <ul id="collapseTwo" class="nav subnav collapse">
                                <li>
                                    <a href="${base}/admin/permissionset/show.do" target="electronicTagIframe"
                                       class="auto cur">
                                        <span>部门与用户管理</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                [/@shiro.hasPermission]

                [#list ["admin:security:level", "admin:security:permission", "admin:security:backup", "admin:security:program", "admin:security:control"] as permission]
                    [@shiro.hasPermission name = permission]
                        <ul class="nav menu">
                            <li class="navitem bottomline">
                                <a class="auto cur" data-toggle="collapse" href="#collapseSix">
                                    <i class="icon icon-nav-stra"></i>
                                    <span class="ptitle">安全策略中心</span>
                                </a>
                                <ul id="collapseSix" class="nav subnav collapse">
[#--                                    [#if isSolo == true]--]
[#--                                        [@shiro.hasPermission name = "admin:security:level"]--]
[#--                                            <li>--]
[#--                                                <a href="../security_level/list.do" target="electronicTagIframe"--]
[#--                                                   class="auto cur">--]
[#--                                                    <span>密级管理</span>--]
[#--                                                </a>--]
[#--                                            </li>--]
[#--                                        [/@shiro.hasPermission]--]
[#--                                    [/#if]--]
                                    [@shiro.hasPermission name = "admin:security:permission"]
                                        <li>
                                            <a href="${base}/admin/permissionset/list.do" target="electronicTagIframe"
                                               class="auto cur">
                                                <span>权限集管理</span>
                                            </a>
                                        </li>
                                    [/@shiro.hasPermission]
                                    [@shiro.hasPermission name = "admin:security:program"]
                                        <li>
                                            <a href="${base}/admin/contrManagerController/list.do"
                                               target="electronicTagIframe"
                                               class="auto cur">
                                                <span>配置程序管理</span>
                                            </a>
                                        </li>
                                    [/@shiro.hasPermission]
                                    [@shiro.hasPermission name = "admin:security:control"]
                                        <li>
                                            <a href="${base}/admin/controlledStrategy/list.do" target="electronicTagIframe"
                                               class="auto cur">
                                                <span>受控程序管理</span>
                                            </a>
                                        </li>
                                    [/@shiro.hasPermission]
                                </ul>
                            </li>
                        </ul>
                        [#break /]
                    [/@shiro.hasPermission]
                [/#list]

                [#--[#list ["admin:flow:approveapprove"] as permission]--]
                [#--[@shiro.hasPermission name = permission]--]

                [#list ["admin:log:file", "admin:log:manage", "admin:log:alarm"] as permission]
                    [@shiro.hasPermission name = permission]
                        <ul class="nav menu">
                            <li class="navitem bottomline">
                                <a class="auto cur" data-toggle="collapse" href="#collapseSeven">
                                    <i class="icon icon-nav-log"></i>
                                    <span class="ptitle">日志审计</span>
                                </a>
                                <ul id="collapseSeven" class="nav subnav collapse">
                                    [@shiro.hasPermission name = "admin:log:file"]
                                        <li>
                                            <a href="${base}/admin/fileLog/list.do" target="electronicTagIframe"
                                               class="auto cur">
                                                <span>文件操作日志</span>
                                            </a>
                                        </li>
                                    [/@shiro.hasPermission]
                                    [@shiro.hasPermission name = "admin:log:alarm"]
                                        <li>
                                            <a href="${base}/admin/alarm/list.do" target="electronicTagIframe" class="auto">
                                                <span>告警日志</span>
                                            </a>
                                        </li>
                                    [/@shiro.hasPermission]
                                    [@shiro.hasPermission name = "admin:log:manage"]
                                        <li>
                                            <a href="${base}/admin/managerLog/list.do" target="electronicTagIframe" class="auto cur">
                                                <span>管理日志</span>
                                            </a>
                                        </li>
                                    [/@shiro.hasPermission]
                                </ul>
                            </li>
                        </ul>
                        [#break /]
                    [/@shiro.hasPermission]
                [/#list]

                <ul class="nav" data-ride="collapse">
                    <li class="navitem" style="height: 41px;">

                    </li>
                </ul>

            </div>

        </div>
    </div>
    <!--dsm右侧主体-->
    <div class="dsm-body">
        [@shiro.hasPermission name = "admin:system"]
            <iframe id="electronicTagIframe" name="electronicTagIframe" src="${base}/admin/permissionset/show.do"
                    style="width: 100%; height: 100%; border: 0;"></iframe>
        [/@shiro.hasPermission]
        [@shiro.hasPermission name = "admin:security"]
            <iframe id="electronicTagIframe" name="electronicTagIframe" src="${base}/admin/permissionset/list.do"
                    style="width: 100%; height: 100%; border: 0;"></iframe>
        [/@shiro.hasPermission]
        [@shiro.hasPermission name = "admin:log:manage"]
            <iframe id="electronicTagIframe" name="electronicTagIframe" src="${base}/admin/managerLog/list.do"
                    style="width: 100%; height: 100%; border: 0;"></iframe>
        [/@shiro.hasPermission]
        [@shiro.hasPermission name = "admin:flow:approveapprove"]
            <iframe id="electronicTagIframe" name="electronicTagIframe" src="${base}/process_management/show.do"
                    style="width: 100%; height: 100%; border: 0;"></iframe>
        [/@shiro.hasPermission]
    </div>
    <!--导航缩进浮动显示-->
    <div class="navhoverbox">
        <div class="nleft">

        </div>
        <div class="nav-cur-l"></div>
    </div>
    <div class="hiduserbox hidden">
        <div class="hidcontent">
            <ul class="nav">
                <li>
                    <a href="${base}/logout.do" class="logoutinfo">
                        <i class="icon icon-loginout m-r-10"></i>
                        <span>注销</span>
                    </a>
                </li>
            </ul>
        </div>
        <span class="tipicon"><i class="icon icon-sxleft"></i></span>
    </div>
    <div id="rightHelp-show">
        <button type="button" class="btn btn-info help-search-btn"></button>
        <div class="col-lg-11">
            <div class="input-group" style="position: absolute;top: 20px;">
                <input type="text" class="form-control" placeholder="在这里输入你要搜索的内容..." style="height: 45px;"
                       id="help-search_input">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" style="height:45px; font-size: 18px; z-index: 999999"
                            id="help-search-go">搜索</button>
                </span>
            </div>
        </div>
        <div id="help-search-content">
            <dl class="help-search-dl">
                <dt><a href="javascript:void(0);" data-toggle="modal" data-target="#myModal"></a></dt>
                <dd title=""></dd>
            </dl>
        </div>
        <div style="position:absolute; width: 94%;height:90%;background-color: #1b7eca; z-index: 9999999;bottom: 0px; display: none; margin: 0 15px;"
             id="search-wait">
            <div class="spinner"
                 style="    width: 60px;height: 60px;position: absolute;margin: 100px auto;left: 50%;top: 50%;margin-left: -30px;margin-top: -30px;z-index: 9999">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 150%;left: -10%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">帮助详细数据</h4>
                </div>
                <div class="modal-body" id="modal-body">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div id="addPatch" style="display: none">
        <form method="post" class="btnitem imp" id="uploadForm" action="${base}/admin/upgrade/import.do"
              enctype="multipart/form-data">
            <div class="dsmForms">
                <label class="dsm-form-label">选择补丁包：</label>
                <div class="dsm-input-block" style="height: 40px;">
                    <input id="fileNameShow11" type="text" autocomplete="off" placeholder="" disabled="true"
                           class="dsm-input w268 f-l m-r-10 " style="width: 150px;">
                    <div class="dsm-upload-button f-l m-r-f10">
                        <input type="file" name="importFile" class="dsm-upload-file js_file1" data-fileid="fileInfo"
                               id="upgradeFileInput">
                        <span class="fbtname">浏览...</span>
                    </div>
                    <button id="insertPatch" type="button" value="导入" class="btn btn-primary btn"
                            style="margin-left:35px;height:35px">导入
                    </button>
                </div>
            </div>
        </form>
    </div>

</div>

<script type="text/javascript">
    $(function () {
        var wellcomeTip = ["有什么需要帮助的吗?", "欢迎回来!", "你好!", "有什么可以帮到你的吗?", "别来无恙啊!"];
        var exitTip = ["下次见哦!", "下次还要来哦!", "再见了!愿你每天都有一个好心情"];
        var flag = 1;
        $(".topbar-nav-help").click(function () {
            $(".help-search-btn").html(wellcomeTip[Math.round(Math.random() * (wellcomeTip.length - 1))]);
            if (flag == 1) {
                $(".topbar-nav-help > a").html("关闭帮助");
                $("#rightHelp-show").stop().animate({width: '30%'}, 500, function () {

                    $(".help-search-btn").stop().animate({opacity: 1}, 500, function () {

                    });
                });
                flag = 0;
            } else {
                $(".topbar-nav-help > a").html("打开帮助");
                $(".help-search-btn").html(exitTip[Math.round(Math.random() * (exitTip.length - 1))]);
                $("#help-search-content").stop().animate({height: "1%"}, 200, function () {

                    $(".help-search-btn").stop().animate({opacity: 0}, 500, function () {
                        $("#rightHelp-show").stop().animate({width: '0%'}, 500, function () {

                        });
                    })
                });
                flag = 1;
            }
        })
        $("#help-search-go").click(function () {
            var keywords = $('#help-search_input').val();
            if (keywords == null || keywords == undefined || keywords.trim() == "" || !(/^[\u4E00-\u9FA5A-Za-z0-9]/.test(keywords))) {
                dsmDialog.msg("搜索内容不合法");
            } else {
                $('#search-wait').css({display: "block"});
                setTimeout(function () {
                    $('#search-wait').css({display: "none"});
                    $.get("${base}/admin/help/search.do", {"content": keywords}, function (data) {
                        if (data.length < 1) {
                            dsmDialog.msg("对不起,没有搜索到您想要的内容哦!");
                        }
                        var content = "";
                        $.each(data, function (index, element) {
                            content += "<dl class='help-search-dl'>\n" +
                                "                <dt><a data-toggle='modal' data-target='#myModal' name='id' value=" + element.id + " class='help-search-title' href='#'>" + element.title + "</a></dt>\n" +
                                "                <dd>" + element.content + "</dd>\n" +
                                "            </dl>"
                        });
                        $("#help-search-content").html(content);

                        $("#help-search-content").animate({height: "90%"}, 1000, function () {
                            $('.help-search-title').click(function () {
                                var id = $(this).attr("value");
                                console.log(id);
                                $.get("${base}/admin/help/search.do", {"id": id}, function (data) {

                                    var content = "<h2 id='help-search-dt' style='text-align: center'>" + data[0].title + "</h2>" +
                                        "                    <div id='help-search-dd' style='text-indent: 2em;'>" + data[0].content + "</div>";
                                    if (data[0].picture != null && data[0].picture != undefined) {
                                        var split = data[0].picture.split(";");
                                        $.each(split, function (index, ele) {
                                            content += "<div class='row' style='text-align: center'><div class='col-xs-10 col-md-10'><a href='#' class='thumbnail'><img src='${base}" + ele + "' alt=''></a></div></div>";
                                        });
                                    }
                                    $('#modal-body').html(content);
                                });
                            })
                        })
                    })
                }, 700)
            }
        });
        $('.topbar-nav-update').click(function () {
            dsmDialog.open({
                type: 1,
                area: ['700px', '250px'],
                btn: ['取消'],
                title: "添加升级补丁包",
                content: $('#addPatch'),
                yes: function (index, layero) {
                    dsmDialog.close(index);
                }
            });
        });

        $(document).on('change', '.js_file1', function (e) {
            var filePath = $(this).val();
            var licNameArr = filePath.lastIndexOf('.');
            if (filePath.substring(licNameArr + 1) != "war") {
                dsmDialog.msg("目前上传包只支持war包!")
                $("#fileNameShow11").val("");
                return false;
            } else {
                $("#fileNameShow11").val(filePath);
            }
        });

        $(document).on('click', '#insertPatch', function (e) {
            if (confirm("系统升级需要5分钟左右的时间,5分钟刷新页面即可,您确定升级吗?")) {
                var formData = new FormData();
                formData.append("importFile", $(".js_file1")[0].files[0]);
                $.ajax({
                    url: '${base}/admin/upgrade/import.do',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: formData,
                    processData: false, // 使数据不做处理
                    contentType: false, // 不要设置Content-Type请求头
                    success: function (data) {
                        dsmDialog.msg(data.content);
                        setTimeout(function () {
                            window.location.reload();
                        }, 1000);
                    },
                    error: function (data) {
                        dsmDialog.error("上传失败");
                    }
                });
            }
        });
    })
    $(function () {
        initWindowsStyle();
        window.onresize = adjust;
    });

    function adjust() {
        initWindowsStyle();
    }

    function initWindowsStyle() {
        if ($(window).width() < 1030) {
            if (!$(".dsm-admin").hasClass('closed')) {
                $(".js_closeBtn").click();
            }
        } else {
            if ($(".dsm-admin").hasClass('closed')) {
                $(".js_closeBtn").click();
            }
        }
    }

    //下载框
    $(".topbar-nav").hover(function () {
        $(".topbar-download-proc").addClass("in");

    }, function () {
        $(".topbar-download-proc").removeClass("in");
    });
    $(".topbar-download-proc").hover(function () {

        $(this).addClass("in");

    }, function () {
        $(this).removeClass("in");
    });

    $(".topbar-nav-help-doc").hover(function () {
        $(".topbar-download-proc-help-doc").addClass("in");

    }, function () {
        $(".topbar-download-proc-help-doc").removeClass("in");
    });
    $(".topbar-download-proc-help-doc").hover(function () {

        $(this).addClass("in");

    }, function () {
        $(this).removeClass("in");
    });


</script>

</body>
</html>
