<!--查看或查看关联对象开始-->
<div class="popup_window scan_relate" id="_link_box" style="display: none;">
	<div class="wind_header">
		<h4>查看关联</h4>
		<i><a href="#" onclick="hideWindows();return false;" ><img src="${base}/resources/dsm/imgae/closed_wind.png"/></a></i>
	</div>
	<div class="popup_wind_cont" >
		<div class="relate_title">相关的部门</div>
		<div class="relate_con_box">
			<div class="right_lis_1">
				<div class="rights_lis_s">技术部</div>
			</div>
		</div>
		<div class="relate_title near">相关的用户</div>
		<div class="tab_small_box" id="_list_box">
			<div class="tab_t_box">
				<table class="widget_title">
					<tr>
						<td style="width: 45%;">账号</td>
						<td style="width: 50%;">姓名</td>
					</tr>
				</table>
			</div>
			<div class="tab_b_box tab_b_box_scroll">
				<table class="widget_body">
					<tr class="tr_border tr_current" style="position: relative;">
						<td style="width: 45%; color: #303030;">ht008</td>
						<td style="width: 50%; color: #303030;">王小二</td>
					</tr>
				</table>
			</div>
		</div>
		<!--页码开始-->
		<div class="win_pagebox">
			<div class="page_number_big_box">
				<form id="_user_pagebox" data-func-name="refreshPageUserBox();" data-list-formid="_list_box">
					<input type="hidden" name="quartersId" >
				</form>
			</div>
		</div>
		<!--页码结束-->
	</div>
</div>
<!--查看或查看关联对象结束-->
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
//刷新关联用户分页列表
function refreshPageUserBox(){
	refreshPageList({id :"_user_pagebox",
					pageSize :3,
					dataFormat :function(_data){
						var _text =     "<tr class='tr_border ' style='position: relative;'>"+
										"<td style=' width:45%; color:#303030;'>"+_data.userName+"</td>"+
										"<td style=' width:50%; color:#303030;'>"+_data.name+"</td>";+
										"</tr>";
						return _text;
					},
					asyncSuccess:function(){
						$("#_user_pagebox input[name='pageSize']").parents(".paginate_length").hide();
					}
	});
}
</script>