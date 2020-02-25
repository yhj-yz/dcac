<!DOCTYPE html>
<html lang="ch">        
<head>
	<meta charset="UTF-8">
	<title>系统角色管理</title>
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
					<a href="add.jhtml" class="btn btn-primary js_add" ><i class="btnicon icon icon-add"></i>新增</a>
					<button type="button" class="btn btn-primary js_del" ><i class="btnicon icon icon-delete"></i>删除</button>
					<button type="button" class="btn btn-primary" ><i class="btnicon icon icon-import"></i>导入</button>
					<button type="button" class="btn btn-primary" ><i class="btnicon icon icon-add"></i>导出</button>
					<div class="searchbox">
						<input class="dsm-input js_search_txt" type="text">
						<i class="icon icon-search js_search" title="搜索"></i>
					</div>
				</div>
				<div class="table-view">
					<form id="list_form" >
					<table id="datalist" class="table" cellspacing="0" width="100%">
				        <thead>
				            <tr>
				                <th>
					                <div class="dsmcheckbox">
					                	<input type="checkbox" value="1" id="checkboxFiveInput"  class="js_checkboxAll" data-allcheckfor="ids">
										<label for="checkboxFiveInput"></label>
									</div>
								</th>
				                <th>名称</th>
				                <th>关联对象</th>
				                <th>管理者</th>
				                <th>描述</th>
				            </tr>
				        </thead>
				        <tbody>
				        	
				        </tbody>
				    </table>
				    </form>
				    <form id="search_form" action="search.jhtml" data-func-name="refreshRolePageList();" data-list-formid="datalist">
						<input type="hidden" name="name" >
					</form>
				</div>
			</div>
		</div>
	</div>

		
	<script type="text/javascript">
	//刷新分页列表
	function refreshRolePageList(){
		refreshPageList({id :"search_form",
			pageSize:10,
			dataFormat :function(_data){
				var rName = _data.description?_data.description:"";
				var _id = _data.id;
				var _text = "<tr>"+
							"<td width='10%'><div class='dsmcheckbox'>"+
							"<input type='checkbox' name='ids' id='m_"+_id+"' value='"+_id+"'/><label for='m_"+_id+"'></label></div></td>"+
							"<td><div class='overtdstyle w200' title='"+_data.name+"'><a href='edit.jhtml?id="+_id+"' >"+_data.name+"</a></div></td>"+
							"<td width='45%'><span class='listdetail bg-red  js_showdetail' data-rid='"+_id+"'> <i class='icon icon-ddown'></i></span></td>"+
							"<td width='45%'>"+_data.createUserAccount+"</td>"+
							"<td><div class='overtdstyle w200' title='"+rName+"'>"+rName+"</div></td>"+
							"</tr>";
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
			refreshRolePageList();
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
						url:'users.jhtml?id=' + $(this).attr('data-rid'),
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
		
		$(document).on('click', '.js_del', function (e) {
			if(noItemSelected()){//如果用户没有勾选
				return;
			};
            dsmDialog.toComfirm("是否删除选中的角色？", {
				btn: ['确定','取消'],
				title:"删除角色"
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
							refreshRolePageList();
						} else {
							dsmDialog.error(data.content);
						}
					}
				});
			}, function(index){						
				dsmDialog.close(index);
			});

        });
        refreshRolePageList();
        
        //检查是否勾选
		function noItemSelected(){
			var ids_ = $("#list_form :checked[name='ids']");
			if(ids_.length === 0){
				dsmDialog.error("请先选择角色!")
				return true;
			}else{
				return false;
			}
		}
	});
	
	function showToolTip(v){
		if(v.data && v.data.type === "success"){
			dsmDialog.msg(v.data.content);
			if(typeof v.success === "function") v.success();
		} else {
			dsmDialog.error(v.data.content);
			if(typeof v.error === "function") v.error();
		}
	}
	</script>
</body>
</html>