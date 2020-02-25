<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html class="app">
<head>
[#include "/dsm/include/head.ftl"]
<link href="${base}/resources/dsm/css/organization-management.css" rel="stylesheet" />
<link href="${base}/resources/dsm/css/metroStyle/metroStyle.css" rel="stylesheet" />
<script type="text/javascript" src="${base}/resources/admin/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/resources/dsm/js/jquery.ztree.js"></script>
<style type="text/css">
.ztree li span.button.z_icon01_ico_open,.ztree li span.button.z_icon01_ico_close{margin-right:2px; background: url(${base}/resources/dsm/imgae/organi_icon.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.z_icon03_ico_open,.ztree li span.button.z_icon03_ico_close,.ztree li span.button.z_icon02_ico_open,.ztree li span.button.z_icon02_ico_close{margin-right:2px; background: url(${base}/resources/dsm/imgae/department_icon.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.z_icon03_ico_docu,.ztree li span.button.z_icon02_ico_docu{margin-right:2px; background: url(${base}/resources/dsm/imgae/department_icon.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.m_enable{color:#000000}.m_disable{color:#cfcfcf}
.text_group input.zhushi{}
</style>
<script>
	$(function() {
		$(".big_main").height($(window).height() - 10 + "px");
		
		
		})
</script>
-组织机构管理</title>
</head>

<body>
   
	<!--header-->
	<div class="big_main">
		<span class="main_title">文件解密日志<span class="stroke50"></span>
		</span>
		
		<div class="main_down_content">
			<!--组织机构框架开始-->
			<div class="organization_box">
				<div class="columnbg64"></div>
				<div class="stroke80"></div>
				<div id="tree-id" class="zTreeDemoBackground left">
					<ul id="treeDemo" class="ztree"></ul>
				</div>

			</div>

			<!--组织机构框架结束-->
			<!--右边表单开始-->
			<div class="tab_container">
				<!--查询开始-->
				
				<form class="search_box">
					<div class="columnbg81"></div>
					<div class="stroke90"></div>
					<div class="form_search" style="width: 80%">
						<span class="input_icon length1"> <!--<input type="text" placeholder="用户/账户名" class="ip_search_input ip_search_input_current"  id="ip_search_input" autocomplete="off" />-->
							<input type="text" placeholder="用户/账号名" id="check_user"
							class="ip_search_input   ip_search_input_on" autocomplete="off" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</div>
					<button type="button" class="search_btn" onclick="btnSearch();">
						<i class="search_icon"><img
							src="${base}/resources/dsm/imgae/searchicon.png" /></i> 搜索
					</button>
				</form>
				
				<!--多条件所搜开始-->
				<form id="search" action="${base}/admin/fileLog/fuzzySearch.jhtml" >
				<input type="text" name="userAccount"  placeholder="账号"/>
				<input type="text" name="userName" placeholder="姓名"/>
				<input type="text" name="ipAddress" placeholder="IP地址"/>
				<input type="text" name="deviceName" placeholder="设备名称"/>
				<input type="text" name="teminalType" placeholder="终端类型"/>
				<input type="text" placeholder="执行时间-起" name="beginTime" class="ip_search_input" onClick="WdatePicker()" />
				<input type="text" placeholder="执行时间-止" name="endTime" class="ip_search_input" onClick="WdatePicker()"/>
				<input type="button" value="搜索" onclick="toSearch()"/>
				</form>
				<!--多条件搜索结束-->
				<!--查询结束-->
				<input type="button" onclick="deleLog()" value="删除终端信息"/>
				<input type="button" onclick="leadingIn()" value="导入"/>
				<input type="button" onclick="export()" value="导出"/>
				
			 <!--表单开始-->
				<div class="tab_big_box">
					<form id="list_form" method="post">
					
					<div class="tabtitle_box">
						<div class="columnbg64"></div>
						<div class="stroke80"></div>
						
					</div>
					<div class="tab_body">
						<div class="columnbg36"></div>
						<div class="stroke60"></div>
						<table class="widget_body">
						[#list list.content as page]
							<tr class="tr_border" style="position: relative;">
									<td style="width: 5%;"><div class="stroke20">
									</div><label class="inline_middle">
									<div class="fuxuankuang_box">
									<input type="checkbox" class="fuxuankuang" name="ids"  value="${page.id}"/></div></label></td>
									<td style="width: 15%; color: #002f4c;">${page.userAccount}</td>
									<td style="width: 15%; color: #002f4c;">${page.userName}</td>
									<td style="width: 15%; color: #002f4c;">${page.ipAddress}</td>
									<td style="width: 15%; color: #002f4c;">${page.deviceName}</td>
									<td style="width: 15%; color: #002f4c;">${page.createDate}</td>
									<td style="width: 15%; color: #002f4c;">${page.teminalType}</td>
							</tr>
						 [/#list]
						</table>
					</div>
					</form>
				</div>
				<!--表单结束-->
				
				<!--页码开始-->
				<div class="page_number_big_box">
					<form  id="search_form" action=""   data-func-name="refreshUserPageList();" data-list-formid="list_form">
						
					</form>
				</div>
				<!--页码结束-->
			</div>
			<!--右边表单结束-->
		</div>
		<!--右下边结束组织结构加表单-->
	</div>
	<!--big_main结束-->
	<!--遮罩层开始-->
	<div class="black"></div>
	<!--遮罩层结束-->
	<!--弹窗开始-->
	[#include "/dsm/include/window_organization.ftl"]
	<!--弹窗结束-->

<script>
   
       //departmentId=选中节点id(单个), 初始为0
		var zTree, rMenu, departmentId = 0;
		
		//ztree 节点点击事件回调函数
		function zTreeOnClick(event, treeId, treeNode){
			departmentId = treeNode.id;
			showUsersByDepartmentId();
		}

		//ztree设置
		var setting = {
		
			//设置是否允许同时选中多个节点，这里设为false
			view: {
				selectedMulti: false,
				fontCss : {"font-size":"60px","letter-spacing": "1px"}
			},
		
			//异步加载
			async: {
				enable: true,
				url:"${base}/admin/department/tree.jhtml",
				type:"get",
				autoParam: ["id"]
			},
			
			edit: {
				enable: true,
				showRemoveBtn: false,
				showRenameBtn: false,
				drag: {
					isCopy: false,
					isMove: true
				}
			},
			
			//回调函数
			callback: {
				onClick: zTreeOnClick,
			},
			
		};
		
		
		//ztree初始节点数据
		var zNodes = [{id:0 , name:"组织架构", isParent:true, iconSkin:"z_icon01"}];
		
		
		
		//刷新用户分页列表
		function refreshUserPageList(){
			 refreshPageList({id :"search_form",
			 	pageSize:10,
				dataFormat :function(data){
			
				var id=data.id
				var text =   "<tr class='tr_border ' style='position: relative;'>"+
									"<td style='width: 5%;'><div class='stroke20'></div><label class='inline_middle'><div class='fuxuankuang_box'>"+
									"<input type='checkbox' class='fuxuankuang' name='ids'  value='"+id+"'/></div></label></td>"+
									"<td style='width: 15%; color: #002f4c;'>"+data.userAccount+"</td>"+
									"<td style='width: 15%; color: #fff;'>"+data.userName+"</td>"+
									"<td style='width: 15%; color: #002f4c;'>"+data.ipAddress+"</td>"+
									"<td style='width: 15%; color: #002f4c;'>"+data.deviceName+"</td>"+
									"<td style='width: 15%; color: #002f4c;'>"+parseDate(data.createDate)+"</td>"+
									"<td style='width: 15%; color: #002f4c;'>"+data.teminalType+"</td>"+
									"</tr>";
					return text;
				
				}});
				
		}
		
		//点击部门显示用户
		function showUsersByDepartmentId(){
			$("#search_form").attr("action", "${base}/admin/clientUninstallLog/showPage.jhtml?departmentId="+departmentId);
			
			refreshUserPageList();
			
		}
		
	
   //多条件模糊搜索查询
   function toSearch(){
	   $("#search_form").empty().attr("action","${base}/admin/clientUninstallLog/fuzzySearch.jhtml?departmentId="+departmentId);
		$("form#search input,select").each(function(){
			var _value, _name=$(this).attr("name");
			if($(this).is("input")){
				_value = this.value;
			}else{
				_value = $(this).find("option:selected").val();
			}
				_input = "<input type='hidden' name='"+_name+"' value='"+_value+"'>"
			if(this.value !== ""){
				$("#search_form").append("<input type='hidden' name='"+_name+"' value='"+_value+"'/>")
			}
		});
   		refreshUserPageList();
   }
  
  //设置延时
  function setDelayed(){
    setTimeout(function(){
    
   window.location.reload();
       
    },1000)
	
	}
	
 //删除终端信息
 function deleLog(){
 //判断终端信息是否勾选
  if(isChecked()){
    return;
    }
  
   var $frm=$("#list_form");
   $frm.attr("action","${base}/admin/clientUninstallLog/deleteLog.jhtml");
   $.ajax({
         data:$frm.serialize(),
         dataType:"json",
         type:"post",
         url:$frm.attr("action"),
         success: function(data){
         //隐藏窗口
         hideWindows();
         //延时刷新页面
         setDelayed();
         confirmWin(data.content);
         }
   }) 
 
 }
 	
 //判断终端设备复选框是否选中
    function isChecked(){
    if($("input[name='ids']").is(":checked")){
    return false;
    }else{
    confirmWin("请选择终端设备");
    return true;
     }
    }
  
  
  	
		$(document).ready(function(){
			//ztree初始化
			
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var node = zTree.getNodeByParam("id",0);
			zTree.expandNode(node, true, false);
			zTree.selectNode(node);
			
			rMenu = $("#rMenu1");
			
			//$(".edit_box").css("visibility","hidden");
			
			checkCheckboxStatus();

			//页脚下拉框绑定事件，传值给input，并触发搜索
			$(document).on("change", ".page_select", function(){
				$(this).parents("label.paginate_length").find("input").val(this.value);
				refreshUserPageList();
			});
				
			
			
			
			// "按钮" 鼠标悬停、点击、离开时变色
			$(document).on("mouseout", ".new_btn_file",
					function() {
						$(this).css("background-color","#fff");
						$(this).find("a").css("color","#2badf4");
					});
		
			$(document).on("mousedown", ".new_btn_file",
					function() {
						$(this).css("background-color", "#004c7d");
					});
		
			$(document).on("mouseover", ".new_btn_file",
					function() {
						$(this).css("cursor", "pointer");
						$(this).css("background-color","#2badf4");
						$(this).find("a").css("color","#fff");
					});
					
			
			
			
			//jquery.validator.js表单验证--部门
			var $departmentForm = $("#pop_department form");
			$departmentForm.validate({
				rules: {
					name: {
						required: true,
						pattern: /^[0-9a-z_A-Z\u4e00-\u9fa5]+$/,
						remote: {
							url: "${base}/admin/department/check_name.jhtml",
							data: {pid: function(){return $departmentForm.find("input[name='parentId']").val();},
									id: function(){return $departmentForm.find("input[name='id']").val();}},
							cache: false
						}
					}
				}
			});
			//jquery.validator.js表单验证--用户
			var $userForm = $("#pop_user form");
			$userForm.validate({
				errorClass: "zhushi",//默认是按照组织结构页面的zhushi
				errorElement: "p",
				ignore: ".ignore",
				ignoreTitle: true,
				errorPlacement: function(error, element) { //错误信息位置设置方法
					error.appendTo(element.parents(".text_group")); //这里的element是录入数据的对象
				},
				rules: {
					name: {
						required: true,
						pattern: /^[0-9a-z_A-Z\u4e00-\u9fa5\@\.]+$/,
					},
					account: {
						required: true,
						pattern: /^[0-9a-z_A-Z\u4e00-\u9fa5\@\.]+$/,
						remote: {
							url: "${base}/admin/user/check_username.jhtml",
							cache: false
						}
					},
					password: {
						required: true,
						pattern: /^[^\s&\"<>]+$/,
						minlength: 2,
						maxlength: 20
					},
					rePassword: {
						required: true,
						equalTo: "#password"
					},
					roleIds: {
						required: true,
					},
				},
			});
			//jquery.validator.js表单验证--批量用户
			var $usersForm = $("#_set_users form");
			$usersForm.validate({
				errorClass: "zhushi",//默认是按照组织结构页面的zhushi
				errorElement: "p",
				ignore: ".ignore",
				ignoreTitle: true,
				errorPlacement: function(error, element) { //错误信息位置设置方法
					error.appendTo(element.parents(".text_group")); //这里的element是录入数据的对象
				},
				rules: {
					roleIds: {
						required: true,
					},
					password: {
						pattern: /^[^\s&\"<>]+$/,
						minlength: 2,
						maxlength: 20
					},
					rePassword: {
						equalTo: "#_set_users input[name='password']"
					},
				},
			});
			
			var _th = "<table class='widget_title'><tr>" +
					"<td style='width: 5%'><label class='inline_middle'><div class='fuxuankuang_box '>" +
					"<input type='checkbox' id='idss'  name='sss' class='fuxuankuang' /><input type='hidden' name='Id'><input type='hidden' name='toId'>" +
					"</div></label></td>" +
					"<td style='width: 15%'>账号</td><td style='width: 15%'>姓名</td>" +
					"<td style='width: 15%'>IP地址</td><td style='width: 15%'>设备名</td>" +
					"<td style='width: 15%'>操作时间</td><td style='width: 15%'>终端类型</td>" +
					"</tr></table>";
			$("#list_form .tabtitle_box").append(_th);
		});
		
	
   
  
  
 
</script>
</body>
</html>
