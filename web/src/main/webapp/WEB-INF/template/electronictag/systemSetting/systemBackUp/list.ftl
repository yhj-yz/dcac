<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>授权页面</title>
    [#include "/include/head.ftl"]
	<script src="${base}/resources/dsm/js/clipboard.js"></script>

</head>
<body>
<div class="dsm-rightside">
        <div class="maincontent">        
            <form id="loginimgForm"  method="post"  action="${base}/admin/backUp/dbRecover.do" enctype="multipart/form-data">
				<div class="mainbox clearfix">
		            <div class="card-info width100">
		                <span class="pic-author"></span>
		                <div class="info-contain ">
		                    <div class="dsmForms">
		                        <div class="dsm-form-item dsm-big">
		                            <div class="dsm-inline">
		                                <label class="dsm-form-label">系统配置导出：</label>
		                                <div class="dsm-input-block">
		                                	<div class=" f-l m-l-13p">
                                            <button type="button" class="btn btn-primary js_backUp"> 导出</button>
		                                	<span class="error" style="margin-left:40px;line-height:35px;"></span>
		                                	</div>
		                                </div>
		                            </div>
		                            <div class="dsm-inline m-t-30p">
		                                <label class="dsm-form-label">系统配置导入：</label>
		                                <div class="dsm-input-block">
		                                    <input id="fileNameShow" type="text"  autocomplete="off" placeholder=""  disabled="true" class="dsm-input w268 f-l m-r-10 " >
		                                    <div class="dsm-upload-button f-l m-r-f10">
		                                        <input type="file" name="file" class="dsm-upload-file js_file" data-fileid="fileInfo" accept=".xml">
		                                        <span class="fbtname">浏览...</span>
											</div>
                                            <div class=" f-l m-l-13p">
                                                <button type="button" class="btn btn-primary js_imp" style="margin-left:20px;">导入</button>
											</div>

		                                </div>
		                            </div>
		                            <div class="form-btns t-l">
	                					<input type="hidden" value="lic" name="urltype">
                            			<div class="syserror" style='color:red;'></div>

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
    
    $(document).ready(function () {
	    if("${data}"!=""){
	        var dateMessage = "${data}";
	        if (dateMessage =="导入成功"){
                dsmDialog.msg('${data}');
                layer.close(_load_layer_index);
			} else {
                dsmDialog.error('${data}');
			}

	    }
	    getQueryString("error");
	    function getQueryString(param){
	        var reg = new RegExp("(^|&)"+ param +"=([^&]*)(&|$)");
	        var r = window.location.search.substr(1).match(reg);
	        if(r!=null){
	           dsmDialog.error("资源文件不存在或者mysql环境变量配置有误");
	        } 
	    }
    });
    
     //导出系统备份数据文件
    $(document).on('click','.js_backUp',function(){
       window.location.href="${base}/admin/backUp/dbBackUp.do";
    })
    
    $(document).on('change', '.js_file', function (e) {
    
	    var fileObj  = $(this);
	    var filePath=$(this).val();
	    var licNameArr=filePath.split('.');
	    if(licNameArr[licNameArr.length-1]!="xml")
	    {
	        dsmDialog.error('请选择格式为.xml的文件！');
	        return false;
	    }
	    else{
	        $("#fileNameShow").val(fileObj[0].files[0].name);
	    }
	})

	$(document).on("click",".js_imp",function(){

        var _file =  $("[name='file']").val();
        if (_file == "") {
            dsmDialog.error('请选择数据文件');
            return false;
        } else{
            dsmDialog .toComfirm("请确认是否继续执行还原操作", {
                btn: ['确定','取消'],
                title:"确定导入"
            }, function(index){
                _load_layer_index = layer.msg('正在导入配置...', {icon: 16,shade: [0.5, '#f5f5f5'],scrollbar: false,offset: '150px', time:4000000});
                dsmDialog.close(index);
                $("#loginimgForm").submit();
            }, function(index){
                dsmDialog.close(index);
            });
        }
	})

	
</script>
</body>
</html>
