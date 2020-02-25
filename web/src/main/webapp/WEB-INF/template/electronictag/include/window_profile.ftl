<!--联系人弹窗开始-->
<div class="popup_window5" id="pop_contact" style="display:none;">
	<div class="wind_header">
		<h4>标题</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" >
		<div class="text_group">
			<div class="attr_name">联系人姓名</div>
			<input class="attr_n_input attr_current" name="contactName"  value=""  placeholder="姓名"  />
		</div>
		<div class="text_group">
			<div class="attr_name">联系人邮箱</div>
			<input  class="attr_n_input" name="contactEmail" value=""  placeholder="邮箱" />
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
<!--联系人弹窗结束-->