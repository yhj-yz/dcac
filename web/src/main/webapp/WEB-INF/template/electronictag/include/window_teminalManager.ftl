 <!--设置智能加密弹框开始-->
    <div class="popup_window2" id="intelligent">
	<div class="wind_header">
		<h4>设置智能加密策略</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form >
	<div class="new_box">
					<div class="popup_wind_cont ">
						<div class="text_group">
							<div class="attr_name">默认密码</div>
							<input class="attr_n_input attr_current" name=""  value=""  placeholder="数据库验证默认密码"  />
						</div>
						<div class="text_group">
						<input type="hidden" name="teminal_id" />
							<div class="attr_name">选择策略</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="">
								[#list intelligentPolicyEntities as p]
									<option value="${p.id}">${p.policyName}</option>
								[/#list]
							</select>
							</span>
						</div>
					</div>
	</div>
		
		<div class="btn_wind">
			<a href="#" onclick="submitForm();return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
    
    
    <!--设置智能加密弹框结束-->
    
    <!--设置准入弹框开始-->
    <div class="popup_window2" id="setAdittan">
	<div class="wind_header">
		<h4>设置准入</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form >
	<div class="new_box">
					<div class="text_group">
							<div class="attr_name">允许接入</div>
							<span class="radio_input"> <label class="danxuankuang_box"><input id="sds" name="allowConnect" class="danxuankuang" type="radio" value="1" checked="true"/>
									<i>是</i>
							</label> <label class="danxuankuang_box "><input name="allowConnect" class="danxuankuang" type="radio" value="0" />
									<i>否</i>
							</label>
							</span>
						</div>
	</div>
		<div class="btn_wind">
			<a href="#" onclick="submitSetAdittance();return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
    <!--设置准入加密弹框结束-->
    
	<!--header-->
	<div data-tab="0">
	<div class="big_main">
		<span class="main_title">终端管理 <span class="stroke50"></span>
		</span>
		
		<div class="main_down_content">
     <!--组织机构框架开始-->
			<div class="organization_box">
				<div class="columnbg64"></div>
				<div class="stroke80"></div>
				<div id="tree-id" class="zTreeDemoBackground left">
					<ul id="treeDemo" class="ztree"></ul>
				</div>

			</div>

	   <!--组织机构框架结束-->