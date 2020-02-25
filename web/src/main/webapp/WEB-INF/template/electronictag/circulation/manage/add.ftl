<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
	<title>流转管理</title>
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
                    </ul>
                    
            		<form id="programSerForm" action="${base}/admin/circulationManage/save.jhtml" method="post" enctype="multipart/form-data">
						<div class="tab-content">
                          <div role="tabpanel" class="tab-pane fade active in" id="basicinfo" >
                        	<div class="dsmForms">
                        		<div class="dsm-form-item">
	                                <div class="dsm-inline ">
	                                    <label class="dsm-form-label">待流转文件：</label>
                                        <div class="dsm-input-block">
                                            <input id="fileNameShow" type="text"  autocomplete="off" placeholder=""  disabled="true" class="dsm-input w268 f-l m-r-10 " >
                                            <div class="dsm-upload-button f-l m-r-f10">
                                                <input type="file" name="file" class="dsm-upload-file js_file" data-fileid="fileInfo">
                                                <span class="fbtname">浏览...</span>
                                            </div>
                                        </div>
	                                </div>
                                    <div class="dsm-inline ">
                                        <label class="dsm-form-label"></label>
                                        <div class="dsm-input-block">
                                            <div class="syserror" style='color:red;'></div>
                                        </div>
                                    </div>
	                                <div class="dsm-inline ">
	                                    <label class="dsm-form-label">目标单位：</label>
                                        <div class="dsm-input-block">
                                            <input type="text" class="dsm-input w268 f-l m-r-10 " readonly="readonly" id="organizationName" name="organizationName" value="${backupManager.organizationName}" autocomplete="off" placeholder="">
                                        </div>
	                                </div>
                                    <div class="dsm-inline ">
                                        <label class="dsm-form-label"></label>
                                        <div class="dsm-input-block">
                                            <div class="dsm-upload-button f-l m-r-f10">
                                                <span class="fbtname" onclick="choiceOrg();">选择单位</span>
                                            </div>
                                        </div>
                                    </div>
	                            </div>
							</div>
                        </div>
                        </div>
                        <div class="form-btns t-l" style="padding-left:0;">
                            [#if backupManager!=null]
                                <button type="button" class="btn btn-lg btn-primary js_edit">修改</button>
                            [#else]
                                <button type="submit" class="btn btn-lg btn-primary js_savebasicinfo">新增</button>
                            [/#if]
                            <a href="${base}/admin/circulationManage/list.jhtml" class="btn btn-lg btn-primary">取消</a>
                        </div>
                    </form>
                </div>
                <div class="modal fade bd-example-modal-lg" id="showModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-body" style="height: 600px;">
                                <iframe id="addressIframe" width="100%" height="100%" frameborder="0"></iframe>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-default" type="button" onclick="getAddress(this);">确定</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function choiceOrg(){
            var frameSrc = "getOrg.jhtml";
            $("#addressIframe").attr("src", frameSrc);
            $('#showModal').modal({ show: true, backdrop: 'static' });
        }

        function getAddress(){
            var objs = document.getElementById('addressIframe').contentWindow.getListData();
            console.dir('objs:'+ objs);
            $('#organizationName').val(objs);
            close();
        }
        function close(){
            //$("#showModal").hide();
            $('#showModal').modal('hide');
        }

	    $(document).ready(function () {
            if("${data}"!=""){
                if("${data.type}"=="success"){
                    dsmDialog.msg('${data.content}');
                }else{
                    $(".syserror").html('${data.content}');
                }
            }

	        //每次隐藏时，清除数据。确保点击时，重新加载
            $("#showModal").on("hidden.bs.modal", function() {
                $(this).removeData("bs.modal");
            });

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
                    "fileNameShow":{
                        required: true
                    },
                    "organizationName":{
                        required: true,
                        maxlength: 256
                    },
                    errorPlacement: function (error, element) {
                        // if ($(element).attr('class')== '') {
                        //     error.appendTo($("#checkbox-lang"));
                        // } else {
                        //     error.insertAfter(element);
                        // }
                    }
                }
            });
        });

        $(document).on('change', '.js_file', function (e) {
            var filePath=$(this).val();
            $("#fileNameShow").val(filePath);
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
