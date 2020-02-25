<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
	<title>备份程序管理</title>
    [#include "/dsm/include/head.ftl"]
    <link rel="stylesheet" type="text/css" href="${base}/resources/dsm/css/zTreeStyle.css">
    <script src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
	<style type="text/css">
		
	</style>

</head>
<body>
<div class="dsm-rightside">
        <div class="maincontent">
			<div class="mainbox setform" id="setform">
				<div class="dsm-nav-tabs" >
                    <ul class="nav nav-tabs" role="tablist" id="perTab">
                        <li class="active"><a href="#basicinfo" data-toggle="tab" aria-expanded="true">基本信息</a></li>
                        <li class="">
                        	<a href="#safeset"  data-toggle="tab" aria-expanded="false">备份信息</a>
                        </li>
                    </ul>
                    
            		<form id="programSerForm">
						<div class="tab-content">
                          <div role="tabpanel" class="tab-pane fade active in" id="basicinfo" >
                        	<div class="dsmForms">
                        		<div class="dsm-form-item">
	                                <div class="dsm-inline ">
	                                    <label class="dsm-form-label">备份策略名称：</label>
	                                    <div class="dsm-input-block">
					                        <input type="hidden" name="id" value="${backupManager.id}">
	                                        <input style="margin-left: 20px;" type="text" class="dsm-input "  autocomplete="off" name="strategyName" value="${backupManager.strategyName}" autocomplete="off" placeholder="">
	                                        <div class="block-noempty">*</div>
	                                    </div>
	                                </div>
	                                <div class="dsm-inline ">
	                                    <label class="dsm-form-label">备份策略描述：</label>
	                                    <div class="dsm-input-inline">
	                                        <textarea style="width:360px;" class="dsm-textarea" name="strategyDesc" id="" cols="15" rows="5">${backupManager.strategyDesc}</textarea>
	                                    </div>
	                                </div>
	                            </div>
							</div>
                        </div>

                        <div role="tabpanel " class="tab-pane fade" id="safeset" >
                            <div class="paramerbox">
                                <div class="dsmForms">
                                    <div class="dsm-form-item">
                                        <div class="dsm-inline">
                                            <label class="dsm-form-label">备份格式：</label>
                                            <div class="dsm-input-inline">
											[#if backupManager!=null]
												<textarea class="dsm-textarea w350" name="strategyForm"  rows="2">${backupManager.strategyForm}</textarea>
											[#else]
                                                <textarea class="dsm-textarea w350" name="strategyForm"  rows="2">*.doc;*.docx;*.xls;*.xlsx;*.ppt;*.pptx;*.pdf</textarea>
											[/#if]
                                            </div>
                                        </div>
                                        <div class="dsm-inline">
                                            <label class="dsm-form-label">排除路径：</label>
                                            <div class="dsm-input-inline">
											[#if backupManager!=null]
                                                <textarea  class="dsm-textarea w350" name="excludePath"  rows="2">${backupManager.excludePath}</textarea>
											[#else]
                                                <textarea class="dsm-textarea w350" name="excludePath"  rows="2">*windows*;*temp*</textarea>
											[/#if]
                                            </div>
                                        </div>
                                        <div class="dsm-inline">
                                            <label class="dsm-form-label">排除格式：</label>
                                            <div class="dsm-input-inline">
                                            [#if backupManager!=null]
                                                <textarea  class="dsm-textarea w350" name="excludeForm"  rows="2">${backupManager.excludeForm}</textarea>
											[#else]
                                                <textarea class="dsm-textarea w350" name="excludeForm"  rows="2"></textarea>
											[/#if]
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
						  </div>
                        </div>
					</form>
                    </div>
			        <div class="form-btns t-l" style="padding-left:0;">
			            [#if backupManager!=null]
			            <button type="button" class="btn btn-lg btn-primary js_edit">修改</button>
			            [#else]
			        	<button type="button" class="btn btn-lg btn-primary js_savebasicinfo">确定</button>
			        	[/#if]
						<a href="${base}/admin/backupManager/list.jhtml" class="btn btn-lg btn-primary">取消</a>
			        </div>	
                </div>
			</div>
    </div>
    <script type="text/javascript">
	    $(document).ready(function () {
	       if("${list.enableLogAutoDel}"==0){
	          $(".logList").addClass("hidden");
	          $(".deleteText").addClass("hidden") 
	       }
	       
	      $(".logList").find("[name='logValue']").each(function(){
	      	var v1 = "${list.recordLogType}";
	        this.checked = (v1&this.value) == this.value;
	      })
	      
	      
	      $("#programSerForm").validate({
            rules:{
                "strategyName":{
                    required: true,
                    specialChar: true,
                    maxlength: 32,
                },
                "strategyDesc":{
                    specialChar: true,
                    maxlength: 256,
                },
                "strategyForm":{
                    maxlength: 256,
                },
                "excludePath":{
                    maxlength: 256,
                },
                "excludeForm":{
                    maxlength: 256,
                },

            }
        });
        });
        
        
        //修改备份策略
        $(document).on("click",".js_edit",function(){
          var btn=$(this);
          $(btn).attr("disabled","true")
          var $frm = $("#programSerForm");
          if(otherValid()&&$frm.valid()){
				$.ajax({
					type: "post",
					url: "${base}/admin/backupManager/edit.jhtml",
					data: $frm.serialize(),
					dataType: "json",
					success: function(data){

						$(btn).removeAttr("disabled");
						if(data.type=="success"){							
							dsmDialog.msg(data.content);
							setTimeout("window.location.href='list.jhtml'",1000);
						}else{	
						    $(btn).removeAttr("disabled");
							dsmDialog.error(data.content);
						}
					}
				});
				
			}else{
				$(btn).removeAttr("disabled");
			}
        })
        //保存备份策略
	    $(document).on('click', '.js_savebasicinfo', function (e) {

        	var btn=$(this);
        	$(btn).attr("disabled","true")
			var $frm = $("#programSerForm");
			
		  
			if(otherValid()&&$frm.valid()){
				$.ajax({
					type: "post",
					url: "${base}/admin/backupManager/save.jhtml",
					data: $frm.serialize(),
					dataType: "json",
					success: function(data){					
						$(btn).removeAttr("disabled");
						if(data.type=="success"){							
							dsmDialog.msg(data.content);
							setTimeout("window.location.href='list.jhtml'",1000);
						}else{	
							dsmDialog.error(data.content);
						}
					}
				});
				
			}else{
				$(btn).removeAttr("disabled");
			}
        });

    	function otherValid(){
			if($("[name='strategyName']").val()==""){
				$('#perTab a:first').tab('show');
				$("#programSerForm").validate().element($("[name='strategyName']"))
				return false ;
			}else{
				return true;
	    }
	}
        
      
    </script>
</body>
</html>
