
<div class="popup_window" style="display:none;">
	<div class="wind_header">
		<h4>弹框提示信息</h4>
		<i><a href="domain-server-set.html"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont">
		<div class="text_group">
			<div class="attr_name">域服务器</div>
			<input class="attr_n_input  attr_current" value="1123" />
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		<div class="text_group">
			<div class="attr_name">域登录账号</div>
			<input class="attr_n_input" value="王志成" />
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		<div class="text_group">
			<div class="attr_name">登录密码</div>
			<input class="attr_n_input" value="******" />
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		<div class="text_group">
			<div class="attr_name">账号导入方式</div>
			<span class="radio_input"> <label
				class="danxuankuang_box selected"> <input
					class="danxuankuang" type="radio" value="1" checked="checked" /> <i>不带域名</i>
			</label> <label class="danxuankuang_box"> <input class="danxuankuang"
					type="radio" value="1" checked="checked" /> <i>带域名</i>
			</label>
			</span>
			<p class="zhushi">
				<span style="color: red;"></span>
			</p>
		</div>
		<div class="text_group">
			<div class="attr_name">域名</div>
			<input class="attr_n_input" value="******" />
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		<div class="btn_wind">
			<a href="" class="wind_save_button">保&nbsp;存</a> <a href=""
				class="wind_cancel_button">取&nbsp;消</a>
		</div>
	</form>
</div>
<script>
	//根据单选框的状态改变样式
	function checkRadioStatus(){
		$(".radio_input :radio").each(function(){
			var $par = $(this).parent();
			if(this.checked){
				$par.removeClass("selected");
				$par.siblings().addClass("selected");
			} else {
				$par.addClass("selected");
				$par.siblings().removeClass("selected");
			}
		});
	}

	//根据复选框状态改变样式
	function checkCheckboxStatus(){
	$("#pop_group select[name='sex'] option[value='1']").prop("selected")
		$("label.inline_middle :checkbox").each(function(){
			var $par = $(this).parent();
			if(this.checked){
				$par.addClass("on");
			} else {
				$par.removeClass("on");
			}
		});
	}

	$(function() {
		checkRadioStatus();
		checkCheckboxStatus();
		
		//新增用户弹窗左侧导航点击改变样式
		$(document).on("click", "li.orgni_new_title", function(){
			$("li.orgni_new_title.on").removeClass("on");
			$(this).addClass("on");
			$("li.orgni_new_title div.current").removeClass("current");
			$(this).find("div.popup_wind_cont_box").addClass("current");
		});

		//复选框点击改变样式
		$(document).on("change", "label.inline_middle :checkbox",function(){
			var $par = $(this).parent();
			if(this.checked){
				$par.addClass("on");
			} else {
				$par.removeClass("on");
			}
		});

		//单选框点击改变样式,
		$(document).on("change", ".radio_input :radio", function(){
			var $par = $(this).parent();
			if(this.checked){
				$par.removeClass("selected");
				$par.siblings().addClass("selected");
			} else {
				$par.addClass("selected");
				$par.siblings().removeClass("selected");
			}
		});

		//input获得焦点时改变样式
		$(document).on("focus", ".text_group input", function(){
			$(".text_group input").removeClass("attr_current");
			$(this).addClass("attr_current");
		});

	})
	//检查文件等级复选框是否勾选
    function isSelected(){
	var ids_ = $("#list_docType :checked[name='ids']");
	alert(ids_.length);
	if(ids_.length === 0){
		confirmWin("请选择用户 !!");
		return true;
	}else{
		return false;
	}
}
	
	//关联岗位用户弹出框显示
//关联岗位用户弹出框显示
function interfix(v){

var $id=$(v).parents("tr").find("input[name='ids']").val();

var $win=$("#_interfix");
$win.find(".role").empty(); 
$win.find(".user").empty(); 
  $.ajax({
     type:"get",
     data:{id:$id},
     dataType:"json",
     url: "${base}/admin/docType/findRoleUser.jhtml",
     success: function(data){
  alert(data.role.length)
     for(var i=0; i<data.role.length;i++){
    
     	$win.find(".role").append("<div class='right_lis_1'><div class='rights_lis_s'>"+data.role[i].roleName+"</div></div>");
     	
    };
     for(var j=0;j<data.user.length;j++){
     $win.find(".user").append("<tr class='tr_border tr_current' style='position:relative;'>"+
                               "<td style=' width:45%; color:#303030;'>"+data.user[j].id+"</td><td style=' width:50%; color:#303030;'>"+data.user[j].name+"</td></tr>");
     
     }
   
     },
    
 });
 $win.show();
}
</script>

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

<!--像confirm一样的弹窗开始-->
<div class="popup_window3" id="confirm_win" style="display:none;">
    <div class="wind_header">
        <i><a href="#" onclick="closeWin();return false;"  ><img src="${base}/resources/dsm/imgae/closed_wind.png"/></a></i>
    </div>
    <p class="hints"></p>
    <div class="btn_wind3">
    	<a href="#" onclick="closeWin();return false;"  class="wind3_confirm_button">确定</a>
    </div>
</div>
<!--像confirm一样的弹窗结束-->
<!--小弹窗结束-->



