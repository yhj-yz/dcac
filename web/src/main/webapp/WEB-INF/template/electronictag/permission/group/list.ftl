<!DOCTYPE html>
<html lang="ch">
<head>
<meta charset="UTF-8">
<title>用户组管理</title>

[#include "/dsm/include/head.ftl"]
<script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>

</head>
<body>
	<div class="dsm-rightside">
		<div class="maincontent">
			<div class="mainbox">
				<div class="btn-toolbar">
					<a href="add.jhtml" class="btn btn-primary"><i
						class="btnicon icon icon-add"></i>新增用户组</a>
					<button type="button" class="btn btn-primary js_del">
						<i class="btnicon icon icon-delete"></i>删除
					</button>
					<button type="button" class="btn btn-primary">
						<i class="btnicon icon icon-import"></i>导入
					</button>
					<button type="button" class="btn btn-primary">
						<i class="btnicon icon icon-add"></i>导出
					</button>
					<div class="searchbox">
						<input class="dsm-input js_search_txt" type="text" > <i
							class="icon icon-search js_search" title="搜索"></i>
					</div>
				</div>
				<div class="table-view">
					<form id="list_form" >
					<table id="datalist" class="table" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th>
									<div class="dsmcheckbox">
										<input type="checkbox" value="1" id="t2"
											class="js_checkboxAll" data-allcheckfor="ids">
										<label for="t2"></label>
									</div>
								</th>
								<th>用户组名称</th>
								<th>描述</th>
								<th>管理者</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<div class="dsmcheckbox">
										<input type="checkbox" value="1" id="t21" name="uids">
										<label for="t21"></label>
									</div>
								</td>
								<td><a href="System-UserGroup-Form.html">测试策略</a></td>
								<td>备注111</td>
								<td>admin</td>
							</tr>
						</tbody>
					</table>
					</form>
				    <form id="search_form" action="search.jhtml" data-func-name="refreshGroupPageList();" data-list-formid="datalist">
						<input type="hidden" name="name" >
					</form>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
	//刷新分页列表
	function refreshGroupPageList(){
		refreshPageList({id :"search_form",
			pageSize:10,
			dataFormat :function(_data){
				var rName = _data.groupDesc?_data.groupDesc:"";
				var _id = _data.id;
				var _text = "<tr>"+
							"<td width='10%'><div class='dsmcheckbox'>"+
							"<input type='checkbox' name='ids' id='m_"+_id+"' value='"+_id+"'/><label for='m_"+_id+"'></label></div></td>"+
							"<td><div class='overtdstyle w300' title='"+_data.groupName+"'><a href='edit.jhtml?id="+_id+"' >"+_data.groupName+"</a></div></td>"+
							"<td><div class='overtdstyle w300' title='"+rName+"'>"+rName+"</div></td>"+
							"<td width='90%'>"+_data.modifyUserAccount+"</td>"+
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
			refreshGroupPageList();
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
		
		$(document).on('click', '.js_del', function (e) {
			if(noItemSelected()){//如果没有勾选
				return;
			};
            dsmDialog.toComfirm("是否删除选中的用户组？", {
				btn: ['确定','取消'],
				title:"删除用户组"
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
							refreshGroupPageList();
						} else {
							dsmDialog.error(data.content);
						}
					}
				});
			}, function(index){						
				dsmDialog.close(index);
			});

        });
        refreshGroupPageList();
        
        //检查是否勾选
		function noItemSelected(){
			var ids_ = $("#list_form :checked[name='ids']");
			if(ids_.length === 0){
				dsmDialog.error("请先选择用户组!")
				return true;
			}else{
				return false;
			}
		}
	});
	</script>
</body>
</html>