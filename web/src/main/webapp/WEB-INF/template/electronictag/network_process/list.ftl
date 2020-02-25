<!DOCTYPE html>
<html lang="ch"> 
<head>
	<meta charset="UTF-8">
	<title>进程信息设置</title>
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
                "processName":"进程信息"
				}' /]			
				[#assign form="networkProcess_form"]
				[#include "/include/search.ftl"]
				<div class="toolbar-btn">
	                <div class="btn-toolbar">
	                	<div class="btnitem imp" style="margin-left: 0px;">
	                   		<button type="button" class="btn btn-primary whitebg  js_add"><i class="btnicon icon icon-del-blue"></i>添加</button>
	                	</div>
                        <div class="btnitem imp" style="margin-left: 15px;">
	                   		<button type="button" class="btn btn-primary whitebg  js_del"><i class="btnicon icon icon-del-blue"></i>删除</button>
	                	</div>
	                </div>
                </div>
				<div id="managerlog-position">
	                <div class="table-view">
	                    <form id="networkprocesslist">
	                        <table id="datalist" class="table" cellspacing="0" width="100%">
	                            <thead>
	                                <tr>
	                                    <th class="w40">
	                                          <div class="dsmcheckbox">
	                                            <input type="checkbox" value="1" id="lcjk" class="js_checkboxAll" data-allcheckfor="ids" name="ids">
	                                            <label for="lcjk"></label>
	                                        </div>
	                                    </th>
	                                    <th>进程信息</th>
	                                </tr>
	                            </thead>
	                            <tbody>
	                            </tbody>
	                        </table>
	                    </form>
	                    <form id="networkProcess_form" action="${base}/admin/networkProcess/search.do" data-func-name="refreshnetprocessTable();" data-list-formid="datalist" style="width: 100%;position: fixed;bottom: 0; background-color: #fff;height: 35px;">
	                    </form>
	                </div>
	            </div>
            </div>
        </div>
    </div>

	<form action="add.do" id="editForm" method="post">
  			<div class="col-lg-10">
  			  	<div class="input-group">  			  	  	
  			  	  <span class="input-group-btn">
  			  	    <button class="btn btn-default" type="button" style="height: 35px; margin-bottom: 10px; width: 110px;">进程名:</button>
  			  	  </span>
				  <input type="text" class="form-control" id="status" name="processName"  >
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
				<label class="dsm-form-label">进程名</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="进程名"
						class="dsm-input" name="addr">
					<div class="block-noempty">*</div>
				</div>
			</div>
		</form>
	</div>
	</div>
	[#include "/log/fileimport.ftl"]
	
   <script src="${base}/resources/dsm/js/dsm-search.js"></script>
   <script type="text/javascript">
   
    	$(document).ready(function () {            
            refreshnetprocessTable();
        });
		
        //刷新用户分页列表
        function refreshnetprocessTable() {
        	clearCheckbox("datalist");
            refreshPageList({
                id: "networkProcess_form",//分页所在form标签id
                pageSize:10,//初始化每页条数
                //js回调函数，参数是ajax请求取得的每条数据，返回表格每一行对应的字符串,然后将返回值传递回ajax请求处
                dataFormat: function (data) { 
                    var _id = data.id;
                    var processName = data.processName;
                	var text = "<tr>" +
                            "<td><div class='dsmcheckbox networkprocesslist'><input type='checkbox' value='" + _id + "' id='m1_" + _id + "' name='ids'><label for='m1_" + _id + "'></label></div></td>" +
                            "<td>" + (processName == null ? "-" : processName) + "</td>" +
                            "</tr>";                                                
                	return text;
                }
            });
        }

		//检查是否勾选
		function oneItemSelected(){
			var ids_ = $("#networkprocesslist :checked[name='ids']");
			if(ids_.length === 1){
				return $(ids_[0]).val();
			}else if(ids_.length === 0){
				dsmDialog.error("请先选择!")
				return false;
			}else{
				dsmDialog.error("所选过多，该功能只支持勾选单个！")
				return false;
			}
		}

		function go() {
				window.location.href="list.do";	
    	}

        $(document).on('click', '.js_add', function (e) {
            dsmDialog.open({
								type: 1,
								area:['800px','300px'],
								title:"编辑进程信息",
								btn:['添加','取消'],
	            				content : $("#editForm"),
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
	        refreshnetprocessTable();
        });
		 
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
								title:"编辑进程信息",
								btn:['保存','取消'],
	            				content : $("#editForm"),
	            				success: function(){
	            					var frm = $('#editForm');
									frm.find("input[name='id']").val(data.id);
									frm.find("input[name='addr']").val(data.addr);
	        						refreshnetprocessTable();
								},
								yes: function(index,layero) {
									submitForm({
										frm : $('#editForm'),
										success: function(data) {
                                            refreshnetprocessTable();
											dsmDialog.close(index);
										},
										error: function() {
                                            refreshnetprocessTable();
											dsmDialog.close(index);
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
	   		var v=alarmChecked();
	   		if(v==0){
	   			dsmDialog.msg('请先选择!'); 
	   		}else{
	     		dsmDialog.toComfirm(
	     			"是否删除选中记录？", 
	     			{
					btn: ['确定','取消'],
					title:"删除进程信息"
					}, 
					function(index){
		 				var $frm=$("#networkprocesslist");
	      				$.ajax({
	          				data:$frm.serialize(),
	          				dataType:"json",
	          				type:"post",
	          				url:"delete.do",
	          				success:function(data){
	               				dsmDialog.msg(data.content);
	              				refreshnetprocessTable();
	          				}
	       				})			
						dsmDialog.close(index);
					},
					function(index){						
						dsmDialog.close(index);
					});
	  	 	}
	 
      	});
      	
		function alarmChecked(){
			var i=0;
			 $(".networkprocesslist").find(":checkbox").each(function(){
			   if($(this).is(":checked")){
			     i=i+1;
			   }
			 })
		    return i;
		}
		
		function itemChecked2(){
			var i=0;
			 $(".networkprocesslist").find(":checkbox").each(function(){
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