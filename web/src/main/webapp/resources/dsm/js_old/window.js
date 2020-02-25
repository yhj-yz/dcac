/**确认窗口setTimeOut返回的ID值*/
var timer;
//根据单选框的状态改变样式
function checkRadioStatus() {
	$(".radio_input :radio").each(function() {
		var $par = $(this).parent();
		var $frm = $(this).parents("form");
		var $name = $(this).attr("name");
		if (this.checked) {
			$frm.find(":radio[name='"+$name+"']").parent().removeClass("selected");
			$par.addClass("selected");
		} else {
			$frm.find(":radio[name='"+$name+"']").parent().addClass("selected");
			$par.removeClass("selected");
		}
	});
}

// 根据复选框状态改变样式
function checkCheckboxStatus() {
	$("label.inline_middle :checkbox").each(function() {
		var $par = $(this).parent();
		if (this.checked) {
			$par.addClass("on");
		} else {
			$par.removeClass("on");
		}
	});
}
// 提示窗口显示后自动淡出
function confirmWin(str) {
	var $_confirm = $("div#confirm_win");
	if ($_confirm.length === 0) {
		var confirm_str =  "<div class='popup_window3' id='confirm_win' style='display:block;'><div class='wind_header'>" +
		"<i><a href='#' onclick='closeWin();return false;'><img src='../../resources/dsm/imgae/closed_wind.png'/>" +
		"</a></i></div><p class='hints'>"+ str +"</p><div class='btn_wind3'>" +
		"<a href='#' onclick='closeWin();return false;' class='wind3_confirm_button'>确定</a></div></div>";
		$(document.body).append(confirm_str);
		$_confirm = $("div#confirm_win");
	} else {
		$_confirm.find("p.hints").html(str);
	}
	$_confirm.show();
	clearTimeout(timer);
	timer = setTimeout(function(){
		$_confirm.fadeOut();
	}, 1000);
	/*$("div#confirm_win p.hints").html(str);
	$("div#confirm_win").show();
	$("div#confirm_win").delay(800).fadeOut();*/
}

