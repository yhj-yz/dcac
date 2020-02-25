<!DOCTYPE html>
<html lang="ch">
<head>
<meta charset="UTF-8">
<title>受控程序管理</title>

[#include "/include/head.ftl"]
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
					 <a href='${base}/admin/controlledStrategy/add.do' type="button" class="btn btn-primary">
						<i class="btnicon icon-toolbar icon-add-white"></i>新增受控策略
					</a>
					<button type="button" class="btn btn-primary js_del">
						<i class="btnicon icon icon-delete"></i>删除受控策略
					</button>
					
					<div class="boxPosition">
						<div class="searchbox">
						<input class="dsm-input js_search_txt" type="text" > <i class="icon icon-search js_search" title="搜索"></i>
					</div>
					</div>
				</div>
				<div id="contrStrategy-table">
					<div class="table-view">
					<form id="list_form" >
					<table id="datalist" class="table" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th>
									<div class="dsmcheckbox">
										<input type="checkbox" value="1" id="checkboxFiveInput"
											class="js_checkboxAll" data-allcheckfor="ids">
										<label for="checkboxFiveInput"></label>
									</div>
								</th>
								<th class="w20p">策略名称</th>
								<th class="w20p">管理员</th>
								<th class="w50p">受控策略描述</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					</form>
				    <form id="search_form" action="search.do" data-func-name="refreshPage();" data-list-formid="datalist">
						<input type="hidden" name="name" >
					</form>
				</div>
				</div>
			</div>
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
				var dscspt="";
				if(_data.decspt!=null){
				  dscspt=_data.decspt;
				}
				var _text = "<tr>\
							<td><div class='dsmcheckbox'>\
							<input type='checkbox' name='ids' id='m_"+_id+"' value='"+_id+"'/><label for='m_"+_id+"'></label></div></td>\
							<td class='hiddentd'><div class='hiddendiv' title='"+_data.name+"'><a href='add.jhtml?id="+_id+"' data-id='"+_id+"' class='js_detailform'>"+_data.name+"</a></div></td>\
							<td class='hiddentd'><div class='hiddendiv' title='"+_data.createUserAccount+"'>"+_data.createUserAccount+"</div></td>\
							<td class='hiddentd'><div class='hiddendiv' title='"+dscspt+"'>"+dscspt+"</div></td>\
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
		
		//新增 受控策略
        $(document).on('click', '.js_add', function (e) {
	      window.location.href="add.jhtml";

        });
       
		
		$(document).on('click', '.js_del', function (e) {
			if(noItemSelected()){//如果用户没有勾选
				return;
			};
            dsmDialog.toComfirm("是否删除受控程序策略？", {
				btn: ['确定','取消'],
				title:"删除受控程序策略"
			}, function(index){
				var $frm = $("#list_form");
				$.ajax({
					dataType:"json",
					type: "get",
					url: "delete.jhtml",
					data: $frm.serialize(),
					success: function(data){
						// 提示
						if(data && data.type === "success"){
							dsmDialog.msg("删除成功");
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
				dsmDialog.error("请选择受控策略!")
				return true;
			}else{
				return false;
			}
		}
    	
    	function clearError(){
    		$('label.error').remove();
    		$('input.error').removeClass('error');
    	}
	});
	</script>
</body>
</html>