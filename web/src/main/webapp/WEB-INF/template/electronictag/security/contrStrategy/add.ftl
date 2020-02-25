<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
	<title>受控程序管理</title>
    [#include "/dsm/include/head.ftl"]
    <link rel="stylesheet" type="text/css" href="${base}/resources/dsm/css/zTreeStyle.css">
    <script src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>

</head>
<body>
<div class="dsm-rightside">
        <div class="maincontent">
            
			<div class="mainbox">
				<div class="dsm-nav-tabs" >
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="active"><a href="#basicinfo" data-toggle="tab" aria-expanded="true">基本信息</a></li>
                        <li class="">
                        	<a href="#safeset"  data-toggle="tab" aria-expanded="false">受控信息</a>
                        </li>
                    </ul>
            		<form id="programSerForm">
            		<input type="hidden" name="id" value="${controlledStrategy.id}">
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="basicinfo" >
                            	<div class="dsmForms">
							    	<div class="dsm-form-item">
							            <div class="dsm-inline ">
		                                    <label class="dsm-form-label w120">受控策略名称：</label>
		                                    <div class="dsm-input-inline">
		                                        <input type="text" name="name" value="${controlledStrategy.name}" class="dsm-input w350 specialChar" autocomplete="off" placeholder="" dzbqSpecialChar="true">
		                                    </div>
		                                    <div class="desc"><em>*</em></div>
		                                </div>
		                                <div class="dsm-inline ">
		                                    <label class="dsm-form-label w120">受控策略描述：</label>
		                                    <div class="dsm-input-inline">
		                                        <textarea class="dsm-textarea w350" name="decspt" cols="10" rows="5"  dzbqSpecialChar="true">${controlledStrategy.decspt}</textarea>
		                                    </div>
		                                </div>			            
							        </div>
                            </div>
                        </div>

                        <div role="tabpanel" class="tab-pane fade" id="safeset" >
                            <div id="addProgramForm" >
								<div id="programList" class="datachosebox clearfix">
							            <div class="cleft">
							                <div class="choseheader">
							                    <span class="ctitle">可选策略</span>
							                </div>
							                <div class="csearch">
							                    <input type="text" autocomplete="off" placeholder="搜索" class="dsm-input js_chosekey search-input"><i class="icon icon-search"></i></input>
							                </div>
							                <div class="itembox">
							                    <div class="items">
							                        [#list contrManagers as s]
														<div class="itemone" data-id="${s.id}">${s.name}</div>
													[/#list]                     
							                    </div>
							                </div>
							            </div>
							            <div class="ccenter clearfix">
							                <div class="chosebtn js_choseone"><i class="icon icon-greenright"></i></div>
							                <div class="chosebtn js_delone"><i class="icon icon-greenleft"></i></div>
							                <div class="chosebtn js_choseall"><i class="icon icon-dgreenright"></i></div>
							                <div class="chosebtn js_delall"><i class="icon icon-dgreenleft"></i></div>
							            </div>
							            <div class="cright">
							                <div class="choseheader">
							                    <span class="ctitle">已选策略</span>
							                </div>                
							                <div class="csearch">
							                    <input type="text" autocomplete="off" placeholder="搜索" class="dsm-input js_chosekey search-input"><i class="icon icon-search"></i></input>
							                </div>
							                <div class="itembox" id="self">
							                    <div class="items">
							                    [#if exists!=null ]
							                    [#list exists as contr]
							                     <div class="itemone " data-id="${contr.id}">${contr.name}</div>
							                    [/#list]
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
			            [#if controlledStrategy!=null]
			            <button type="button" class="btn btn-lg btn-primary js_edit">修改</button>
			            [#else]
			        	<button type="button" class="btn btn-lg btn-primary js_savebasicinfo">确定</button>
			        	[/#if]
						<a href="${base}/admin/controlledStrategy/list.jhtml" class="btn btn-lg btn-primary">取消</a>
			        </div>	
                </div>
			</div>

        </div>
    </div>
    <script type="text/javascript">
	    $(document).ready(function () {
	    
	     $("#programSerForm").validate({
	            rules:{
	                "name":{
	                    required: true,
	                    specialChar: true,
	                    maxlength: 32,
	                },
	                "decspt":{
	                    specialChar: true,
	                    maxlength: 256,
	                }	
	            }
	        });
	        
	       if("${list.enableLogAutoDel}"==0){
	          $(".logList").addClass("hidden");
	          $(".deleteText").addClass("hidden") 
	       }
	       
	      $(".logList").find("[name='logValue']").each(function(){
	      	var v1 = "${list.recordLogType}";
	        this.checked = (v1&this.value) == this.value;
	      })
        });
        
        
        //修改程序策略
        $(document).on("click",".js_edit",function(){
         var _name=$("#programSerForm").find("[name='name']").val();
	      if(_name==""){
	       dsmDialog.error("受控策略名称不能为空");
	       return;
	      }
         var arr= new Array(); 
	       $("#self .itemone").each(function(){
	         arr.push($(this).data("id"));
	       })
	      for(var i=0;i<arr.length; i++){
	         $("#self").append("<input type='hidden' name='ids' value='"+arr[i]+"' />");
	       }
          var btn=$(this);
          $(btn).attr("disabled","true")
          var $frm = $("#programSerForm");
          if($frm.valid()){
				$.ajax({
					type: "post",
					url: "${base}/admin/controlledStrategy/edit.jhtml",
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
        //保存程序策略
	    $(document).on('click', '.js_savebasicinfo', function (e) {
	      var _name=$("#programSerForm").find("[name='name']").val();
	      if(_name==""){
	       dsmDialog.error("请输入受控策略名称");
	       return;
	      }
	       var arr= new Array(); 
	       $("#self .itemone").each(function(){
	         arr.push($(this).data("id"));
	       })
	      for(var i=0;i<arr.length; i++){
	         $("#self").append("<input type='hidden' name='ids' value='"+arr[i]+"' />");
	       }
        	var btn=$(this);
        	$(btn).attr("disabled","true")
			var $frm = $("#programSerForm");
			if($frm.valid()){
				$.ajax({
					type: "post",
					url: "${base}/admin/controlledStrategy/save.jhtml",
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
		
		
        
      
    </script>
</body>
</html>
