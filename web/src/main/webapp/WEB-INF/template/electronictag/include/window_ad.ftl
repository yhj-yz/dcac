
<!--新增域服务器开始-->
<div class="popup_window2" id="pop_ad">
	<div class="wind_header">
		<h4>${message("dsm.adserver.add")}</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form  action="${base}/admin/group/add.jhtml">
	<div class="new_box">
		<ul class="orgni_new_title_box">
			<li class="orgni_new_title on">基本信息
				<div class="popup_wind_cont_box current">
					<div class="popup_wind_cont ">
						<div class="text_group">
							<div class="attr_name">策略名称</div>
							<input class="attr_n_input attr_current" name="domainPolicyName"  value=""  placeholder="${message("dsm.adserver.server")}"  />
						</div>
						<div class="text_group">
							<div class="attr_name">策略描述</div>
							<input class="attr_n_input attr_current" name="domainPolicyDesc"  value=""  placeholder="${message("dsm.adserver.server")}"  />
						</div>
						<div class="text_group">
							<div class="attr_name">${message("dsm.adserver.server")}</div>
							<input class="attr_n_input attr_current" name="domainIp"  value=""  placeholder="${message("dsm.adserver.server")}"  />
						</div>
						<div class="text_group">
							<div class="attr_name">${message("dsm.adserver.loginname")}</div>
							<input class="attr_n_input attr_current" name="domainLoginAccount"  value=""  placeholder="${message("dsm.adserver.loginname")}"  />
						</div>
						<div class="text_group">
							<div class="attr_name">${message("dsm.adserver.password")}</div>
							<input class="attr_n_input attr_current" type="password" name="domainPwd"  value="" placeholder="${message("dsm.adserver.password")}"  />
						</div>
						<div class="text_group">
							<div class="attr_name">${message("dsm.adserver.link")}</div>
							<div id="pop_test_link">
							<a href='#' onclick='popTestLink(this);return false;'  >${message("dsm.adserver.link")}</a>
							</div>
						</div>
					</div>
				</div>
			</li>
			<li class="orgni_new_title">同步选项
				<div class="popup_wind_cont_box ">
					<div class="popup_wind_cont ">
						<div class="text_group">
							<div class="attr_name">选择同步部门</div>
							<span >
								<i><a href="#" onclick="showADImport(this);return false;">选择同步部门</a></i>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">同步到</div>
							<span >
								<i><a href="#" onclick="showDept(this);return false;">同步到</a></i>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">${message("dsm.adserver.accountmode")}</div>
							<span class="radio_input"> <label
								class="danxuankuang_box selected"> <input name="loadIncludeDomain" 
									class="danxuankuang" type="radio"  value="true" />
									<i>${message("dsm.adserver.withdomain")}</i>
							</label> <label class="danxuankuang_box"> <input name="loadIncludeDomain" 
									class="danxuankuang" type="radio" value="false" checked="false"/>
									<i>${message("dsm.adserver.withoutdomain")}</i>
							</label>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">${message("dsm.adserver.passwordtyp")}</div>
							<span class="radio_input"> <label
								class="danxuankuang_box selected"> <input name="passwordCheckType" 
									class="danxuankuang" type="radio"  value="database" />
									<i>${message("dsm.adserver.database")}</i>
							</label> <label class="danxuankuang_box"> <input name="passwordCheckType" 
									class="danxuankuang" type="radio" value="domain" checked="true"/>
									<i>${message("dsm.adserver.ad")}</i>
							</label>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">默认密码</div>
							<input class="attr_n_input attr_current" name="defaultPwd"  value=""  placeholder="数据库验证默认密码"  />
						</div>
						<div class="text_group">
							<div class="attr_name">默认安全域</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="defaultSecurityDomain.id">
								[#list securityDomains as q]
									<option value="${q.id}">${q.securityName}</option>
								[/#list]
							</select>
							</span>
						</div>
						[#if DRMNum > 0]
						<div class="text_group">
							<div class="attr_name">默认密级</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="defaultSecurity.id">
								[#list levels as q]
									<option value="${q.id}">${q.securityName}</option>
								[/#list]
							</select>
							</span>
						</div>
						[/#if]
						<div class="text_group">
							<div class="attr_name">默认安全策略</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="defaultPolicy.id" >
								[#list policys as q]
									<option value="${q.id}">${q.policyName}</option>
								[/#list]
							</select>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">默认角色</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="defaultRole.id" >
								[#list roles as q]
									<option value="${q.id}">${q.name}</option>
								[/#list]
							</select>
							</span>
						</div>
					</div>
				</div>
			</li>
			<li class="orgni_new_title">自动同步设置
				<div class="popup_wind_cont_box ">
					<div class="popup_wind_cont ">
						<div class="text_group">
							<div class="attr_name">是否开启自动同步</div>
							<span class="radio_input"> <label
								class="danxuankuang_box selected"> <input name="autoLoad" 
									class="danxuankuang" type="radio"  value="true" />
									<i>${message("admin.common.true")}</i>
							</label> <label class="danxuankuang_box"> <input name="autoLoad" 
									class="danxuankuang" type="radio" value="false" checked="true"/>
									<i>${message("admin.common.false")}</i>
							</label>
							</span>
						</div>
						<!--
						<div class="text_group">
							<div class="attr_name">
								<span class="radio_input" ><label class="danxuankuang_box selected"> 
									<input name="timer" class="danxuankuang" type="radio"  value="0" />
									<i>每天同步</i>
								</label></span>
							</div>
							<span class="xialakuang_box" style="width:100px;"> <select class="xialakuang" style="width:100px;" name="hour">
								[#list 0..24 as t]
									<option value="${t}">${t}点</option>
								[/#list]
							</select>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">
								<span class="radio_input"><label class="danxuankuang_box selected"> 
									<input name="timer" class="danxuankuang" type="radio"  value="1" />
									<i>每周同步</i>
								</label></span>
							</div>
							<span class="xialakuang_box" style="width:100px;"> <select class="xialakuang" style="width:100px;" name="week">
								[#list 1..7 as t]
									<option value="${t}">周${t}</option>
								[/#list]
							</select>
							</span>
							<span class="xialakuang_box" style="width:100px;"> <select class="xialakuang" style="width:100px;" name="hour">
								[#list 0..24 as t]
									<option value="${t}">${t}点</option>
								[/#list]
							</select>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">
								<span class="radio_input"><label class="danxuankuang_box selected"> 
									<input name="timer"   class="danxuankuang" type="radio"  value="2"/>
									<i>每月同步</i>
								</label></span>
							</div>
							<span class="xialakuang_box" style="width:100px;"> <select class="xialakuang" style="width:100px;" name="day">
								[#list 1..31 as t]
									<option value="${t}">${t}日</option>
								[/#list]
							</select>
							</span>
							<span class="xialakuang_box" style="width:100px;"> <select class="xialakuang" style="width:100px;" name="hour">
								[#list 0..24 as t]
									<option value="${t}">${t}点</option>
								[/#list]
							</select>
							</span>
						</div>
						-->
					</div>
				</div>
			</li>
		</ul>
	</div>
		<div class="hid">
			<input type='hidden' name='id' value='' >
			<input type='hidden' name='deptId' value='' >
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
<!--新增域服务器结束-->
<!--选择同步节点开始-->
<div class="popup_window tree" id="pop_ad_import">
	<div class="wind_header">
		<h4>修改</h4>
		<i><a href="#" onclick="hideCheckNodes();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form>
	<div class="new_box">
		<div class="tree_box">
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="ImportByAD(this);return false;" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
		<a href="#" onclick="hideCheckNodes();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
	</div>
	</form>
</div>
<!--选择同步节点结束-->
<!--选择部门-->
<div class="popup_window tree" id="pop_check_dept">
	<div class="wind_header">
		<h4>请选择部门</h4>
		<i><a href="#" onclick="hideCheckDept();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form>
	<div class="new_box">
		<div class="tree_box">
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="hideCheckDept();return false;" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
		<a href="#" onclick="hideCheckDept();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
	</div>
	</form>
</div>
<script>
//关闭弹窗中的弹窗
function hideCheckDept(){
	$("div#pop_check_dept").hide();
}
function hideCheckNodes(){
	$("#pop_ad_import").hide();
}
//异步提交表单
function submitForm(v){
	var $frm = $(v).parents("form");
	
	if($frm.valid()){//使用valid()方法对表单进行验证，基于jquery.validator.js
		$.ajax({
			async: true,
			type: "post",
			url: $frm.attr("action"),
			data: $frm.serialize(),
			dataType:"json",
			success: function(data){
				//如果连接成功就保存
				if (data.type === "success") {
					hideWindows();
					search();
				}
				confirmWin(data.content);
			}
		});
	} else {
		var $input = $("p.zhushi:first").parent().find("input:first");
		$input.parents(".orgni_new_title").click();
		$input.focus();
	}
}
//新增域服务器
function addAD(){
	var _title = "${message("dsm.adserver.add")}";
	$("div#pop_ad .wind_header h4").html(_title);
	var $frm = $("div#pop_ad form");
	$(".black").show();
	$("div#pop_ad").show().find("input:first").focus();
	$frm.attr("action", "${base}/admin/domain_manager/save.jhtml");
	var $hid = $(".hid");
	$hid.find("input[name='domainNodes']").remove();
	$hid.find("input[name='id']").val("");
	$hid.find("input[name='deptId']").val("");
	$frm.find("input[name='domainIp']").prop("readonly", false);
	$frm[0].reset();
	$("#pop_test_link").empty().append("<a href='#' onclick='popTestLink(this);return false;'  >${message("dsm.adserver.link")}</a>");
	
	if(! $frm.valid()){//使用valid()方法对表单进行验证，基于jquery.validator.js
		var $input = $("p.zhushi:first").parent().find("input:first");
		$input.parents(".orgni_new_title").click();
		$input.focus();
	}
}
//修改域服务器
function modifyAD(_id){
	var _title = "${message("dsm.adserver.edit")}";
	$("div#pop_ad .wind_header h4").html(_title);
	var $frm = $("div#pop_ad form");
	var $hid = $(".hid");
	$hid.find("input[name='domainNodes']").remove();
	$hid.find("input[name='id']").val(_id);
	$hid.find("input[name='deptId']").val("");
	$frm.attr("action", "${base}/admin/domain_manager/update.jhtml");
	$(".black").show();
	$("#pop_test_link").empty().append("<a href='#' onclick='popTestLink(this);return false;'  >${message("dsm.adserver.link")}</a>");
	$("div#pop_ad").show().find("input:first").focus();
	$.ajax({
		url : "${base}/admin/domain_manager/find.jhtml?id="+_id,
		dataType : "json",
		success : function(data) {
			$frm.find("input[name='domainPolicyName']").val(data.domainPolicyName);
			$frm.find("input[name='domainPolicyDesc']").val(data.domainPolicyDesc);
			$frm.find("input[name='domainIp']").val(data.domainIp).prop("readonly", true);
			$frm.find("input[name='domainLoginAccount']").val(data.domainLoginAccount);
			$frm.find("input[name='domainPwd']").val(data.domainPwd);
			$frm.find("input[name='defaultPwd']").val(data.defaultPwd);
			$frm.find("input[name='defaultOnlineTime']").val(data.defaultOnlineTime);
			//单选
			$frm.find("input[name='loadIncludeDomain'][value='"+data.loadIncludeDomain+"']").prop("checked", true);
			$frm.find("input[name='passwordCheckType'][value='"+data.passwordCheckType+"']").prop("checked", true);
			$frm.find("input[name='autoLoad'][value='"+data.autoLoad+"']").prop("checked", true);
			//下拉框
			$frm.find("select[name='defaultSecurityDomain.id'] option[value='"+data.defaultSecurityDomain.id+"']").prop("selected", true);
			$frm.find("select[name='defaultSecurity.id'] option[value='"+data.defaultSecurity.id+"']").prop("selected", true);
			$frm.find("select[name='defaultRole.id'] option[value='"+data.defaultRole.id+"']").prop("selected", true);
			$frm.find("select[name='defaultPolicy.id'] option[value='"+data.defaultPolicy.id+"']").prop("selected", true);
			//$frm.find("input[name='defaultDepartment.id'] option[value='"+data.defaultDepartment.id+"']").prop("checked", true);
			checkRadioStatus();
			checkCheckboxStatus();
			if(data.defaultDepartment){
				$frm.find("input[name='deptId']").val(data.defaultDepartment.id);
			}
			var $hid = $(".hid");
			for(var i=0; i<data.domainNodes.length; i++){
				$(".hid").find("input[name='domainPwd']").val(data.domainPwd);
				$hid.append("<input type='hidden' name='domainNodes' value='"+data.domainNodes[i]+"'>");
			}
			if($frm.valid()){//使用valid()方法对表单进行验证，基于jquery.validator.js
				$frm.find("li.orgni_new_title:first").click();
				$frm.find("li.orgni_new_title:first input:first").focus();
			}else{
				var $input = $("p.zhushi:first").parent().find("input:first");
				$input.parents(".orgni_new_title").click();
				$input.focus();
			}
		} 
	});
}
//选择同步部门 保存按钮
function ImportByAD(v){
	var zTree2 = $.fn.zTree.getZTreeObj("treeDemo2");
	var nodes = zTree2.getCheckedNodes(true);
	var $hid = $(".hid");
	$hid.find("input[name='domainNodes']").remove();
	for(var i=0; i<nodes.length; i++){
		if(nodes[i].getCheckStatus().half === false){
			$hid.append("<input type='hidden' name='domainNodes' value='"+nodes[i].id+"'>");
		}
	}
	hideCheckNodes();
}
//显示  选择同步部门
function showADImport(v){
	$frm = $(v).parents("form");
	var _ip = $frm.find("input[name='domainIp']").val();
	var _account = $frm.find("input[name='domainLoginAccount']").val();
	var _pwd = $frm.find("input[name='domainPwd']").val();
	if(_ip === "" || _account === "" || _pwd === "" ){
		confirmWin("请输入正确的服务器ip、账号、密码");
		return;
	}
	$.ajax({
		type : "get",
		url : "${base}/admin/ad_import/tree.jhtml",
		data : $frm.serialize(),
		dataType : "json",
		async: true,
		success : function(data) { 
			showADTree(data);
		}
	})
}
//显示域树结构
function showADTree(zNodes){
	//ztree设置
	var setting2 = {
		//设置是否允许同时选中多个节点，这里设为false
		view: {
			selectedMulti: false,
			fontCss : {"font-size":"60px","letter-spacing": "1px"}
		},
		check: {
			enable: true,
			chkStyle: "checkbox"
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};
	//$(".black").show();
	$("div#pop_ad_import").show();
	if($("#treeDemo2").length === 0){
		$("div#pop_ad_import div.tree_box").append( "<div class='columnbg64'></div>"+
													"<div class='stroke80'></div>"+
													"<div class='zTreeDemoBackground left'>"+
													"<ul id='treeDemo2' class='ztree'></ul></div>");
	}
	$.fn.zTree.init($("#treeDemo2"), setting2, zNodes);
}
//显示选择部门
function showDept(v){
	var $frm_ = $("div#pop_ad form");
	//ztree设置
	var setting3 = {
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
		//回调函数
		callback: {
			onClick: zTreeOnClick1,
		},
	};
	//ztree初始节点数据
	var zNodes3 = [{id:1 , name:"组织架构", isParent:true, iconSkin:"z_icon01"}];
	//ztree 节点点击事件回调函数
	function zTreeOnClick1(event, treeId, treeNode){
		$frm_.find("input:hidden[name='deptId']").val(treeNode.id);
	}
	$(".black").show();
	$("div#pop_check_dept").show();
	if($("#treeDemo3").length === 0){
		$("div#pop_check_dept div.tree_box").append( "<div class='columnbg64'></div>"+
												"<div class='stroke80'></div>"+
												"<div class='zTreeDemoBackground left'>"+
												"<ul id='treeDemo3' class='ztree'></ul></div>");
	}
	$.fn.zTree.init($("#treeDemo3"), setting3, zNodes3);
	var zTree3 = $.fn.zTree.getZTreeObj("treeDemo3");
			var node = zTree3.getNodeByParam("id",0);
			zTree3.expandNode(node, true, false);
			zTree3.selectNode(node);
}

</script>