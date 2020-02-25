<style>
.stepbox .tabtitle_box, .stepbox .widget_body tr {
	border-bottom: 1px solid #ddd;
}
.userPickerView{
    overflow-y: auto;
    overflow-x: hidden;
    line-height: 34px !important;
}
.userPickerView .chosedUser{
    border-right: 1px solid #303030;
}
.userPickerView dd{
	float:left;
	margin-right:5px;
}
.userPickerView em,
.stepTbBody em{
	display:none;
}
.userPickerView .js_utext{
	margin-right: 5px;
}
.steplLink{
    cursor: pointer;
}
.steplLink:hover{
    text-decoration: underline;
}
.stepTbBody 
</style>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title">新增流程模板</h4>
</div>
<div class="modal-body">
	<div>
		  <ul class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="active"><a href="#modelset" aria-controls="modelset" role="tab" data-toggle="tab">模板设置</a></li>
		    <li role="presentation"><a href="#stepset" aria-controls="stepset" role="tab" data-toggle="tab">步骤设置</a></li>
		  </ul>
		  
		  <!-- 面板    模板管理-->
		  <div>
		  <div class="tab-content" >
		    <div role="tabpanel" class="tab-pane active modelset" id="modelset">
		    	<form id="flowModelForm" action="${base}/admin/flowModel/save.jhtml">
			    	<div class="form_group">
						<div class="text_group">
							<div class="attr_name">模板类型：</div>
							<span class="xialakuang_box"> 
							<select class="xialakuang valid modelTypeSel" name="modelType">
								<option value="fileDecodeApprove">文件解密审批</option>
								<option value="fileOutsideApprove">文件外发审批</option>
								<option value="mailDecodeApprove">邮件解密审批</option>
								<option value="changeFileSecurityApprove">调整个人安全域审批</option>
								<option value="TerminalOfflineApprove">终端离网审批</option>
								<option value="OfflineAddTimeApprove">离网补时审批</option>
							</select>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">模板名称：</div>
							<input class="attr_n_input required" name="modelName"  placeholder="模板名称">
						</div>
						<div class="text_group">
							<div class="attr_name">模板描述：</div>
							<input class="attr_n_input" name="modelDesc" placeholder="模板描述">
						</div>
						<div class="text_group" style="width: 700px;">
							<div class="attr_name">接收方式：</div>
							<span class="radio_input js_receviceType" style="width: 555px;"> 
								<label class="danxuankuang_box selected"> 
									<input name="receviceType" class="danxuankuang js_receviceTypera" type="radio" value="launchUser"><i>发起人</i>
								</label> 
								<label class="danxuankuang_box "> 
									<input name="receviceType" class="danxuankuang js_receviceTypera" type="radio" value="modelAppoint"><i>模板指定</i>
								</label>
								<label class="danxuankuang_box "> 
									<input name="receviceType" class="danxuankuang js_receviceTypera" type="radio" value="launchUserAppoint" ><i>发起人指定</i>
								</label>
								<label class="danxuankuang_box "> 
									<input name="receviceType" class="danxuankuang js_receviceTypera" type="radio" value="approveAppoint" ><i>审批人指定</i>
								</label>
								
							</span>
						</div>
						<div class="text_group acceptUserPicker hidden">
							<div class="attr_name">接收人：</div>
							
							<div class="attr_n_input userPickerView" id="viewReceiceUsers"></div>
							<button type="button" data-ushow="viewReceiceUsers" data-uhidden="receviceUserId" data-ghidden="receviceGroupId" class="btn js_pickerUsers" style="width: 40px;height: 38px;border-radius: 0;outline: none;padding-top: 0px;">选择</button>
							
							<input type="hidden" id="receviceUserId" name="receviceUsers"  /> 
							<input type="hidden" id="receviceGroupId" name="receviceGroups" /> 
						</div>
						<div class="text_group" >
							<div class="attr_name">允许自己审批：</div>
							<span class="check_input"> 
								<label class="check_box"> 
									<input name="allowSelfApprove" class="allowSelfApproveCheck" value="1" type="checkbox" ><i style="width:100px;display: inline-block;height: 10px;"></i>
								</label> 
							</span>
						</div>
						<div class="text_group" style="width: 700px;">
							<div class="attr_name">可使用者：</div>
							<span class="radio_input js_enableUser" style="width: 555px;"> 
								<label class="danxuankuang_box selected"> 
									<input name="enableUserFlag" class="danxuankuang raenableUserRadio" type="radio" value="-1"><i>所有人</i>
								</label> 
								<label class="danxuankuang_box"> 
									<input name="enableUserFlag" class="danxuankuang raenableUserRadio" type="radio" value="0" ><i>指定人员</i>
								</label>
								<div class="hidden attr_n_input userPickerView"  style="width: 130px;" id="viewEnableUsers"></div>
								<button type="button" data-ushow="viewEnableUsers" data-uhidden="enableUserId" data-ghidden="enableGroupId" class="btn js_pickerUsers hidden" style="width: 40px;height: 38px;border-radius: 0;outline: none;padding-top: 0px;">选择</button>
							
								<input type="hidden" id="enableUserId" name="enableUsers" /> 
								<input type="hidden" id="enableGroupId" name="enableGroups" /> 
							</span>
						</div>
						<div class="text_group" style="width: 700px;">
							<div class="attr_name">文件安全域：</div>
							<div class="safeDomainBox">
								<div class="safeDomainLeft">
									<div class="title">可选安全域</div>
									<div class="itemBox">
										[#list securityDomains as s]
											<div class="domainItem" data-domainid="${s.id}">${s.securityName}</div>
										[/#list]
									</div>
									
									<input type="hidden" id="domainItemIds" name="securityDomains" value="-1" />
								</div>
								<div class="safeDomainCenter">
									<button type="button" class="btn rselectbtn">></button>
									<button type="button" class="btn rcancelbtn"><</button>
						
								</div>
								<div class="safeDomainRight">
									<div class="title">已选安全域</div>
									<div class="itemBox">
										
									</div>
								</div>
							</div>
						</div>
						<input type="hidden" id="flowModelId" name="mid" value="-1"/> 
						<div class="modelStepForms">
							
						</div>
					</div>
				</form>
		    </div>
		    
		    <!-- 面板    步骤管理-->
		    <div role="tabpanel" class="tab-pane" id="stepset">
		    	<div class="btn">
				<ul class="btn_column">
					<li class="btn_list">
						<div class="columnbg48"></div>
						<div class="stroke60"></div> 
						<a class="addStepModalBtn">
							<span class="btn_title stepbtn">新增</span>
					</a>
					</li>
					<li class="btn_list">
						<div class="columnbg48"></div>
						<div class="stroke60"></div> <a href="#">
						<span class="btn_title stepDelBtn">删除</span>
					</a>
					</li>
				</ul>
			</div>
			<!--btn结束-->
			<div class="main_down_content">
				<!--右边表单开始-->
				<div class="tab_container tab_container1">
					
					<!--表单开始-->
					<div class="tab_big_box stepbox" >
						<form id="step_form" >
						<div class="tabtitle_box">
							<div class="columnbg64"></div>
							<div class="stroke80"></div>
							
						</div>
						<div class="tab_body">
							<div class="columnbg36"></div>
							<div class="stroke60"></div>
							<table class="widget_body">
								<tbody class="stepTbBody">
									
								</tbody>
							</table>
						</div>
						</form>
					</div>
					<!--表单结束-->
					<!--页码开始-->
					<div class="page_number_big_box">
						<form id="searchStepform" action="${base}/admin/flowStep/search.jhtml" data-func-name="refreshFlowStepTable();" data-list-formid="step_form">
						
						</form>
					</div>
					<!--页码结束-->
				</div>
				<!--右边表单结束-->
			</div>
			<!--main_down_conent结束-->
		    </div>
		    </div>
	    </div>
	</div>
</div>

<div class="modal-footer">
	<button type="button" class="btn btn-primary js_modelAdd" onclick="submitAddModel('flowModelForm')">新增</button>
	<button type="button" class="btn btn-primary js_modelCancel" data-dismiss="modal">取消</button>
</div>
<script>
$(document).on("click", ".safeDomainBox .rselectbtn", function(){
	addItemSelectDomain($(".safeDomainLeft .domainItem.focusaction"));
});
$(document).on("dblclick", ".safeDomainLeft .domainItem", function(){

	addItemSelectDomain($(this));	
});

$(document).on("click", ".safeDomainBox .rcancelbtn", function(){
	delItemSelectDomain($(".safeDomainRight .domainItem.focusaction"));
		
});
$(document).on("dblclick", ".safeDomainRight .domainItem", function(){

	delItemSelectDomain($(".safeDomainRight .domainItem.focusaction"));
		
});
function addItemSelectDomain(t){
	var domainItem=$(t);
	if(domainItem!=null){
		$(domainItem).next().addClass("focusaction");
		var outerHtml=$(domainItem).removeClass("focusaction").prop('outerHTML')
		$(".safeDomainBox .safeDomainRight .itemBox").prepend(outerHtml);
		$(domainItem).remove();
	}
}

function delItemSelectDomain(t){
	var domainItem=$(t);
	if(domainItem!=null){
		$(domainItem).next().addClass("focusaction");
		var outerHtml=$(domainItem).removeClass("focusaction").prop('outerHTML')
		$(".safeDomainBox .safeDomainLeft .itemBox").prepend(outerHtml);
		$(domainItem).remove();
	}

}
$(document).on("click", ".safeDomainBox .domainItem", function(){
	$(this).addClass('focusaction').siblings().removeClass('focusaction');
});
$(document).on("click", "input[name=receviceType]", function(){
	hideAcceptPicker($(this).val())
});
$(document).on("click", "input[name=enableUserFlag]", function(){
	hideEnablePicker($(this).val())
});
$(document).on("click", ".js_pickerUsers", function(){
	dataAttrCopy($(this),$("#userPickerModal"));
	$("#userPickerModal").modal("show");
});
$(document).on("click", ".addStepModalBtn", function(){
	clearStepForm();
	$("#addStepModal").data("sid","0");
	$("#addStepModal .modal-footer .js_stepAdd").html("新增");
	$("#addStepModal").modal("show");
});
function hideAcceptPicker(val){
	if(val=="modelAppoint"){
		$(".acceptUserPicker").removeClass('hidden');
	}
	else{
		$(".acceptUserPicker").addClass('hidden');
	}
}
function hideEnablePicker(val){
	if(val=="0"){
		$("#viewEnableUsers").removeClass('hidden');
		$(".js_enableUser .btn").removeClass('hidden');
	}
	else{
		$("#viewEnableUsers").addClass('hidden');
		$(".js_enableUser .btn").addClass('hidden');
	}
}
function initForm(data){
	
	$("#flowModelId").val(data.id);
	$(".modelTypeSel").val(data.modelType);
	$("input[name=modelName]").val(data.modelName);
	$("input[name=modelDesc]").val(data.modelDesc);
		
	$("input[type='radio'][name='receviceType'][value='"+data.receviceType+"']").prop("checked",true);
	$("input[type='radio'][name='receviceType'][value='"+data.receviceType+"']").parent().addClass('selected').siblings().removeClass('selected');
	
	
	hideAcceptPicker(data.receviceType);
	hideEnablePicker(data.enableUserFlag);
	
	if(data.allowSelfApprove==1){
		$(".allowSelfApproveCheck").attr("checked",'true');
	}
	if(data.enableUserFlag=="-1"){	
		$("input[type='radio'][name='enableUserFlag'][value='-1']").prop("checked",true);
		$("input[type='radio'][name='enableUserFlag'][value='-1']").parent().addClass('selected').siblings().removeClass('selected')
	}
	else{
		$("input[type='radio'][name='enableUserFlag'][value='0']").prop("checked",true);
		$("input[type='radio'][name='enableUserFlag'][value='0']").parent().addClass('selected').siblings().removeClass('selected')	
	}
	
	initUserAndGroup(data);
	
	initStepTable(data.flowStepEntities);
	initSecDomainTable(data.securityDomainEntities);
	
}
function initSecDomainTable(domainlist){
	for (var i=0;i<domainlist.length;i++){
		var selDomain=$(".safeDomainLeft .domainItem[data-domainid="+domainlist[i].id+"]");
		if(selDomain!=null){
			addItemSelectDomain(selDomain);
		}
	}
}
function initStepTable(arr){
	var tableArr=arr;
	$(".stepTbBody").html("");
	for (var i=0;i<tableArr.length;i++){
		var fApprovePattern="";
		var fApproveType="";
		var fUserViews="";
		var fStepApproveUserId="";
		var fStepApproveGroupId="";
		
		if(fApproveType=="1"){
			fUserViews="";
			fStepApproveUserId="";
			fStepApproveGroupId="";
		}else{
			fUserViews=getUserGroupListViesw(tableArr[i].approveUser,tableArr[i].approveGroup);
			fStepApproveUserId=getUserArrStr(tableArr[i].approveUser);
			fStepApproveGroupId=getUserArrStr(tableArr[i].approveGroup);
		}
		if(tableArr[i].approvePattern=="andSign"){
			fApprovePattern="并签";
		}else{
			fApprovePattern="汇签";			
		}
		if(tableArr[i].approveType==1){
			fApproveType="指定人员";
		}else{
			fApproveType="部门管理员";
		}
		
		var _tr = '<tr class="tr_border" style="position: relative;">';
		var _td='<td style="width: 9%;"><div class="stroke20"></div><label class="inline_middle">' +
		'<div class="fuxuankuang_box"><input type="checkbox" class="fuxuankuang " name="ids" value="42"></div></label></td>' +
		//'<td style="width: 15%; "><a></a></td>' +
		'<td style="width: 15%;" class="steplLink">'+tableArr[i].stepName+'</td>' +
		'<td style="width: 28%; color:#333;" class="stepPattern" data-pattern="'+tableArr[i].approvePattern+'">'+fApprovePattern+'</td>' +
		'<td style="width: 15%; color:#333;" class="stepAppType" data-appType="'+tableArr[i].approveType+'">'+fApproveType+'</td>' +
		'<td style="width: 15%; color:#333;" class="stepAppUsers" data-appTypeUsers="'+fStepApproveUserId+'"  data-appTypeGroups="'+fStepApproveGroupId+'" data-appRoles="3">'+fUserViews+'</td>';
		_tr+=_td+'</tr>';
		
		$(".stepTbBody").append(_tr);
	}
}
function getUserArrStr(arr){
	var uStr="";
	for(var j=0;j<arr.length;j++){
		if(uStr==""){
			uStr+=arr[j].id;
		}else{
			uStr+=","+arr[j].id;
		}
	}
	return uStr;
}
function getUserGroupListViesw(userArr,groupArr){
	var rHtml="";
	for(var i=0;i<userArr.length;i++){
		rHtml+='<dd><span class="chosedUser" data-utype="1" data-selid="'+userArr[i].id+'" data-selaccount="'+userArr[i].account+'">';
		rHtml+='<span class="js_utext">'+userArr[i].name+'['+userArr[i].account+']</span><em class="remove J_remove">×</em></span></dd>';
	}
	for(var j=0;j<groupArr.length;j++){
		rHtml+='<dd><span class="chosedUser" data-utype="2" data-selid="'+groupArr[j].id+'">';
		rHtml+='<span class="js_utext">【'+groupArr[j].groupName+'】</span><em class="remove J_remove">×</em></span></dd>';
	}
	return rHtml;
}
function initUserAndGroup(data){
	//人员选择-隐藏控件初始值
	$("#viewEnableUsers").html("");
	$("#viewReceiceUsers").html("");
	
	setUserHiddenVal(data.enableUser,"enableUserId","viewEnableUsers");
	setGroupHiddenVal(data.enableGroup,"enableGroupId","viewEnableUsers");
	
	setUserHiddenVal(data.receiveUser,"receviceUserId","viewReceiceUsers");
	setGroupHiddenVal(data.receiveGroup,"receviceGroupId","viewReceiceUsers");
	
} 
function setUserHiddenVal(arr,userHiddenId,showViewId){
	$("#"+userHiddenId).val(getHidUserOrShowView(arr,1));
	$("#"+showViewId).append(getHidUserOrShowView(arr,2));
}
function setGroupHiddenVal(arr,groupHiddenId,showViewId){
	$("#"+groupHiddenId).val(getHidGroupOrShowView(arr,1));
	$("#"+showViewId).append(getHidGroupOrShowView(arr,2));
}
function getHidGroupOrShowView(arr,type){
	var hidvalue="";
	var htmlvalue="";
	$.each(arr, function(index, item) {
		//type 1:人员  2：组
		
		htmlvalue+=getSelectedUserHtml(2,item.id,item.groupName);
		
		if(hidvalue==""){
			hidvalue+=item.id;
		}else{
			hidvalue+=","+item.id;
		}
	});
	if(type==1){
		return hidvalue;
	}else{
		return htmlvalue;
	}
}

function getHidUserOrShowView(arr,type){
	var hidvalue="";
	var htmlvalue="";
	$.each(arr, function(index, item) {
		//type 1:人员  2：组
		htmlvalue+=getSelectedUserHtml(1,item.id,item.name,item.account);
		if(hidvalue==""){
			hidvalue+=item.id;
		}else{
			hidvalue+=","+item.id;
		}
	});
	if(type==1){
		return hidvalue;
	}else{
		return htmlvalue;
	}
}
function submitAddModel(id){
	var $frm = $("#"+id);
	//步骤拼接
	setStepEntitiesFrom();
	//文件安全域
	setsecurityDomain();
	if($frm.valid()){//使用valid()方法对表单进行验证，基于jquery.validator.js
		$.ajax({
			async: true,
			type: "post",
			url: $frm.attr("action"),
			data: $frm.serialize(),
			dataType:"json",
			success: function(data){
				clearForm();
				refreshFlowTempTable();
				$("#addModal").modal('hide');
			}
		});
	} else {
		//var $input = $("p.zhushi:first").parent().find("input:first");
		//$input.parents(".orgni_new_title").click();
		//$input.focus();
	}
}
function setsecurityDomain(){
	var domains="";
	var t=0;
	$(".safeDomainRight .domainItem").each(function(){
		t++;
		if(domains==""){
			domains+=$(this).data("domainid");
		}else{
			domains+=","+$(this).data("domainid");
		}
	});
	if(t>0){
		$("#domainItemIds").val(domains);
	}
}
function setStepEntitiesFrom(){
	var stepHiddenHtml="";
	var stepItem=$("#step_form .stepTbBody tr")
	for (var i=0;i<stepItem.length;i++){
		var vStepName=$(stepItem[i]).find(".steplLink").html();
		var vAppPattern=$(stepItem[i]).find(".stepPattern").data("pattern");
		var vAppType=$(stepItem[i]).find(".stepAppType").data("apptype");
		
		stepHiddenHtml+='<input type="hidden"  name="links['+i+'].flowStepEntity.stepName" value="'+vStepName+'" >';
		stepHiddenHtml+='<input type="hidden"  name="links['+i+'].flowStepEntity.approvePattern" value="'+vAppPattern+'" >';
		stepHiddenHtml+='<input type="hidden"  name="links['+i+'].flowStepEntity.approveType" value="'+vAppType+'" >';
		
		var vAppUsers=$(stepItem[i]).find(".stepAppUsers").attr("data-appTypeUsers");
		var vAppGroups=$(stepItem[i]).find(".stepAppUsers").attr("data-appTypeGroups");
		var vAppRoles=$(stepItem[i]).find(".stepAppUsers").attr("data-appRoles");
		stepHiddenHtml+=getUserGroupRoleList(vAppUsers,"users",i);
		stepHiddenHtml+=getUserGroupRoleList(vAppGroups,"groups",i);
		stepHiddenHtml+=getUserGroupRoleList(vAppRoles,"roles",i);
		
	}
	$(".modelStepForms").html(stepHiddenHtml);
}
function getUserGroupRoleList(arrStr,objId,num){
	var userHrmlStr="";
	var objArr=arrStr.split(',');
	for(var j=0;j<objArr.length;j++){
		if(objArr[j]>0){
			userHrmlStr+='<input type="hidden"  name="links['+num+'].'+objId+'['+j+'].id" value="'+objArr[j]+'" >';	
		}
		
	}
	return userHrmlStr;
}
function clearSecDomain(){
	$("#domainItemIds").val("-1");
	$(".safeDomainRight .domainItem").each(function(){
		delItemSelectDomain(selDomain);
	});
}
function clearForm(){
	$("#flowModelId").val("-1");
	$(".form_group .attr_n_input").val("");
	$("input[name=enableUserFlag]:first").prop("checked",true); 
	$("input[name=receviceType]:first").prop("checked",true); 
	$("input[name=allowSelfApprove]:first").prop("checked",false); 
	$(".modelTypeSel").val("fileDecodeApprove"); 
	$(".js_enableUser .danxuankuang_box").first().addClass('selected').siblings().removeClass('selected'); 
	$(".js_receviceType .danxuankuang_box").first().addClass('selected').siblings().removeClass('selected'); 
	$("#receviceUserId").val("");
	$("#receviceGroupId").val("");
	$("#enableUserId").val("");
	$("#enableGroupId").val("");
	$("#flowModelForm .userPickerView").html("");
	$(".acceptUserPicker").addClass("hidden");
	$("#viewEnableUsers").addClass("hidden");
	$(".js_enableUser .js_pickerUsers").addClass("hidden");
	clearSecDomain();
}
</script>
