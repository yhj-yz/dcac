<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>密级管理</title>
	[#include "/dsm/include/head.ftl"]
	<script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
	<style>
		.highlight {background-color: yellow}
	</style>
	<script type="text/javascript" src="${base}/resources/dsm/js/highlight.js"></script>
</head>
<body>
	<div class="dsm-rightside">		
		<div class="maincontent">
			<div class="mainbox">
				<div class="btn-toolbar">
					<button type="button" class="btn btn-primary btn-tool js_add">
						<i class="btnicon icon-toolbar icon-add-white"></i>新增密级
					</button>
					<button type="button" class="btn btn-primary btn-tool js_del">
						<i class="btnicon icon-toolbar icon-delete"></i>删除密级
					</button>
					<div class="searchbox">
						<input class="dsm-input js_search_txt" placeholder="密级名称" type="text" ><i class="icon icon-search js_search" title="搜索"></i>
					</div>
				</div>
				<div class="table-view">
					<form id="list_form" >
					<table id="datalist" class="table" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th class="w50">
									<div class="dsmcheckbox">
										<input type="checkbox" value="1" id="checkboxFiveInput"	class="js_checkboxAll" data-allcheckfor="ids">
										<label for="checkboxFiveInput"></label>
									</div>
								</th>
								<th class="w20p">序号</th>
								<th class="w30p">名称</th>
								<th class="">描述</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					</form>
				    <form id="search_form" action="search.jhtml" data-func-name="refreshPage();" data-list-formid="datalist">
						<input type="hidden" name="name" >
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--新增/修改密级-->
	<div id="levelForm" style="display: none">
		<div class="dsmForms">
			<form action="save.jhtml">
			<input type="hidden" name="id">
			<div class="dsm-form-item">
				<div class="dsm-inline">
					<label class="dsm-form-label">密级名称：</label>
					<div class="dsm-input-inline">
						<input type="text" autocomplete="off" placeholder="密级名称"
							class="dsm-input" name="securityName">
					</div>
					<div class="desc"><em>*</em></div>
				</div>
				<div class="dsm-inline">
					<label class="dsm-form-label">密级序号：</label>
					<div class="dsm-input-inline">
						<input type="text" autocomplete="off" placeholder="密级序号"
							class="dsm-input" name="order">
					</div>
					<div class="desc"><em>*</em></div>
				</div>
				<div class="dsm-inline">
					<label class="dsm-form-label">描述：</label>
					<div class="dsm-input-inline dsm-tarea ">
                    	<textarea  name="securityDesc" id="txt_desc" cols="10" rows="2" class="dsm-textarea"></textarea>
                    	<span class="txt-limit">（限256个字）</span>
                	</div>					
				</div>
			</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">
	//刷新分页列表
	function refreshPage(){
		refreshPageList({id :"search_form",
			pageSize:10,
			dataFormat :function(_data){
				var rName = _data.securityDesc?_data.securityDesc:"";
				var _id = _data.id;
				var _text = "<tr>\
							<td><div class='dsmcheckbox'>\
							<input type='checkbox' name='ids' id='m_"+_id+"' value='"+_id+"'/><label for='m_"+_id+"'></label></div></td>\
							<td>"+_data.order+"</td>\
							<td class='hiddentd'><div class='hiddendiv overtdstyle w200' title='"+_data.securityName+"'><a href='#' data-id='"+_id+"' class='js_detailform' \
							data-name='"+_data.securityName+"' data-desc='"+_data.securityDesc+"' \
							data-order='"+_data.order+"' >"+_data.securityName+"</a></div></td>\
							<td class='hiddentd'><div class='hiddendiv overtdstyle w200' title='"+rName+"'>"+rName+"</div></td>\
							</tr>";
				return _text;
			}});
		
	}
	$(document).ready(function() {
		
		//根据用户名/账号搜索
		function search(search_name){
			if(search_name.length > 32){
				dsmDialog.error("搜索框最多输入32位");
				return;
			}
			$("#search_form input[name='name']").val(search_name);
			$("#search_form").attr("action", "search.jhtml");
			refreshPage();
		}
		//搜索
        $(document).on('click', '.js_search', function (e) {
        	search($(this).prev().val());
        });
        //搜索栏绑定键盘keyup事件
		$(document).on("keyup", ".js_search_txt", function(event){
			$("#search_form input[name='name']").val(this.value);
			if(event.which === 13){
				search(this.value);
			}
		});
        //搜索结果高亮显示
		$(document).on("keyup", ".js_userkey", function(){
			var key = $(this).val();
			var container = $(this).parent().parent().parent().next();
			container.removeHighlight();
			if(key.length > 0) {  
				container.highlight(key);
			}
		});
		//点击关联显示
		$(document).on('click', '.js_showdetail', function (e) {
			if($(this).hasClass("active")){
				$(this).removeClass("active");
				$(this).parent().parent().next().hide();
			} else {
				var sp = $(this);
				if(!sp.parent().parent().next().hasClass("linktr")){
					$.ajax({
						url:'users2.jhtml?id=' + $(this).attr('data-rid'),
						dataType:'json',
						success:function(data){
							sp.parent().parent().nextAll(".linktr").remove();
							var udetailHtml='<tr class="linktr"><td colspan="6"><div class="linkbox">';
							udetailHtml+='<div class="dsm-form-item searchbox clearfix">';
							udetailHtml+='<div class="dsm-inline"><div class="dsm-input-inline">';
							udetailHtml+='<input type="text" autocomplete="off" class="dsm-input js_userkey">';
							udetailHtml+='<i  class="icon icon-search js_searchlinkuser"></i></div></div></div>';
							udetailHtml+='<div class="linkuserlist clearfix">';
			    			udetailHtml+='<ul>';
			    			for(var i=0; i<data.length; i++){
								udetailHtml+='<li>'+data[i].name+'['+data[i].account+']</li>';
			    			}
			    			udetailHtml+='</ul></div></div></td></tr>';
							sp.parent().parent().after(udetailHtml);
							sp.addClass('active');
						}
					});
				} else {
					sp.parent().parent().next().show();
					sp.addClass('active');
				}
			}
			
    	}); 
		
		//新增 密级
        $(document).on('click', '.js_add', function (e) {
        	clearError();
        	var frm = $('#levelForm form');
	        frm.attr("action", "save.jhtml")[0].reset();
	        frm.find("input[name='id']").val("");
        	dsmDialog.open({
				type: 1,
				area:['420px','300px'],
				btn:['确定','取消'],
				title:"新增密级",
	            content : $("#levelForm"),
	            yes: function(index, layero){
	            	//执行确定操作 调用 iframe中的方法
	            	if(frm.valid()){
			        	submitForm({
			        		frm: frm,
			        		success: function(){
			        			dsmDialog.close(index);
			        			window.location.href="list.jhtml";
			        		},
			        	})
		        	} else {
		        		$(".error").prev().focus();
		        	}
			  	}
    		});

        });
        //点击名称弹框修改
        $(document).on('click', '.js_detailform', function (e) {
        	clearError();
        	var frm = $('#levelForm form');
	        frm.attr("action", "update.jhtml")[0].reset();
	        frm.find("input[name='order']").val($(this).data("order"));
	        frm.find("input[name='securityName']").val($(this).data("name"));
	        frm.find("[name='securityDesc']").val($(this).data("desc"));
	        //frm.find("input[name='securityYear']").val($(this).data("year"));
	        frm.find("input[name='id']").val($(this).data("id"));
        	dsmDialog.open({
				type: 1,
				area:['420px','300px'],
				btn:['确定','取消'],
				title:"修改密级",
	            content : $("#levelForm"),
	            yes: function(index, layero){
	            	//执行确定操作 调用 iframe中的方法
	            	if(frm.valid()){
			        	submitForm({
			        		frm: frm,
			        		success: function(){
			        			dsmDialog.close(index);
			        			window.location.href="list.jhtml";
			        		},
			        	})
		        	} else {
		        		$(".error").prev().focus();
		        	}
			  	}
    		});

        });
		
		$(document).on('click', '.js_del', function (e) {
			if(noItemSelected()){//如果用户没有勾选
				return;
			};
            dsmDialog.toComfirm("删除密级可能导致系统中已存在的密级文件无法打开，是否执行删除操作？", {
				btn: ['确定','取消'],
				title:"删除密级"
			}, function(index){
				var $frm = $("#list_form");
				$.ajax({
					dataType:"json",
					type: "post",
					url: "delete.jhtml",
					data: $frm.serialize(),
					success: function(data){
						
						// 提示
						if(data && data.type === "success"){
							dsmDialog.msg(data.content);
							refreshPage();
						} else {
							dsmDialog.error(data.content);
							refreshPage();
						}
					}
				});
			}, function(index){						
				dsmDialog.close(index);
			});

        });
        refreshPage();
        
        //检查是否勾选
		function noItemSelected(){
			var ids_ = $("#list_form :checked[name='ids']");
			if(ids_.length === 0){
				dsmDialog.error("请先选择密级!")
				return true;
			}else{
				return false;
			}
		}
		$("#levelForm form").validate({
	    	rules:{
	    		"securityName":{
	    			required: true,
	    			specialChar: true,
	    			maxlength: 32,
	    		},
				"securityDesc":{
					maxlength: 256,
				},
				"order":{
					required: true,
					digits: true,
					range: [1, 100]
				},
	    	}
    	});
    	//清除错误提示
    	function clearError(){
    		$('label.error').remove();
    		$('input.error').removeClass('error');
    	}
    	 //初始化输入控件
        function clearVal(){
            $(".dsm-input").val("");
            $(".dsm-textarea").val("");
        }
	});
	</script>
</body>
</html>