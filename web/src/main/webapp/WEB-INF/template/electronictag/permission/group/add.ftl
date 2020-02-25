<!DOCTYPE html>
<html lang="ch">
<head>
<meta charset="UTF-8">
<title>新增用户组</title>

[#include "/dsm/include/head.ftl"]
<link href="${base}/resources/dsm/css/zTreeStyle.css" rel="stylesheet" />
<script type="text/javascript" src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript" src="${base}/resources/dsm/js/ztree.helper.js"></script>
</head>
<body>
	<div class="dsm-rightside">
		<div class="maincontent">

			<div class="mainbox system-role-form">

				<div class="dsmForms">
				<form action="save.jhtml">
					<div class="dsm-form-item">
						<div class="dsm-inline">
							<label class="dsm-form-label">用户组名称：</label>
							<div class="dsm-input-block">
								<input type="text" autocomplete="off" placeholder="用户组名称"
									class="dsm-input required specialChar" name="groupName">
								<div class="block-noempty">*</div>
							</div>
						</div>
						<div class="dsm-inline">
							<label class="dsm-form-label">用户组描述：</label>
							<div class="dsm-input-block">
								<input type="text" autocomplete="off" placeholder="用户组描述"
									class="dsm-input" name="groupDesc">
							</div>
						</div>
						<div class="dsm-inline">
							<label class="dsm-form-label">选择用户：</label>
							<div class="dsm-input-block">
								<div class="dsm-box clearfix">
									<!--左右选择器 切记加上ID 左侧是树 右侧是checkbox-->
									<div id="openUserGroup" class="datachosebox clearfix"
										data-role="chosetree" data-treeid="dsmOrgTree">
										<div class="cleft">
											<div class="choseheader">
												<span class="ctitle">可选用户</span>
												<button type="button" class="btn btn-primary f-r whitebg js_showall_left">显示全部</button>
											</div>
											<div class="csearch">
												<input type="text" autocomplete="off"
													class="dsm-input js_chosekey_left"> <i
													class="icon icon-search"></i>
											</div>
											<div class="itembox">
												<div class="treedata">
													<ul id="dsmOrgTree" class="ztree"></ul>
												</div>
											</div>
										</div>
										<div class="ccenter clearfix">
											<div class="chosebtn js_chosetreeone">
												<i class="icon icon-greenright"></i>
											</div>
											<div class="chosebtn js_deltreeone">
												<i class="icon icon-greenleft"></i>
											</div>
											<div class="chosebtn js_deltreeall">
												<i class="icon icon-dgreenleft"></i>
											</div>
										</div>
										<div class="cright">
											<div class="choseheader">
												<span class="ctitle">已选用户</span>
												<button type="button" class="btn btn-primary f-r whitebg js_showall_right">显示全部</button>
											</div>
											<div class="csearch">
												<input type="text" autocomplete="off"
													class="dsm-input js_chosekey_right search-input"> <i
													class="icon icon-search"></i>
											</div>
											<div class="itembox">
												<div class="items"></div>
											</div>
										</div>
									</div>
									<!--左右选择器结束-->
								</div>
							</div>
						</div>


					</div>
					<div class="form-btns t-l">
						<button type="button" class="btn btn-lg btn-primary js_add">确定新增</button>
						<a href="list.jhtml"
							class="btn btn-lg btn-primary">取消</a>
					</div>
				</div>
			</div>
		</form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			initTree('dsmOrgTree');
			$("form:first").validate({
				rules: {
					"groupName": {
						required: true,
						specialChar: true,
						maxlength: 32
					},
					"groupDesc": {
						maxlength: 256
					},
				}
			});
		});
    	
        //选择人员
        $(document).on('click', '.js_chosetreeone', function (e) {

			var orgDataTree = zTrees["dsmOrgTree"];
			
			var nodes = orgDataTree.getCheckedNodes(true);
			var $_ul_right = $("div.right_member_box ul.member_ul").empty();
			var _ids = "";
			for(var i=0; i<nodes.length; i++){
				//alert(JSON.stringify(nodes[i].iconSkin))
				if(nodes[i].getCheckStatus().half === false){
					if(nodes[i].iconSkin === "z_icon03"){
						_ids = _ids + "userIds=" + (-nodes[i].id);
					} else {
						_ids = _ids + "deptIds=" + nodes[i].id;
					}
					_ids = _ids + "&";
				}
			}
			$.ajax({
				type: "get",
				url: "${base}/admin/user/list_forgroup.jhtml?"+_ids,
				dataType:"json",
				success: function(data){
					//alert(JSON.stringify(data))
					if(data){
						for(var i = 0; i < data.length; i++){
							var outerHtml='<div class="itemcheckone">'
		                		+'<div class="dsmcheckbox">'
			                	+'	<input type="hidden" value='+data[i].id+'  name="userIds">'
			                	+'	<input type="checkbox" value='+data[i].id+' class="checkeduser" id="u_'+data[i].id+'">'
								+'	<label for="u_'+data[i].id+'"></label>'
								+'</div>'
								+'<label for="u_'+data[i].id+'">'+data[i].name+'['+data[i].account+']</label>'
								+'</div>';
		
							if($("#openUserGroup .cright #u_"+data[i].id).length==0){
								$("#openUserGroup .cright .itembox .items").prepend(outerHtml);
							}
						}
					}
				}
			});
			
        });

    	//删除选择
        $(document).on('click', '.js_deltreeone', function (e) {
			$(".checkeduser").each(function(){
				if(this.checked){	
					$(this).parent().parent().remove();
				}
			});
        });
    	//删除全部选择
        $(document).on('click', '.js_deltreeall', function (e) {
        	$("#openUserGroup .cright .itembox .items .itemcheckone:visible").remove();
        });
        //显示全部已选
        $(document).on('click', '.js_showall_right', function (e) {
        	$("#openUserGroup .cright .itembox .items .itemcheckone:hidden").show();
        });
        //显示全部可选
        $(document).on('click', '.js_showall_left', function (e) {
        	initTree('dsmOrgTree');
        });
    	//搜索已选
        $(document).on('keyup', '.js_chosekey_right', function (e) {
        	var key = this.value;
        	if(!key || key.trim() === "" || e.which !== 13){
        		$("#openUserGroup .cright .itembox .items .itemcheckone").show();
        	} else{
	        	$("#openUserGroup .cright .itembox .items .itemcheckone").each(function(data){
	        		if($(this).text().indexOf(key) !== -1){
	        			$(this).show();
	        		}else{
	        			$(this).hide();
	        		}
	        	});
        	}
        });
    	//搜索可选
        $(document).on('keyup', '.js_chosekey_left', function (e) {
        	var key = this.value;
        	if(!key || key.trim() === "" || e.which !== 13){
        		return;
        	}
        	$.ajax({
				type: "get",
				url: "${base}/admin/group/search_trees.jhtml?",
				data:{name:key},
				dataType:"json",
				success: function(data){
					//alert(JSON.stringify(data))
					if(data){
						initTree('dsmOrgTree', data);
					}
				}
			});
        });
        
        //确定新增
        $(document).on('click', '.js_add', function (e) {
        	var btn = $(this);
        	var frm = $("form");
        	if(frm.valid()){
        		btn.addClass("disabled");
	        	submitForm({
	        		frm: frm,
	        		success: function(){
	        			setTimeout("window.location.href='list.jhtml'",1500)
	        		},
	        		error: function(){
	        			btn.removeClass("disabled");
	        		}
	        	})
        	} else {
        		$(".error").prev().focus();
        	}

        });
        //初始化zTree;
        function initTree(id, data){
        	if(zTrees && zTrees[id]){
        		zTrees[id].destroy();
        	}
        	zTreeInit({
        		data:data,
				id:id,
				check: true,
				url: '${base}/admin/department/tree_user.jhtml',
				zTreeOnClick : function(event, treeId, treeNode){//ztree 节点点击事件回调函数
					if(treeNode.id<0){
						var name = treeNode.name.substring(treeNode.name.indexOf("[") + 1,treeNode.name.indexOf("]"));
						var str = '<input type="hidden" name="proxyName" value='+name+'>';
						$("#to_dept_name").html(name + str);
					}
				},
			});
        }
    </script>
</body>
</html>
