<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title">新增步骤</h4>
</div>
<div class="modal-body">
	<form id="stepForm" >
		<div class="form_group addStepModalform">
			<div class="text_group">
				<div class="attr_name">步骤名称：</div>
				<input class="attr_n_input stepName"  name="stepName" required value="" placeholder="步骤名称">
			</div>
			<div class="text_group" style="width: 700px;">
				<div class="attr_name">审批人类型：</div>
				<span class="radio_input js_approveType" style="width: 555px;"> 
					<label class="danxuankuang_box selected"> 
						<input name="approveType" class="danxuankuang" checked="true" type="radio" value="0"><i>指定人员</i>
					</label> 
					<label class="danxuankuang_box "> 
						<input name="approveType" class="danxuankuang" type="radio" value="1" checked="false"><i>部门管理员</i>
					</label>
				</span>
			</div>
			<div class="text_group js_UserPickerGroup">
				<div class="attr_name">审批人：</div>
				<div class="attr_n_input userPickerView" name="userPickerView" style="width: 130px;" id="stepApproveUsersView"></div>
				<button type="button" data-ushow="stepApproveUsersView" data-uhidden="stepApproveUserId" data-ghidden="stepApproveGroupId" class="btn js_pickerUsers userss" style="width: 40px;height: 38px;border-radius: 0;outline: none;padding-top: 0px;">选择</button>
				<span for="userPickerView" class="forUserPickerView hidden"><span style="color: red;">*</span>必填</span>
				<input type="hidden" id="stepApproveUserId" name="stepApproveUsers" /> 
				<input type="hidden" id="stepApproveGroupId" name="stepApproveGroups" />  
			</div>
			<div class="text_group" style="width: 700px;">
				<div class="attr_name">审批模式：</div>
				<span class="radio_input js_approvePattern" style="width: 555px;"> 
					<label class="danxuankuang_box selected"> 
						<input name="approvePattern" class="danxuankuang" type="radio" value="0"><i>并签</i>
					</label> 
					<label class="danxuankuang_box"> 
						<input name="approvePattern" class="danxuankuang" type="radio" value="1"><i>汇签</i>
					</label>
				</span>
			</div>
		</div>
	</form>
</div>
<div class="modal-footer">
  	<button type="button" class="btn btn-primary js_stepAdd" onclick="submitAddStep('stepForm')" >新增</button>
	<button type="button" class="btn btn-primary js_stepModelClear" data-dismiss="modal">取消</button>
</div>
<script>
$(document).on("click", ".userss", function(){
   

	dataAttrCopy($(this),$("#usersPickerModal"));
	
	$("#usersPickerModal").modal("show");
	
});


</script>
<script>
$().ready(function(){
	
	var _th = "<table class='widget_title'><tr>" +
		"<td style='width: 10%'><label class='inline_middle'>" +
		"<div class='fuxuankuang_box'><input type='checkbox' class='fuxuankuang' /></div>" +
		"</label></td>" +
		//"<td style='width: 15%'>序号</td>" +
		"<td style='width: 15%; color:#333;'>步骤名称</td>" +
		"<td style='width: 30%; color:#333;'>审批模式</td>" +
		"<td style='width: 15%; color:#333;'>审批人类型</td>" +
		"<td style='width: 15%; color:#333;'>审批人</td>" +
		"</tr></table>";
	$("#step_form .tabtitle_box").append(_th);
	
});


$(document).on("click", "input[name=approveType]", function(){
	hideApprovePicker($(this).val());
});
$(document).on("click", ".steplLink", function(){
	initStepFrom(this);
	$("#addStepModal .modal-footer .js_stepAdd").html("确定");
	$("#addStepModal").modal("show");
	$("#addStepModal").data("sid","1");
	$(this).parent().addClass('edited').siblings().removeClass('edited');
});

