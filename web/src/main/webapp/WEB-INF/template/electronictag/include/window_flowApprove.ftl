<!--流程驳回弹框 开始-->
<div class="popup_window" id="reject_button" style="display: none;">
	<div class="wind_header">
		<h4>选择会回退到</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" id="reject_form">
	   <div class="text_group">
				<div class="attr_name"> 步骤名称：</div>
					<span class="xialakuang_box"> 
					 
						<select class="xialakuang valid modelTypeSel" name="stepName">
						          <option value="发起流程">发起流程</option>
							 [#list flowSteps as s]
								  <option value="${s.stepName}">${s.stepName}</option>
							  [/#list]
						</select>
						 
					</span>
					
				</div>
				驳回原因： <input type="text" name="approveView" value="sssss"/>
		
		<div class="level_btn">
			<a href="#" onclick="rejectApprove();return false;">保&nbsp;存</a>
		</div>
	</form>
</div>
<!--流程驳回弹框结束-->


<!--流程参考弹框 开始-->
<div class="popup_window" id="referto_button" style="display: none;">
	<div class="wind_header">
		<h4>参考信息</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont" id="referto_form">
	   <div class="text_group">
				<div class="attr_name"> 步骤名称：</div>
					<input  type="text" name="userId" value="453"/>
					
				</div>
				驳回原因： <input type="text" name="approveView" value="sssss"/>
		
		<div class="level_btn">
			<a href="#" onclick="refertoApprove();return false;">保&nbsp;存</a>
		</div>
	</form>
</div>
<!--流程参考弹框结束-->

