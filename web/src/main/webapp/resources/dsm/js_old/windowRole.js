//根据单选框的状态改变样式
function checkRadioStatus() {
	$(".radio_input :radio").each(function() {
		var $par = $(this).parent();
		if (this.checked) {
			$par.removeClass("selected");
			$par.siblings().addClass("selected");
		} else {
			$par.addClass("selected");
			$par.siblings().removeClass("selected");
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
	$("div#confirm_win p.hints").html(str);
	$("div#confirm_win").show();
	$("div#confirm_win").delay(400).fadeOut();
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
	$(document).on("click", ".radio_input :radio", function() {
		var $par = $(this).parent();
		if (this.checked) {
			$par.removeClass("selected");
			$par.siblings().addClass("selected");
		} else {
			$par.addClass("selected");
			$par.siblings().removeClass("selected");
		}
	});

	// input获得焦点时改变样式
	$(document).on("focus", ".text_group input", function() {
		$(".text_group input").removeClass("attr_current");
		$(this).addClass("attr_current");
	});

	// "按钮" 鼠标悬停、点击、离开时变色
	$(document).on("mouseout", "a.wind_save_button,a.wind_cancel_button",
			function() {
				$(this).css("background-color", "#2ba6f4");
			});

	$(document).on("mousedown", "a.wind_save_button,a.wind_cancel_button",
			function() {
				$(this).css("background-color", "#004c7d");
			});

	$(document).on("mouseover", "a.wind_save_button,a.wind_cancel_button",
			function() {
				$(this).css("background-color", "#007ece");
			});
	
	//用户一般权限的全选
	$(document).on("change", ":checkbox.checkall_1",
			function() {
				$(this).parent().parent().parent().parent().parent().find(":checkbox").prop("checked", this.checked);//用户一般权限的分组全选
				checkCheckboxStatus();// 根据复选框状态改变样式
			});
	
	
	//用户文件等级权限的竖向全选
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
	
	//用户文件等级权限的全选
	$(document).on("change", ":checkbox.checkall_3",
			function() {
		$(this).parent().parent().parent().parent().parent().parent().parent().find(":checkbox").prop("checked", this.checked);
		checkCheckboxStatus();// 根据复选框状态改变样式
	});
	
	// 复选框点击后面的文字同时点击复选框
	$(document).on("click", "div.rights_list_s,div.left_list_s,div.left_strate_s,div.rights_lis_s,div.rights_lis_s", function() {
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

	//与程序无关，是禁止坏人用鼠标选中文字。
	$(document).bind("selectstart",function(){return false;});
})

