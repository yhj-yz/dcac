<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>授权页面</title>
    [#include "/dsm/include/head.ftl"]
	<script src="${base}/resources/dsm/js/clipboard.js"></script>

</head>
<body>
<div class="dsm-rightside">
        <div class="maincontent">        
            <form id="loginimgForm"  method="post"  action="${base}/admin/authorizationManager/importlic.jhtml"  enctype="multipart/form-data">
				<div class="mainbox clearfix">
		            <div class="card-info width100">
		                <span class="pic-author"></span>
		                <div class="info-contain ">
		                    <div class="dsmForms">
		                        <div class="dsm-form-item dsm-big">
		                        
		                            <div class="dsm-inline">
		                                <label class="dsm-form-label">到期时间：</label>
		                                <div class="dsm-input-inline">
		                                    <label class="dsm-label" style="line-height: 28px;">${OT}</label>
		                                </div>
		                            </div>
		                            <div class="dsm-inline">
		                                <label class="dsm-form-label">申请码：</label>
		                                <div class="dsm-input-block">
		                                    <input type="text" class="dsm-input w268 f-l m-r-10 " id="foo" value="${GDU}" autocomplete="off"  readonly placeholder="申请码">
		                                    <input type="hidden" value="${GDU}" name="SGUD">
		                                    <div class="dsm-upload-button f-l m-r-f10">
		                                        <span class="fbtname js_copy" data-clipboard-action="copy" data-clipboard-target="#foo">复制</span>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="dsm-inline m-t-30p">
		                                <label class="dsm-form-label">选择授权：</label>
		                                <div class="dsm-input-block">
		                                    <input id="fileNameShow" type="text"  autocomplete="off" placeholder=""  disabled="true" class="dsm-input w268 f-l m-r-10 " >
		                                    <div class="dsm-upload-button f-l m-r-f10">
		                                        <input type="file" name="file" class="dsm-upload-file js_file" data-fileid="fileInfo">
		                                        <span class="fbtname">浏览...</span>
		                                    </div>
		
		                                </div>
		                            </div>
		                            <div class="form-btns t-l">
	                					<input type="hidden" value="lic" name="urltype">
                            			<div class="syserror" style='color:red;'></div>
		                                <button type="submit" class="btn btn-primary js_imp">导入授权文件</button>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
			</form>
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
      
</script>
</body>
</html>
