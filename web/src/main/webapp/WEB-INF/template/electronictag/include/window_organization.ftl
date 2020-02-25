<!--新增用户弹窗开始-->
<div class="popup_window2"  id="pop_user" style="display:none;">
	<form >
	<div class="wind_header">
		<h4>新增用户</h4>
		<i><a href="#" onclick="hideWindows();return false;" class="wind_cancel_button"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<div class="new_box">
		<ul class="orgni_new_title_box">
			<li class="orgni_new_title on">基本权限
				<div class="popup_wind_cont_box current">
					<div class="popup_wind_cont ">
						<div class="text_group">
							<div class="attr_name">账号</div>
							<input class="attr_n_input" name="account" value="" placeholder="账号" />
						</div>
						<div class="text_group">
							<div class="attr_name">姓名</div>
							<input class="attr_n_input attr_current" name="name" value="" placeholder="姓名" />
						</div>
						<div class="text_group">
							<div class="attr_name">密码验证类型</div>
							<span class="radio_input"> <label class="danxuankuang_box selected"> 
									<input class="danxuankuang" type="radio" name="passwordCheckType" value="database" checked="true" />
									<i>系统验证</i>
							</label> <label class="danxuankuang_box"> 
									<input class="danxuankuang" type="radio" name="passwordCheckType" value="domain" />
									<i>域验证</i>
							</label>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">密码</div>
							<input type="password" class="attr_n_input" name="password" id="password" value="" placeholder="密码"/>
						</div>
						<div class="text_group">
							<div class="attr_name">确认密码</div>
							<input type="password" class="attr_n_input" name="rePassword" value="" placeholder="确认密码"/>
						</div>
						<div class="text_group">
							<div class="attr_name">允许密码修改</div>
							<label class='inline_middle' style="margin-left:10px;margin-top:10px;float: left;">
								<div class='fuxuankuang_box'>
									<input type='checkbox' class='fuxuankuang' name='allowUserChangePwd' value='1'/>
								</div>
							</label>
						</div>
						<div class="text_group">
							<div class="attr_name">客户端首次登录要求修改密码</div>
							<label class='inline_middle' style="margin-left:10px;margin-top:10px;float: left;">
								<div class='fuxuankuang_box'>
									<input type='checkbox' class='fuxuankuang' name='firstLoginChangePwd' value='1'/>
								</div>
							</label>
						</div>
						<!--<div class="text_group" >
							<div class="attr_name"></div>
							<span class="radio_input"> <label
								class="danxuankuang_box selected"> <input name="gender" 
									class="danxuankuang" type="radio"  value="male" checked="male" />
									<i>男</i>
							</label> <label class="danxuankuang_box"> <input name="gender" 
									class="danxuankuang" type="radio" value="female" />
									<i>女</i>
							</label>
							</span>
						</div>-->
						<div class="text_group" >
							<div class="attr_name">是否禁用</div>
							<label class='inline_middle' style="margin-left:10px;margin-top:10px;float: left;">
								<div class='fuxuankuang_box'>
									<input type='checkbox' class='fuxuankuang' name='isDisable' value='1'/>
								</div>
							</label>
						</div>
						<div class="text_group">
							<div class="attr_name">所属部门</div>
							<input class="attr_n_input" id="departmentName" value="" disabled="true" />
							<input type="hidden" name="departmentId" value="" />
							<input type="hidden" name="id" value="" />
						</div>
					</div>
				</div>
			</li>
			<li class="orgni_new_title">高级设置
				<div class="popup_wind_cont_box ">
					<div class="popup_wind_cont ">
						<div class="text_group">
							<div class="attr_name">所属安全域</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="belongDomain.id">
								[#list securityDomains as q]
									<option value="${q.id}">${q.securityName}</option>
								[/#list]
							</select>
							</span>
						</div>
						[#if DRMNum > 0]
						<div class="text_group">
							<div class="attr_name">所属密级</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="belongSecurity.id">
								[#list levels as q]
									<option value="${q.id}">${q.securityName}</option>
								[/#list]
							</select>
							</span>
						</div>
						[/#if]
						<div class="text_group">
							<div class="attr_name">角色</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="role.id">
								[#list roles as q]
									<option value="${q.id}">${q.name}</option>
								[/#list]
							</select>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">安全策略设置</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="securityPolicy.id" >
								[#list policys as q]
									<option value="${q.id}">${q.policyName}</option>
								[/#list]
							</select>
							</span>
						</div>
						
						<div class="text_group">
							<div class="attr_name">备注</div>
							<input class="attr_n_input" value="" name="userRemark" placeholder="备注"  />
						</div>
					</div>
				</div>
			</li>
		</ul>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="submitForm(this);return false;" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
	</div>

	</form>
</div>
<!--新增用户弹窗结束-->
<!--新增部门弹窗开始-->
<div class="popup_window5" id="pop_department" style="display:none;">
	<div class="wind_header">
		<h4>新增部门</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" action="${base}/admin/department/save.jhtml">
		<div class="text_group">
			<div class="attr_name">部门名称</div>
			<input class="attr_n_input attr_current" name="name"  value=""  placeholder="部门名称"  />
		</div>
		<div class="text_group">
			<div class="attr_name">部门描述</div>
			<textarea  class="attr_n_input" name="desc" cols="30" rows="3" placeholder="部门描述"></textarea>
		</div>
		<div class="hid">
			<input type='hidden' name='parentId' value='' >
			<input type='hidden' name='id' value='' >
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
<!--新增部门弹窗结束-->

<!--移动人员到开始-->
<div class="popup_window tree" id="pop_user_move">
	<div class="wind_header">
		<h4>请选择部门</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form>
	<div class="new_box">
		<div class="tree_box">
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="saveUserMulti();return false;" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
	</div>
	</form>
</div>
<!--移动人员到结束-->

<!--批量设置用户信息开始-->
<!--设置用户信息开始-->
<div class="popup_window2" id="_set_users">
	<form>
	<div class="wind_header">
		<h4>批量设置用户信息</h4>
		<i><a href="#" onclick="hideWindows();return false;" ><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<div class="new_box">
		<ul class="orgni_new_title_box">
			<li class="orgni_new_title on">基本权限
				<div class="popup_wind_cont_box current">
					<div class="popup_wind_cont ">
						<div class="text_group">
							<div class="attr_name">密码验证类型</div>
							<span class="radio_input"> <label class="danxuankuang_box selected"> 
									<input class="danxuankuang" type="radio" name="passwordCheckType" value="database" checked="true" />
									<i>数据库验证</i>
							</label> <label class="danxuankuang_box"> 
									<input class="danxuankuang" type="radio" name="passwordCheckType" value="domain" />
									<i>域验证</i>
							</label>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">密码</div>
							<input class="attr_n_input" name="password"  value="" placeholder="密码"/>
						</div>
						<div class="text_group">
							<div class="attr_name">确认密码</div>
							<input class="attr_n_input" name="rePassword" value="" placeholder="确认密码"/>
						</div>
						<div class="text_group">
							<div class="attr_name">允许密码修改</div>
							<span class="radio_input"> <label
								class="danxuankuang_box selected"> <input name="allowUserChangePwd" 
									class="danxuankuang" type="radio"  value="true" checked="true" />
									<i>允许</i>
							</label> <label class="danxuankuang_box"> <input name="allowUserChangePwd" 
									class="danxuankuang" type="radio" value="false" />
									<i>不允许</i>
							</label>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">客户端首次登录要求修改密码</div>
							<span class="radio_input"> <label
								class="danxuankuang_box selected"> <input name="firstLoginChangePwd" 
									class="danxuankuang" type="radio"  value="true" checked="true" />
									<i>是</i>
							</label> <label class="danxuankuang_box"> <input name="firstLoginChangePwd" 
									class="danxuankuang" type="radio" value="false" />
									<i>否</i>
							</label>
							</span>
						</div>
						<div class="text_group" >
							<div class="attr_name">是否禁用</div>
							<span class="radio_input"> <label
								class="danxuankuang_box selected"> <input name="isDisable" 
									class="danxuankuang" type="radio"  value="true" checked="true" />
									<i>是</i>
							</label> <label class="danxuankuang_box"> <input name="isDisable" 
									class="danxuankuang" type="radio" value="false" />
									<i>否</i>
							</label>
							</span>
						</div>
					</div>
				</div>
			</li>
			<li class="orgni_new_title">高级设置
				<div class="popup_wind_cont_box ">
					<div class="popup_wind_cont ">
						<div class="text_group">
							<div class="attr_name">所属安全域</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="belongDomain.id">
								[#list securityDomains as q]
									<option value="${q.id}">${q.securityName}</option>
								[/#list]
							</select>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">所属密级</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="belongSecurity.id">
								[#list levels as q]
									<option value="${q.id}">${q.securityName}</option>
								[/#list]
							</select>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">角色</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="role.id">
								[#list roles as q]
									<option value="${q.id}">${q.name}</option>
								[/#list]
							</select>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">安全策略设置</div>
							<span class="xialakuang_box"> <select class="xialakuang" name="securityPolicy.id" >
								[#list policys as q]
									<option value="${q.id}">${q.policyName}</option>
								[/#list]
							</select>
							</span>
						</div>
						<div class="text_group">
							<div class="attr_name">备注</div>
							<input class="attr_n_input" value="" name="userRemark" placeholder="备注"  />
						</div>
					</div>
				</div>
			</li>
		</ul>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
	</div>
	</form>
</div>
<!--设置用户信息结束-->

<!--批量设置用户-所属角色-->
<div class="popup_window5" id="pop_set_user_role" style="display:none;">
	<div class="wind_header">
		<h4>批量设置用户-所属角色</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" action="${base}/admin/department/set_user_role.jhtml">
		<div class="text_group">
			<div class="attr_name">所属角色</div>
			<span class="xialakuang_box"> <select class="xialakuang" name="roleId">
				[#list roles as q]
					<option value="${q.id}">${q.name}</option>
				[/#list]
			</select>
			</span>
		</div>
		<div class="col_xtsz_2" style="margin-left:110px;">
			<div style="height:38px;">
				<div class="right_lis_1">
					<label class="inline_middle" style="margin-right: 10px; float: left;">
						<div class="fuxuankuang_box on">
							<input type="checkbox" class="fuxuankuang" name="containStatus" value="1">
						</div>
					</label>
					<div class="rights_lis_s">包含子部门</div>
				</div>
			</div>
		</div>
		<div class="hid">
			<input type='hidden' name='departmentId' value='' >
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
<!--批量设置用户-密码校验方式-->
<div class="popup_window5" id="pop_set_user_password_checktype" style="display:none;">
	<div class="wind_header">
		<h4>批量设置用户-密码校验方式</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" action="${base}/admin/department/set_user_password_checktype.jhtml">
		<div class="text_group">
			<div class="attr_name">密码校验方式</div>
			<span class="radio_input"> <label class="danxuankuang_box selected"> 
					<input class="danxuankuang" type="radio" name="passwordCheckType" value="0" checked="true" />
					<i>系统验证</i>
			</label> <label class="danxuankuang_box"> 
					<input class="danxuankuang" type="radio" name="passwordCheckType" value="1" />
					<i>域验证</i>
			</label>
			</span>
		</div>
		<div class="text_group">
			<div class="attr_name">所属域</div>
			<span class="xialakuang_box"> <select class="xialakuang" name="domainId">
				[#list domains as q]
					<option value="${q.id}">
						[#list q.domainLoginAccount?split("@") as name][#if name_index == 1]${name}[/#if][/#list]
					</option>
				[/#list]
			</select>
			</span>
		</div>
		<div class="col_xtsz_2" style="margin-left:110px;">
			<div style="height:38px;">
				<div class="right_lis_1">
					<label class="inline_middle" style="margin-right: 10px; float: left;">
						<div class="fuxuankuang_box on">
							<input type="checkbox" class="fuxuankuang" name="containStatus" value="1">
						</div>
					</label>
					<div class="rights_lis_s">包含子部门</div>
				</div>
			</div>
		</div>
		<div class="hid">
			<input type='hidden' name='departmentId' value='' >
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
<!--批量设置用户-所属安全域-->
<div class="popup_window5" id="pop_set_user_domain" style="display:none;">
	<div class="wind_header">
		<h4>批量设置用户-所属安全域</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" action="${base}/admin/department/set_user_domain.jhtml">
		<div class="text_group">
			<div class="attr_name">安全域</div>
			<span class="xialakuang_box"> <select class="xialakuang" name="domainId">
				[#list securityDomains as q]
					<option value="${q.id}">${q.securityName}</option>
				[/#list]
			</select>
			</span>
		</div>
		
		<div class="col_xtsz_2" style="margin-left:110px;">
			<div style="height:38px;">
				<div class="right_lis_1">
					<label class="inline_middle" style="margin-right: 10px; float: left;">
						<div class="fuxuankuang_box on">
							<input type="checkbox" class="fuxuankuang" name="containStatus" value="1">
						</div>
					</label>
					<div class="rights_lis_s">包含子部门</div>
				</div>
			</div>
		</div>
		<div class="hid">
			<input type='hidden' name='departmentId' value='' >
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
<!--批量设置用户-所属密级-->
<div class="popup_window5" id="pop_set_user_level" style="display:none;">
	<div class="wind_header">
		<h4>批量设置用户-所属密级</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" action="${base}/admin/department/set_user_level.jhtml">
		<div class="text_group">
			<div class="attr_name">所属密级</div>
			<span class="xialakuang_box"> <select class="xialakuang" name="levelId">
				[#list levels as q]
					<option value="${q.id}">${q.securityName}</option>
				[/#list]
			</select>
			</span>
		</div>
		<div class="col_xtsz_2" style="margin-left:110px;">
			<div style="height:38px;">
				<div class="right_lis_1">
					<label class="inline_middle" style="margin-right: 10px; float: left;">
						<div class="fuxuankuang_box on">
							<input type="checkbox" class="fuxuankuang" name="containStatus" value="1">
						</div>
					</label>
					<div class="rights_lis_s">包含子部门</div>
				</div>
			</div>
		</div>
		<div class="hid">
			<input type='hidden' name='departmentId' value='' >
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
<!--批量设置用户-当前安全策略-->
<div class="popup_window5" id="pop_set_user_policy" style="display:none;">
	<div class="wind_header">
		<h4>批量设置用户-当前安全策略</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" action="${base}/admin/department/set_user_policy.jhtml">
		<div class="text_group">
			<div class="attr_name">安全策略</div>
			<span class="xialakuang_box"> <select class="xialakuang" name="policyId" >
				[#list policys as q]
					<option value="${q.id}">${q.policyName}</option>
				[/#list]
			</select>
			</span>
		</div>
		<div class="col_xtsz_2" style="margin-left:110px;">
			<div style="height:38px;">
				<div class="right_lis_1">
					<label class="inline_middle" style="margin-right: 10px; float: left;">
						<div class="fuxuankuang_box on">
							<input type="checkbox" class="fuxuankuang" name="containStatus" value="1">
						</div>
					</label>
					<div class="rights_lis_s">包含子部门</div>
				</div>
			</div>
		</div>
		<div class="hid">
			<input type='hidden' name='departmentId' value='' >
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>
<!--批量设置用户-用户禁用状态-->
<div class="popup_window5" id="pop_set_user_disable" style="display:none;">
	<div class="wind_header">
		<h4>批量设置用户-用户禁用状态</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" action="${base}/admin/department/set_user_disable.jhtml">
		<div class="text_group">
			<div class="attr_name">用户状态</div>
			<span class="radio_input"> <label class="danxuankuang_box "> 
					<input class="danxuankuang" type="radio" name="isDisable" value="0">
					<i>启用</i>
			</label> <label class="danxuankuang_box"> 
					<input class="danxuankuang" type="radio" name="isDisable" value="1">
					<i>禁用</i>
			</label>
			</span>
		</div>
		<div class="col_xtsz_2" style="margin-left:110px;">
			<div style="height:38px;">
				<div class="right_lis_1">
					<label class="inline_middle" style="margin-right: 10px; float: left;">
						<div class="fuxuankuang_box on">
							<input type="checkbox" class="fuxuankuang" name="containStatus" value="1">
						</div>
					</label>
					<div class="rights_lis_s">包含子部门</div>
				</div>
			</div>
		</div>
		<div class="hid">
			<input type='hidden' name='departmentId' value='' >
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitForm(this);return false" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
			<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
		</div>
	</form>
</div>


<!--设置成员开始-->
<div class="popup_window2 change_btn" id="pop_user_set" style="display: none;">
	<div class="wind_header">
		<h4>设置成员信息</h4>
		<i><a href="#" onclick="hideWindows();return false;" ><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<div class="new_box">
		<div class="member_box">
			<div class="left_member_box">
				<div class="member_title">未选中的</div>
				<div class="member_box_d">
					<ul class="member_ul">
					</ul>
				</div>
			</div>
			<div class="middle_member_box">
				<div class="member_btn" onclick="setUserAdd();return false;">
					<i><img src="${base}/resources/dsm/imgae/member_arrow_r.png" /></i>
				</div>
				<div class="member_btn" onclick="setUserRemove();return false;">
					<i><img src="${base}/resources/dsm/imgae/member_arrow_l.png" /></i>
				</div>
				<div class="member_btn" onclick="setUserRemoveAll();return false;">
					<i><img src="${base}/resources/dsm/imgae/member_arrow_ll.png" /></i>
				</div>
			</div>
			<div class="right_member_box">
				<div class="member_title">已选中的</div>
				<div class="member_box_d">
					<form>
					<input type="hidden" name="departmentId">
					<ul class="member_ul">
					</ul>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="setUserSubmit();return false;" class="btn_blue wind_save_button">${message("admin.dialog.ok")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.dialog.cancel")}</a>
	</div>
</div>
<!--设置成员结束-->
<!--小弹窗开始-->
<!--像alert一样的弹窗开始-->
<div class="popup_window3" id="alert_win" style="display:none;">
    <div class="wind_header">
        <i><a href="#" onclick="closeWin();return false;" ><img src="${base}/resources/dsm/imgae/closed_wind.png"/></a></i>
    </div>
    <p class="hints">
        您确定要删除吗？
    </p>
    <div class="btn_wind3">
        <a href="#" onclick="closeWin();return false;"  class="wind3_save_button blue ">是</a>
        <a href="#" onclick="closeWin();return false;"  class="wind3_cancel_button grey">否</a>
    </div>
</div>
<!--像alert一样的弹窗结束-->

<!--小弹窗结束-->


<script src="${base}/resources/dsm/js/window.js"></script>
<script>
//执行域导入
function executeADImport() {
	$.ajax({
		type : "post",
		url : "${base}/admin/ad_import/execute.jhtml",
		success : function(data) {
			//刷新zTree树的根节点
			var node = zTree.getNodeByParam("id",0);
		    zTree.reAsyncChildNodes(node, "refresh");
			confirmWin(data.content);
			refreshUserPageList();
		}
	});
}

//显示移动用户弹出框
function moveUsers(){
	if(noUserSelected()){//如果用户没有勾选
		return;
	};
	var $frm_ = $("#list_form");
	$frm_.attr("action", "${base}/admin/user/move.jhtml");
	$frm_.find("input:hidden[name='fromId']").val(departmentId);
	$frm_.find("input:hidden[name='toId']").val("");
	var departmentId1 = 0;
	//ztree设置
	var setting1 = {
		//设置是否允许同时选中多个节点，这里设为false
		view: {
			selectedMulti: false,
			fontCss : {"font-size":"60px","letter-spacing": "1px"}
		},
		//异步加载
		async: {
			enable: true,
			url:"${base}/admin/department/tree.jhtml",
			type:"get",
			autoParam: ["id"]
		},
		//回调函数
		callback: {
			onClick: zTreeOnClick1,
		},
	};
	
	//ztree 节点点击事件回调函数
	function zTreeOnClick1(event, treeId, treeNode){
		$frm_.find("input:hidden[name='toId']").val(treeNode.id);
	}
	$(".black").show();
	$("div#pop_user_move").show();
	if($("#treeDemo1").length === 0){
		$("div#pop_user_move div.tree_box").append( "<div class='columnbg64'></div>"+
												"<div class='stroke80'></div>"+
												"<div class='zTreeDemoBackground left'>"+
												"<ul id='treeDemo1' class='ztree'></ul></div>");
	}
	$.fn.zTree.init($("#treeDemo1"), setting1, zNodes);
	var zTree1 = $.fn.zTree.getZTreeObj("treeDemo1");
			var node = zTree1.getNodeByParam("id",0);
			zTree1.expandNode(node, true, false);
			zTree1.selectNode(node);
}
//显示复制用户弹出框
function copyUsers(){
	if(noUserSelected()){//如果用户没有勾选
		return;
	};
	var $frm_ = $("#list_form");
	$frm_.attr("action", "${base}/admin/user/copy.jhtml");
	//ztree设置
	var setting1 = {
		//设置是否允许同时选中多个节点，这里设为false
		view: {
			selectedMulti: false,
			fontCss : {"font-size":"60px","letter-spacing": "1px"}
		},
		//异步加载
		async: {
			enable: true,
			url:"${base}/admin/department/tree.jhtml",
			type:"get",
			autoParam: ["id"]
		},
		//回调函数
		callback: {
			onClick: zTreeOnClick1,
		},
	};
	
	//ztree 节点点击事件回调函数
	function zTreeOnClick1(event, treeId, treeNode){
		$frm_.find("input:hidden[name='toId']").val(treeNode.id);
	}
	$(".black").show();
	$("div#pop_user_move").show();
	if($("#treeDemo1").length === 0){
		$("div#pop_user_move div.tree_box").append( "<div class='columnbg64'></div>"+
												"<div class='stroke80'></div>"+
												"<div class='zTreeDemoBackground left'>"+
												"<ul id='treeDemo1' class='ztree'></ul></div>");
	}
	$.fn.zTree.init($("#treeDemo1"), setting1, zNodes);
	var zTree1 = $.fn.zTree.getZTreeObj("treeDemo1");
			var node = zTree1.getNodeByParam("id",0);
			zTree1.expandNode(node, true, false);
			zTree1.selectNode(node);
}
//移动/复制用户
function saveUserMulti(){
	hideWindows();
	var $frm = $("#list_form");
	$.ajax({
		type : "post",
		url : $frm.attr("action"),
		data : $frm.serialize(),
		dataType : "json",
		success : function(data) { 
			// 提示
			confirmWin(data.content); 
			showUsersByDepartmentId();
		}
	})
}
//检查用户是否勾选
function noUserSelected(){
	var ids_ = $("#list_form :checked[name='ids']");
	if(ids_.length === 0){
		confirmWin("请选择用户 !!")
		return true;
	}else{
		return false;
	}
}
//设置用户信息-多个
function setUsers(){
	if(noUserSelected()){//如果用户没有勾选
		return;
	};
	$(".black").show();
	var $win=$("#_set_users");
	$win.show();
	$win.find("li.orgni_new_title:first").click();
	$win.find("input[name='passwordCheckType']").focus();
	$win.find("form").attr("action", "${base}/admin/user/set_users.jhtml")[0].reset();
	$win.find("input[name='ids']").remove();
	var _ids = $("#list_form").find(":checked[name='ids']");
	$win.find("form").append(_ids.clone().attr("type", "hidden"));
	checkRadioStatus();
	checkCheckboxStatus();// 根据复选框状态改变样式
	//批量修改用户时，修改validator验证
	var $frm = $win.find("form");
	if($frm.valid()){//使用valid()方法对表单进行验证，基于jquery.validator.js
		$frm.find("li.orgni_new_title:first").click();
		$frm.find("li.orgni_new_title:first input:first").focus();
	}else{
		var $input = $frm.find("p.zhushi:first").parents(".text_group").find("input:first");
		$input.parents(".orgni_new_title").click();
		$input.focus();
	}
	checkRadioStatus();
	checkCheckboxStatus();
}
</script>