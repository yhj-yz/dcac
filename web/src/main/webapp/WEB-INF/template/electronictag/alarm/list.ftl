<!DOCTYPE html>
<html lang="ch"> 
<head>
	<meta charset="UTF-8">
	<title>告警页面</title>
	[#include "/include/head.ftl"]
	<script src="${base}/resources/dsm/js/My97DatePicker/WdatePicker.js"></script>
    <script src="${base}/resources/dsm/js/page.js"></script>
    <script src="${base}/resources/dsm/js/fileupload/js/vendor/jquery.ui.widget.js"></script>
	<script src="${base}/resources/dsm/js/fileupload/js/fileupload.js"></script>
</head>
<body>	
	<div class="dsm-rightside">		
        <div class="maincontent">
            <div class="mainbox">
            	<div class="main-right"  style="left: 0;">                
                [#assign searchMap='{
                "warnDetail":"描述"
				,"userAccount":"告警用户账号"
				,"operateTime-Wdate":"告警时间"
				,"readFlag-checkb":{"read":"是否已读-已读","unread":"是否已读-未读"}
                ,"level-checkb":{"0":"告警等级-致命","1":"告警等级-严重","2":"告警等级-错误","3":"告警等级-警告"}
				}' /]			
				[#assign form="logsearch_form"]
				[#include "/include/search.ftl"]
				<div class="toolbar-btn">
	                <div class="btn-toolbar">
	                	[#--<div class="btnitem imp" style="margin-left: 0px;">
	                   		<button type="button" class="btn btn-primary whitebg  js_del"><i class="btnicon icon icon-del-blue"></i>删除</button>
	                	</div>--]
	                	<div class="btnitem imp" style="margin-left: 15px;">
					   		<button type="button" class="btn btn-primary whitebg  js_edit"><i class="btnicon icon icon-del-blue"></i>告警处理</button>
	                	</div>
	                	<div class="btnitem imp" style="margin-left: 15px;">
								<button type="button" class="btn btn-primary whitebg js_imp"  isLoading="${isLogImport}" isAlarm="1"><i class="btnicon icon icon-import-blue"></i>导入</button>
	                    	</div>	                        
	                        <div class="btnitem imp" style="margin-left: 15px;">
								<button type="button" class="btn btn-primary whitebg dropdown-toggle-log" data-toggle="dropdown"><i class="btnicon icon icon-export-blue"></i>导出</button>
		                        <ul class="dropdown-menu" style="left:190px;">
		                            <li><a href="#" class="js_exp_all_xml">导出到Xml文件</a></li>
		                            <li><a href="#" class="js_exp_all_xls">导出当前到Excel文件</a></li>
		                        </ul>	
	                        </div>	
	                </div>
                </div>
				<div id="managerlog-position">
	                <div class="table-view">
	                    <form id="alarmList">
	                        <table id="datalist" class="table" cellspacing="0" width="100%">
	                            <thead>
	                                <tr>
	                                    <th class="w40">
	                                          <div class="dsmcheckbox">
	                                            <input type="checkbox" value="1" id="lcjk" class="js_checkboxAll" data-allcheckfor="ids" name="ids">
	                                            <label for="lcjk"></label>
	                                        </div>
	                                    </th>
	                                    <th>告警类别</th>
	                                    <th>终端编码</th>
	                                    <th>告警主体IP</th>
	                                    <th>用户账号</th>
	                                    <th class="w180">告警时间</th>
	                                    <th>告警等级</th>
	                                    <th>平台ID</th>
	                                    <th>描述</th>
	                                </tr>
	                            </thead>
	                            <tbody>
	                            </tbody>
	                        </table>
	                    </form>
	                    <form id="logsearch_form" action="${base}/admin/alarm/search.do" data-func-name="refreshAlarmTable();" data-list-formid="datalist" style="width: 100%;position: fixed;bottom: 0; background-color: #fff;height: 35px;">
	                    </form>
	                </div>
	            </div>
            </div>
        </div>
    </div>

	<form action="edit.do" id="editForm" method="post">
		<input type="hidden" name="id" value="1">
		<div class="row">
  			<div id="editDiv" style="position: absolute;left: 40%;margin-left: -25%; padding: 20px;">
			  	<div class="col-lg-10">
    			<div class="input-group">
    			  <span class="input-group-btn">
    			    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;" >告警类别：</button>
    			  </span>
    			  <input type=" " class="form-control" name="type" readonly>
    			</div>
  			</div>
  			<div class="col-lg-10">
  			  	<div class="input-group">
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button"  style="height: 35px; margin-bottom: 10px; width: 110px;" >保密编码：</button>
  			  	  </span>
					<input type="text" class="form-control" name="mcode" readonly>
  			  	</div>
  			</div>
			  <div class="col-lg-10">
  			  	<div class="input-group">
  			  	  
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;" >告警主体IP：</button>
  			  	  </span>
					  <input type="text" class="form-control" name="ip" readonly>
  			  	</div>
  			</div>
			  <div class="col-lg-10">
  			  	<div class="input-group">
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;" >当前用户：</button>
  			  	  </span>
  			  	  <input type="text" class="form-control"name="userAccount" readonly>

  			  	</div>
  			</div>
			  <div class="col-lg-10">
  			  	<div class="input-group">
  			  	  
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;" >告警时间：</button>
  			  	  </span>
					  <input type="text" class="form-control" name="operateTime" readonly>
  			  	</div>
  			</div>
			  <div class="col-lg-10">
  			  	<div class="input-group">
  			  	 
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;" >告警等级：</button>
  			  	  </span>
					   <input type="text" class="form-control"name="level" readonly>
  			  	</div>
  			</div>
			  <div class="col-lg-10">
  			  	<div class="input-group">
  			  	  
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;" >平台ID：</button>
  			  	  </span>
					  <input type="text" class="form-control"name="warnid" readonly>
  			  	</div>
  			</div>
			  <div class="col-lg-10">
  			  	<div class="input-group">
  			  	  
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;" >告警原因：</button>
  			  	  </span>
					  <input type="text" class="form-control"name="warnDetail" readonly>
  			  	</div>
  			</div>
  			
  			<div class="col-lg-10">
  			  	<div class="input-group">  			  	  	
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;">处置状态：</button>
  			  	  </span>
				  <input type="text" class="form-control" id="status" readonly >
  			  	</div>
  			</div>
			
			<div class="col-lg-10">
  			  	<div class="input-group">
  			  	  	
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;">处置结果描述：</button>
  			  	  </span>
					<input type="text" class="form-control"name="result" > 
  			  	</div>
  			</div>

			  
			</div>
		</div>
	</form>
    
    <div id="alarmDetailForm" style="background-color:#F8F8FF;display: none">
	<div class="dsmForms">
		<form id="inputForm" action="list.do">
		<div class="dsm-form-item">
			<div class="dsm-inline">
				<label class="dsm-form-label">告警类别：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="告警类别"
						class="dsm-input" name="type">
					<div class="block-noempty">*</div>
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">保密编码：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="保密编码"
						class="dsm-input" name="mcode">
					<div class="block-noempty">*</div>
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">告警主体IP：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="告警主体IP"
						class="dsm-input" name="ip">
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">当前用户：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="当前用户"
						class="dsm-input" name="uaccount">
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">告警时间：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="告警时间"
						class="dsm-input" name="time">
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">告警等级：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="告警等级"
						class="dsm-input" name="level">
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">平台ID：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="平台ID"
						class="dsm-input" name="warnid">
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">描述：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="描述"
						class="dsm-input" name="warnDetail">
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">处置结果：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="处置结果"
						class="dsm-input" name="result">
				</div>
			</div>
		</div>
		</form>
	</div>
	</div>
	[#include "/log/fileimport.ftl"]
	
   <script src="${base}/resources/dsm/js/dsm-search.js"></script>
   <script type="text/javascript">

	   function getlevel(level) {
	   		switch (level) {
				case ("0"):
					return "致命";
					break;
				case ("1"):
					return "严重";
					break;
				case ("2"):
					return "错误";
					break;
				case ("3"):
					return "告警";
					break;
				default:
					return "未定义";
					break;
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
				   return "文件网络接收";
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
            refreshAlarmTable();
        });
        
        var fileupload_checkurl='${base}/admin/alarm/import_alarm_check.do';
		var fileupload_url='${base}/admin/alarm/import_alarm.do';
		
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
				window.open("${base}/admin/alarm/exportlogAll.do?"+datapara);
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
				window.open("${base}/admin/alarm/exportlogAllAsXml.do?"+datapara);
			}
		});
   
        //刷新用户分页列表
        function refreshAlarmTable() {
        	clearCheckbox("datalist");
            refreshPageList({
                id: "logsearch_form",//分页所在form标签id
                pageSize:10,//初始化每页条数
                //js回调函数，参数是ajax请求取得的每条数据，返回表格每一行对应的字符串,然后将返回值传递回ajax请求处
                dataFormat: function (data) { 

                	var _id = data.id;
                	var _persent = 0; 
                	var _warnDetail = "";
                	if(data.readFlag=="read"){//已读信息内容不加粗
                		_warnDetailTd = "<td class='hiddentd'><div class='hiddendiv' title='"+(data.warnDetail == null ? " ": data.warnDetail)+"'>" + (data.warnDetail == null ? "-": data.warnDetail) + "</div></td>";
                	}else{//未读信息内容加粗
                		_warnDetailTd = "<td class='hiddentd'><div class='hiddendiv'  title='"+(data.warnDetail == null ? " ": data.warnDetail)+"'>" + (data.warnDetail == null ? "-": data.warnDetail) + "</div></td>";
                	}
                	
                	var text = "<tr>" +
                            "<td><div class='dsmcheckbox logList'><input type='checkbox' value='" + _id + "' id='m1_" + _id + "' name='ids'><label for='m1_" + _id + "'></label></div></td>" +
                            "<td title='" + (getOperateType(data.type) == null ? "-" : getOperateType(data.type))+"'>" + (getOperateType(data.type) == null ? "-" : getOperateType(data.type)) + "</td>" +
                            "<td title='" + (data.mcode == null ? "-" : data.mcode)+"'>" + (data.mcode == null ? "-" : data.mcode) + "</td>" +
                            "<td title='" +(data.ip == null ? "-" : data.ip) +"'>" + (data.ip == null ? "-" : data.ip) + "</td>" +
                            "<td title='" + (data.userAccount == null ? "-" : data.userAccount)+"'>" + (data.userAccount == null ? "-" : data.userAccount) + "</td>" +
                            "<td title='" + (data.operateTime == null ? "-" : parseDate(data.operateTime))+"'>" + (data.operateTime == null ? "-" : parseDate(data.operateTime)) + "</td>" +
                            "<td title='" +(getlevel(data.level) == null ? "-" :getlevel(data.level)) +"'>" + (getlevel(data.level) == null ? "-" :getlevel(data.level)) + "</td>" +
                            "<td title='" + (data.warnid == null ? "-" :data.warnid)+"'>" + (data.warnid == null ? "-" :data.warnid) + "</td>" +
                            _warnDetailTd +
                            "</tr>";                                                
                	return text;
                }
            });
        }

		//检查是否勾选
		function oneItemSelected(){
			var ids_ = $("#alarmList :checked[name='ids']");
			if(ids_.length === 1){
				return $(ids_[0]).val();
			}else if(ids_.length === 0){
				dsmDialog.error("请先选择告警信息!")
				return false;
			}else{
				dsmDialog.error("所选告警信息过多，该功能只支持勾选单个告警信息")
				return false;
			}
		}

		function go() {
				window.location.href="list.do";	
    	}
		 
		//点击编辑内容弹出详情页
       $(document).on('click', '.js_edit', function (e) {
		   	var id = null;
		   	if(oneItemSelected()) {
				id = oneItemSelected();
			}
			if(id == null || id == "" || id == "null" || id == undefined) {
				return;
			}
       		$.ajax({
	   				url:'detail.do?id=' + id,//id为当前点击单元格的兄弟单元格的id属性值
					dataType:"json",
					success: function(data){
						dsmDialog.open({
								type: 1,
								area:['800px','450px'],
								title:"编辑警告信息",
								btn:['保存','取消'],
	            				content : $("#editForm"),
	            				success: function(){
	            					var frm = $('#editForm');
									frm.find("input[name='id']").val(data.id);
									frm.find("input[name='type']").val(data.type);
	        						frm.find("input[name='mcode']").val(data.mcode);
	        						frm.find("input[name='ip']").val(data.ip);
	        						frm.find("input[name='userAccount']").val(data.userAccount);
	        						frm.find("input[name='operateTime']").val(parseDate(data.operateTime));	        						
	        						frm.find("input[name='level']").val(data.level);
	        						frm.find("input[name='warnid']").val(data.warnid);
	        						frm.find("input[name='warnDetail']").val(data.warnDetail);
									frm.find("input[name='result']").val(data.result);
									frm.find("input[id='status']").val(data.status==0?"已处理":"未处理");
	        						refreshAlarmTable(); 
								},
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
								} 
    						});														
					}
			});
       
	    });
        
       //点击删除按钮，删除所选记录，如未选中，此按钮未灰色，且鼠标悬停时，提示“请先选择告警信息”
       $(document).on('click', '.js_del', function (e) {
	   		var v=0;
	   		var v=alarmChecked();//判断是否有流程被选中，有返回选中条数
	   		if(v==0){
	   			dsmDialog.msg('请先选择告警信息'); 
	   		}else{
	     		dsmDialog.toComfirm(
	     			"是否删除选中记录？", 
	     			{
					btn: ['确定','取消'],
					title:"删除记录"
					}, 
					function(index){
		 				var $frm=$("#alarmList");
	      				$.ajax({
	          				data:$frm.serialize(),
	          				dataType:"json",
	          				type:"post",
	          				url:"delete.do",
	          				success:function(data){
	               				dsmDialog.msg(data.content);
	              				refreshAlarmTable();
	          				}
	       				})			
						dsmDialog.close(index);
					},
					function(index){						
						dsmDialog.close(index);
					});
	  	 	}
	 
      	});
      	
    	//判断是否有记录被勾选
		function alarmChecked(){
			//声明一个数组用于接收选中流程数
			var i=0;
			 $(".logList").find(":checkbox").each(function(){
			   if($(this).is(":checked")){
			     i=i+1;
			   }
			 })
		    return i;
		}
		
		//判断是否有日志
		function itemChecked2(){		
			//声明一个数组用于接收选中流程数
			var i=0;
			 $(".logList").find(":checkbox").each(function(){
			     i=i+1;
			 })
		    return i;
		}
		
		
       	function clearError(){
    		$('label.error').remove();
    		$('input.error').removeClass('error');
    	}
		

    </script>
</body>
</html>