<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html class="app">
<head>
    [#include "/include/head.ftl"]
    <link rel="stylesheet" type="text/css" href="${base}/resources/dsm/css/zTreeStyle.css">
    <script src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
    <script src="${base}/resources/dsm/js/My97DatePicker/WdatePicker.js"></script>
    <script src="${base}/resources/dsm/js/page.js"></script>
    <script src="${base}/resources/dsm/js/fileupload/js/vendor/jquery.ui.widget.js"></script>
    <script src="${base}/resources/dsm/js/fileupload/js/fileupload.js"></script>
    <script type="text/javascript" src="${base}/resources/dsm/js/highlight.js"></script>
    <style>
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

        .table1 tbody tr td{
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .table1 thead {
            width: calc( 100% - 1em )
        }
    </style>
    <title>文件日志</title>
</head>

<body>
<div class="dsm-rightside">
    <div class="maincontent">
        <div class="mainbox">
            <div class="main-right fileLog" style="left:0;">
                [#assign searchMap='{
                    "fileName":"文件名称",
                    "fileSize":"文件大小",
                    "fileMD5":"文件指纹",
                    "classifyName":"分类信息",
                    "gradeName":"分级信息",
                    "time-Wdate":"采集时间",
                	"userAccount":"用户账号",
                	"department":"所属部门",
                	"ipAddress":"IP地址",
                	"equipName":"设备名",
                	"filePath":"文件路径",
                	"responseType":"防护动作",
                	"strategyName":"关联策略"
[#--                	"operateTime-Wdate":"操作时间",--]
[#--                	"operationType-checkb":{"0":"操作类型-文件打印","1":"操作类型-修改保存",--]
[#--                							"2":"操作类型-内容复制","3":"操作类型-文件复制","4":"操作类型-内容剪切",--]
[#--                							"5":"操作类型-文件移动","6":"操作类型-标签分离","7":"操作类型-文件重命名","8":"操作类型-文件网络接受",--]
[#--                							"9":"操作类型-文件网络发送","10":"操作类型-修改电子标签","11":"操作类型-新建电子标签"},--]
[#--                	"docName":"文件名"--]
					}' /]
                [#assign form="logsearch_form"]
                [#include "/include/search.ftl"]
                <div id="deletebtn" style="margin-top: 30px">
                    <div class="btn-toolbar">
                        [#--<div class="btnitem imp" style="margin-left: 0px;">
                            <button type="button" class="btn btn-primary whitebg js_del"><i class="btnicon icon icon-del-blue"></i>删除</button>
                        </div>--]
                        <div class="btnitem imp" style="margin-left: 15px;">
                            <button type="button" class="btn btn-primary whitebg js_imp" isAlarm="0"><i
                                        class="btnicon icon icon-import-blue"></i>导入
                            </button>
                        </div>
                        <div class="btnitem imp" style="margin-left: 15px;">
                            <button type="button" class="btn btn-primary whitebg dropdown-toggle-log"
                                    data-toggle="dropdown"><i class="btnicon icon icon-export-blue"></i>导出
                            </button>
                            <ul class="dropdown-menu" style="left:190px;">
                                <li><a href="#" class="js_exp_all_xml">导出文件</a></li>
                                <li><a href="#" class="js_exp_all_xls">导出当前到Excel文件</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="fileLogPosition" style="margin-top: 30px">
                    <div class="table-view">
                        <form id="loglistform">
                            <table id="datalist" class="table table1" cellspacing="0" width="100%" style="border-collapse:collapse;width: 1278px;" >
                                <thead>
                                <tr>
                                    <th class="w40">
                                        <div class="dsmcheckbox">
                                            <input type="checkbox" value="1" id="lcjk" class="js_checkboxAll"
                                                   data-allcheckfor="ids" name="">
                                            <label for="lcjk"></label>
                                        </div>
                                    </th>
                                    <th>文件名称</th>
                                    <th>文件大小</th>
                                    <th>疑似加密</th>
                                    <th>文件指纹</th>
                                    <th>分类信息</th>
                                    <th>分级信息</th>
                                    <th>严重程度</th>
                                    <th>命中次数</th>
                                    <th>采集时间</th>
                                    <th>用户账号</th>
                                    <th>所属部门</th>
                                    <th>IP地址</th>
                                    <th>设备名称</th>
                                    <th>文件路径</th>
                                    <th>防护动作</th>
                                    <th>关联策略</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </form>
                        <form id="logsearch_form" action="${base}/admin/fileLog/search.do"
                              data-func-name="refreshlogTable();" data-list-formid="datalist">
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<div id="addStrategy" style="display:none;">
    <div class="dsmForms">
        <form id="strategyForm">
            <div class="dsm-form-item dsm-big">
                <div class="dsm-inline">
                    <label class="dsm-form-label">策略名称：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="strategyName" placeholder="策略名称" class="dsm-input required strategyName">
                    </div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">描述：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" name="strategyDesc" placeholder="描述" class="dsm-input required strategyDesc">
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">数据分类：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" placeholder="请选择数据分类" class="dsm-input required dataClassifyName" readonly>
                    </div>
                </div>
                <div class="dsm-inline">
                    <label class="dsm-form-label">数据分级：</label>
                    <div class="dsm-input-inline">
                        <input type="text" autocomplete="off" placeholder="请选择数据分级" class="dsm-input required dataGradeName" readonly>
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">扫描类型：</label>
                    <div class="dsm-input-inline" style="width: auto">
                        <input id="scanType01" type="radio" value="0" class="scanType" name="scanType" style="margin-top: 5px;margin-left: 10px" checked>落地扫描</input>
                        <input id="scanType02" type="radio" value="1" class="scanType" name="scanType" style="margin-left: 10px">全盘扫描</input>
                        <input id="scanType03" type="radio" value="2" class="scanType" name="scanType" style="margin-left: 10px">指定路径</input>
                        <input type="text" autocomplete="off" name="scanPath" class="dsm-input required scanPath" style="width: auto;float: right;height:22px;display: none">
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">检测规则：</label>
                    <div class="dsm-input-inline table-view" style="width: 600px;height: auto;position: relative">
                        <table class="table ruleForm" width="100%" cellspacing="0">
                            <thead>
                            <tr style="height: 40px">
                                <th>规则名称</th>
                                <th>描述</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="dsm-inline">
                    <label class="dsm-form-label">响应规则：</label>
                    <div class="dsm-input-inline">
                        <input id="responseType01" type="radio" value="0" class="responseType" name="responseType" style="margin-top: 5px;margin-left: 10px" checked>发现审计</input><br>
                        <input id="responseType02" type="radio" value="2" class="responseType" name="responseType" style="margin-left: 10px">文件加密</input><br>
                        <input id="responseType03" type="radio" value="1" class="responseType" name="responseType" style="margin-left: 10px">内容脱敏</input><br>
                        <div class="table-view addMaskRule" style="width: 600px;height: auto;display: none;position: relative;">
                            <table class="maskRuleForm table"  width="100%" cellspacing="0">
                                <thead>
                                <tr style="height: 40px">
                                    <th class="w40">
                                        <div class="dsmcheckbox" style="margin-left: 10px">
                                            <input type="checkbox" value="1" id="checkboxFiveInput1"
                                                   class="js_checkboxAll1" data-allcheckfor="maskRuleIds">
                                            <label for="checkboxFiveInput1"></label>
                                        </div>
                                    </th>
                                    <th style="width: 100px">脱敏规则名称</th>
                                    <th>规则类型</th>
                                    <th>待脱敏内容</th>
                                    <th>脱敏方式</th>
                                    <th>脱敏后内容</th>
                                    <th>描述</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div style="width: auto;margin-top: 10px">
                            <input type="checkbox" class="isMatch" style="float: left;zoom: 150%">
                            <div class="dsm-input-inline" style="float:left;bottom: 20px">匹配数大于
                                <input type="text" class="matchValue" name="matchValue" style="width: 50px;height: 22px" value="0" readonly>
                                0表示不限制
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div id="addLog" style="display:none;">
    <div class="dsmForms">
        <form id="logForm">
            <div class="dsm-form-item dsm-big">
                <div style="float: left">
                    <label class="dsm-form-label">文件名称：</label>
                    <div class="dsm-input-inline">
                        <h5 class="fileName"></h5>
                    </div>
                </div>

                <div>
                    <label class="dsm-form-label">文件大小：</label>
                    <div class="dsm-input-inline">
                        <h5 class="fileSize"></h5>
                    </div>
                </div>

                <div>
                    <label class="dsm-form-label">疑似加密：</label>
                    <div class="dsm-input-inline">
                        <h5 class="isEncrypted"></h5>
                    </div>
                </div>

                <div style="float: left">
                    <label class="dsm-form-label">文件指纹：</label>
                    <div class="dsm-input-inline">
                        <h5 class="fileMD5"></h5>
                    </div>
                </div>

                <div>
                    <label class="dsm-form-label">分类信息：</label>
                    <div class="dsm-input-inline">
                        <h5 class="dataClassifyName"></h5>
                    </div>
                </div>

                <div style="float: left">
                    <label class="dsm-form-label">分级信息：</label>
                    <div class="dsm-input-inline">
                        <h5 type="text" class="dataGradeName"></h5>
                    </div>
                </div>

                <div>
                    <label class="dsm-form-label">严重程度：</label>
                    <div class="dsm-input-inline">
                        <h5 type="text" class="dataLevel"></h5>
                    </div>
                </div>

                <div>
                    <label class="dsm-form-label">命中次数：</label>
                    <div class="dsm-input-inline">
                        <h5 type="text" class="hits"></h5>
                    </div>
                </div>

                <div style="float: left">
                    <label class="dsm-form-label">采集时间：</label>
                    <div class="dsm-input-inline">
                        <h5 type="text" class="time"></h5>
                    </div>
                </div>

                <div>
                    <label class="dsm-form-label">用户账号：</label>
                    <div class="dsm-input-inline">
                        <h5 class="userName"></h5>
                    </div>
                </div>

                <div style="float: left">
                    <label class="dsm-form-label">所属部门：</label>
                    <div class="dsm-input-inline">
                        <h5 class="department"></h5>
                    </div>
                </div>

                <div>
                    <label class="dsm-form-label">IP地址：</label>
                    <div class="dsm-input-inline">
                        <h5 class="ipAddress"></h5>
                    </div>
                </div>

                <div style="float: left">
                    <label class="dsm-form-label">设备名称：</label>
                    <div class="dsm-input-inline">
                        <h5 class="equipName"></h5>
                    </div>
                </div>

                <div>
                    <label class="dsm-form-label">文件路径：</label>
                    <div class="dsm-input-inline">
                        <h5 class="filePath"></h5>
                    </div>
                </div>

                <div style="float: left">
                    <label class="dsm-form-label">防护动作：</label>
                    <div class="dsm-input-inline">
                        <h5 class="responseTypeName"></h5>
                    </div>
                </div>

                <div>
                    <label class="dsm-form-label">关联策略：</label>
                    <div class="dsm-input-inline">
                        <h5 class="strategyName"></h5>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
[#include "/log/fileimport.ftl"]
<script src="${base}/resources/dsm/js/dsm-search.js"></script>
<script type="text/javascript">

    var departmentId = 0;

    //刷新用户分页列表
    function refreshlogTable() {
        refreshPageList({
            id: "logsearch_form",
            dataFormat: function (data) {
                var _id = data.id;
                var _docName = data.docName == null ? "" : data.docName;
                var _uName = (data.userAccount == null ? "" : data.userAccount) + "[" + (data.userName == null ? "" : data.userName);
                var fileName = data.fileName.substring(data.fileName.lastIndexOf("\\") + 1, data.fileName.length);
                var filePath = data.fileName.substring(0, data.fileName.lastIndexOf("\\"));
                var dataClassifyName = "";
                var isEncrypted = "";
                $.ajax({
                    data: {id: data.dataType},
                    dataType: "json",
                    type: "get",
                    async: false,
                    url: "${base}/admin/data/classify/getSmallClassify.do",
                    success: function (_data) {
                        if (_data.classifyName != null) {
                            dataClassifyName = _data.classifyName;
                        }
                    }
                });
                var dataGradeName = "";
                $.ajax({
                    data: {id: data.dataClassification},
                    type: "get",
                    async: false,
                    url: "${base}/admin/data/grade/getDataGrade.do",
                    success: function (_data) {
                        if (_data.gradeName != null) {
                            dataGradeName = _data.gradeName;
                        }
                    }
                });
                var strategyName = "";
                var strategyId = "";
                var dataLevel = "";
                var hits = parseInt(data.hits);
                if(data.strategyId != "" && null != data.strategyId){
                    $.ajax({
                        data: {id: data.strategyId},
                        type: "get",
                        async: false,
                        url: "${base}/admin/strategy/showStrategy.do",
                        success: function (_data) {
                            if (_data != null && ""!= _data) {
                                strategyName = _data.strategyName;
                                strategyId = _data.id;
                                var dataLevelRuleEntities = _data.strategyRuleEntities[0].dataLevelRuleEntities;
                                var levelDefaultCode = _data.strategyRuleEntities[0].levelDefaultCode;
                                var levelDefaultValue = "";
                                if (levelDefaultCode === "0") {
                                    levelDefaultValue = "信息";
                                } else if (levelDefaultCode === "1") {
                                    levelDefaultValue = "低";
                                } else if (levelDefaultCode === "2") {
                                    levelDefaultValue = "中";
                                } else if (levelDefaultCode === "3") {
                                    levelDefaultValue = "高";
                                }
                                for (var index in dataLevelRuleEntities) {
                                    var ruleScopeCode = dataLevelRuleEntities[index].ruleScopeCode;
                                    var ruleScopeValue = dataLevelRuleEntities[index].ruleScopeValue;
                                    var levelCode = dataLevelRuleEntities[index].levelCode;
                                    if (levelCode === "0") {
                                        dataLevel = "信息";
                                    } else if (levelCode === "1") {
                                        dataLevel = "低";
                                    } else if (levelCode === "2") {
                                        dataLevel = "中";
                                    } else if (levelCode === "3") {
                                        dataLevel = "高";
                                    }
                                    if (ruleScopeCode === "0") {
                                        var ruleScopeValues = ruleScopeValue.split(",");
                                        if ((parseInt(ruleScopeValues[0]) <= hits && parseInt(ruleScopeValues[1]) >= hits && parseInt(ruleScopeValues[0]) <= parseInt(ruleScopeValues[1])) || (parseInt(ruleScopeValues[1]) <= hits && parseInt(ruleScopeValues[0]) >= hits && (ruleScopeValues[0]) >= parseInt(ruleScopeValues[1]))) {
                                            break;
                                        } else {
                                            dataLevel = levelDefaultValue;
                                        }
                                    } else if (ruleScopeCode === "1") {
                                        if (parseInt(ruleScopeValue) <= hits) {
                                            break;
                                        } else {
                                            dataLevel = levelDefaultValue;
                                        }
                                    } else if (ruleScopeCode === "2") {
                                        if (parseInt(ruleScopeValue) >= hits) {
                                            break;
                                        } else {
                                            dataLevel = levelDefaultValue;
                                        }
                                    }
                                }
                            }
                        }
                    });
                }

                var responseTypeName = "";
                if (data.fileOper === 0) {
                    responseTypeName = "发现审计";
                } else if (data.fileOper === 2) {
                    responseTypeName = "文件加密";
                } else if (data.fileOper === 1) {
                    responseTypeName = "内容脱敏";
                }
                if(data.isEncrypted === "1"){
                    isEncrypted = "加密";
                }else if(data.isEncrypted === "0"){
                    isEncrypted = "非加密";
                }
                var department = "内置账号";
                var text = "<tr>" +
                    "<td class='w40'><div class='dsmcheckbox logList'><input type='checkbox' value='" + _id + "' id='m1_" + _id + "' name='ids'><label for='m1_" + _id + "'></label></div></td>" +
                    "<td><a onclick='getLogDetails(\"" + fileName + "\",\""+data.fileSize+"\",\""+isEncrypted+"\",\""+data.fileMD5+"\",\""+dataClassifyName+"\",\""+dataGradeName+"\",\""+dataLevel+"\",\""+hits+"\",\""+data.time+"\",\""+data.userName+"\",\""+department+"\",\""+data.ip+"\",\""+data.computerName+"\",\""+filePath.split('\\').join('\\\\')+"\",\""+responseTypeName+"\",\""+strategyName+"\")'>"+fileName+"</a></td>" +
                    "<td>" + data.fileSize + "KB</td>" +
                    "<td>" + isEncrypted + "</td>" +
                    "<td>" + data.fileMD5 + "</td>" +
                    "<td>" + dataClassifyName + "</td>" +
                    "<td>" + dataGradeName + "</td>" +
                    "<td>" + dataLevel + "</td>" +
                    "<td>" + hits + "</td>" +
                    "<td>" + data.time + "</td>" +
                    "<td>" + data.userName + "</td>" +
                    "<td>内置账号</td>" +
                    "<td>" + data.ip + "</td>" +
                    "<td>" + data.computerName + "</td>" +
                    "<td>" + filePath + "</td>" +
                    "<td>" + responseTypeName + "</td>" +
                    "<td><a onclick='getStrategyDetails(\"" + strategyId + "\")'>"+strategyName+"</a></td>" +
                    "</tr>";
                return text;
            }
        });
    }

    //获取策略详细信息
    function getStrategyDetails(strategyId){
        $.ajax({
            data: {id: strategyId},
            type: "get",
            dataType: "json",
            url: "${base}/admin/strategy/showStrategy.do",
            success: function (data){
                var strategyRuleEntities = data.strategyRuleEntities;
                var strategyMaskRuleEntities = data.strategyMaskRuleEntities;
                $(".strategyName").val(data.strategyName);
                $(".strategyDesc").val(data.strategyDesc);
                $(".dataClassifyName").val(data.dataClassifySmallEntity.classifyName);
                $(".dataClassifyId").val(data.dataClassifySmallEntity.id);
                $(".dataGradeName").val(data.dataGradeEntity.gradeName);
                $(".dataGradeId").val(data.dataGradeEntity.id);

                if(data.scanTypeCode === "0"){
                    $("#scanType01").prop("checked","checked");
                    $(".scanPath").css("display","none");
                }else if(data.scanTypeCode === "1"){
                    $("#scanType02").prop("checked","checked");
                    $(".scanPath").css("display","none");
                }else if(data.scanTypeCode === "2"){
                    $("#scanType03").prop("checked","checked");
                    $(".scanPath").css("display","block");
                    $(".scanPath").val(data.scanPath);
                }
                if(data.responseTypeCode === "0"){
                    $("#responseType01").prop("checked","checked");
                    $(".addMaskRule").css("display","none");
                }else if(data.responseTypeCode === "1"){
                    $("#responseType03").prop("checked","checked");
                    $(".addMaskRule").css("display","block");
                }else if(data.responseTypeCode === "2"){
                    $("#responseType02").prop("checked","checked");
                    $(".addMaskRule").css("display","none");
                }
                var ruleHtml = "<tr>\
								    <td>"+strategyRuleEntities[0].ruleName+"</td>\
								    <td>"+strategyRuleEntities[0].ruleDesc+"</td>\
                                </tr>";
                $(".ruleForm tbody").html(ruleHtml);
                var maskRuleHtml = "";
                var maskRuleId = "";
                for(var index in strategyMaskRuleEntities){
                    var ruleType = "";
                    if(strategyMaskRuleEntities[index].ruleTypeCode === "0"){
                        ruleType = "隐私检测模版";
                    }else if(strategyMaskRuleEntities[index].ruleTypeCode === "1"){
                        ruleType = "正则表达式";
                    }else if(strategyMaskRuleEntities[index].ruleTypeCode === "2"){
                        ruleType = "关键字";
                    }
                    var maskType = "";
                    if(strategyMaskRuleEntities[index].maskTypeCode === "0"){
                        maskType = "掩码屏蔽";
                    }else if(strategyMaskRuleEntities[index].maskTypeCode === "1"){
                        maskType = "内容替换";
                    }
                    maskRuleId += strategyMaskRuleEntities[index].id+",";
                    maskRuleHtml += "<tr>\
								        <td><div class='dsmcheckbox' style='margin-left: 10px'>\
								        <input type='checkbox' name='maskRuleIds' class='maskRuleIds' id='m_" + strategyMaskRuleEntities[index].id + "' value='" + strategyMaskRuleEntities[index].id + "'/><label for='m_" + strategyMaskRuleEntities[index].id + "'></label></div></td>\
								        <td>"+strategyMaskRuleEntities[index].ruleName+"</td>\
								        <td>"+ruleType+"</td>\
								        <td>"+strategyMaskRuleEntities[index].maskContent+"</td>\
								        <td>"+maskType+"</td>\
								        <td>"+strategyMaskRuleEntities[index].maskEffect+"</td>\
								        <td>"+strategyMaskRuleEntities[index].ruleDesc+"</td>\
						 	        </tr>";
                }
                $(".maskRuleId").val(maskRuleId);
                if(data.matchValue != "0"){
                    $(".isMatch").prop("checked","checked");
                }else {
                    $(".isMatch").removeAttr("checked");
                }
                $(".matchValue").val(data.matchValue);
                $(".maskRuleForm tbody").html(maskRuleHtml);
                $("input").attr("disabled",true);
            }
        });

        dsmDialog.open({
            type: 1,
            area:['1000px','600px'],
            title:"策略信息",
            content : $("#addStrategy"),
        });
    }

    function getLogDetails(fileName,fileSize,isEncrypted,fileMD5,dataClassifyName,dataGradeName,dataLevel,hits,time,userName,department,ipAddress,equipName,filePath,responseTypeName,strategyName) {
        $(".fileName").text(fileName);
        $(".fileSize").text(fileSize+"KB");
        $(".isEncrypted").text(isEncrypted);
        $(".fileMD5").text(fileMD5);
        $(".dataClassifyName").text(dataClassifyName);
        $(".dataGradeName").text(dataGradeName);
        $(".dataLevel").text(dataLevel);
        $(".hits").text(hits);
        $(".time").text(time);
        $(".userName").text(userName);
        $(".department").text(department);
        $(".ipAddress").text(ipAddress);
        $(".equipName").text(equipName);
        $(".filePath").text(filePath);
        $(".responseTypeName").text(responseTypeName);
        $(".strategyName").text(strategyName);
        dsmDialog.open({
            type: 1,
            area:['800px','500px'],
            title:"文件日志信息",
            content : $("#addLog"),
        });
    }

    //判断终端设备复选框是否选中
    function isChecked() {
        if ($("input[name='ids']").is(":checked")) {
            return false;
        } else {
            dsmDialog.error("请选择日志");
            return true;
        }
    }

    function getOperateType(type) {
        switch (type) {
            case ("fileopen"):
                return "文件打开";
                break;
            case ("fileprint"):
                return "文件打印";
                break;
            case ("filesave"):
                return "修改保存";
                break;
            case ("commentcopy"):
                return "内容复制";
                break;
            case ("filecopy"):
                return "文件复制";
                break;
            case ("commentcut"):
                return "内容剪切";
                break;
            case ("filemove"):
                return "文件移动";
                break;
            case ("Labelseparation"):
                return "标签分离";
                break;
            case ("Labelbinding"):
                return "标签绑定";
                break;
            case ("filedelete"):
                return "文件删除";
                break;
            case ("filerename"):
                return "文件重命名";
                break;
            case ("sendNetFile"):
                return "文件网络发送";
                break;
            case ("receiveNetFile"):
                return "网络接收";
                break;
            case ("Labelmodify"):
                return "修改电子标签";
                break;
            case ("Labelcreate"):
                return "新建电子标签";
                break;
            default:
                return "未定义";
        }
    }

    $(document).ready(function () {

        refreshlogTable();
    });

    var fileupload_checkurl = '${base}/admin/fileLog/import_file_log_check.do';
    var fileupload_url = '${base}/admin/fileLog/import_file_log.do';
    //导出全部xls
    $(document).on('click', '.js_exp_all_xls', function (e) {
        dsmDialog.msg("如需选择性导出,请筛选后导出!", 2000)
        var v = 0;
        var v = itemChecked2();
        if (v == 0) {
            dsmDialog.error('列表无日志信息!');
        } else {
            $frm = $("#logsearch_form");
            var datapara = $frm.serialize();
            window.open("${base}/admin/fileLog/exportlogAll.do?" + datapara);
        }
    });

    //导出全部xml
    $(document).on('click', '.js_exp_all_xml', function (e) {
        var v = 0;
        var v = itemChecked2();
        if (v == 0) {
            dsmDialog.error('列表无日志信息!');
        } else {
            $frm = $("#logsearch_form");
            var datapara = $frm.serialize();
            window.open("${base}/admin/fileLog/exportlogAllAsXml.do?" + datapara);
        }
    });

    $(document).on('click', '.js_del', function (e) {
        if (isChecked()) {
            return;
        }

        dsmDialog.toComfirm("是否删除选中日志？", {
            btn: ['确定', '取消'],
            title: "删除日志"
        }, function (index) {

            dsmDialog.close(index);

            var $frm = $("#loglistform");
            $.ajax({
                data: $frm.serialize(),
                dataType: "json",
                type: "post",
                url: "${base}/admin/fileLog/deleteLog.do",
                success: function (data) {
                    if (data.type = "success") {
                        refreshlogTable();
                    } else {
                        dsmDialog.error(data.content);
                    }
                }
            })

        }, function (index) {
            dsmDialog.close(index);
        });

    });

    //判断是否有日志
    function itemChecked2() {
        //声明一个数组用于接收选中流程数
        var i = 0;
        $(".logList").find(":checkbox").each(function () {
            i = i + 1;
        });
        return i;
    }
</script>
</body>
</html>
