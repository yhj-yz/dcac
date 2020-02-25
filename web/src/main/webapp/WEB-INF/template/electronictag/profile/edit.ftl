<!DOCTYPE html>
<html lang="ch">
<head>
<meta charset="UTF-8">
<title>我的账号</title>

[#include "/dsm/include/head.ftl"]
<script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
<link href="${base}/resources/dsm/css/zTreeStyle.css" rel="stylesheet" />
<script type="text/javascript" src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript" src="${base}/resources/dsm/js/ztree.helper.js"></script>
<script src="${base}/resources/dsm/js/watermark.js"></script>
</head>
<body>
	<div class="dsm-rightside">
		<div class="maincontent">

			<div class="mainbox">
				<div class="dsm-nav-tabs">
					<ul class="nav nav-tabs" role="tablist">
						<li class="active"><a href="#basicinfo" data-toggle="tab"
							aria-expanded="true">基本信息</a></li>
						<li class=""><a href="#powerpolicy" data-toggle="tab"
							aria-expanded="false">个人安全策略</a></li>
						<li class=""><a href="#infoset" data-toggle="tab"
							aria-expanded="false">个人设置</a></li>
						<li class=""><a href="#linkmans" data-toggle="tab"
							aria-expanded="false">联系人设置 <i
								class="icon icon-navset dropdown-toggle dsmdropdown-toggle"></i></a>
							<div class="dropdown-div dsmnav-tab">
								<div class="dropheader">
									<div class="js_addcontract opitem">新增</div>
									<div class="js_delcontract opitem">删除选中</div>
								</div>
							</div></li>
					</ul>
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane fade active in"
							id="basicinfo">
							<div class="basicinfobox ">
								<div class="loginuserForms">
									<div class="dsm-form-item">
										<div class="dsm-block">
											<label class="dsm-form-label">姓名：</label>
											<div class="dsm-input-block">
												<label class="dsm-label">${user.name}</label>
											</div>
										</div>
										<div class="dsm-block">
											<label class="dsm-form-label">用户名：</label>
											<div class="dsm-input-block">
												<label class="dsm-label">${user.account}</label>
											</div>
										</div>
										<div class="dsm-block">
											<label class="dsm-form-label">所属部门：</label>
											<div class="dsm-input-block">
					                        	<table class="table" cellspacing="0" width="100%">
											        <thead>
											            <tr>
											                <th>序号</th>
											                <th>部门</th>
											            </tr>
											        </thead>
											        <tbody>
											            [#list depts as q]
											            <tr>
											                <td>${q_index + 1}</td>
											                <td>${q}</td>
											            </tr>
														[/#list]
											        </tbody>
											    </table>
						                    </div>
										</div>
										<div class="dsm-block">
											<label class="dsm-form-label">所属域：</label>
											<div class="dsm-input-block">
												<label class="dsm-label">${domain}</label>
											</div>
										</div>
										<div class="dsm-block">
											<label class="dsm-form-label">所属安全域：</label>
											<div class="dsm-input-block">
												<label class="dsm-label">${user.belongDomain.securityName}</label>
											</div>
										</div>
										<div class="dsm-block">
											<label class="dsm-form-label">所属密级：</label>
											<div class="dsm-input-block">
												<label class="dsm-label">${user.belongSecurity.securityName}</label>
											</div>
										</div>
										<div class="dsm-block">
											<label class="dsm-form-label">所属角色：</label>
											<div class="dsm-input-block">
												<label class="dsm-label">${user.role.name}</label>
											</div>
										</div>
										<div class="dsm-block">
											<label class="dsm-form-label">所属用户组：</label>
											<div class="dsm-input-block">
												<label class="dsm-label">${group}</label>
											</div>
										</div>
										<div class="dsm-block">
											<label class="dsm-form-label">故障离网时间：</label>
											<div class="dsm-input-block">
												<label class="dsm-label">${policy.offlineTime} 分钟</label>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="powerpolicy">
							<div class="basicinfobox">
								<div class="panel-group powerpanelbox" id="powerpanel">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#powerpanel"
													href="#basic-info"> 基本信息 </a>
											</h4>
										</div>
										<div id="basic-info" class="panel-collapse collapse in">
											<div class="panel-body">
												<div class="dsm-panel-box">
													<div class="dsm-form-item">
														<div class="dsm-block">
															<label class="dsm-form-label">策略名称：</label>
															<div class="dsm-input-block">
																<label class="dsm-label">${policy.policyName}</label>
															</div>
														</div>
														<div class="dsm-block">
															<label class="dsm-form-label">策略描述：</label>
															<div class="dsm-input-block">
																<label class="dsm-label">${policy.policyDesc}</label>
															</div>
														</div>

													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#powerpanel"
													href="#user-power"> 用户权限 </a>
											</h4>
										</div>
										<div id="user-power" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="dsm-panel-box">
													<ul class="checkboxlist">
														<li class="clearfix" data-ck="${policyMap.POLICY_AUTH_4}">
															<i class="icon icon-key"></i><label for="p1">允许截屏</label>
														</li>
														<li class="clearfix" data-ck="${policyMap.POLICY_AUTH_5}">
															<i class="icon icon-key"></i><label for="p1">允许OLE嵌入</label>
														</li>
														<li class="clearfix" data-ck="${policyMap.POLICY_AUTH_7}">
															<i class="icon icon-key"></i><label for="p1">工作模式切换</label>
														</li>
														<li class="clearfix" data-ck="${policyMap.POLICY_AUTH_8}">
															<i class="icon icon-key"></i><label for="p1">程序禁用例外</label>
														</li>
														<li class="clearfix" data-ck="${policyMap.POLICY_AUTH_10}">
															<i class="icon icon-key"></i><label for="p1">允许删除密文</label>
														</li>
														[#if policy.allowIntelligentTeminalLogin == 1]
														<li class="clearfix">
															<i class="icon icon-key"></i><label for="p1">允许智能终端登陆</label>
														</li>
														[/#if]
														[#list userConfig as uc]
															[#if uc.scope == 0 && policy.userConfigs?seq_contains(uc.indexName)]
															<li class="clearfix" >
																<i class="icon icon-key"></i><label for="p1">${uc.textCh}</label>
															</li>
															[/#if]
														[/#list]
													</ul>
												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#powerpanel"
													href="#controlpolicy"> 受控程序策略 </a>
											</h4>
										</div>
										<div id="controlpolicy" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="poliycontrol">
													<ul class="nav nav-tabs" role="tablist">
														<li role="presentation" class="active"><a
															href="#startpolicy" id="startpolicy-tab" data-toggle="tab">启动加密策略</a></li>
														<li role="presentation" class=""><a href="#stoppolicy"
															id="stoppolicy-tab" data-toggle="tab" aria-expanded="false">停止加密策略</a></li>
									
													</ul>
													<div class="tab-content">
														<div role="tabpanel" class="tab-pane fade active in" id="startpolicy" aria-labelledby="startpolicy-tab">
															<div id="openPolicy" class="datachosebox clearfix">
															<div class="dsm-panel-box">
																<ul class="checkboxlist">
																	[#list policy.policyControlManagerLinks as p]
																		[#if p.workModel == 0]
																		<li class="clearfix"><i class="icon icon-safepolicy"></i>
																			<label for="p1">${p.control.name}</label></li>
																		[/#if]
																	[/#list]
																</ul>
															</div>
															</div>
														</div>
														<div role="tabpanel" class="tab-pane fade  in" id="stoppolicy" aria-labelledby="startpolicy-tab">
															<div id="closedPolicy" class="datachosebox clearfix">
															<div class="dsm-panel-box">
																<ul class="checkboxlist">
																	[#list policy.policyControlManagerLinks as p]
																		[#if p.workModel == 1]
																		<li class="clearfix"><i class="icon icon-safepolicy"></i>
																			<label for="p1">${p.control.name}</label></li>
																		[/#if]
																	[/#list]
																</ul>
															</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#powerpanel"
													href="#safe-policy"> 安全域权限 </a>
											</h4>
										</div>
										<div id="safe-policy" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="dsm-panel-box">
													<table class="table" cellspacing="0" width="100%">
														<thead>
															<tr>
																<th><label for="w1">安全域权限</label></th>
																<th><label for="w2">打开权限</label></th>
																<th><label for="w3">打印权限</label></th>
																<th><label for="w4">解密权限</label></th>
																<th><label for="w5">调整权限</label></th>
															</tr>
														</thead>
														<tbody>
															[#list policy.policySecurityDomainLinks as p]
															<tr>
																<td><label for="w6">研发安全域</label></td>
																<td>
																	<div class="isHave">
																		<i class="icon icon-redclose" data-ck="${policyMap.POLICY_AUTH_26}" data-id="${p.authorityInfo}"></i>
																	</div>
																</td>
																<td>
																	<div class="isHave">
																		<i class="icon icon-redclose" data-ck="${policyMap.POLICY_AUTH_0}" data-id="${p.authorityInfo}"></i>
																	</div>
																</td>
																<td>
																	<div class="isHave">
																		<i class="icon icon-redclose" data-ck="${policyMap.POLICY_AUTH_3}" data-id="${p.authorityInfo}"></i>
																	</div>
																</td>
																<td>
																	<div class="isHave">
																		<i class="icon icon-redclose" data-ck="${policyMap.POLICY_AUTH_28}" data-id="${p.authorityInfo}"></i>
																	</div>
																</td>
															</tr>
															[/#list]
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#powerpanel"
													href="#content-copy"> 内容复制控制 </a>
											</h4>
										</div>
										<div id="content-copy" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="dsm-panel-box">
													<div class="dsm-form-item">
														<div class="dsm-block">
															<label class="dsm-form-label">允许内容复制：</label>
															<div class="dsm-input-block">
																<label class="dsm-label" id="allow_content_copy">否</label>
															</div>
														</div>
														<div class="dsm-block">
															<label class="dsm-form-label">限制文字数：</label>
															<div class="dsm-input-block">
																<label class="dsm-label">${policy.limitCount}</label>
															</div>
														</div>

													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#powerpanel"
													href="#print-waterset"> 打印水印设置 </a>
											</h4>
										</div>
										<div id="print-waterset" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="dsm-panel-box printwaterpanel">
													<div class="dsmForms">
														<div class="dsm-form-item">
															<div class="dsm-inline">
																<label class="dsm-form-label" for="wfs4">上传打印日志：</label>

																<div class="dsm-input-inline">
																	<div class="dsmcheckbox  m-t-10p disabled">
																		<input type="checkbox" value="1"[#if policy.printManagerAuth == 1] checked="true"[/#if]disabled id="wfs44"> 
																		<label for="wfs44"></label>
																	</div>
																</div>
																<label class="dsm-form-label" for="wfd4">上传打印快照：</label>
																<div class="dsm-input-inline">
																	<div class="dsmcheckbox m-t-10p disabled">
																		<input type="checkbox" disabled id="wfd423" data-name="policy.userAuthority" value="${policyMap.POLICY_AUTH_21}"> 
																		<label for="wfd423"></label>
																	</div>
																</div>
															</div>
														</div>
														<div class="dsm-form-item">
															<label class="dsm-form-label">打印机白名单：</label>
															<div class="dsm-input-block">
																<div class="dsm-box m-l-55p">
																	<table class="table" cellspacing="0" width="100%">
																		<thead>
																			<tr>
																				<th>打印机型号</th>

																			</tr>
																		</thead>
																		<tbody>
																			[#list policy.printerWhiteList as p]
																			<tr>
																				<td>${p.printerModel}</td>
																			</tr>
																			[/#list]
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
														<div class="dsm-form-item">
															<label class="dsm-form-label">显示打印水印：</label>
															<div class="dsm-input-block">
																<div class="dsmcheckbox m-t-10p disabled">
																	<input type="checkbox" value="1" 
																	[#list policy.watermarks as w][#if w.wmFlag==2&&w.isDisplay==1] checked="true"[/#if][/#list]
																	data-name="printWatermark.isDisplay" id="p133" >
																	<label for="p133"></label>
																</div>
																<div class="dsm-box">
																	<div class="printwatershow" id="water-preview"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#powerpanel"
													href="#float-waterset"> 屏幕浮水印设置 </a>
											</h4>
										</div>
										<div id="float-waterset" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="dsm-panel-box">
													<div class="dsmForms">
														<div class="dsm-form-item">
															<label class="dsm-form-label">显示屏幕浮水印：</label>
															<div class="dsm-input-block">
																<div class="dsmcheckbox m-t-10p disabled">
																	<input type="checkbox" value="1"[#list policy.watermarks as w]
																		[#if w.wmFlag==1&&w.isDisplay==1] checked="true"[/#if][/#list]
																		disabled="true" data-name="printWatermark.isDisplay" id="s410" >
																	<label for="s410"></label>
																</div>
																<div class="dsm-box">
																	<div class="printwatershow" id="print-preview"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default file-outside-info">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#powerpanel"
													href="#file-outside-info"> 文件外发控制 </a>
											</h4>
										</div>
										<div id="file-outside-info" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="dsm-panel-box">
													<div class="dsm-form-item">
														<div class="dsm-inline">
															<label class="dsm-form-label">允许外发算号：</label>
															<div class="dsmcheckbox m-t-10p disabled">
																<input type="checkbox" disabled id="cu1" data-name="policy.userAuthority" value="${policyMap.POLICY_AUTH_25}"> 
																<label for="cu1"></label>
															</div>
														</div>
														<div class="dsm-inline">
															<label class="dsm-form-label">允许外发打印：</label>
															<div class="dsmcheckbox m-t-10p disabled">
																<input type="checkbox" disabled id="cu12" data-name="policy.userAuthority" value="${policyMap.POLICY_AUTH_27}"> 
																	<label for="cu12"></label>
															</div>
														</div>
														<div class="dsm-block">
															<label class="dsm-form-label">限制外发打开次数：</label>
															<div class="dsm-input-block">
																<label class="dsm-label">${policy.outsideControl.openCount}</label>
															</div>
														</div>
														<div class="dsm-block">
															<label class="dsm-form-label">限制外发打开天数：</label>
															<div class="dsm-input-block">
																<label class="dsm-label">${policy.outsideControl.openDayCount}</label>
															</div>
														</div>
														<div class="dsm-block">
															<label class="dsm-form-label">可外发安全域文件：</label>
															<div class="dsm-input-block">
																<label class="dsm-label">
																[#list policy.outsideControl.domainManagers as p]${p.securityName} [/#list]
																</label>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#powerpanel"
													href="#offline-info"> 用户离网策略 </a>
											</h4>
										</div>
										<div id="offline-info" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="dsm-panel-box">
													<div class="dsm-form-item">

														<div class="dsm-block">
															<label class="dsm-form-label">故障离网时长：</label>
															<div class="dsm-input-block">
																<label class="dsm-label">${policy.offlineTime} 分钟</label>
															</div>
														</div>
														<div class="dsm-inline">
															<label class="dsm-form-label" for="wfs4">允许主动离网：</label>
										
															<div class="dsm-input-inline">
																<div class="dsmcheckbox enablecopy">
																	<input type="checkbox" value="1" id="zdwfs4" [#if policy.allowUserOfflineInitiative==1] checked="true"[/#if]
																		data-name="policy.allowUserOfflineInitiative" disabled> 
																	<label for="zdwfs4"></label>
																</div>
															</div>
														</div>
														<div class="dsm-inline [#if policy.allowUserOfflineInitiative==0] hidden[/#if]">
															<label class="dsm-form-label">主动离网时长：</label>
															<div class="dsm-input-block">
																<label class="dsm-label">${policy.offlineTimeInitiative} 小时</label>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div role="tabpanel" class="tab-pane fade" id="infoset">
							<div class="basicinfobox border-bottom">
								<div class="basictitle">修改密码</div>
								<div class="dsmForms">
								<form method="post" action="change_password.jhtml" id="password_form">
									<div class="dsm-form-item">
										<div class="dsm-inline">
											<label class="dsm-form-label">原始密码：</label>
											<div class="dsm-input-inline">
												<input type="password" autocomplete="off" placeholder="原始密码"
													class="dsm-input required" name="currentPassword"[#if user.allowUserChangePwd==0] disabled="true"[/#if]>
											</div>
										</div>
										<div class="dsm-inline">
											<label class="dsm-form-label">新密码：</label>
											<div class="dsm-input-inline">
												<input type="password" autocomplete="off" placeholder="新密码"
													class="dsm-input required" name="password"[#if user.allowUserChangePwd==0] disabled="true"[/#if]>
											</div>
										</div>
										<div class="dsm-inline">
											<label class="dsm-form-label">确认密码：</label>
											<div class="dsm-input-inline">
												<input type="password" autocomplete="off" placeholder="确认密码"
													class="dsm-input required" name="rePassword"[#if user.allowUserChangePwd==0] disabled="true"[/#if]>
											</div>
										</div>

										<div class="form-btns t-l">
											<button type="button"
												class="btn btn-lg btn-primary js_editPwd"[#if user.allowUserChangePwd==0] disabled="true"[/#if]>修改</button>
										</div>
									</div>
								</form>
								</div>
							</div>
							<div class="basicinfobox border-bottom">
								<div class="basictitle">邮箱设置</div>
								<div class="dsmForms">
								<form method="post" action="change_email.jhtml" id="email_form">
									<div class="dsm-form-item">
										<div class="dsm-inline">
											<label class="dsm-form-label">邮箱地址：</label>
											<div class="dsm-input-inline">
												<input type="text" autocomplete="off" placeholder="邮箱地址"
													class="dsm-input " name="emailAddress" value="${user.emailAddress}">
											</div>
										</div>
										<div class="dsm-inline">
											<label class="dsm-form-label">邮箱登录名：</label>
											<div class="dsm-input-inline">
												<input type="text" autocomplete="off" placeholder="邮箱登录名"
													class="dsm-input " name="emailLoginName" value="${user.emailLoginName}">
											</div>
										</div>
										<div class="dsm-inline">
											<label class="dsm-form-label">邮箱密码：</label>
											<div class="dsm-input-inline">
												<input type="password" autocomplete="off" placeholder="邮箱密码"
													class="dsm-input " name="emailPassword" value="">
											</div>
										</div>
										<div class="dsm-inline">
											<label class="dsm-form-label">SMTP服务器：</label>
											<div class="dsm-input-inline">
												<input type="text" autocomplete="off" name="emailSmtp" value="${user.emailSmtp}"
													placeholder="SMTP服务器地址" class="dsm-input">
											</div>
										</div>
										<div class="dsm-inline">
											<label class="dsm-form-label">SSL加密连接：</label>
											<div class="dsm-input-inline">
												<div class="dsmcheckbox m-t-10p">
													<input type="checkbox" value="1" id="ctf4" name="emailUseSsl"[#if user.emailUseSsl == 1] checked="true" [/#if]>
													<label for="ctf4"></label>
												</div>
											</div>
										</div>
										<div class="form-btns t-l">
											<button type="button"
												class="btn btn-lg btn-primary js_setEmail">设置</button>
										</div>
									</div>
									</form>
								</div>
							</div>
							<div class="basicinfobox">
								<div class="basictitle">代理审批人设置</div>
								<div class="dsmForms">
								<form method="post" action="change_proxy.jhtml" id="proxy_form">
									<div class="dsm-form-item">
										<div class="dsm-inline">
											<label class="dsm-form-label">启用代理审批：</label>
											<div class="dsm-input-inline">
												<div class="dsmcheckbox m-t-10p">
													<input type="checkbox" value="1" id="ctf41" name="useProxy"[#if user.useProxy == 1] checked="true" [/#if]>
													<label for="ctf41"></label>
												</div>
											</div>
										</div>
										
										<div class="dsm-inline">
											<label class="dsm-form-label">选择代理审批人：</label>
											<div class="dsm-input-inline">
												<table class="table" cellspacing="0" width="100%">
												<thead>
													<tr>
								            			<td>
															<span id="to_dept_name">${user.proxyName!"-"}<input type="hidden" name="proxyName" value="${user.proxyName!}"><span>
														</td>
										            </tr>
								            		<tr>
								            			<td>
															<div class="treedata">
																<ul id="dsmOrgTree" class="ztree"></ul>
															</div>
														</td>
													</tr>
										        </thead>
												</table>
											</div>
										</div>
										<div class="form-btns t-l">
											<button type="button"
												class="btn btn-lg btn-primary js_setAng">设置</button>
										</div>
									</div>
									</form>
								</div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="linkmans">
							<div class="basicinfobox ">
								<form id="list_form" >
								<table class="table" cellspacing="0" width="100%">
									<thead>
										<tr>
											<th>
												<div class="dsmcheckbox">
													<input type="checkbox" value="1" id="ct"
														class="js_checkboxAll" data-allcheckfor="ids" >
													<label for="ct"></label>
												</div>
											</th>
											<th>姓名</th>
											<th></th>
											<th>邮箱</th>
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
								</form>
							    <form id="search_form" action="${base}/admin/contact/search.jhtml" data-func-name="refreshPage();" data-list-formid="list_form">
									<input type="hidden" name="name" >
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	
	<div class=" add-Flow-step-form" id="contact" style="display:none;">
		<div class="dsmForms">
		<form  id="contact_form">
		<input type="hidden" name="id">
			<div class="dsm-form-item">
				<div class="dsm-inline">
					<label class="dsm-form-label">联系人姓名：</label>
					<div class="dsm-input-block">
						<input type="text" autocomplete="off" placeholder="联系人姓名"
							class="dsm-input" name="contactName">
					</div>
				</div>
				<div class="dsm-inline">
					<label class="dsm-form-label">联系人邮箱：</label>
					<div class="dsm-input-block">
						<input type="text" autocomplete="off" placeholder="联系人邮箱"
							class="dsm-input" name="contactEmail">
					</div>
				</div>
			</div>
		</form>
		</div>
	</div>
	<script type="text/javascript">
		//刷新分页列表
		function refreshPage(){
			refreshPageList({id :"search_form",
				pageSize:10,
				dataFormat :function(_data){
					var rName = _data.policyDesc?_data.policyDesc:"";
					var _id = _data.id;
					var _text = '<tr>\
									<td>\
										<div class="dsmcheckbox">\
											<input type="checkbox" value="'+_data.id+'" id="tt'+_data.id+'" name="ids">\
											<label for="tt'+_data.id+'"></label>\
										</div>\
									</td>\
									<td>'+_data.contactName+'</td>\
									<td>\
										<span class="listdetail bg-green js_showdedit" data-id="'+_data.id+'" data-name="'+_data.contactName+'" data-email="'+_data.contactEmail+'"> <i class="icon icon-pen"></i></span>\
										<span class="listdetail bg-yellow js_del"><i class="icon icon-delete"></i></span>\
									</td>\
									<td>'+_data.contactEmail+'</td>\
								</tr>';
					return _text;
				}});
			
		}
	    $(document).ready(function () {
			$('#basic-info').collapse('show');
			$('#user-power').collapse('show');
			$('#controlpolicy').collapse('show');
			$('#safe-policy').collapse('show');
			$('#content-copy').collapse('show');
			$('#print-waterset').collapse('show');
			$('#float-waterset').collapse('show');
			$('#file-outside-info').collapse('show');
			$('#offline-info').collapse('show');

			//修改
			$(document).on('click', '.js_editPwd', function (e) {
            	var frm = $(this).parents("form:first");
				if(frm.valid()){
					submitForm({
						frm:frm,
					})
            	}
            });
            //设置
			$(document).on('click', '.js_setEmail', function (e) {
				var frm = $(this).parents("form:first");
				if(frm.valid()){
					submitForm({
						frm:frm,
					})
            	}
            });
            //设置
			$(document).on('click', '.js_setAng', function (e) {
            	var frm = $(this).parents("form:first");
				submitForm({
					frm:frm,
				})
            });

            //删除选中
			$(document).on('click', '.js_delcontract', function (e) {
				if(noItemSelected()){//如果没有勾选
					return;
				};
	            dsmDialog.toComfirm("是否删除联系人？", {
					btn: ['确定','取消'],
					title:"删除联系人"
				}, function(index){
					var $frm = $("#list_form");
					$.ajax({
						dataType:"json",
						type: "post",
						url: "${base}/admin/contact/delete.jhtml",
						data: $frm.serialize(),
						success: function(data){
							dsmDialog.msg(data.content);
							refreshPage();
						}
					});
				}, function(index){						
					dsmDialog.close(index);
				});

	        });

	        //新增联系人
	        $(document).on('click', '.js_addcontract', function (e) {
	        	var frm = $("#contact form:first").attr("action","${base}/admin/contact/save.jhtml");
	        	frm.valid()
	        	frm.find("input[name='id']").val("");
	        	frm.find("input[name='contactEmail']").val("").removeData("previousValue");
	        	frm.find("input[name='contactName']").val("");
		        dsmDialog.open({
					type: 1,
					area:['700px','350px'],
					btn:['确定','取消'],
					title:"新增联系人",
		            content : $("#contact"),
		            yes: function(index, layero){
		            	if(frm.valid()){
			            	submitForm({
			            		frm:frm,
			            		success:function(){
								    dsmDialog.close(index);
								    refreshPage();
			            		}
			            	})
		            	}
				  	}
	    		});

	        });
	        //删除当前联系人
			$(document).on('click', '.js_del', function (e) {
				var sp = $(this).parents("tr:first");
	            dsmDialog.toComfirm("是否删除联系人？", {
					btn: ['确定','取消'],
					title:"删除联系人"
				}, function(index){
					var value = sp.find("input[name='ids']").val();
					//删除操作代码
					$.ajax({
						dataType:"json",
						type: "post",
						url: "${base}/admin/contact/delete.jhtml",
						data: {ids:value},
						success: function(data){
							dsmDialog.msg(data.content);
							refreshPage();
						}
					});
				}, function(index){						
					dsmDialog.close(index);
				});

	        });
	        //修改联系人
	        $(document).on('click', '.js_showdedit', function (e) {
	        	var frm = $("#contact form:first").attr("action","${base}/admin/contact/update.jhtml");
	        	frm.find("input[name='contactEmail']").val($(this).data("email")).removeData("previousValue");
	        	frm.find("input[name='contactName']").val($(this).data("name"));
	        	frm.find("input[name='id']").val($(this).data("id"));
	        	frm.valid();
	        	dsmDialog.open({
					type: 1,
					area:['700px','350px'],
					btn:['确定','取消'],
					title:"修改联系人",
		            content : $("#contact"),
		            yes: function(index, layero){
		            	if(frm.valid()){
			            	submitForm({
			            		frm:frm,
			            		success:function(){
								    dsmDialog.close(index);
								    refreshPage();
			            		}
			            	})
		            	} 
				  	}
	    		});

	        });
	        //安全域权限勾选
	        $(".isHave i").each(function(){
	        	if(($(this).data("id")&$(this).data("ck")) !== 0){
	        		$(this).addClass("active");
	        	}
	        });
	        //内容复制
	        if(!checkNum(${policy.contentCopy},1)){
	        	$("#allow_content_copy").text("是");
	        }else{
	        	$("#allow_content_copy").text("否");
	        }
	        //用戶权限勾选
	        $("#user-power li[data-ck]").each(function(){
	        	var sp = $(this);
	        	if(!checkNum(${policy.userAuthority},sp.data("ck"))){
	        		sp.remove();
	        	}
	        });
	        checkAuthsByDataName("#powerpanel", "policy.userAuthority", "${policy.userAuthority}");
	        refreshPage();
	         //检查是否勾选
			function noItemSelected(){
				var ids_ = $("#list_form :checked[name='ids']");
				if(ids_.length === 0){
					dsmDialog.error("请先选择联系人!")
					return true;
				}else{
					return false;
				}
			}
			
			var passwordForm = $("#password_form").validate({
				rules: {
					"currentPassword": {
						required: true,
						maxlength: 32,
					},
					"password": {
						required: true,
						
						[#if pwdCheck == 1]
						pattern: /(?=.*?[a-zA-Z]+.*?)(?=.*?[1-9]+.*?)(?=.*?[~!@#$%^&*]+.*?).*/,
						rangelength:[8,32],
						[#else]
						maxlength: 32,
						[/#if]
						
					},
					"rePassword": {
						equalTo: "[name='password']",
					},
				},
				[#if pwdCheck == 1]
				messages: {
					"password": {
						pattern:"*密码强度不足，密码至少8位且必须包含字母、数字、特殊字符"
					}
				}
				[/#if]
			});
			
			var emailForm = $("#email_form").validate({
				rules: {
					"emailAddress": {
						required: true,
						rangelength:[1,64],
						email:true,
					},
					"emailLoginName": {
						required: true,
						rangelength:[1,32],
						specialChar:true,
					},
					"emailPassword": {
						required: true,
						rangelength:[1,32],
					},
					"emailSmtp": {
						required: true,
						rangelength:[1,32],
					},
				}
			});
			var contactForm = $("#contact form:first").validate({
				rules: {
					"contactName": {
						required: true,
						rangelength:[1,32],
					},
					"contactEmail": {
						required: true,
						rangelength:[1,64],
						email:true,
						remote: {
							url: "${base}/admin/contact/check_name.jhtml",
							data:{id: function(){return $("#contact input[name='id']").val();}},
							cache: false
						}
					},
				}
			});
			
			zTreeInit({
				id:'dsmOrgTree',
				url: '${base}/admin/department/tree_user.jhtml',
				zTreeOnClick : function(event, treeId, treeNode){//ztree 节点点击事件回调函数
					if(treeNode.id<0){
						var name = treeNode.name.substring(treeNode.name.indexOf("[") + 1,treeNode.name.indexOf("]"));
						var str = '<input type="hidden" name="proxyName" value='+name+'>';
						$("#to_dept_name").html(name + str);
					}
				},
			});
        });
        function checkNum(num1,num2){
        	return (num1&num2)===num2;
        }
        //检查input的勾选状态
		function checkAuthsByDataName(containerId, name, value){
			var container = $(containerId);
			container.find("input[data-name='"+name+"']").each(function(){
				$(this).prop("checked", ((value & this.value) !== 0));
			});
		}
		
		var waterObject={},printObject={};
		//水印设置弹窗勾选状态
		[#list policy.watermarks as w]
			[#if w.wmFlag == 1]
				waterObject.id='water-preview';
	        	waterObject.fontFamily='${w.wmFont}';
	        	waterObject.fontSize='${w.wordSize}';
	        	waterObject.lean=[#if w.xsWm == 1]true[#else]false[/#if];
	        	waterObject.viewType='${w.viewType}';
	        	waterObject.lineNumber='${w.lineNumber}';
	        	waterObject.fontColor='${w.fontColor}';
	        	waterObject.fontAlpha='${w.transparent}';
	        	waterObject.text=[];
	        	waterObject.img={};
			    waterObject.img.src='${w.photoPath}';
			    waterObject.img.imgAlpha='${w.photoTransparent}';
			    waterObject.img.layer='${w.photoLayerSet}';
			    waterObject.img.viewType='${w.photoViewType}';
			
				[#list w.words as p]
			    	[#if p.wordType == 4]
			    		var word = '${.now?string("yyyy-MM-dd hh:mm:ss")}';
			    	[#else]
			    		var word = '${p.word}';
			    	[/#if];
			    	waterObject.text[${p_index}] = {type:'${p.location}',text:word};
				[/#list]
			[#elseif w.wmFlag == 2]
				printObject.id='print-preview';
	        	printObject.fontFamily='${w.wmFont}';
	        	printObject.fontSize='${w.wordSize}';
	        	printObject.lean=[#if w.xsWm == 1]true[#else]false[/#if];
	        	printObject.viewType='${w.viewType}';
	        	printObject.lineNumber='${w.lineNumber}';
	        	printObject.fontColor='${w.fontColor}';
	        	printObject.fontAlpha='${w.transparent}';
	        	printObject.text=[];
	        	printObject.img={};
			    printObject.img.src='${w.photoPath}';
			    printObject.img.imgAlpha='${w.photoTransparent}';
			    printObject.img.layer='${w.photoLayerSet}';
			    printObject.img.viewType='${w.photoViewType}';
			
				[#list w.words as p]
			    	[#if p.wordType == 4]
			    		var word = '${.now?string("yyyy-MM-dd hh:mm:ss")}';
			    	[#else]
			    		var word = '${p.word}';
			    	[/#if];
			    	printObject.text[${p_index}] = {type:'${p.location}',text:word};
				[/#list]
			[/#if]
		[/#list]
		
		//画图
		function initWatermark(v){
			var w = watermarks.init(v);
			var index = 0;
			if(!v.id)return;
			if(v.text){
				for(var i=0;i<v.text.length;i++){
					var text = v.text[i].text;
					var location = parseInt(v.text[i].type);
		    		for(var j=0;j<5;j++){
		    			var r = 1<<j;
		    			if((location&r) === r){
		    				w.addText({type:r,text:text});
		    			}
		    		}
				}
			}
			if(v.img){
				w.addImage(v.img);
			}
			w.draw();
		}
		function addText(v,location,text){
			if(text&&text.length>0){
	    		for(var i=0;i<5;i++){
	    			var r = 1<<i;
	    			if((location&r) === r){
	    				v.text[index++]={type:r,text:text};
	    			}
	    		}
			}
		}
		initWatermark(waterObject);
		initWatermark(printObject);
    </script>
</body>
</html>
