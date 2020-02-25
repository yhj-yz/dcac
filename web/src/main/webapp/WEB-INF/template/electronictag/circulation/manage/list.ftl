<!DOCTYPE html>
<html lang="ch">
<head>
	<meta charset="UTF-8">
	<title>流转管理</title>
	[#include "/dsm/include/head.ftl"]
	<!--时间选择器-->
	<script src="${base}/resources/dsm/js/My97DatePicker/WdatePicker.js"></script>
	<!--按页码查询-->
	<script src="${base}/resources/dsm/js/page.js"></script>
</head>
<body>
	<div class="dsm-rightside">
		<div class="maincontent">
			<div class="mainbox">
				<div class="main-right"  style="left: 0;">
					[#assign searchMap='{
						"organizationName":"单位名称",
						"srcFileName":"源文件名称",
						"circulationFileName":"流转文件名称"
						}' /]
					[#assign form="search_form"]
					[#include "/dsm/include/search.ftl"]
					<div class="btn-toolbar">
						<a href='${base}/admin/circulationManage/add.jhtml?id=-1' type="button" class="btn btn-primary">
							<i class="btnicon icon icon-add-white"></i>流转
						</a>
						<button type="button" class="btn btn-primary js_del" style="margin-left: 15px">
							<i class="btnicon icon icon-delete"></i>删除
						</button>
					</div>
					<div id="backupManager">
						<div class="table-view">
							<form id="list_form">
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
										<th>单位名称</th>
										<th>源文件</th>
										<th>流转文件</th>
										<th>状态</th>
									</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
							</form>
							<form id="search_form" action="search.jhtml" data-func-name="refreshPage();" data-list-formid="datalist" style="width: 100%;position: fixed;bottom: 0; background-color: #fff;height: 35px;">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="${base}/resources/dsm/js/dsm-search.js"></script>
<script type="text/javascript">

	function changeForm(div) {
		$(".dsm-form-item").hide();
		$("#" + div).show();
	}

	//刷新分页列表
	function refreshPage() {
		refreshPageList({
			id: "search_form",
			pageSize: 10,
			dataFormat: function (_data) {
				var _id = _data.id;
				var organizationName = _data.organizationName;
				var srcFileName = _data.srcFileName;
				var circulationFileName = _data.circulationFileName == null ? '' : _data.circulationFileName;
				var state = _data.state;
				if(state == 1){
					state = '成功';
				}else{
					state = '失败';
				}
				var _text = "<tr>"+
						"<td width='10%'><div class='dsmcheckbox'>"+
						"<input type='checkbox' name='ids' id='m_" + _id + "' value='" + _id + "'/><label for='m_" + _id + "'></label></div></td>"+
						"<td class='hiddentd'><div class='hiddendiv' title='"+_data.organizationName+"'>"+ organizationName +"</div></td>"+
						"<td class='hiddentd'><div class='hiddendiv' title='"+_data.srcFileName+"'><a class=\'link\' style=\'cursor: pointer;\'>" + srcFileName + "<a></div></td>"+
						"<td class='hiddentd'><div class='hiddendiv' title='"+_data.circulationFileName+"'><a class=\'link\' style=\'cursor: pointer;\'>" + circulationFileName + "</a></div></td>"+
						"<td class='hiddentd'><div class='hiddendiv' title='"+state+"'>" + state + "</div></td>"+
						"</tr>";
				return _text;
			}
		});
	}

	$(document).ready(function () {
		//.dsm-searchbar有显示问题
		$('.dsm-searchbar').attr('style', 'position:unset;margin-bottom: 15px;');

		function search(search_name) {
			if (search_name.length > 32) {
				dsmDialog.error("搜索框最多输入32位");
				return;
			}
			$("#search_form input[name='strategyName']").val(search_name);
			$("#search_form").attr("action", "search.jhtml");
			refreshPage();
		}

		//搜索
		$(document).on('click', '.js_search', function (e) {
			search($(this).prev().val());
		});

		$(document).on("click",".link",function () {
			var url = 'download.jhtml?file='+encodeURI($(this).html());
			location.href = url;
		})

		//搜索结果高亮显示
		$(document).on("keyup", ".js_userkey", function () {
			var key = $(this).val();
			var container = $(this).parent().parent().parent().next();
			container.removeHighlight();
			if (key.length > 0) {
				container.highlight(key);
			}
		});

		//新增 备份策略
		$(document).on('click', '.js_add', function (e) {
			window.location.href="add.jhtml";

		});
		$(document).on('click', '.js_del', function (e) {
			if (noItemSelected()) {//如果用户没有勾选
				return;
			}
			dsmDialog.toComfirm("是否执行删除操作？", {
				btn: ['确定', '取消'],
				title: "删除流转文件"
			}, function (index) {
				var $frm = $("#list_form");
				$.ajax({
					dataType: "json",
					type: "post",
					url: "delete.jhtml",
					data: $frm.serialize(),
					success: function (data) {
						if (data && data.type === "success") {
							dsmDialog.msg(data.content);
							refreshPage();
						} else {
							dsmDialog.error(data.content);
							refreshPage();
						}
					}
				});
			}, function (index) {
				dsmDialog.close(index);
			});

		});
		refreshPage();

		//检查是否勾选
		function noItemSelected() {
			var ids_ = $("#list_form :checked[name='ids']");
			if (ids_.length === 0) {
				dsmDialog.error("请先选择流转文件!")
				return true;
			} else {
				return false;
			}
		}


	});


</script>
</body>
</html>