<!DOCTYPE html>
<html lang="ch">
<head>
<meta charset="UTF-8">
<title>修改角色表单</title>
[#include "/dsm/include/head.ftl"]

</head>
<body>
	<div class="dsm-rightside">
		<div class="maincontent">

			<div class="mainbox system-role-form">

				<div class="dsmForms">
				<form action="update.jhtml" >
					<div class="dsm-form-item">
						<div class="dsm-inline">
							<label class="dsm-form-label">角色名称：</label>
							<div class="dsm-input-block">
								<input type="hidden" name="id" value="${role.id}">
								<input type="text" autocomplete="off" placeholder="角色名称"
									class="dsm-input required specialChar" name="name" value="${role.name}">
								<div class="block-noempty">*</div>
							</div>
						</div>
						<div class="dsm-inline">
							<label class="dsm-form-label">角色描述：</label>
							<div class="dsm-input-block">
								<input type="text" autocomplete="off" placeholder="角色描述"
									class="dsm-input" name="description" value="${role.description}">
							</div>
						</div>
						<div class="dsm-inline">
							<label class="dsm-form-label">特殊权限：</label>
							<div class="dsm-input-block">
								<div class="dsmcheckbox">
									<input type="checkbox" id="sp11" name="status" value="1" 
									[#if role.status == 1] checked="true"[/#if]/>
									<label for="sp11"></label>
								</div> <label for="sp11">部门管理员权限</label>
							</div>
						</div>
						<div class="dsm-inline">
							<label class="dsm-form-label">可使用模块：</label>
							<div class="dsm-input-block">
								<div class="dsm-box clearfix">

									
									
									<div class="moduleitem">
										<div class="moduleall">
											<div class="dsmcheckbox">
												<input type="checkbox" value="1" id="z66"
													class="js_checkboxAll" data-allcheckfor="m3" name="">
												<label for="z66"></label>
											</div>
											<label for="z66">组织架构管理</label>
										</div>
										<div class="modules">
											<ul class="checkboxlist">
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z3" name="authorities" value="admin:organization:usermanager" 
														[#if role.authorities?seq_contains("admin:organization:usermanager")] checked="true"[/#if]/>
														<label for="z3"></label>
													</div> <label for="z3">部门与用户管理</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z4"  name="authorities" value="admin:organization:rolemanager" 
														[#if role.authorities?seq_contains("admin:organization:rolemanager")] checked="true"[/#if]/>
														<label for="z4"></label>
													</div> <label for="z4">系统角色管理</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z5"  name="authorities" value="admin:organization:groupmanager" 
														[#if role.authorities?seq_contains("admin:organization:groupmanager")] checked="true"[/#if]/>
														<label for="z5"></label>
													</div> <label for="z5">用户组管理</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z6"  name="authorities" value="admin:organization:domainmanager" 
														[#if role.authorities?seq_contains("admin:organization:domainmanager")] checked="true"[/#if]/>
														<label for="z6"></label>
													</div> <label for="z6">域同步管理</label>
												</li>

											</ul>
										</div>
									</div>
									<div class="moduleitem">
										<div class="moduleall">
											<div class="dsmcheckbox">
												<input type="checkbox" value="1" id="z67"
													class="js_checkboxAll" data-allcheckfor="m4" name="">
												<label for="z67"></label>
											</div>
											<label for="z67">安全策略中心</label>
										</div>
										<div class="modules">
											<ul class="checkboxlist">
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z31" name="authorities" value="admin:security:domain" 
														[#if role.authorities?seq_contains("admin:security:domain")] checked="true"[/#if]/>
														<label for="z31"></label>
													</div> <label for="z31">安全域管理</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z41" name="authorities" value="admin:security:level" 
														[#if role.authorities?seq_contains("admin:security:level")] checked="true"[/#if]/>
														<label for="z41"></label>
													</div> <label for="z41">密级管理</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z51" name="authorities" value="admin:security:policy" 
														[#if role.authorities?seq_contains("admin:security:policy")] checked="true"[/#if]/>
														<label for="z51"></label>
													</div> <label for="z51">安全策略管理</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z61" name="authorities" value="admin:security:intelligent" 
														[#if role.authorities?seq_contains("admin:security:intelligent")] checked="true"[/#if]/>
														<label for="z61"></label>
													</div> <label for="z61">智能加密策略管理</label>
												</li>
											</ul>
										</div>
									</div>
									<div class="moduleitem">
										<div class="moduleall">
											<div class="dsmcheckbox">
												<input type="checkbox" value="1" id="p543"
													class="js_checkboxAll" data-allcheckfor="m1" name="">
												<label for="p543"></label>
											</div>
											<label for="p543">终端管理</label>
										</div>
										<div class="modules">
											<ul class="checkboxlist">
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="p99" name="authorities" value="admin:teminal:list"  
														[#if role.authorities?seq_contains("admin:teminal:list")] checked="true"[/#if]/>
														<label for="p99"></label>
													</div> <label for="p99">终端列表</label>
												</li>

											</ul>
										</div>
									</div>
									<div class="moduleitem">
										<div class="moduleall">
											<div class="dsmcheckbox">
												<input type="checkbox" value="1" id="z70"
													class="js_checkboxAll" data-allcheckfor="m7" name="">
												<label for="z70"></label>
											</div>
											<label for="z70">日志管理</label>
										</div>
										<div class="modules">
											<ul class="checkboxlist">
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z181" name="authorities" value="admin:log:file" 
														[#if role.authorities?seq_contains("admin:log:file")] checked="true"[/#if]/>
														<label for="z181"></label>
													</div> <label for="z181">文件日志</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z151" name="authorities" value="admin:log:print" 
														[#if role.authorities?seq_contains("admin:log:print")] checked="true"[/#if]/>
														<label for="z151"></label>
													</div> <label for="z151">打印日志</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z141" name="authorities" value="admin:log:outside" 
														[#if role.authorities?seq_contains("admin:log:outside")] checked="true"[/#if]/>
														<label for="z141"></label>
													</div> <label for="z141">外发日志</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z171" name="authorities" value="admin:log:authfile" 
														[#if role.authorities?seq_contains("admin:log:authfile")] checked="true"[/#if]/>
														<label for="z171"></label>
													</div> <label for="z171">授权文件日志</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z161" name="authorities" value="admin:log:login" 
														[#if role.authorities?seq_contains("admin:log:login")] checked="true"[/#if]/>
														<label for="z161"></label>
													</div> <label for="z161">用户登录日志</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z191" name="authorities" value="admin:log:manage" 
														[#if role.authorities?seq_contains("admin:log:manage")] checked="true"[/#if]/>
														<label for="z191"></label>
													</div> <label for="z191">管理日志</label>
												</li>
											</ul>
										</div>
									</div>
									<div class="moduleitem">
										<div class="moduleall">
											<div class="dsmcheckbox">
												<input type="checkbox" value="1" id="z69"
													class="js_checkboxAll" data-allcheckfor="m6" name="">
												<label for="z69"></label>
											</div>
											<label for="z69">工作流审批</label>
										</div>
										<div class="modules">
											<ul class="checkboxlist">
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z33" name="authorities" value="admin:flow:myflow" 
														[#if role.authorities?seq_contains("admin:flow:myflow")] checked="true"[/#if]/>
														<label for="z33"></label>
													</div> <label for="z33">我的流程</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z43" name="authorities" value="admin:flow:model" 
														[#if role.authorities?seq_contains("admin:flow:model")] checked="true"[/#if]/>
														<label for="z43"></label>
													</div> <label for="z43">流程模板管理</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z53" name="authorities" value="admin:flow:monitor" 
														[#if role.authorities?seq_contains("admin:flow:monitor")] checked="true"[/#if]/>
														<label for="z53"></label>
													</div> <label for="z53">流程监控</label>
												</li>
											</ul>
										</div>
									</div>
									<div class="moduleitem">
										<div class="moduleall">
											<div class="dsmcheckbox">
												<input type="checkbox" value="1" id="p123"
													class="js_checkboxAll" data-allcheckfor="m2" name="">
												<label for="p123"></label>
											</div>
											<label for="p123">系统管理</label>
										</div>
										<div class="modules">
											<ul class="checkboxlist">
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="p1" name="authorities" value="admin:system:clientconnect" 
														[#if role.authorities?seq_contains("admin:system:clientconnect")] checked="true"[/#if]/>
														<label for="p1"></label>
													</div> <label for="p1">客户端连接设置</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="p2" name="authorities" value="admin:system:paramset" 
														[#if role.authorities?seq_contains("admin:system:paramset")] checked="true"[/#if]/>
														<label for="p2"></label>
													</div> <label for="p2">系统参数设置</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="p3" name="authorities" value="admin:system:customloginpage" 
														[#if role.authorities?seq_contains("admin:system:customloginpage")] checked="true"[/#if]/>
														<label for="p3"></label>
													</div> <label for="p3">自定义登录界面</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="p4" name="authorities" value="admin:system:authmanager" 
														[#if role.authorities?seq_contains("admin:system:authmanager")] checked="true"[/#if]/>
														<label for="p4"></label>
													</div> <label for="p4">授权管理</label>
												</li>

											</ul>
										</div>
									</div>
									<div class="moduleitem">
										<div class="moduleall">
											<div class="dsmcheckbox">
												<input type="checkbox" value="1" id="z68"
													class="js_checkboxAll" data-allcheckfor="m5" name="">
												<label for="z68"></label>
											</div>
											<label for="z68">终端更新管理</label>
										</div>
										<div class="modules">
											<ul class="checkboxlist">
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z32" name="authorities" value="admin:update:package" 
														[#if role.authorities?seq_contains("admin:update:package")] checked="true"[/#if]/>
														<label for="z32"></label>
													</div> <label for="z32">安装包管理</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z42" name="authorities" value="admin:update:record" 
														[#if role.authorities?seq_contains("admin:update:record")] checked="true"[/#if]/>
														<label for="z42"></label>
													</div> <label for="z42">更新操作记录</label>
												</li>
											</ul>
										</div>
									</div>
									<div class="moduleitem">
										<div class="moduleall">
											<div class="dsmcheckbox">
												<input type="checkbox" value="1" id="z696"
													class="js_checkboxAll" data-allcheckfor="m8" name="">
												<label for="z696"></label>
											</div>
											<label for="z696">配置管理</label>
										</div>
										<div class="modules">
											<ul class="checkboxlist">
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z3231" name="authorities" value="admin:config:program_control" 
														[#if role.authorities?seq_contains("admin:config:program_control")] checked="true"[/#if]/>
														<label for="z3231"></label>
													</div> <label for="z3231">程序控制管理</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z3231" name="authorities" value="admin:config:program_type" 
														[#if role.authorities?seq_contains("admin:config:program_type")] checked="true"[/#if]/>
														<label for="z3231"></label>
													</div> <label for="z3231">应用程序分类</label>
												</li>
												<li class="clearfix">
													<div class="dsmcheckbox">
														<input type="checkbox" id="z3231" name="authorities" value="admin:config:user_config" 
														[#if role.authorities?seq_contains("admin:config:user_config")] checked="true"[/#if]/>
														<label for="z3231"></label>
													</div> <label for="z3231">配置管理</label>
												</li>
											</ul>
										</div>
									</div>

								</div>
							</div>
						</div>


					</div>
					<div class="form-btns t-l">
						<button type="button" class="btn btn-lg btn-primary js_add">确定修改</button>
						<a href="list.jhtml" class="btn btn-lg btn-primary">取消</a>
					</div>
				</div>
			</div>
		</form>
		</div>
	</div>
	<script type="text/javascript">
	
		/*全选*/
		$(document).on("click", ".js_checkboxAll", function(){
			$(this).parents('.moduleitem').find(':checkbox').prop('checked',this.checked);
	    });
    	//确定修改
        $(document).on('click', '.js_add', function (e) {
        	var btn = $(this);
        	var frm = $("form");
        	if(frm.valid()){
        		btn.addClass("disabled");
	        	submitForm({
	        		frm: frm,
	        		success: function(){
	        			setTimeout("window.location.href='list.jhtml'",1500)
	        		},
	        		error: function(){
	        			btn.removeClass("disabled");
	        		}
	        	})
        	} else {
        		$(".error").prev().focus();
        	}

        });
		$(function(){
			$("form:first").validate({
				rules: {
					"name": {
						required: true,
						maxlength: 32,
						specialChar: true,
					},
					"description": {
						maxlength: 256
					},
				}
			});
		});
    </script>
</body>
</html>