<!--添加文件等级显示框--!>
<div class="popup_window" id="addDoc" style="display:none;">
	<div class="wind_header">
		<h4>文件等级</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	 <form class="popup_wind_cont" action="${base}/admin/docType/save.jhtml">
		<div class="text_group">
			<div class="attr_name">序号</div>
			<input class="attr_n_input attr_current" name="indexid" value="" placeholder="序号">
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		<div class="text_group">
			<div class="attr_name">名称</div>
			<input class="attr_n_input" name="name" value="" placeholder="名称">
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		 <div class="text_group">
			<div class="attr_name">备注</div>
			<input class="attr_n_input" name="remark" value="" placeholder="备注">
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submit(this);return false" class="wind_save_button">保&nbsp;存</a> 
			<a href="#" onclick="hideWindows();return false;" class="wind_cancel_button">取&nbsp;消</a>
		</div>
	</form>
</div>
		
<!--文件等级显示框--!>

<div class="popup_window" id="docName" style="display:none;">
	<div class="wind_header">
		<h4>文件等级</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	 <form class="popup_wind_cont" action="${base}/admin/docType/updateDoc.jhtml">
	 <div>
	  <input type="hidden" name="id" value="">
	 </div>
		<div class="text_group">
			<div class="attr_name">序号</div>
			<input class="attr_n_input attr_current" name="indexid" value="" placeholder="序号">
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		<div class="text_group">
			<div class="attr_name">名称</div>
			<input class="attr_n_input" name="doctypeName" value="" placeholder="名称">
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		 <div class="text_group">
			<div class="attr_name">备注</div>
			<input class="attr_n_input" name="doctypeRemark" value="" placeholder="备注">
			<p class="zhushi">
				<span style="color: red;">*</span>必填项
			</p>
		</div>
		<div class="btn_wind">
			<a href="#" onclick="submitfind(this);return false;" class="wind_save_button">保&nbsp;存</a> 
			<a href="#" onclick="hideWindows();return false;" class="wind_cancel_button">取&nbsp;消</a>
		</div>
	</form>
</div>


<!--查看或查看关联角色开始-->
        <div class="popup_window" id="_interfix" style="display:none;" >
	               <div class="wind_header">
                                <h4>关联岗位用户</h4>
                                <i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png"/></a></i>
                            </div>
                            <form class="popup_wind_cont">
                            	<div class="relate_title ">
                                相关的角色
                                </div>
                                
                                <div class="relate_con_box role">
                               
                                	<div class="right_lis_1">
                                        
                                        <div class="rights_lis_s">技术部</div>
                                    </div>
                                 
                                </div>
                                
                                <div class="relate_title near">
                                相关的用户
                                </div>
                                <div class="tab_small_box">
                                	<div class="tab_t_box">
                                    	<table class="widget_title" >
                                            <tr>
                                                <td style=" width:45%;">
                                                </td>
                                                <td style=" width:50%;">姓名</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="tab_b_box tab_b_box_scroll">
                                    	<table  class="widget_body user">
                                            <tr class="tr_border tr_current" style="position:relative;">
                                                <td style=" width:45%; color:#303030;">
                                                    ht008
                                                </td>
                                                <td style=" width:50%; color:#303030;">王小二</td>
                                            </tr>
                                           
                                        </table>
                                    </div>
                                </div>
                                <!--页码开始-->
                                <div class="win_pagebox">
                                    <div class="page_number_big_box">
                                        <div class="col_xs_9">
                                            <ul class="paginate">
                                                    <li class="pagebtn_previous">
                                                        <a href="#"><i><img src="${base}/resources/dsm/imgae/arrow_left.png"/></i></a>
                                                    </li>
                                                    <li class="pagebtn_number">
                                                        <a href="#">1</a>
                                                    </li>
                                                    <li class="pagebtn_number">
                                                        <a href="#">2</a>
                                                    </li>
                                                    <li class="pagebtn_number">
                                                        <a href="#" class="page_current">3</a>
                                                    </li>
                                                    <li class="pagebtn_number">
                                                        <a href="#">4</a>
                                                    </li>
                                                    <li class="pagebtn_number">
                                                        <a href="#">5</a>
                                                    </li>
                                                    <li class="pagebtn_number">
                                                        <a href="#">6</a>
                                                    </li>
                                                    <li class="pagebtn_number">
                                                        <a href="#">……</a>
                                                    </li>
                                                    <li class="pagebtn_number">
                                                        <a href="#">26</a>
                                                    </li>
                                                    <li class="pagebtn_number">
                                                        <a href="#"><i><img src="${base}/resources/dsm/imgae/arrow_right.png"/></a>
                                                    </li>
                                                    <span class="total_page">
                                                        共26页/100条数据
                                                    </span>
                                                </ul>
                                        </div>
                                        <div class="col_xs_9">
                                            <label class="paginate_length">
                                                跳转到:&nbsp;&nbsp;
                                                <div class="page_select_box">
                                                    <select class="page_select">
                                                        <option value="0">0</option>
                                                        <option value="1">1</option>
                                                        <option value="2">2</option>
                                                        <option value="3">3</option>
                                                    </select>
                                                </div>
                                                <i class="length2"><input type="text" placeholder="9" class="page_input" id="ip_search_input" autocomplete="off" /></i>
                                                &nbsp;页
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <!--页码结束-->
                        	</form>
                        </div>			           
        </div>	
<!--查看或查看关联角色结束-->










