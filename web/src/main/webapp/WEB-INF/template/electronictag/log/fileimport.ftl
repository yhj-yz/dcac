<div id="fileimport" style="display: none">
	<div class="dsmForms">
		<form id="import_form">
			<input type="hidden" name="destDeptId" />
			<input type="hidden" name="isAlarm" />
		</form>
		
    	<div class="dsm-form-item">
			<div class="dsm-inline">
				<label class="dsm-form-label">选择文件：</label>
				<div class="dsm-input-inline">
					<input type="text" readonly="readonly" class="dsm-input" name="fileName">
				</div>
				<div class="dsm-upload-button  m-r-f10">
					<input class="dsm-upload-file" id="fileupload" type="file" name="file" data-url="" >
					<span class="btn">浏览</span>
				</div>
			</div>
			<div class="dsm-inline ">
				<label class="dsm-form-label"></label>
				<div class="progress" style="display:none;" id="progress">

				    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
				        <span class="sr-only"></span>
				    </div>
				</div>
			</div>
        </div>
	</div>
</div>
	
<script>
	//浏览按钮：加载文件完成事件
	var fileData,loadingIndex;
	$('#fileupload').fileupload({
	    dataType: 'json',
	    autoUpload: 'false',
	    maxNumberOfFiles : 1,
	    add: function (e, data) {
	        if(data.files.length > 0){
	        	if(! validImportFileName(data.files[0].name)){
	        		dsmDialog.error('文件不能识别');
	        		clearFileUpload();
	        		return;
	        	}
	        	$('input[name="fileName"]').val(data.files[0].name);
		        $('.progress .progress-bar').css('width','0%');
		    	$('.progress').show();
		        fileData = data;
	        }
	    },
	    send: function (e, data) {
	    	$('#fileupload').attr('disabled', 'disabled');
	    },
	    done: function (e, data) {
	    	fileUploadDone(data);
			var isAlarm = $(".js_imp").attr("isAlarm");
			if(isAlarm == "0") {
				refreshlogTable();
			}else if(isAlarm == "1"){
				refreshAlarmTable();
			}
	    },
	    //显示进度条
	    progressall: function (e, data) {
	        var progress = parseInt(data.loaded / data.total * 100, 10);
	        $('.progress .progress-bar').css('width',progress + '%');
	    },
	    fail:function(e,data){
	    	clearFileUpload();
	    	layer.closeAll();
	    	//alert(JSON.stringify(e));
	    }
	});

	//从xml文件导入       
    $(document).on('click', '.js_imp', function (e) {
    	var isLoading = $(this).attr("isLoading");
    	if(isLoading!=null && isLoading ==1){

    		dsmDialog.error('日志正在导入请稍后再试');
    		return false;
    	}
    	clearFileUpload();
    	dsmDialog.open({
			type: 1,
			area:['500px','250px'],
			btn:['确定','取消'],
			title:"日志导入",
            content: $('#fileimport'),
            yes: function(index, layero){
            	fileUpload();
		  	}
		});
    });
    
    //导入文件上传
    function fileUpload(){
    	if(fileData && fileData != null){
    		var url = $('#fileupload').data('url');
    		$('#fileupload').fileupload('option', 'url', url);
        	showLoadLayer();
    	} else {
    		dsmDialog.error('文件不能为空');
    	}
    }
    
    //是否是xml文件
	function validImportFileName(name){
		if(name != null && name.lastIndexOf('.') !== -1){
	    	var suffix = name.substr(name.lastIndexOf('.') + 1);
	    	if(suffix === 'xml' || suffix ==='log' || suffix ==='json'){
	    		return true;
	    	}
    	}
    	return false;
	}

	//弹框提示是否取消上传；
    function cancelUpload(v){
    	if($('.progress').is(':hidden')){
    		if(typeof v.yes === 'function'){v.yes();}
    		return;
    	}
    	dsmDialog.toComfirm("有文件正在上传，是否取消？", {
			btn: ['确定','取消'],
			title:"取消上传"
		}, function(index2){
		    clearFileUpload();
			if(typeof v.yes === 'function'){v.yes();}
			dsmDialog.close(index2);
		}, function(index2){
			if(typeof v.no === 'function'){v.no();}
			dsmDialog.close(index2);
		});
    }
    
    function closeLoadLayer(){
    	layer.close(loadingIndex);
    }
    
    //提示
    function fileUploadDone(data){
    	closeLoadLayer();
    	$('#fileupload').removeAttr('disabled');
    	$('.progress .progress-bar').css('width','0%');
    	if($('#fileupload').data('url') === fileupload_checkurl){
			if(data.result.type === "success"){
				$('#fileupload').data('url',fileupload_url);
				fileUpload();
			} else if(data.result.type === "warn"){
				dsmDialog.toComfirm(data.result.content, {
					btn: ['确定','取消'],
					title:"确认导入"
				}, function(index){
					$('#fileupload').data('url',fileupload_url);
					fileUpload();
					dsmDialog.close(index);
				}, function(index){	
					dsmDialog.close(index);
				});
			} else {
				dsmDialog.error(data.result.content);
			}
    	} else {
			if(data.result.type === "success"){
		    	clearFileUpload();
	    		layer.closeAll();
				dsmDialog.msg(data.result.content);
			} else {
				dsmDialog.error(data.result.content);
			}
    	}
    }
    
    		
	
    //清除上传组件与 组件名称input；
    function clearFileUpload(){
    	fileData = null;
        $('#fileupload').removeAttr('disabled');
        $("input[name='fileName']").val("");
        $("input[name='destDeptId']").val("");
        $('.progress .progress-bar').css('width','0%');
        $('.progress').hide();
        $('#fileupload').data('url',fileupload_checkurl);
    }
    
    
    function showLoadLayer(){
    	var msg;
    	if($('#fileupload').data('url') === fileupload_checkurl){
    		msg = '正在检查...';
    	}else{
    		msg = '正在导入...'
    	}
		var isAlarm = $(".js_imp").attr("isAlarm");
    	$('input[name="isAlarm"]').val(isAlarm);
    	fileData.formData = function () {
		    return $('#import_form').serializeArray();
		};
    	fileData.submit();
    	loadingIndex = layer.msg(msg, {icon: 16,shade: [0.5, '#f5f5f5'],scrollbar: false,offset: '0px', time:1000000});
    	//loadingIndex = layer.load(1, {title: msg,shade: [0.5, '#f5f5f5']});
    }
    
</script>