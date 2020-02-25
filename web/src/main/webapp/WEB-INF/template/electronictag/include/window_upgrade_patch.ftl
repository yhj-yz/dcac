<!--弹窗开始-->
<div class="popup_window5" id="pop_rule" style="display:none;">
	<div class="wind_header">
		<h4>新增部门</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<div class="popup_wind_cont" >
		<div class="text_group" >
			<div class="attr_name">组件类型</div>
			<span class="radio_input">
				<label class="danxuankuang_box selected"> 
					<input name="moduleType" class="danxuankuang" type="radio"  value="issuerun" />
					<i>下发运行</i>
				</label>
				<label class="danxuankuang_box"> 
					<input name="moduleType" class="danxuankuang" type="radio" value="updatereplace" />
					<i>更新替换</i>
				</label>
			</span>
		</div>
		<div class="text_group">
			<div class="attr_name">下发路径</div>
			<input class="attr_n_input" name="issuePath"  value=""  placeholder="下发路径"  />
		</div>
		<div class="text_group">
			<div class="attr_name">命令行</div>
			<input class="attr_n_input" name="commandLine"  value=""  placeholder="命令行"  />
		</div>
		<div class="text_group" >
			<div class="attr_name">组件上传</div>
			<span class="radio_input">
				<div id="fileupload" >
		            <div class="row fileupload-buttonbar">
		                <div class="col-lg-10">
		                    <span class="btn btn-success fileinput-button">
		                        <i class="glyphicon glyphicon-plus"></i>
		                        <span>添加...</span>
		                        <input type="file" name="file" multiple>
		                    </span>
		                    <button type="submit" class="btn btn-primary start js_start hidden">
		                        <i class="glyphicon glyphicon-upload"></i>
		                        <span>上传</span>
		                    </button>
		                    <button type="reset" class="btn btn-warning cancel hidden">
		                        <i class="glyphicon glyphicon-ban-circle"></i>
		                        <span>清空</span>
		                    </button>
		                    <span class="fileupload-process"></span>
		                </div>
		                <div class="col-lg-5 fileupload-progress fade">
		                    <div class="progress progress-striped active" role="progressbar" aria-valuemin="0"
		                         aria-valuemax="100">
		                        <div class="progress-bar progress-bar-success" style="width:0%;"></div>
		                    </div>
		                    <div class="progress-extended">&nbsp;</div>
		                </div>
		            </div>
		            <table role="presentation" class="table table-striped">
		                <tbody class="files"></tbody>
		            </table>
		        </div>
			</span>
		</div>
		
		<div class="btn_wind">
			<a href="#" onclick="saveRule();" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</div>
</div>
<script>
$().ready(function(){
	
	$("input[name='moduleType']").change(function(){
		if(this.value === "issuerun") {
			$("input[name='issuePath']").parents(".text_group").show();
			$("input[name='commandLine']").parents(".text_group").hide();
		} else {
			$("input[name='issuePath']").parents(".text_group").hide();
			$("input[name='commandLine']").parents(".text_group").show();
		}
	});
	$("input[name='moduleType']:first").click();
});
</script>
<!--新增规则弹窗结束-->
