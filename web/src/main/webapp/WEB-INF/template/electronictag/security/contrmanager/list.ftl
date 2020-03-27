<!DOCTYPE html>
<html lang="ch">
<head>
	<meta charset="UTF-8">
	<title>配置程序管理</title>

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
				<button type="button" class="btn btn-primary js_add">
					<i class="btnicon icon-toolbar icon-add-white"></i>添加软件
				</button>
				<button type="button" class="btn btn-primary js_del">
					<i class="btnicon icon-toolbar icon-delete"></i>删除软件
				</button>
				<button type="button" class="btn btn-primary js_change">
					<i class="btnicon icon-toolbar icon-delete"></i>修改软件
				</button>
				<button type="button" class="btn btn-primary js_add_config">
					<i class="btnicon icon-toolbar icon-delete"></i>添加配置
				</button>
				<div class="boxPosition">
					<div class="searchbox">
						<input class="dsm-input js_search_txt" type="text" ><i class="icon icon-search js_search" title="搜索"></i>
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
								<th>软件名称</th>
								<th>详情</th>
							</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</form>
					<form id="search_form" action="search.do" data-func-name="refreshPage();" data-list-formid="datalist">
						<input type="hidden" name="softName" >
					</form>
				</div>
			</div>
			<!--添加软件-->
			<div id="addProgram" style="display:none;">
				<div class="dsmForms">
					<form id="formCustom">
						<div class="dsm-form-item dsm-big">
							<div class="dsm-inline">
								<label class="dsm-form-label">软件名称：</label>
								<div class="dsm-input-inline">
									<input type="text" autocomplete="off" name="softName" placeholder="软件名称" class="dsm-input required" dzbqSpecialChar="true" >
								</div>
								<div class="desc"><em>*</em></div>
								<div class="line-tip error" >*软件名称不能为空</div>
							</div>
						</div>
					</form>
				</div>
			</div>

			<!--添加配置-->
			<div id="addConfig" style="display: none;">
				<div class="dsmForms">
					<form id="configForm">
						<div class="dsm-form-item dsm-big">
							<div class="dsm-inline">
								<label class="dsm-form-label ">进程名称：</label>
								<div class="dsm-input-inline">
									<input type="hidden" name="softId">
									<input type="text" autocomplete="off" id="version" name="processName" placeholder="进程名称" class="dsm-input form_input required" ContrSpecialChar="true" maxlength="32">
									<label for="version" class="error" style="display:none;">*必填</label>
								</div>
								<div class="desc"><em>*</em></div>
							</div>
							<div class="dsm-inline fileType">
								<label class="dsm-form-label ">受控类型：</label>
								<div class="dsm-input-inline">
									<textarea name="manageType" id="manageType" cols="10" rows="2" class="dsm-textarea form_input" ContrSpecialChar="true" maxlength="2000"></textarea>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>

			<!--详情 -->
			<form id="detail_form" style="display: none">
				<table id="detail_list" class="table" cellspacing="0" width="100%">
					<thead>
					<tr>
						<th class="w40">
							<div class="dsmcheckbox">
								<input type="checkbox" id="checkbox_detail" value="1"
									   class="js_checkboxAll" data-allcheckfor="processIds">
								<label for="checkbox_detail"></label>
							</div>
						</th>
						<th>进程名称</th>
						<th>受控类型</th>
					</tr>
					</thead>
					<tbody>
					</tbody>
					<div class="btn-toolbar">
						<button type="button" class="btn btn-primary js_del_config">
							<i class="btnicon icon-toolbar icon-delete"></i>删除配置
						</button>
						<button type="button" class="btn btn-primary js_change_config">
							<i class="btnicon icon-toolbar icon-delete"></i>修改配置
						</button>
					</div>
				</table>
			</form>

			<form id="search_form" action="search.do" data-func-name="refreshPage();" data-list-formid="datalist">
				<input type="hidden" name="softName" >
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
				var _id = _data.id;
				var _text = "<tr>\
								<td><div class='dsmcheckbox'>\
								<input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>\
								<td class='hiddentd'><div class='hiddendiv' title='" + _data.softName + "'>" + _data.softName + "</div></td> \
								<td><a onclick='getDetails(\""+_id+"\")'>详情</a></td>\
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
			dsmDialog.error("请先选择软件!");
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
		$("#search_form input[name='softName']").val(search_name);
		$("#search_form").attr("action", "search.do");
		refreshPage();
	}

	//搜索
	$(document).on('click', '.js_search', function (e) {
		search($(this).prev().val());
	});

	//新增软件
	$(document).on('click', '.js_add', function (e) {
		$("#addProgram").find("input").val("");
		dsmDialog.open({
			type: 1,
			area: ['500px', '250px'],
			btn: ['确定', '取消'],
			title: "添加软件",
			content: $('#addProgram'),
			yes: function (index, layero) {
				$.ajax({
					data: $("#formCustom").serialize(),
					dataType: "json",
					type: "post",
					url: "saveSoftWare.do",
					success: function (data) {
						if (data.type == "success") {
							dsmDialog.close(index);
							dsmDialog.msg(data.content);
							setTimeout(function () {
								window.location.reload();
							},1500);
						} else {
							dsmDialog.error(data.content);
						}
					}
				});
			},
			btn2: function (index, layero) {
				$(".error").empty();
				dsmDialog.close(index);
			}
		});
	});

	//删除软件
	$(document).on('click', '.js_del', function (e) {
		if(noItemSelected()){//如果用户没有勾选
			return;
		};
		dsmDialog.toComfirm("是否执行删除操作？", {
			btn: ['确定','取消'],
			title:"删除软件"
		}, function(index){
			var ids_ = "";
			$("#list_form :checked[name='ids']").each(function(i){
				ids_ += $(this).val()+",";
			});
			$.ajax({
				dataType:"json",
				type: "post",
				url: "deleteSoftWare.do",
				data: {ids : ids_},
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

	//修改软件
	$(document).on("click",".js_change",function(){
		if(noItemSelected()){//如果用户没有勾选
			return;
		};
		var isOne = true;
		$("#list_form :checked[name='ids']").each(function(i){
			if(i >= 1){
				dsmDialog.error("不能勾选多个软件");
				isOne = false;
			}
		});
		if(isOne) {
			$.ajax({
				data: {id: $("#list_form :checked[name='ids']").val()},
				dataType: "json",
				type: "get",
				url: "showSoftWare.do",
				success: function (data) {
					updateProgram($("#list_form :checked[name='ids']").val(), data.softName);
				}
			});
		}
	})

	//软件修改方法
	function updateProgram(id,softName){
		$("#addProgram").find("input[name='softName']").val(softName);
		dsmDialog.open({
			type: 1,
			area:['500px','250px'],
			btn:['确定','取消'],
			title:"修改软件",
			content: $('#addProgram'),
			yes: function(index, layero){
				$.ajax({
					data: {id:id,
					       softName:$("#formCustom input[name='softName']").val()},
					dataType: "json",
					type: "post",
					url: "updateSoftWare.do",
					success: function (data) {
						if (data.type == "success") {
							dsmDialog.close(index);
							dsmDialog.msg(data.content);
							setTimeout(function () {
								window.location.reload();
							},1500);
						} else {
							dsmDialog.error(data.content);
						}
					}
				});
			},
			btn2: function(index, layero){
				$(".error").empty();
				dsmDialog.close(index);
			}
		});
	}

	//添加配置方法
	$(document).on("click",".js_add_config",function(){
		$("#addConfig").find("input").val("");
		if(noItemSelected()){//如果用户没有勾选
			return;
		};
		var isOne = true;
		$("#list_form :checked[name='ids']").each(function(i){
			if(i >= 1){
				dsmDialog.error("不能勾选多个软件");
				isOne = false;
			}
		});
		if(isOne) {
			$("#addConfig").find("input").val();//初始化输入框
			$("input[name='softId']").val($("#list_form :checked[name='ids']").val());
			dsmDialog.open({
				type: 1,
				area: ['460px', '380px'],
				btn: ['确定', '取消'],
				title: "添加配置",
				content: $('#addConfig'),
				yes: function (index, layero) {
					$.ajax({
						data: $("#configForm").serialize(),
						dataType: "json",
						type: "post",
						url: "addConfig.do",
						success: function (data) {
							if (data.type == "success") {
								dsmDialog.close(index);
								dsmDialog.msg(data.content);
								setTimeout(function () {
									window.location.reload();
								},1500);
							} else {
								dsmDialog.error(data.content);
							}
						}
					});
				},
				btn2: function (index, layero) {
					$(".error").empty();
					dsmDialog.close(index);
				}
			});
		}
	});

	//检查是否勾选配置
	function noItemSelectedProcess(){
		var ids_ = $("#detail_form :checked[name='processIds']");
		if(ids_.length === 0){
			dsmDialog.error("请先选择进程!")
			return true;
		}else{
			return false;
		}
	}

	//删除配置方法
	$(document).on("click",".js_del_config",function(){
		if(noItemSelectedProcess()){//如果用户没有勾选
			return;
		};
		dsmDialog.toComfirm("是否执行删除操作？", {
			btn: ['确定','取消'],
			title:"删除配置"
		}, function(index){
			var ids_ = "";
			$("#detail_form :checked[name='processIds']").each(function(i){
				ids_ += $(this).val()+",";
			});
			$.ajax({
				dataType:"json",
				type: "post",
				url: "deleteConfig.do",
				data: {ids : ids_},
				success: function(data){
					if(data && data.type === "success"){
						dsmDialog.msg(data.content);
						setTimeout(function () {
							window.location.reload();
						},1500);
					} else {
						dsmDialog.error(data.content);
					}
				}
			});
		}, function(index){
			dsmDialog.close(index);
		});
	});

	function getDetails(softId){
		$("#detail_list tbody").html("");
		$.ajax({
			data: {id: softId},
			dataType: "json",
			type: "get",
			url: "showSoftWare.do",
			success: function (data){
				var process = data.processEntities;
				var text = "";
				if (process.length > 0) {
					for (var index in process) {
						text += "<tr>\
									<td><div class='dsmcheckbox'>\
									<input type='checkbox' name='processIds' id='p_" + process[index].id + "' value='" + process[index].id + "'/><label for='p_" + process[index].id + "'></label></div></td>\
									<td>" + process[index].processName + "</td>\
									<td class='hiddentd'><div class='hiddendiv' title='" + process[index].managerTypeEntities[0].manageName + "'>" + process[index].managerTypeEntities[0].manageName + "</div></td>\
								 </tr>";
					}
				}
				$("#detail_list tbody").append(text);
				$("#detail_form").css("display","block");
			}
		});
		dsmDialog.open({
			type: 1,
			area:['800px','500px'],
			btn:false,
			title:"详情",
			content: $('#detail_form')
		});
	}

	//修改配置
	$(document).on("click",".js_change_config",function(){
		if(noItemSelectedProcess()){//如果用户没有勾选
			return;
		};
		var isOne = true;
		$("#detail_form :checked[name='processIds']").each(function(i){
			if(i >= 1){
				dsmDialog.error("不能勾选多个进程");
				isOne = false;
			}
		});
		if(isOne) {
			$.ajax({
				data: {id: $("#detail_form :checked[name='processIds']").val()},
				dataType: "json",
				type: "get",
				url: "showProcess.do",
				success: function (data) {
					changeConfig($("#detail_form :checked[name='processIds']").val(), data.processName,data.managerTypeEntities[0].manageName);
				}
			});
		}
	});

	//修改配置方法
	function changeConfig(processId,processName,manageName) {
		$("#addConfig").find("input[name='processName']").val(processName);
		$("#manageType").val(manageName);
		dsmDialog.open({
			type: 1,
			area:['500px','250px'],
			btn:['确定','取消'],
			title:"修改配置",
			content: $('#addConfig'),
			yes: function(index, layero){
				$.ajax({
					data: {
						id: processId,
						processName: $("#configForm input[name='processName']").val(),
						manageName: $("#manageType").val()
					},
					dataType: "json",
					type: "post",
					url: "updateConfig.do",
					success: function (data) {
						if (data.type == "success") {
							dsmDialog.close(index);
							dsmDialog.msg(data.content);
							setTimeout(function () {
								window.location.reload();
							},1500);
						} else {
							dsmDialog.error(data.content);
						}
					}
				});
			},
			btn2: function(index, layero){
				$(".error").empty();
				dsmDialog.close(index);
			}
		});
	}

</script>
</body>
</html>