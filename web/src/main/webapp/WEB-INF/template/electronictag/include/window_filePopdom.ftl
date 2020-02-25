
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
	
//显示文件等级弹出框
function addDoc(){

	var $win=$("#_set_docs");
	$win.find(":checkbox").prop("checked", false);//清空所有复选框勾选状态
	checkCheckboxStatus();// 根据复选框状态改变样式
	$win.find(".tab_b_box table.widget_body").empty();
	appendDocs();
	$win.show();
	//根据权限弹窗里面 存在的文件权限 将文件等级页面的文件等级列表移除(tr)
	$(".bind_append_doc .rights_group div.left_list_s.all").each(function(){
		var docName = $(this).text();
		$win.find(".tab_b_box table td").each(function(){
			if(docName === $(this).text()){
				$(this).parent().remove();
			}
		});
		
	});
	checkCheckboxStatus();
}	



//添加所有文件等级
function appendDocs(){
	var _tab = $(".tab_b_box table.widget_body");
	[#list docType as d]
		_tab.append("<tr class='tr_border' style='position:relative;'><td style='width:30%;'>"+
					"<div class='stroke20'></div><label class='inline_middle'><div class='fuxuankuang_box'>"+
                    "<input type='checkbox' class='fuxuankuang' name='docPops' value='${d.id}' tt='${d.doctypeName}'/>"+
					"</div></label></td><td style='width:50%; color:#002f4c;'>${d.doctypeName}</td></tr>");
	[/#list]
}

//设置权限-文件等级窗口关闭按钮
function hideDocs(){
	$("#_set_docs :checked").prop("checked", false);
	checkCheckboxStatus();
	$("#_set_docs").hide();//隐藏文件等级窗口
}	


//设置权限-文件等级窗口确定按钮
function setDocs(){
	$("#_set_docs :checked[value]").each(function(){
		appendDocPop(this.value, $(this).attr("tt"));//向用户权限窗口添加文件等级权限复选框
		$(this).parent().parent().parent().parent().remove();//移除文件等级窗口相应的文件等级复选框
	});
	$("#_set_docs").hide();//隐藏文件等级窗口
}

<!--页面和文件等级弹窗之间的交互过程开始--!>
// 根据权限id、权限名称和文件等级ID获取文件权限的html元素 字符串，用于append 
function getDocPop(popId, popName, docId, docName){
	if(popId !== 0){
		if(docId){// 如果参数都存在
			var _str =	"<label class='inline_middle' style='margin-right:10px;float:left;'><div class='fuxuankuang_box'>"+
						"<input type='checkbox' class='fuxuankuang' name='docPops' value='"+popId+"-"+docId+"'/>"+
						"</div></label><div class='rights_list_s short'>"+popName+"</div>";
			return _str;
		}else{// 如果文件等级参数为空，value=权限id
			var _str =	"<label class='inline_middle' style='margin-right:10px;float:left;'><div class='fuxuankuang_box'>"+
						"<input type='checkbox' class='fuxuankuang checkall_2' value='"+popId+"'/>"+//checkall_2无样式 用来控制checkbox竖向全选
						"</div></label><div class='rights_list_s short'>"+popName+"</div>";
			return _str;
		}
	}else{
		var _docName = docName?docName:"文件等级";
		var _ck = docName?"checkall_1":"checkall_3";//checkall_1、checkall_3无样式 用来控制checkbox横向全选和 全部全选
		var _str =	"<div class='right_lis_1'><label class='inline_middle' style='margin-right:10px;float:left;'><div class='fuxuankuang_box'>"+
						"<input type='checkbox' class='fuxuankuang "+_ck+"' />"+
						"</div></label></div><div class='left_list_s all '>"+_docName+"</div>";
		return _str;
	}
}

// 根据权限名称和文件等级ID获取文件权限的html元素 字符串，用于append 
function getDocPopByPopName(popName, docId, docName){
	// 遍历权限集合，如果存在就调用getDocPop方法，返回值是 字符串 html元素
	[#list popdoms as p]
		if("${p.popdomName}" === popName){
			return getDocPop("${p.id}", "${p.popdomName}", docId, docName);
		}
	[/#list]
	return getDocPop(0, popName, docId, docName);
}

// 将查到的html元素添加到 jquery元素，再把jquery元素添加到对应的文件权限窗口
function appendDocPop(docId, docName){
	var _rights_group = $("<div></div>").addClass("cont_group");
	var _con = $("<div></div>").addClass("right_cont");
	var _left_con = $("<div></div>").addClass("right_cont_lef").append(getDocPopByPopName(0,0,docName));
	var _lis_1 = $("<div></div>").addClass("right_lis_1");
	var _right_con = $("<div></div>").addClass("right_cont_rig")
									   .append(_lis_1.clone().append(getDocPopByPopName("打印文件", docId, docName)))
									   .append(_lis_1.clone().append(getDocPopByPopName("解密文件", docId, docName)))
									   .append(_lis_1.clone().append(getDocPopByPopName("调整文件", docId, docName)))
									   .append(_lis_1.clone().append(getDocPopByPopName("外发文件", docId, docName)))
									   .append(_lis_1.clone().append(getDocPopByPopName("打开文件", docId, docName)));
	var _right_con2 = $("<div></div>").addClass("right_cont_rig")
									   .append(_lis_1.clone().append(getDocPopByPopName("解密审批", docId, docName)))
									   .append(_lis_1.clone().append(getDocPopByPopName("外发审批", docId, docName)))
									   ;								   
									   
									   
	_con.append(_left_con, _right_con); 
	_rights_group.append(_con);
	$(".bind_append_doc").append(_rights_group);
	
	var _rights_group2 = $("<div></div>").addClass("cont_group");
	var _con2 = $("<div></div>").addClass("right_cont");
	var _left_con2 = $("<div></div>").addClass("right_cont_lef").append(getDocPopByPopName(0,0,docName));
	var _lis_2 = $("<div></div>").addClass("right_lis_1");
	_con2.append(_left_con2, _right_con2); 
	_rights_group2.append(_con2);
	$(".bind_append_doc2").append(_rights_group2);
}
//用户文件等级权限的竖向全选
	$(document).on("change", ":checkbox.checkall_2",
			function() {
		var _docId = this.value;
		var checked = this.checked;
		var _ck = $(this).parents(".popup_wind_cont_box").find(":checkbox");
		_ck.each(function(){
			var _value = this.value;
			if (_value.indexOf("-") !== -1 && _value.split("-")[0] === _docId) {
				this.checked = checked;
			}
			
		});
		checkCheckboxStatus();// 根据复选框状态改变样式
	});
<!--页面和文件等级弹窗之间的交互过程结束--!>

  //显示角色模板弹出框
    function put_model(){
     var $win=$("#set_model");
    
     $win.show();
 
  }
   //关闭角色模板
   function model_hide(){
     $("#set_model :checked").prop("checked",false);
    checkCheckboxStatus();
    $("#set_model").hide();

}



//角色模板弹出框保存事件
function setModel(){
//设置操作权限复选框复选状态为空
$(".operation :checkbox").prop("checked",false);
checkCheckboxStatus();
 var model_id=$("#set_model :checked");
 if(model_id.length>1){
 $("#set_model").find("p").text("不能同时选取两个模板").css({"color":"red"});  }

var $popids=$(".operation input[name='popids']");
   $.ajax({
	    type:"get",
	    data:{id:model_id.val()},
	    url:"${base}/admin/fileRole/findModel.jhtml",
	    dataType:"json",
	    success: function(data){
		    for(var i=0;i<data.length;i++){
		    	$(".operation input[name='popids']").each(function(){
				    if(parseInt(this.value)===data[i]){
					   	this.checked=true;
				    }
		    	});
			}
			checkCheckboxStatus();
		}	});
model_hide();

}

//检查文件等级复选框是否勾选
    function isSelected(){
	var ids_ = $(".tab_body :checked[name='ids']");
	if(ids_.length === 0){
		confirmWin("请选择用户 !!");
		return true;
	}else{
		return false;
	}
}
	




//关联岗位用户弹出框显示
function interfix(v){

var $id=$(v).parents("tr").find("input[name='ids']").val();

var $win=$("#_interfix");
$win.find(".quarter").empty(); 
$win.find(".user").empty(); 
  $.ajax({
     type:"get",
     data:{id:$id},
     dataType:"json",
     url: "${base}/admin/fileRole/findQuartersUser.jhtml",
     success: function(data){

     for(var i=0; i<data.quarter.length;i++){
     	$win.find(".quarter").append("<div class='right_lis_1'><div class='rights_lis_s'>"+data.quarter[i].quartName+"</div></div>");
     	
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

<!--像confirm一样的弹窗开始-->
<div class="popup_window3" id="confirm_win" style="display:none;">
    <div class="wind_header">
        <i><a href="#" onclick="closeWin();return false;"  ><img src="${base}/resources/dsm/imgae/closed_wind.png"/></a></i>
    </div>
    <p class="hints">
        组织机构下无法新增用户
    </p>
    <div class="btn_wind3">
    	<a href="#" onclick="closeWin();return false;"  class="wind3_confirm_button">确定</a>
    </div>
</div>
<!--像confirm一样的弹窗结束-->

<!--文件等级显示框--!>
<div class="popup_window" id="file_open" style="display:none;">
	<div class="wind_header">
		<h4>文件等级</h4>
		<i><a href="#" onclick="hideWindows();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	    <div id="docs">
	    	[#list docType as doc]
	    	<div tt="${doc.id}">
				<input type='checkbox' name='popids'  value='${doc.id}' />${doc.doctypeName}<br>
			</div>
			[/#list]
	    </div>
		<div class="btn_wind">
			<a href="#" onclick="queding();return false" class="wind_save_button">保&nbsp;存</a> 
			<a href="#" onclick="hideWindows();return false;" class="wind_cancel_button">取&nbsp;消</a>
		</div>
</div>



<!--新增文件等级开始-->
<div class="popup_window" id="_set_docs" style="display: none;">
	<div class="wind_header">
		<h4>文件等级</h4>
		<i><a href="#" onclick="hideDocs();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont">
		<div class="form_search">
			<span class="input_icon "> <input type="text"
				placeholder="文件等级名称" class="ip_search_input   ip_search_input_on"
				autocomplete="off" /> <i
				class="ace-icon fa fa-search nav-search-icon"></i>
			</span>
			<button type="button" class="search_btn">
				<i class="search_icon"><img src="${base}/resources/dsm/imgae/searchicon.png" /></i> 搜索
			</button>
		</div>
		<div class="tab_small_box">
			<div class="tab_t_box">
				<table class="widget_title">
					<tr>
						<td style="width: 30%;"><label class="inline_middle">
								<div class="fuxuankuang_box">
									<input type="checkbox" class="fuxuankuang" />
								</div>
						</label></td>
						<td style="width: 50%; color: #000;">文件等级</td>
					</tr>
				</table>
			</div>
			<div class="tab_b_box tab_b_box_scroll">
				<table class="widget_body">
				[#list docType as d]
					<tr class="tr_border " style="position: relative;">
						<td style="width: 30%;">
							<div class="stroke20"></div> <label class="inline_middle">
								<div class="fuxuankuang_box">
									<input type="checkbox" class="fuxuankuang" name="docPops" value="${d.id}" tt="${d.doctypeName}"/>
								</div>
						</label>
						</td>
						<td style="width: 50%; color: #002f4c;">${d.doctypeName}</td>
					</tr>
				[/#list]
				</table>
			</div>
		</div>
		<div class="level_btn">
			<a href="#" onclick="setDocs();return false;">保&nbsp;存</a>
		</div>
	</form>
</div>

<!--角色模板弹出框--!>

<div class="popup_window" id="set_model" style="display: none;">
	<div class="wind_header">
		<h4>角色模板</h4>
		<i><a href="#" onclick="model_hide();return false;"><img
				src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form class="popup_wind_cont">
		<div class="form_search">
			<span class="input_icon "> <input type="text"
				placeholder="模板模名称" class="ip_search_input   ip_search_input_on"
				autocomplete="off" /> <i
				class="ace-icon fa fa-search nav-search-icon"></i>
			</span>
			<button type="button" class="search_btn">
				<i class="search_icon"><img src="${base}/resources/dsm/imgae/searchicon.png" /></i> 搜索
			</button>
		</div>
		<div class="tab_small_box">
			<div class="tab_t_box">
				<table class="widget_title">
					<tr>
						<td style="width: 30%;"><label class="inline_middle">
								<div class="fuxuankuang_box">
									<input type="checkbox" class="fuxuankuang" />
								</div>
						</label></td>
						<td style="width: 50%; color: #000;">文件等级</td>
					</tr>
				</table>
			</div>
			<div class="tab_b_box tab_b_box_scroll">
				<table class="widget_body">
				[#list fileRoleModel as d]
					<tr class="tr_border " style="position: relative;">
						<td style="width: 30%;">
							<div class="stroke20"></div> <label class="inline_middle">
								<div class="fuxuankuang_box">
									<input type="checkbox" class="fuxuankuang" name="models" value="${d.id}" tt="${d.roleModelName}"/>
								</div>
						</label>
						</td>
						<td style="width: 50%; color: #002f4c;">${d.roleModelName}</td>
					</tr>
				[/#list]
				</table>
			</div>
			
		</div>
			<div><p></p></div>
			<div class="level_btn">
                   
				<a href="#" onclick="setModel();return false;">保&nbsp;存</a>
			</div>
	</form>
</div>

<!--查看或查看关联对象开始-->
        <div class="popup_window" id="_interfix" style="display:none;" >
	               <div class="wind_header">
                                <h4>关联岗位用户</h4>
                                <i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png"/></a></i>
                            </div>
                            <form class="popup_wind_cont">
                            	<div class="relate_title ">
                                相关的部门
                                </div>
                                
                                <div class="relate_con_box quarter">
                               
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
<!--查看或查看关联对象结束-->

