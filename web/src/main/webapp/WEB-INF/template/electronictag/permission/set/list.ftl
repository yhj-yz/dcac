<!DOCTYPE html>
<html lang="ch">
<head>
<meta charset="UTF-8">
<title>权限集管理</title>

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
					<a href='${base}/admin/permissionset/edit.do?id=-1' type="button" class="btn btn-primary js_add">
						<i class="btnicon icon-toolbar icon-add-white"></i>新增权限集
					</a>
					<button type="button" class="btn btn-primary js_del">
						<i class="btnicon icon-toolbar icon-delete"></i>删除权限集
					</button>
					<div class="boxPosition">
						<div class="searchbox">
						<input class="dsm-input js_search_txt" type="text" > <i class="icon icon-search js_search" title="搜索"></i>
					</div>
					</div>
				</div>
				<div id="managerContent">
					<div class="table-view">
					<form id="list_form" >
					<table id="datalist" class="table" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th class="w40">
									<div class="dsmcheckbox">
										<input type="checkbox" value="1" id="checkboxFiveInput"
											class="js_checkboxAll" data-allcheckfor="ids">
										<label for="checkboxFiveInput"></label>
									</div>
								</th>
								<th>权限集名称</th>
								<th>管理员</th>
								<th>权限集描述</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
					</form>
				    <form id="search_form" action="search.do" data-func-name="refreshPage();" data-list-formid="datalist">
						<input type="hidden" name="permissionName" >
					</form>
				</div>
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
					var rName = _data.permissionDesc?_data.permissionDesc:"";
					var _id = _data.id;
					var _text = "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' id='m_"+_id+"' value='"+_id+"'/><label for='m_"+_id+"'></label></div></td>\
								<td class='hiddentd'><div class='hiddendiv' title='"+_data.permissionName+"'><a data-id='"+_id+"' href='${base}/admin/permissionset/edit.do?id="+_id+"' class='js_detailform'>"+_data.permissionName+"</a></div></td> \
								<td>"+(_data.createUserAccount==null?"":_data.createUserAccount)+"</td>\
								<td class='hiddentd'><div class='hiddendiv' title='"+rName+"'>"+rName+"</div></td>\
								</tr>";
					return _text;
				}});
			
		}
		$(document).ready(function() {
	        refreshPage();
		});
		
	    
		//检查是否勾选
		function noItemSelected(){
			var ids_ = $("#list_form :checked[name='ids']");
			if(ids_.length === 0){
				dsmDialog.error("请先选择权限集!")
				return true;
			}else{
				return false;
			}
		}
    	
    	function clearError(){
    		$('label.error').remove();
    		$('input.error').removeClass('error');
    	}
    	
		function search(search_name){
			if(search_name.length > 32){
				dsmDialog.error("搜索框最多输入32位");
				return;
			}
			$("#search_form input[name='permissionName']").val(search_name);
			$("#search_form").attr("action", "search.do");
			refreshPage();
		}
		//搜索
        $(document).on('click', '.js_search', function (e) {
        	search($(this).prev().val());
        });
		
		//新增 权限集
        
        
		
		$(document).on('click', '.js_del', function (e) {
			if(noItemSelected()){//如果用户没有勾选
				return;
			};
            dsmDialog.toComfirm("是否执行删除操作？", {
				btn: ['确定','取消'],
				title:"删除权限集"
			}, function(index){
				var $frm = $("#list_form");
				$.ajax({
					dataType:"json",
					type: "post",
					url: "${base}/admin/permissionset/delete.do",
					data: $frm.serialize(),
					success: function(data){
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
	</script>
</body>
</html>