$(document).on("click", ".stepDelBtn", function(){
	$("#step_form .stepTbBody .fuxuankuang_box.on").each(function(){
		$(this).parent().parent().parent().remove();
	});
});
function hideApprovePicker(val){
	if(val=="0"){
		$(".js_UserPickerGroup").removeClass('hidden');
	}
	else{
		$(".js_UserPickerGroup").addClass('hidden');
		$(".forUserPickerView").addClass('hidden');
	}
}
function submitAddStep(id){
	var $frm = $("#"+id);
	var isEdid=$("#addStepModal").data("sid");
	if($frm.valid()&&otherStepValid()){
		var fApprovePattern=$("input[name=approvePattern]:checked").val();
		var fApproveType=$("input[name=approveType]:checked").val();
		var fUserViews=$("#stepForm .userPickerView").html()
		var fStepApproveUserId=$("#stepApproveUserId").val();
		var fStepApproveGroupId=$("#stepApproveGroupId").val();
		if(fApproveType=="1"){
			fUserViews="";
			fStepApproveUserId="";
			fStepApproveGroupId="";
		}
		
		var _tr = '<tr class="tr_border" style="position: relative;">';
		var _td='<td style="width: 9%;"><div class="stroke20"></div><label class="inline_middle">' +
		'<div class="fuxuankuang_box"><input type="checkbox" class="fuxuankuang " name="ids" value="42"></div></label></td>' +
		//'<td style="width: 15%; "><a></a></td>' +
		'<td style="width: 15%;" class="steplLink">'+$(".stepName").val()+'</td>' +
		'<td style="width: 28%; color:#333;" class="stepPattern" data-pattern="'+fApprovePattern+'">'+$("input[name=approvePattern]:checked").next().text()+'</td>' +
		'<td style="width: 15%; color:#333;" class="stepAppType" data-appType="'+fApproveType+'">'+$("input[name=approveType]:checked").next().text()+'</td>' +
		'<td style="width: 15%; color:#333;" class="stepAppUsers" data-appTypeUsers="'+fStepApproveUserId+'"  data-appTypeGroups="'+fStepApproveGroupId+'" data-appRoles="3">'+fUserViews+'</td>';
		_tr+=_td+'</tr>';
		
		if(isEdid=="1"){
			
			$(".stepTbBody .edited").html(_td);
		}else{
			$(".stepTbBody").append(_tr);
		}
		clearStepForm();
		
		$("#addStepModal").modal('hide');
	} 
	
	
}
function otherStepValid(){
	var flag=true;
	if($("input[name=approveType]:checked").val()==0&&$("#stepForm .userPickerView").html()==""){
		flag=false;
		$(".forUserPickerView").removeClass('hidden');
	}
	else{
		$(".forUserPickerView").addClass('hidden');
	}
	return flag;
}
function clearStepForm(){

	$("#addStepModal").data("sid","0");
	$("#stepForm .userPickerView").html("");
	$("#stepApproveUserId").val("");
	$("#stepApproveGroupId").val("");
	$(".stepName").val("");
	$("input[name=approveType]:first").prop("checked",true);
	$("input[name=approvePattern]:first").prop("checked",true); 
	hideApprovePicker("0");
	$(".js_approvePattern .danxuankuang_box").first().addClass('selected').siblings().removeClass('selected');
	$(".js_approveType .danxuankuang_box").first().addClass('selected').siblings().removeClass('selected');
}
function initStepFrom(linkObj){

	var trItem=$(linkObj).parent();
	
	var vStepName=$(trItem).find(".steplLink").html();
	var vAppPattern=$(trItem).find(".stepPattern").data("pattern");
	var vAppType=$(trItem).find(".stepAppType").data("apptype");
	
	hideApprovePicker(vAppType);
	$("input[type='radio'][name='approveType'][value='"+vAppType+"']").prop("checked",true);
	$("input[type='radio'][name='approveType'][value='"+vAppType+"']").parent().addClass('selected').siblings().removeClass('selected')
	
	if(vAppType=="0"){
		var vUserViews=$(trItem).find(".stepAppUsers").html();
		var vUserIds=$(trItem).find(".stepAppType").data("apptypeusers");
		var vGroupIds=$(trItem).find(".stepAppType").data("apptypeusers");
		$("#stepForm .userPickerView").html(vUserViews);
		$("#stepApproveUserId").val(vUserIds);
		$("#stepApproveGroupId").val(vGroupIds);
	}
	$(".stepName").val(vStepName);
	$("input[type='radio'][name='approvePattern'][value='"+vAppPattern+"']").prop("checked",true);
	$("input[type='radio'][name='approvePattern'][value='"+vAppPattern+"']").parent().addClass('selected').siblings().removeClass('selected')
	
}
</script>
