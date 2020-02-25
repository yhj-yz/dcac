<link href="${base}/resources/dsm/css/metroStyle/metroStyle.css" rel="stylesheet" />
<style>
.ztree li span.button.z_icon01_ico_open,.ztree li span.button.z_icon01_ico_close{margin-right:2px; background: url(${base}/resources/dsm/imgae/organi_icon.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.z_icon03_ico_open,.ztree li span.button.z_icon03_ico_close,.ztree li span.button.z_icon02_ico_open,.ztree li span.button.z_icon02_ico_close{margin-right:2px; background: url(${base}/resources/dsm/imgae/department_icon.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.z_icon03_ico_docu,.ztree li span.button.z_icon02_ico_docu{margin-right:2px; background: url(${base}/resources/dsm/imgae/department_icon.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.uPickerModal .widget_body tr {
    padding: 5px;
}
.uPickerModal .tabtitle_box {
	border: 1px solid #ddd;
}
.uPickerModal .col_xs_9 ul li a {
    color: #333;
}
.uPickerModal .page_number_big_box {
    position: relative;
    width: 515px;
    float: right;
}
.uPickerModal .organization_box {
    padding-bottom: 0;
}
.uPickerModal .nav-tabs > li > a {
    width: 75px;
}
.uPickerModal .userchoose {
    height: 38px;
    border-radius: 0;
    outline: none;
    padding-top: 0px;
    width: 65px;
    background-color: #fff;
    border: 1px solid #ddd;
    
}
.uPickerModal .userchoose.groupchoose{
    position: absolute;
    top: 0;
    right: 2px;
    
}
.uPickerModal .chosedUser{
    background-color: #2BAEF5;
    padding: 3px 5px 4px 7px;
    line-height: 16px;
    color: #fff;
}
.uPickerModal .chosedUser .remove
{
    cursor: pointer;
}
.uPickerModal .page_number_big_box {
    margin-top: 0;
    margin-bottom: 0;
}
.uPickerModal dd  {
    float: left;
    margin-right: 10px;
    margin-bottom: 15px;
    margin-top: 5px;
}
.uPickerModal dl{
	height: 100px;
    overflow-y: auto;
}
.uPickerModal .groupitem{
    clear: both;
    padding: 5px;
}
.uPickerModal .fuxuankuang_box{
    margin-top: 0;
}
.uPickerModal .inline_middle,
.uPickerModal .gname{
	float:left;
}
.uPickerModal .gname{
    margin-left: 5px;
}
.inline_middle .on {
    margin-top: 8px;
}
</style>
<script type="text/javascript" src="${base}/resources/dsm/js/jquery.ztree.js"></script>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title">选择人员</h4>
</div>
<div class="modal-body">
	<div class="main_down_content">
		<!--组织机构框架开始-->
		<div class="organization_box">
			<ul class="nav nav-tabs" role="tablist">
			    <li role="presentation" class="active"><a href="#treeid" aria-controls="treeid" role="tab" data-toggle="tab">按组织</a></li>
			    <li role="presentation"><a href="#groupid" aria-controls="groupid" role="tab" data-toggle="tab">按分组</a></li>
			</ul>
			<button type="button" class="btn userchoose groupchoose JS_grchooseok" data-toggle="modal" >选择分组</button>
			<div class="tab-content" >
		    	<div role="tabpanel" class="tab-pane active" id="treeid">
		    		
					<ul id="deptTree" class="ztree"></ul>
		    	</div>
		    	<div role="tabpanel" class="tab-pane" id="groupid" style="height: 240px;overflow-y: auto;">
		    		
		    	</div>
	    	</div>
		</div>
		<!--组织机构框架结束-->
		<button type="button" class="btn userchoose JS_chooseok" data-toggle="modal">选择人员</button>
		<!--右边表单开始-->
		<div class="tab_container" style="margin-top: 3px;">
			<!--表单开始-->
			<div class="tab_big_box">
				<form id="chooselist_form" >
				<div class="tabtitle_box">
					<div class="columnbg64"></div>
					<div class="stroke80"></div>
					
				</div>
				<div class="tab_body" style="height: 220px;overflow-y: auto;">
					<div class="columnbg36"></div>
					<div class="stroke60"></div>
					<table class="widget_body">
						<!-- 用户列表 -->
					</table>
				</div>
				</form>
			</div>
			<!--表单结束-->
			<!--页码开始-->
			<div class="page_number_big_box">
				<form id="search_form" data-func-name="refreshUserPageList();" data-list-formid="chooselist_form">
					<input type="hidden" name="name" >
				</form>
			</div>
			<!--页码结束-->
		</div>
		<!--右边表单结束-->
	</div>
	
		<fieldset style="margin-top: 0;">
		    <legend>已选</legend>
		    <dl class="clearfix filter-selected-list">
    		</dl>
		</fieldset>
</div>
<div class="modal-footer">
  	<button type="button" class="btn btn-primary js_modelPickerUser" >完成选择</button>
	<button type="button" class="btn btn-primary js_modelClear" data-dismiss="modal">清空</button>
	<button type="button" class="btn btn-primary " data-dismiss="modal">取消</button>
</div>

	
	<script type="text/javascript">
	var zTree, rMenu, departmentId = 0;
	var zNodes = [{id:0 , name:"组织架构", isParent:true, iconSkin:"z_icon01"}];
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
			onAsyncSuccess: zTreeOnAsyncSuccess
		}
	};
	function initGroupList(){
		$.ajax({
		async: true,
		type: "get",
		url: "${base}/admin/group/search.jhtml?name=&pageSize=100",
		dataType:"json",
		success: function(data){
			$("#groupid").html("");
			var jobject=data.content;
			var ghtml="";
			var gghtml="";
			for(var i=0;i<jobject.length;i++)
			{
			    gghtml+='<div class="groupitem"><div class="domainItem" name="groupName" value="'+jobject[i].id+'"  >'+jobject[i].groupName+'</div></div>';
			 
			}
			$("#groupid").append(gghtml);
		}
	});
	}
	
	function initGroupLists(){
		$.ajax({
		async: true,
		type: "get",
		url: "${base}/admin/group/search.jhtml?name=&pageSize=100",
		dataType:"json",
		success: function(data){
			$("#groupid").html("");
			var jobject=data.content;
			var ghtml="";
			for(var i=0;i<jobject.length;i++)
			{
			 	ghtml+='<div class="groupitem"><label class="inline_middle"><div class="fuxuankuang_box"><input type="checkbox" class="fuxuankuang js_gid" data-uname="'+jobject[i].groupName+'" data-utype="2" name="gids" value="'+jobject[i].id+'"></div></label><div class="gname">'+jobject[i].groupName+'</div></div>';
			 
			}
			$("#groupid").append(ghtml);
		}
	});
	}
	
	
	//点击用户组事件查询用户列表
	$(document).on("click",".domainItem",function(){
	 var groupId=$(this).attr("value");
	
	 showUsersBygroupId(groupId);
	   
	   
	})
	
	function zTreeOnClick(event, treeId, treeNode){
		departmentId = treeNode.id;
		showUsersByDepartmentId();
	}
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		var node = zTree.getNodeByParam("id",departmentId);
	    zTree.selectNode(node);
	};
	function showUsersByDepartmentId(){
		$("#search_form").attr("action", "${base}/admin/user/list_bydepartment.jhtml?departmentId="+departmentId);
		refreshUserPageList();
	}
	
	function showUsersBygroupId(groupId){
	 $("#search_form").empty();
	 $("#search_form").attr("action","${base}/admin/group/findUsers.jhtml?groupId="+groupId);
	 refreshUserPageList();
	}
	
	//刷新用户分页列表
	function refreshUserPageList(){
		refreshPageList({id :"search_form",
			pageSize:10,
			dataFormat :function(_data){
				var rName = "";
				if(_data.roles){
					for(var a = 0; a < _data.roles.length; a++){
						if(a === _data.roles.length - 1){
							rName += _data.roles[a].name;
						}else{
							rName = rName + _data.roles[a].name + ";";
						}
					}
				}
				var _id = _data.id;
				var _result = function (v){
					return v === true ? "是" : "否";
				}
				var _loginDate = _data.loginDate ? parseDate(_data.loginDate) : "--";
				var _domainName = _data.domainUserName ? _data.domainUserName.split("@")[1] : "系统用户";
				var _text =     "<tr class='tr_border ' style='position: relative;'>"+
								"<td style='width: 15%;'><div class='stroke20'></div><label class='inline_middle'><div class='fuxuankuang_box'>"+
								"<input type='checkbox' class='fuxuankuang js_cid' data-uname='"+_data.name+"' data-uaccount='"+_data.account+"' name='cids' value='"+_id+"'/></div></label></td>"+
								"<td style='width: 17%; color: #002f4c;'><a href='#' style='color: #002f4c;' onclick='menu_editUser("+_id+");return false;' >"+_data.account+"</a></td>"+
								"<td style='width: 17%; color: #002f4c;'>"+_data.name+"</td>"+
								"<td style='width: 17%; color: #002f4c;'>"+rName+"</td>"+
								"<td style='width: 17%; color: #002f4c;'>"+_data.belongDomain.securityName+"</td>"+
								"<td style='width: 17%; color: #002f4c;'>"+_data.belongSecurity.securityName+"</td>"+
								"</tr>";
				return _text;
			}});
		
	}
	$('#userPickerModal').on('shown.bs.modal', function (e) {
		//ztree初始化
		$.fn.zTree.init($("#deptTree"), setting, zNodes);
		zTree = $.fn.zTree.getZTreeObj("deptTree");
		var node = zTree.getNodeByParam("id",0);
		zTree.expandNode(node, true, false);
		zTree.selectNode(node);
		
		initGroupList();
		initSelData();
	})
	$(document).ready(function(){
		//搜索栏绑定键盘keyup事件
		$(document).on("keyup", "#check_user", function(){
			search(this.value);
		});
		$(document).on("keydown", "#check_user", function(event){
			if(event.which === 13){
				event.preventDefault();//阻止元素发生默认的行为(确认键)
			}
		});
		
		//页脚下拉框绑定事件，传值给input，并触发搜索
		$(document).on("change", "select.page_select", function(){
			$(this).parents("label.paginate_length").find("input").val(this.value);
			refreshUserPageList();
		});
			
		
		var _th = "<table class='widget_title'><tr>" +
				"<td style='width: 15%'><label class='inline_middle'><div class='fuxuankuang_box '>" +
				"<input type='checkbox' class='fuxuankuang' /><input type='hidden' name='fromId'><input type='hidden' name='toId'>" +
				"</div></label></td>" +
				"<td style='width: 17%'>账号</td>" +
				"<td style='width: 17%'>姓名</td><td style='width: 17%'>所属角色</td>" +
				"<td style='width: 17%'>所属安全域</td>" +
				"<td style='width: 17%'>所属密级</td>" 
				"</tr></table>";
		$("#chooselist_form .tabtitle_box").append(_th);
	});
	$(document).on("click", ".JS_chooseok", function(){
		$("#chooselist_form  input:checked[name='cids']").each(function(){
			if($(".uPickerModal .chosedUser[data-selaccount='"+$(this).data("uaccount")+"']").length==0){
				$(".filter-selected-list").prepend(getSelectedUserHtml(1,$(this).val(),$(this).data("uname"),$(this).data("uaccount")));
			}
		});
	});
	$(document).on("click", ".JS_grchooseok", function(){
		$("#groupid  input:checked[name='gids']").each(function(){
			if($(".uPickerModal .chosedUser[data-selid='"+$(this).val()+"'][data-utype='2']").length==0){
				$(".filter-selected-list").prepend(getSelectedUserHtml(2,$(this).val(),$(this).data("uname")));
			}
		});
	});
	$(document).on("click", ".J_remove", function(){
        $(this).parent().parent().remove();
    });
	function getSelectedUserHtml(type,uid,uname,uaccount){
		//type 1:人员  2：组
		if(type==1){
			return '<dd><span class="chosedUser" data-utype="'+type+'" data-selid="'+uid+'" data-selaccount="'+uaccount+'" ><span class="js_utext">'+uname+'['+uaccount+']</span><em class="remove J_remove">×</em></span></dd>'			
		}
		else{
			return '<dd><span class="chosedUser"  data-utype="'+type+'"  data-selid="'+uid+'" ><span class="js_utext">【'+uname+'】</span><em class="remove J_remove">×</em></span></dd>'			
		}
	}
	
	$(document).on("click", ".js_modelPickerUser", function(){
		callBackInitData($("#userPickerModal"));
		$("#userPickerModal").modal("hide");
	});
	
	function dataAttrCopy(btn,modal){
		$(modal).data("ushow",$(btn).data("ushow"));
		$(modal).data("uhidden",$(btn).data("uhidden"));
		$(modal).data("ghidden",$(btn).data("ghidden"));
	}
	function callBackInitData(modal){
		var viewId=$(modal).data("ushow");
		var uhiddenId=$(modal).data("uhidden");
		var ghiddenId=$(modal).data("ghidden");
		if($("#"+viewId)!=null){
			$("#"+viewId).html($(".filter-selected-list").html());
		}
		if($("#"+uhiddenId)!=null){
			$("#"+uhiddenId).val(getUserIds());
		}
		if($("#"+ghiddenId)!=null){
			$("#"+ghiddenId).val(getGroupIds());
		}
		clean();
	}
	function getUserIds(){
		var ids="";
		$(".filter-selected-list .chosedUser[data-utype='1']").each(function(){
			if(ids==""){
				ids+=$(this).data("selid");
			}else{
				ids+=","+$(this).data("selid");
			}
		});
		return ids;
	}
	function getGroupIds(){
		var gids="";
		$(".filter-selected-list .chosedUser[data-utype='2']").each(function(){
			if(gids==""){
				gids+=$(this).data("selid");
			}else{
				gids+=","+$(this).data("selid");
			}
		});
		return gids;
	}
	function getUserView(){
		var views="";
		$(".filter-selected-list .chosedUser").each(function(){
			if(views==""){
				views+=$(this).find(".js_utext").html();
			}else{
				views+=","+$(this).find(".js_utext").html();
			}
		});
		return views;
	}
	function clean(){
		$(".filter-selected-list").html("");
		$('.uPickerModal [type="checkbox"]').attr("checked",false);
		$('.uPickerModal .fuxuankuang_box').removeClass('on');
	}
	function initSelData(){
		var viewId=$("#userPickerModal").data("ushow");
		$(".uPickerModal .filter-selected-list").html($("#"+viewId).html());
	}
	</script>

