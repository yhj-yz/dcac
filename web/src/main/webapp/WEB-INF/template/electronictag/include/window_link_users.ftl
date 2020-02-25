<!--查看或查看关联对象开始-->
<div class="popup_window scan_relate" id="_link_box" style="display: none;">
	<div class="wind_header">
		<h4>查看关联</h4>
		<i><a href="#" onclick="hideWindows();return false;" ><img src="${base}/resources/dsm/imgae/closed_wind.png"/></a></i>
	</div>
	<div class="popup_wind_cont" >
		<div class="relate_title near">相关的用户</div>
		<div class="tab_small_box" id="_list_box" >
			<div class="tab_t_box">
				<table class="widget_title">
				</table>
			</div>
			<div class="tab_b_box tab_b_box_scroll">
				<table class="widget_body">
				</table>
			</div>
		</div>
		<!--页码开始-->
		<div class="win_pagebox">
			<div class="page_number_big_box">
				<form id="_user_pagebox" data-func-name="refreshPageUserBox();" data-list-formid="_list_box" action="">
					<input type="hidden" name="id" >
				</form>
			</div>
		</div>
		<!--页码结束-->
	</div>
</div>
<!--查看或查看关联对象结束-->
<script>
//刷新关联用户分页列表
function refreshPageUserBox(){
	refreshPageList({
		id :"_user_pagebox",
		pageSize :10,
		dataFormat :function(_data){
			var _text = "<tr class='tr_border ' style='position: relative;'>"+
						"<td style=' width:45%; color:#303030;'>"+_data.account+"</td>"+
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