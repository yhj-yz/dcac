<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html class="app">
<head>
    [#include "/include/head.ftl"]
    <link rel="stylesheet" type="text/css" href="${base}/resources/dsm/css/zTreeStyle.css">
    <script src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
    <script src="${base}/resources/dsm/js/My97DatePicker/WdatePicker.js"></script>
	<script src="${base}/resources/dsm/js/page.js"></script>
	<script src="${base}/resources/dsm/js/fileupload/js/vendor/jquery.ui.widget.js"></script>
	<script src="${base}/resources/dsm/js/fileupload/js/fileupload.js"></script>
    <title>文件日志</title>
</head>

<body>
    <div class="dsm-rightside">
        <div class="maincontent">
            <div class="mainbox">
                <div class="main-right fileLog" style="left:0;">
                	[#assign searchMap='{
                	"userAccount":"账号",
                	"userName":"姓名",
                	"ip":"IP地址",
                	"deviceName":"设备名",
                	"operateTime-Wdate":"操作时间",
                	"operationType-checkb":{"0":"操作类型-文件打印","1":"操作类型-修改保存",
                							"2":"操作类型-内容复制","3":"操作类型-文件复制","4":"操作类型-内容剪切",
                							"5":"操作类型-文件移动","6":"操作类型-标签分离","7":"操作类型-文件重命名","8":"操作类型-文件网络接受",
                							"9":"操作类型-文件网络发送","10":"操作类型-修改电子标签","11":"操作类型-新建电子标签"},
                	"docName":"文件名"
					}' /]
					[#assign form="logsearch_form"]
                	[#include "/include/search.ftl"]
                    <div id="deletebtn">
                        <div class="btn-toolbar">
	                        [#--<div class="btnitem imp" style="margin-left: 0px;">
	                        	<button type="button" class="btn btn-primary whitebg js_del"><i class="btnicon icon icon-del-blue"></i>删除</button>
							</div>--]
							<div class="btnitem imp" style="margin-left: 15px;">
								<button type="button" class="btn btn-primary whitebg js_imp" isAlarm="0"><i class="btnicon icon icon-import-blue"></i>导入</button>
	                    	</div>
	                        <div class="btnitem imp" style="margin-left: 15px;">
								<button type="button" class="btn btn-primary whitebg dropdown-toggle-log" data-toggle="dropdown"><i class="btnicon icon icon-export-blue"></i>导出</button>
		                        <ul class="dropdown-menu" style="left:190px;">
		                            <li><a href="#" class="js_exp_all_xml">导出文件</a></li>
		                            <li><a href="#" class="js_exp_all_xls">导出当前到Excel文件</a></li>
		                        </ul>
	                        </div>
	                    </div>
                    </div>
                    <div id="fileLogPosition">
						<div class="table-view">
                        <form id="loglistform">
                            <table id="datalist" class="table" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                       <th class="w40">
                                           <div class="dsmcheckbox">
                                               <input type="checkbox" value="1" id="lcjk" class="js_checkboxAll" data-allcheckfor="ids" name="">
                                               <label for="lcjk"></label>
                                           </div>
                                       </th>
                                        <th>账户姓名</th>
                                        <th>IP地址</th>
                                        <th>设备名</th>
                                        <th class="w180">操作时间</th>
                                        <th>操作类型</th>
                                        <th>文件名</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </form>
                        <form id="logsearch_form" action="${base}/admin/fileLog/search.do" data-func-name="refreshlogTable();" data-list-formid="datalist">
                        </form>
                    </div>
					</div>
                </div>

            </div>
        </div>
    </div>
	[#include "/log/fileimport.ftl"]
    <script src="${base}/resources/dsm/js/dsm-search.js"></script>
    <script>

        var departmentId = 0;

        //刷新用户分页列表
        function refreshlogTable() {
            refreshPageList({
                id: "logsearch_form",
                dataFormat: function (data) {
					console.log(data);
                    var _id = data.id;
                    var _docName=data.docName==null?"":data.docName;
                    var _uName=(data.userAccount==null?"":data.userAccount) + "["+(data.userName==null?"":data.userName);
                    var text = "<tr>" +
                                "<td><div class='dsmcheckbox logList'><input type='checkbox' value='" + _id + "' id='m1_" + _id + "' name='ids'><label for='m1_" + _id + "'></label></div></td>" +
                                "<td class='hiddentd'><div class='hiddendiv' title='"+_uName+"'>" + _uName+"]</td>" +
                                "<td>" + (data.ip==null?"":data.ip) + "</td>" +
                                "<td>" + (data.deviceName==null?"":data.deviceName)  + "</td>" +
                                "<td>" + parseDate(data.operateTime) + "</td>" +
                                "<td>" + getOperateType(data.operationType) + "</td>" +
                                "<td class='hiddentd'><div class='hiddendiv' title='"+_docName+"'>" +_docName + "</td>" +
                                "</tr>";
                    return text;

                }
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

		function getOperateType(type){
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
        
        var fileupload_checkurl='${base}/admin/fileLog/import_file_log_check.do';
		var fileupload_url='${base}/admin/fileLog/import_file_log.do';
		//导出全部xls
		$(document).on('click', '.js_exp_all_xls', function (e) {
            dsmDialog.msg("如需选择性导出,请筛选后导出!",2000)
			var v=0;
	   		var v=itemChecked2();
			if(v==0){
	     		dsmDialog.error('列表无日志信息!');
	   		}else{
				$frm=$("#logsearch_form");
				var datapara=$frm.serialize();
				window.open("${base}/admin/fileLog/exportlogAll.do?"+datapara);
			}
		});
		
		//导出全部xml
		$(document).on('click', '.js_exp_all_xml', function (e) {
			var v=0;
	   		var v=itemChecked2();
			if(v==0){
	     		dsmDialog.error('列表无日志信息!');
	   		}else{
				$frm=$("#logsearch_form");
				var datapara=$frm.serialize();
				window.open("${base}/admin/fileLog/exportlogAllAsXml.do?"+datapara);
			}
		});
		        
		$(document).on('click', '.js_del', function (e) {
			if (isChecked()) {
                return;
            }
		
			dsmDialog.toComfirm("是否删除选中日志？", {
	            btn: ['确定','取消'],
	            title:"删除日志"
	        }, function(index){
	        
	            dsmDialog.close(index);
		        
				var $frm = $("#loglistform");
	            $.ajax({
	                data: $frm.serialize(),
	                dataType: "json",
	                type: "post",
	                url: "${base}/admin/fileLog/deleteLog.do",
	                success: function (data) {
	                	if(data.type="success"){
	                		refreshlogTable();
	                	}else{
                			dsmDialog.error(data.content);
	                	}
	                }
	            })
				
	        }, function(index){
	            dsmDialog.close(index);
	        });

    	}); 

		//判断是否有日志
		function itemChecked2(){		
			//声明一个数组用于接收选中流程数
			var i=0;
			 $(".logList").find(":checkbox").each(function(){
			     i=i+1;
			 })
		    return i;
		}
    </script>
</body>
</html>
