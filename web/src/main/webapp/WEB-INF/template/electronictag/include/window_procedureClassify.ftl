<!--添加普通配置 开始-->
<div class="popup_window tree" id="addProcedureClassify">
	<div class="wind_header">
		<h4></h4>
		<i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form id="form_list">
	<div class="new_box">
		<div class="tree_box">
		<input type="hidden" id="pId" name="id" value="" />
		<input type="text" name="name" value="" class="text" />
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="addClassify(this);return false;" class="btn_blue wind_save_button">${message("admin.common.submit")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.common.back")}</a>
	</div>
	</form>
  </div>  

<!--添加普通配置结束-->

<!--修改普通配置 开始-->
<div class="popup_window tree" id="editProcedureClassify">
	<div class="wind_header">
		<h4></h4>
		<i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form id="editForm_list">
	<div class="new_box">
		<div class="tree_box">
		<input type="hidden" id="id" name="id" value="" />
		<input type="text" name="name" value="" class="text" />
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="editClassify();return false;" class="btn_blue wind_save_button">${message("admin.common.submit")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.common.back")}</a>
	</div>
	</form>
  </div>  

<!--修改普通配置结束-->



<!--添加程序开始--->
<div class="popup_window tree" id="addContrManager">
	<div class="wind_header">
		<h4></h4>
		<i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	 <div class="text_group" style="width: 700px;height:200px;">
							<div class="attr_name">添加程序：</div>
							<div class="safeDomainBox">
								<div class="safeDomainLeft">
									<div class="title">未选</div>
									<div class="itemBox">
										/*[#list securityDomains as s]
											<div class="domainItem" data-domainid="${s.id}">${s.securityName}</div>
										[/#list]*/
									</div>
									
									<input type="hidden" id="domainItemIds" name="securityDomains" value="-1" />
								</div>
								<div class="safeDomainCenter">
									<button type="button" class="btn rselectbtn">></button>
									<button type="button" class="btn rcancelbtn"><</button>
						
								</div>
								<div class="safeDomainRight">
									<div class="title">已选</div>
									<div class="itemBox">
										
									</div>
								</div>
							</div>
						</div>
  </div>  
<!--添加程序结束--->
                    






