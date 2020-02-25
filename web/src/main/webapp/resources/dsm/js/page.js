function add0(m){return m<10?'0'+m:m }
function pageformat(timestamp)
{
  //timestamp是整数，否则要parseInt转换,不会出现少个0的情况

	var time = new Date(timestamp);
	var year = time.getFullYear();
	var month = time.getMonth()+1;
	var date = time.getDate();
	var hours = time.getHours();
	var minutes = time.getMinutes();
	var seconds = time.getSeconds();
	return year+'-'+add0(month)+'-'+add0(date)+' '+add0(hours)+':'+add0(minutes)+':'+add0(seconds);
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
	var pageSize = 10;
	var dataFormat = option.dataFormat;
	var asyncSuccess = option.asyncSuccess;
	var msg_total_0 = message("dsm.page.total", 0, 0);//"共0页/0条数据"
	if($("#" + formid).find("input[name='pageNumber']").length == 0){
		$("#" + formid).append("<input type='hidden' name='pageNumber' value='1'/>")
	} else if ($("#" + formid).find("input[name='pageNumber']").val() == "") {
		$("#" + formid).find("input[name='pageNumber']").val(1);
	}
	
	if($("#" + formid).find("input[name='pageSize']").length == 0){
		$("#" + formid).append("<input type='hidden' name='pageSize' value='"+pageSize+"'/>")
	} else if ($("#" + formid).find("input[name='pageSize']").val() == "") {
		$("#" + formid).find("input[name='pageSize']").val(pageSize);
	}
	var list_formid = $("#" + formid).attr("data-list-formid");
	var $tab_ = $("#" + list_formid).find("tbody");

	$('.js_checkboxAll').prop("checked", false);
	$.ajax({
		dataType: "json",
		data: $("#" + formid).serialize(),
		type: "get",
		url: $("#" + formid).attr("action"),
		success: function(data){
			// 用户分页列表
			if(data && data.content){				
				
				var prestr="";
				var nextstr="";
				var tr_all="";
				for(var i = 0; i < data.content.length; i++){
					if (typeof dataFormat === "function") {
						var _id = data.content[i].id;
						var tr_text = dataFormat(data.content[i]);//td_text是dataFormat函数返回的整行内容
						tr_all+=tr_text;
					}
				}

				$tab_.html(tr_all);//分页列表table 添加1行
				if($('[data-toggle="popover"]').length>0){
		       		$('[data-toggle="popover"]').popover();
				}
				initPage(formid, data.pageNumber, data.pageSize, data.totalPages, data.total);
				if (typeof asyncSuccess === "function") {
					asyncSuccess();
				}
			} else {
				$tab_.html("");
				initPage(formid, 1, option.pageSize, 0, 0)
			}
		},
		error: function(){
			$tab_.html("");
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
	var msg_total = '<span class="lengthinfo">'+message("dsm.page.total", totalPages, total)+'</span>';
	/** 选择页按钮*/
	var btnInfo='';	
	var btn_prev='';
	var btn_prev_middle='';
	var btn_middle='';
	var btn_middle_next='';
	var btn_next='';
	var input_goto='';
	
	var html_lengthInput='<input type="text" value="'+pageSize+'" class="dsm-lengthinput"><select class="page-length dsm-lengthselect">';
	var hasSelected=false;
	for (var i = 0; i < 4; i++) {
		var l=i*30+10;
		if(l==pageSize){
			html_lengthInput+='<option selected>'+l+'</option>';	
			hasSelected=true;
		}else{
			html_lengthInput+='<option>'+l+'</option>';
		}
		
	}
	if(!hasSelected){
		html_lengthInput+='<option style="display:none" selected>'+pageSize+'</option>';
	}
	html_lengthInput+='</select>';
	//var showInfo='<span class="showinfo"><span class="lengthinput">'+html_lengthInput+'</span><button type="button" onclick="goLength(this)" class="dsm-laypage-btn">确定</button>'+msg_total+'</span>';
	var showInfo='<span class="showinfo"><span class="lengthinput">'+html_lengthInput+'</span>'+msg_total+'</span>';
	
	//先处理按钮显示效果
	if(pageNumber==1){
		btn_prev='<a href="javascript:;" class="dsm-laypage-prev color-999">上一页</a>';
	}else{
		btn_prev='<a href="javascript:;" class="dsm-laypage-prev" data-page="'+(pageNumber-1)+'">上一页</a>';
	}
	if(pageNumber==totalPages){
		btn_next='<a href="javascript:;" class="dsm-laypage-next color-999">下一页</a>';
	}else{
		btn_next='<a href="javascript:;" class="dsm-laypage-next" data-page="'+(pageNumber+1)+'">下一页</a>';
	}
	
	if(totalPages>6){
		if(pageNumber==1){
			btn_prev_middle='<span class="dsm-laypage-curr"><em class="dsm-laypage-em"></em><em>1</em></span><a href="javascript:;" data-page="2">2</a><a href="javascript:;" data-page="3">3</a>';
			btn_middle='<span>…</span>';
			btn_middle_next='<a href="javascript:;" data-page="'+(totalPages-1)+'">'+(totalPages-1)+'</a> <a href="javascript:;" data-page="'+totalPages+'">'+totalPages+'</a>';
		}else if(pageNumber>=(totalPages-3)){
			
			btn_prev_middle='<a href="javascript:;" data-page="1">1</a><a href="javascript:;" data-page="2">2</a>';
			btn_middle='<span>…</span>';
			for (var k = (totalPages-3); k<=totalPages; k++) {
				if(k!=pageNumber){
					btn_middle_next+='<a href="javascript:;" data-page="'+k+'">'+k+'</a>';				
				}else{
					btn_middle_next+='<span class="dsm-laypage-curr"><em class="dsm-laypage-em"></em><em>'+k+'</em></span>';
				}
			}
		
		}else{
			btn_prev_middle='<a href="javascript:;" data-page="'+(pageNumber-1)+'">'+(pageNumber-1)+'</a><span class="dsm-laypage-curr"><em class="dsm-laypage-em"></em><em>'+pageNumber+'</em></span><a href="javascript:;" data-page="'+(pageNumber+1)+'">'+(pageNumber+1)+'</a>';
			btn_middle='<span>…</span>';
			btn_middle_next='<a href="javascript:;" data-page="'+(totalPages-1)+'">'+(totalPages-1)+'</a> <a href="javascript:;" data-page="'+totalPages+'">'+totalPages+'</a>';
			
		}
				
	}else{
		
		for (var t = 1; t <= totalPages; t++) {
			if(t!=pageNumber){
				btn_middle+='<a href="javascript:;" data-page="'+t+'">'+t+'</a>';				
			}else{
				btn_middle+='<span class="dsm-laypage-curr"><em class="dsm-laypage-em"></em><em>'+t+'</em></span>';
			}
		}
		btn_prev_middle='';
		btn_middle_next='';
	
	}
	input_goto='<span class="dsm-laypage-total">跳转到<input type="number" min="1" max="'+totalPages+'" value="'+pageNumber+'" class="dsm-laypage-skip">页<button type="button" onclick="go(this)" class="dsm-laypage-btn">跳转</button></span>';
	btnInfo='<span class="buttoninfo"><div class="dsm-laypage">'+btn_prev+btn_prev_middle+btn_middle+btn_middle_next+btn_next+input_goto+'</div></span>';
	//先处理按钮显示效果结束
	
	if($("#"+id+' .pagebox').length==0){
		$("#"+id).append('<div class="pagebox"></div>');
	}
	$("#"+id+" .pagebox").html(showInfo+btnInfo);
	
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
$(document).on("click", ".dsm-laypage a", function(){
	var pageto = $(this).data("page");
	if(pageto!=null){
		var $frm = $(this).parent().parent().parent().parent();
		$frm.find("input[name='pageNumber']").val(pageto);
		if($frm!=null){
			var func_name = $frm.attr("data-func-name");
			if(func_name!=null){
				eval(func_name);
			}
		}
	}
	
});
function go(t){
	var valcontr=$(t).parent().find('.dsm-laypage-skip');
	if(valcontr.length>0){
		var gopage=$(valcontr).val();
		var max=$(valcontr).attr("max");
		var min=$(valcontr).attr("min");
		if(parseInt(gopage)>=parseInt(min)&&parseInt(gopage)<=parseInt(max)){
			var $frm = $(t).parent().parent().parent().parent().parent();
			$frm.find("input[name='pageNumber']").val(gopage);
			if($frm!=null){
				var func_name = $frm.attr("data-func-name");
				if(func_name!=null){
					eval(func_name);
				}
			}
		}
	}
}

function goLength(t){
	
	var $frm = $(t).parent().parent().parent();
	if($frm!=null){
		var func_name = $frm.attr("data-func-name");
		if(func_name!=null){
			eval(func_name);
		}
	}
}
function refreshPageBylengthinput(v){
	var $frm = $(v).parent().parent().parent().parent();
	
	if($frm!=null){
		var pageLengthTo = $(v).val();
		$frm.find(".dsm-lengthinput").val(pageLengthTo);
		$frm.find("input[name='pageSize']").val(pageLengthTo);
		var func_name = $frm.attr("data-func-name");
		if(func_name!=null){
			eval(func_name);
		}
	}
}
$(document).on("change", ".dsm-lengthselect", function(){
	refreshPageBylengthinput(this);
});

$(document).on("change", ".dsm-lengthinput", function(){
	refreshPageBylengthinput(this);
});
$(document).on("keyup", ".dsm-lengthinput", function(event){
	if (event.which === 13) {
		refreshPageBylengthinput(this);
	}
});
$(document).on("change", ".dsm-laypage-skip", function(){
	var $frm = $(this).parent().parent().parent().parent();
	if($frm!=null){
		$frm.find(".dsm-laypage-btn").click();
	}
});
$(document).on("keyup", ".dsm-laypage-skip", function(event){
	if (event.which === 13) {
		$(this).change();
	}
});

$(function () {
	
})


