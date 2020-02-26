<!DOCTYPE html>
<html lang="ch">        
<head>
	<meta charset="UTF-8">
    <title>授权激活</title>
    [#include "/dsm/include/head.ftl"]

	<script src="${base}/resources/dsm/js/clipboard.js"></script>
</head>
<body>
	<div class="dsm-auth">
		<div class="authbox">
			<div class="auth-header">
				<div class="product">数据分类分级管理系统授权许可</div>
				<div class="desc">未获得授权，请根据申请码导入授权文件</div>
				<div class="auth-icon"><img src="${base}/resources/dsm/images/safe.png"></div>
			</div>
			<div class="auth-body">
			
        		<form id="lic_form"  method="post"  action="${base}/admin/authorizationManager/importlic.jhtml"  enctype="multipart/form-data">
				<div class="dsm-form-item">
		            <div class="dsm-inline">
	                    <label class="dsm-form-label">申请码：</label>
	                    <div class="dsm-input-inline" style="width: 400px;">
	                        <input type="text" id="foo" autocomplete="off" style="outline: none;border: 0;width: 317px;float: left;" placeholder="请填写申请码" readonly value="${GDU}" class="js_applycode dsm-input required">
	                    	<div class="dsm-upload-button  m-r-f10" style="float: left;margin-left: 20px;">
	                    		<span class="fbtname js_copy"  data-clipboard-action="copy" data-clipboard-target="#foo" style="margin: 0 16px;padding: 0 5px;">复制</span>
	                    	</div>
	                    </div>
	                    <input type="hidden" name="SGUD" value="${GDU}">
	                </div>
		            <div class="dsm-inline m-b-20">
	                    <label class="dsm-form-label">选择软授权：</label>

	                    <div class="dsm-input-inline">
	                        <input type="text" autocomplete="off" disabled="true" id="fileNameShow" placeholder="" style="width: 317px;" class="auth-file-input required">
	                        
	                    </div>
	                    <div class="dsm-input-inline f-r">
	                    	<div class="dsm-upload-button  m-r-f10">
	                    		<input type="file" name="file" class="dsm-upload-file js_file"  accept=".lic"><span class="fbtname">浏览...</span>
	                    		<input type="hidden" name="fileType" value="file">
	                    	</div>
	                    </div>
	                </div>
	                
	                <input type="hidden" value="nolic" name="urltype">
	                <div class="syserror" style='color:red;'></div>
		            <button type="submit" class="btn btn-lg btn-primary f-r m-r-10">导入</button>
		        </div>
		        <div class="footerimg"><img src="${base}/resources/dsm/images/auth-tip.png"></div>
		        <div class="tip">申请码为当前系统申请授权的唯一凭证，请联系经销商通过该申请码获取授权文件，导入授权文件后，系统即可正常使用</div>
		        </form>
			</div>
		</div>
	</div>	
	<script type="text/javascript">
	var clipboard = new Clipboard('.js_copy');
	clipboard.on('success', function(e) {
       alert("复制成功！");
    });
    $(document).ready(function () {
	    if("${data}"!=""){
	    	if("${data.type}"=="success"){
        		dsmDialog.msg('${data.content}');
				setTimeout("window.location.href='${base}/admin/common/main.jhtml'",1000);
	    	}else{	    		
        		$(".syserror").html('${data.content}');
	    	}
	    }
    	
    });
    
    $(document).on('change', '.js_file', function (e) {
    
	    var filePath=$(this).val();
	    var licNameArr=filePath.split('.');
	    if(licNameArr[licNameArr.length-1]!="lic")
	    {
	        dsmDialog.error('请选择格式为.lic的文件！');
	        return false;
	    }
	    else{
	        $("#fileNameShow").val(filePath);
	    }
	})
  
    
	
    $(document).on("click",".js_save",function(){
	    $frm=$("#lic_form");
	    
    	var t=$(this);
		$(this).addClass('disabled');
	    $.ajax({  
	          url: "${base}/admin/authorizationManager/importlic.jhtml",  
	          type: "post",  
	          data: new FormData($frm[0]),
	          async: false,  
	          cache: false,  
	          contentType: false,  
	          processData: false,  
	          success: function (data) {
				  $(t).removeClass('disabled');
	          	if(data.type=="success"){
	          		dsmDialog.msg(data.content);
    				setTimeout('window.location.href="${base}/admin/login.jsp";',1500);
	          	}else{
		            dsmDialog.error(data.content);
	          	}
	          	//setTimeout('window.location.reload();',1500);
	          },  
	          error: function (data) { 
				  $(t).removeClass('disabled');
		          dsmDialog.error(data.content);
				  //setTimeout(' window.location.reload();',1500);
	          }   
	     });  
	
	})
</script>
</body>
</html>