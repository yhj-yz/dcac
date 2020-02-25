
/**
 * 时间对象的格式化
 *
 * ##调用方法
 * var time = Date.parse("你的时间字符串");
 * dt = time.format("yyyy-MM-dd hh:mm:ss");
 */
Date.prototype.format = function(format){
	/*
	* format="yyyy-MM-dd hh:mm:ss";
	*/
		var o = {
		"M+" : this.getMonth() + 1,
		"d+" : this.getDate(),
		"h+" : this.getHours(),
		"m+" : this.getMinutes(),
		"s+" : this.getSeconds(),
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		"S" : this.getMilliseconds()
	}
	 
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4-RegExp.$1.length));
	}
	 
	for (var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
}

/**
 * 时间戳格式化
 * 
 * @param timestamp
 * 			时间戳
 * @param format
 * 			格式
 * @returns 格式化后的时间
 */
function parseDate(timestamp, format){
	var defaltFormat = format ? format : "yyyy/MM/dd";
	var time = new Date();
	time.setTime(timestamp);
	return time.format(defaltFormat);
}


/**
 * 加载分页列表
 * 
 * @param option
 *					json格式的参数,详细信息如下:
 * @param option.id
 *					必选参数: 分页所在form标签的id;
 * @param option.pageSize
 * 					可选参数: 初始化页数;
 * @param option.dataFormat
 *					必选参数, 回调函数: 需要有一个参数和一个返回值,
 *						参数是ajax请求返回集合里面的每一条数据,
 *						返回值是指需要把分页列表每行的内容以字符串形式返回;
 * @param option.asyncSuccess
 * 					可选参数, 回调函数: 在数据加载完成后执行;
 */
function refreshPageList(option){
	var formid = option.id;
	var pageSize = option.pageSize?option.pageSize:10;//默认每页10条记录
	var dataFormat = option.dataFormat;
	var asyncSuccess = option.asyncSuccess;
	var msg_total_0 = message("dsm.page.total", 0, 0);//"共0页/0条数据"
	if($("#" + formid).find("input[name='pageNumber']").length === 0){
		$("#" + formid).append("<input type='hidden' name='pageNumber' value='1'/>")
	} else if ($("#" + formid).find("input[name='pageNumber']").val() === "") {
		$("#" + formid).find("input[name='pageNumber']").val(1);
	}
	if($("#" + formid).find("input[name='pageSize']").length === 0){
		$("#" + formid).append("<input type='hidden' name='pageSize' value='"+pageSize+"'/>")
	} else if ($("#" + formid).find("input[name='pageSize']").val() === "") {
		$("#" + formid).find("input[name='pageSize']").val(pageSize);
	}
	var list_formid = $("#" + formid).attr("data-list-formid");
	var $tab_ = $("#" + list_formid).find("table.widget_body");
	$tab_.empty();
	$("#" + list_formid).find(":checkbox").prop("checked", false);
	checkCheckboxStatus();// 根据复选框状态改变样式
	$.ajax({
		dataType: "json",
		data: $("#" + formid).serialize(),
		type: "get",
		url: $("#" + formid).attr("action"),
		success: function(data){
			$tab_.empty();
			$("#" + formid).find("input[name='pageNumber']").remove();
			$("#" + formid).find("input[name='pageSize']").remove();
			// 用户分页列表
			if(data && data.content){
				var prePage_ = data.pageNumber<=1?1:(data.pageNumber-1);
				var nextPage_ = data.pageNumber>=(data.totalPages-1)?data.totalPages:(data.pageNumber+1);
				var prestr="";
				var nextstr="";
				for(var i = 0; i < data.content.length; i++){
					if (typeof dataFormat === "function") {
						var _id = data.content[i].id;
						var tr_text = dataFormat(data.content[i]);//td_text是dataFormat函数返回的整行内容
						$tab_.append(tr_text);//分页列表table 添加1行
					}
				}
				initPage(formid, data.pageNumber, data.pageSize, data.totalPages, data.total);
				if (typeof asyncSuccess === "function") {
					asyncSuccess();
				}
			} else {
				initPage(formid, 1, option.pageSize, 0, 0)
			}
		},
		error: function(){
			initPage(formid, 1, option.pageSize, 0, 0)
		}
	});
}
/**
 *  表单下面页码初始化
 * 
 *  @param id
 * 				父容器id
 *  @param pageNumber
 * 				当前页
 *  @param pageSize
 *  			每页记录数
 *  @param totalPages
 *  			总页数
 *  @param total
 *  			总记录数
 */
