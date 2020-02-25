<!DOCTYPE html>
<html lang="ch">
<head>
<meta charset="UTF-8">
<title>权限集管理</title>

[#include "/include/head.ftl"]
<style>
.dsm-nav-tabs {
    padding: 0;
}
</style>
</head>
<body>
<div class="dsm-rightside">
    <div class="maincontent">

        <div class="mainbox setform">
            <div class="dsm-nav-tabs" >
                <ul class="nav nav-tabs" role="tablist" id="perTab">
                    <li class="active">
                    <a href="#tabone" data-toggle="tab" aria-expanded="true">基本信息</a></li>
                    <li class="">
                        <a href="#tabtwo"  data-toggle="tab" aria-expanded="false">权限集信息</a>
                    </li>
                </ul>

    			<form id="perForm">
	                <div class="tab-content">
	                    <div role="tabpanel" class="tab-pane fade active in" id="tabone" >
	                        <div class="dsmForms">
	                            <div class="dsm-form-item">
	                                <div class="dsm-inline ">
	                                    <label class="dsm-form-label">权限集名称：</label>
	                                    <div class="dsm-input-block">
	                                        <input type="text" autocomplete="off" id="permissionName_text" name="permissionName"  required value="${permissionEntity.permissionSetName}"  class="dsm-input specialChar">
	                                        <div class="block-noempty">*</div>
	                                    </div>
	                                </div>
	                                <div class="dsm-inline ">
	                                    <label class="dsm-form-label">权限集描述：</label>
	                                    <div class="dsm-input-block">
				                        	<input type="text" autocomplete="off" name="permissionDesc" value="${permissionEntity.permissionSetDesc}"  class="dsm-input specialChar">
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                    <div role="tabpanel" class="tab-pane fade " id="tabtwo" >
	                        <div class="dsmForms w100">
	                            <div class="dsm-form-item">
	                                <ul class="checkboxlist">
										<li class="clearfix">
											<div class="dsmcheckbox">
												<input type="checkbox"id="p7" data-name="userAuthority" value="${policyMap.POLICY_AUTH_4}">
												<label for="p7"></label>
											</div>
											<label for="p7">允许分离</label>
										</li>
										<li>
											<div class="dsmcheckbox">
												<input type="checkbox"id="p8" data-name="userAuthority" value="${policyMap.POLICY_AUTH_5}">
												<label for="p8"></label>
											</div>
											<label for="p8">允许流转</label>
										</li>
									</ul>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <input type="hidden" value="${oldPermissValue}" name="oldPermissValue">
    			</form>
            </div>
            <div class="form-btns t-l">
                <button type="button" class="btn btn-lg btn-primary js_save">确定</button>
                <a href="${base}/admin/permissionset/list.do" class="btn btn-lg btn-primary">取消</a>
            </div>
        </div>

    </div>
</div>
	
	<script>
	
	$(document).ready(function() {
		$("#perForm").validate({
	            rules:{
	                "permissionSetName":{
	                    required: true,
	                    specialChar: true,
	                    maxlength: 32,
	                },
	                "permissionSetDesc":{
	                    specialChar: true,
	                    maxlength: 256,
	                }	
	            }
	        });
		
		var $frm = $("#perForm");
		
		$frm.validate({
			rules: {
				permissionSetName: {
					required: true,
					remote: {
						url: "${base}/admin/permissionset/check_name.do",
						data: {permissionSetName: function(){return $frm.find("input[name='permissionSetName']").val();},
								id: function(){return $("#permissionId").val();}},
						cache: false
					}
				}
			},
			messages:
			{
				targetAddress: {
					remote: "*权限集名称重复"
				}
			}
		});
		initPower();
    });
    function initPower(){
    	if("${permissionEntity.userAuthority}"!=""){
    		checkAuthsByDataName("perForm","userAuthority","${permissionEntity.userAuthority}");
    	}
    }
    $(document).on('click', '.js_save', function (e) {
    	if($("#permissionId").val()!=null&&$("#permissionId").val()!=""&&$("#permissionId").val()!=-1){
    		updateForm();
    	}else{
    		addForm();
    	}
    });
	function addForm(){
		$frm=$("#perForm");
		$frm.append("<input type='hidden' name='userAuthority' value='"+countInput($frm, 'userAuthority')+"' />");
		
	    if(otherValid()){
		    if($frm.valid()){
		    	$.ajax({
					dataType:"json",
					type: "post",
					url: "${base}/admin/permissionset/save.do",
					data: $frm.serialize(),
					success: function(data){
						if(data && data.type === "success"){
							dsmDialog.msg(data.content);						
							setTimeout("window.location.href='list.do'",1000);
						} else {
							dsmDialog.error(data.msg);
						}
					}
				});
		    }
			
		}
		
	}
	function updateForm(){
		$frm=$("#perForm");
		$frm.append("<input type='hidden' name='userAuthority' value='"+countInput($frm, 'userAuthority')+"' />");
		
	     if(otherValid()){
		    if($frm.valid()){
				$.ajax({
					dataType:"json",
					type: "post",
					url: "${base}/admin/permissionset/update.do",
					data: $frm.serialize(),
					success: function(data){
						if(data && data.type === "success"){
							dsmDialog.msg(data.content);						
							setTimeout("window.location.href='list.do'",1000);
			
						} else {
							dsmDialog.error(data.content);
						}
					}
				});
			}
		}
		
	}
	function otherValid(){
		if($("#permissionName_text").val()==""){
			$('#perTab a:first').tab('show');
			$("#perForm").validate().element($("#permissionName_text"))
			return false ;
		}else{
			return true;
		}
	}
	//求和
	function countInput(container, dataName){
		var countI = 0;
		container.find("input[data-name='"+dataName+"']:checked").each(function(){
			if(this.value!=null){
				countI += parseInt(this.value);
			}
		});
		return countI;
	}
	function checkAuthsByDataName(containerId, name, value){
		var container = $("#"+containerId);
		container.find("input[data-name='"+name+"']").each(function(){
			$(this).prop("checked", ((value & this.value) !== 0));
		});
	}
	</script>
</body>
</html>