// 提示窗口关闭
function closeWin() {
	// 隐藏小弹窗
	$("div.popup_window3").hide();
}
//隐藏弹出框
function hideWindows(){
	$(".black").hide();
	$(".popup_window").hide();
	$(".popup_window2").hide();
	$(".popup_window4").hide();
	$(".popup_window5").hide();
}
$(function() {
	checkRadioStatus();
	checkCheckboxStatus();// 根据复选框状态改变样式

	// 新增用户弹窗左侧导航点击改变样式
	$(document).on("click", "li.orgni_new_title", function() {
		$("li.orgni_new_title.on").removeClass("on");
		$(this).addClass("on");
		$("li.orgni_new_title div.current").removeClass("current");
		$(this).find("div.popup_wind_cont_box").addClass("current");
	});

	// 复选框点击改变样式
	$(document).on("click", "label.inline_middle :checkbox", function(e) {
		//停止事件冒泡,当点击的是checkbox时,就不执行父div的click
        e.stopPropagation();
		var $par = $(this).parent();
		if (this.checked) {
			$par.addClass("on");
		} else {
			$par.removeClass("on");
		}
	});

	// 单选框点击改变样式,
	$(document).on("click", ".radio_input :radio", function(e) {
		var $par = $(this).parent();
		var $name = $(this).attr("name");
		var $frm = $(this).parents("form");

		$(this).parent().addClass('selected').siblings().removeClass('selected');
	});

	// input,textarea获得焦点时改变样式
	$(document).on("focus", ".text_group input,textarea", function() {
		$(".text_group input,textarea").removeClass("attr_current");
		$(this).addClass("attr_current");
	});

	// "按钮" 鼠标悬停、点击、离开时变色(蓝色主题)
	$(document).on("mouseout", ".btn_blue", function() {
				$(this).css("background-color", "#2ba6f4");
			});

	$(document).on("mousedown", ".btn_blue", function() {
				$(this).css("background-color", "#004c7d");
			});
	
	$(document).on("mouseup", ".btn_blue", function() {
		$(this).css("background-color", "#007ece");
	});

	$(document).on("mouseover", ".btn_blue", function() {
				$(this).css("background-color", "#007ece");
				$(this).css("cursor", "pointer");
			});
	
	//用户一般权限的全选(根据dom层级关系，可控制往上5层以内的checkbox全选)
	$(document).on("change", ":checkbox.checkall_1", function() {
				$(this).parent().parent().parent().parent().parent().find(":checkbox").prop("checked", this.checked);//用户一般权限的分组全选
				checkCheckboxStatus();// 根据复选框状态改变样式
			});
	
	//用户文件等级权限的竖向全选(根据dom层级关系，可控制往上7层以内的符合条件的checkbox全选)
	$(document).on("change", ":checkbox.checkall_2",
			function() {
		var _docId = this.value;
		var checked = this.checked;
		var _ck = $(this).parent().parent().parent().parent().parent().parent().parent().find(":checkbox");
		_ck.each(function(){
			var _value = this.value;
			if (_value.indexOf("-") !== -1 && _value.split("-")[0] === _docId) {
				this.checked = checked;
			}
			
		});
		checkCheckboxStatus();// 根据复选框状态改变样式
	});
	
	//用户文件等级权限的全选(根据dom层级关系，可控制往上7层以内的checkbox全选)
	$(document).on("change", ":checkbox.checkall_3",
			function() {
		$(this).parent().parent().parent().parent().parent().parent().parent().find(":checkbox").prop("checked", this.checked);
		checkCheckboxStatus();// 根据复选框状态改变样式
	});
	
	// 复选框点击后面的文字同时点击复选框
	$(document).on("click", "div.rights_list_s,div.left_list_s,div.left_strate_s,div.rights_lis_s", function() {
		$(this).prev().find(":checkbox").click();
		checkCheckboxStatus();// 根据复选框状态改变样式
	});
	

	//tr列表(文件等级弹窗)悬停改变样式(tr背景颜色、鼠标变小手)
	$(document).on("mouseout", ".tab_b_box tr",
			function() {
				$(this).css("background-color", "#fff");
				//$(this).removeClass("tr_current");
			});
	$(document).on("click", ".tab_small_box tr",
			function() {
				$(this).find(":checkbox").click();
				checkCheckboxStatus();
			});
	$(document).on("mouseover", ".tab_b_box tr",
			function() {
				$(this).css("background-color", "#f2f9fe");
			});
	$(document).on("mouseover", ".tab_small_box tr",
			function() {
				$(this).css("cursor", "pointer");
	});
	

	//table列表的全选(有两个table，全选在上面一个table里面，列表在下面一个table里面)
	$(document).on("change", "table.widget_title :checkbox", function(){
		$(this).parents("table.widget_title").parent().next().find("table.widget_body :checkbox").prop("checked", this.checked);
		checkCheckboxStatus();// 根据复选框状态改变样式
	});

	
	// 搜索框获得焦点时改变样式(:text.ip_search_input)
	$(document).on("focus", ":text.ip_search_input", function() {
		$(this).addClass("ip_search_input_on");
	});
	$(document).on("blur", ":text.ip_search_input", function() {
		$(this).removeClass("ip_search_input_on");
	});
	//搜索按钮鼠标悬停背景色改变(.search_btn)
	$(document).on("mouseover", ".search_btn", function() {
		$(this).css("background-color","#1890dc");
	});
	$(document).on("mouseout", ".search_btn", function() {
		$(this).css("background-color","#2badf4");
	});
	//上方按钮悬停改变透明度
	$("li.btn_list").hover(function(){
		$(this).find("div.columnbg48").addClass("columnbg80")
	},function(){
		$(this).find("div.columnbg48").removeClass("columnbg80");
	});
	
	
	//与程序无关，是禁止坏人用鼠标选中文字。
	$(document).bind("selectstart",function(){return false;});
	
})