function initPage(id, pageNumber, pageSize, totalPages, total){
	//下面是页数
	/** 每页显示 */
	var msg_pageSize = message("dsm.page.pageSize");
	/** 跳转到第 */
	var msg_pageTo = message("dsm.page.pageTo");
	/** 页 */
	var msg_number = message("dsm.page.number");
	
	$_container = $("#"+id);
	$_container.find("div.col_xs_9").remove();
	var _col_xs = $("<div></div>").addClass("col_xs_9");
	var _paginate = $("<ul></ul>").addClass("paginate");
	var _total_page = $("<span></span>").addClass("total_page");
	var _page_option = "<option value='0'>0</option>";
	for (var i = 1; i < totalPages + 1; i++) {
		_page_option +="<option value="+i+">"+i+"</option>";
	}
	var _paginate_length_1 = $( "<label class='paginate_length'>"+msg_pageSize+":&nbsp;&nbsp;<div class='page_select_box'>"+
			"<select class='page_select'><option value='0'>0</option><option value='3'>3</option><option value='6'>6</option>"+
			"<option value='9'>9</option></select></div><i class='length2'>" +
			"<input type='text' placeholder='9' class='page_input' id='ip_search_input' name='pageSize'" +
			"value='" + pageSize + "' autocomplete='off'/></i>&nbsp;</label>");
	var _paginate_length_2 = $( "<label class='paginate_length'>"+msg_pageTo+":&nbsp;&nbsp;<div class='page_select_box'>"+
			"<select class='page_select'>" + _page_option + "</select></div><i class='length2'>" +
			"<input type='text' placeholder='1' class='page_input' id='ip_search_input' name='pageNumber'" +
			"value='" + pageNumber + "' autocomplete='off'/></i>&nbsp;"+msg_number+"</label>");
	var prestr="";
	var nextstr="";
	var prePage_ = pageNumber<=1?1:(pageNumber-1);
	var nextPage_ = pageNumber>=(totalPages-1)?totalPages:(pageNumber+1);
	/** 共totalPages页/total条数据 */
	var msg_total = message("dsm.page.total", totalPages, total);
	_total_page.html(msg_total);//"共totalPages页/total条数据"
	_paginate.append("<li class='pagebtn_previous'><a href='#' data-page='"+prePage_+"' onclick='pageTo(this);return false;'>"+
	"<i><img src='../../resources/dsm/imgae/arrow_left.png' /></i></a></li>");
	
	if(pageNumber === 2){
		prestr= "<li class='pagebtn_number'><a href='#' data-page='1' onclick='pageTo(this);return false;' >1</a></li>";
	}else if(pageNumber === 3){
		prestr= "<li class='pagebtn_number'><a href='#' data-page='1' onclick='pageTo(this);return false;' >1</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='2' onclick='pageTo(this);return false;' >2</a></li>";
	}else if(pageNumber === 4){
		prestr= "<li class='pagebtn_number'><a href='#' data-page='1' onclick='pageTo(this);return false;' >1</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='2' onclick='pageTo(this);return false;' >2</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='3' onclick='pageTo(this);return false;' >3</a></li>";
	}else if(pageNumber > 4){
		prestr= "<li class='pagebtn_number'><a href='#' data-page='1' onclick='pageTo(this);return false;'>1</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber-3)+"' onclick='pageTo(this);return false;'>……</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber-2)+"' onclick='pageTo(this);return false;'>"+
		(pageNumber-2)+"</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber-1)+"' onclick='pageTo(this);return false;'>"+
		(pageNumber-1)+"</a></li>";
	}
	
	if(totalPages === (pageNumber+1)){
		nextstr= "<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber+1)+"' onclick='pageTo(this);return false;' >"+
		(pageNumber+1)+"</a></li>";
	}else if(totalPages === (pageNumber+2)){
		nextstr= "<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber+1)+"' onclick='pageTo(this);return false;' >"+
		(pageNumber+1)+"</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber+2)+"' onclick='pageTo(this);return false;' >"+
		(pageNumber+2)+"</a></li>";
	}else if(totalPages === (pageNumber+3)){
		nextstr= "<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber+1)+"' onclick='pageTo(this);return false;' >"+
		(pageNumber+1)+"</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber+2)+"' onclick='pageTo(this);return false;' >"+
		(pageNumber+2)+"</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber+3)+"' onclick='pageTo(this);return false;' >"+
		(pageNumber+3)+"</a></li>";
	}else if(totalPages > (pageNumber+3)){
		nextstr= "<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber+1)+"' onclick='pageTo(this);return false;' >"+
		(pageNumber+1)+"</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber+2)+"' onclick='pageTo(this);return false;' >"+
		(pageNumber+2)+"</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='"+(pageNumber+3)+"' onclick='pageTo(this);return false;' >……</a></li>"+
		"<li class='pagebtn_number'><a href='#' data-page='"+totalPages+"' onclick='pageTo(this);return false;'>"+
		totalPages+"</a></li>";
	}
	
	_paginate.append(prestr + "<li class='pagebtn_number'><a href='#' data-page='"+pageNumber+"' onclick='pageTo(this);return false;' " +
			"class='page_current'>"+pageNumber+"</a></li>" + nextstr);
	
	_paginate.append("<li class='pagebtn_number'><a href='#' data-page='"+nextPage_+"' onclick='pageTo(this);return false;'>"+
	"<img src='../../resources/dsm/imgae/arrow_right.png' /></a></li>");
	_paginate.append(_total_page);
	$_container.append(_col_xs.clone().append(_paginate), _col_xs.clone().append(_paginate_length_1, _paginate_length_2));
}
/**
 * 跳到指定页
 * @param v
 * 		传入的this
 */
function pageTo(v){
	var num = $(v).attr("data-page");
	var $frm = $(v).parents("form");
	$frm.find("input[name='pageNumber']").val(num);//更改当前页数
	var func_name = $frm.attr("data-func-name");
	eval(func_name);
}

$(function () {
	//分页页脚下拉框绑定事件，传值给input，并触发搜索
	$(document).on("change", "select.page_select", function(){
		var $frm = $(this).parents("form");
		$(this).parents("label.paginate_length").find("input").val(this.value);
		var func_name = $frm.attr("data-func-name");
		try {
			eval(func_name);
		} catch (e) {
			alert(e);
		}
		
	});
})


