<!DOCTYPE html>
<html lang="ch">        
<head>
	<meta charset="UTF-8">
	<title>外发文件数量统计</title>
	[#include "/dsm/include/head.ftl"]
	<link href="${base}/resources/dsm/css/zTreeStyle.css" rel="stylesheet" />
	<script type="text/javascript" src="${base}/resources/dsm/js/jquery.ztree.all.min.js"></script>
	<script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
	<script type="text/javascript" src="${base}/resources/dsm/js/echarts.min.js"></script>
	<script type="text/javascript" src="${base}/resources/dsm/js/echarts.helper.js"></script>
</head>
<body>
	<div class="dsm-rightside chartdetails">
		<div class="maincontent">
			<div class="mainbox clearfix">
				<div class="main-left">
					<div class="orglist">
						<div class="treedata">
							<ul id="dsmOrgTree" class="ztree"></ul>
						</div>
						<div class="zclosebtn js_showchartzree"><i class="icon icon-blue-s-left"></i></div>
					</div>
				</div>
				<div class="main-right">
					<div class="chartbox">
						<div class="chartitem">
							<div class="chart-header">
								<span class="title"><i class="icon icon-chart"></i>客户端外发数量总数：</span>
								<span class="total">0</span>个
							</div>
							<div class="chart-body">
								<div id="outside_file" width="100%" height="100%"></div>
							</div>
						</div>
					</div>
					<div class="chartbox">
						<div class="chartitem">
							<div class="chart-header">
								<span class="title"><i class="icon icon-chart"></i>审批流程外发数量总数：</span>
								<span class="total">0</span>个
							</div>
							<div class="chart-body">
								<div id="flow_outside_file" width="100%" height="100%"></div>
							</div>
						</div>
					</div>
					<div class="totaltable wb50">
						<form id="list_form" >
						<table class="table" cellspacing="0" width="100%">
					        <thead>
					            <tr>
					                <th>序号</th>
					                <th>账号</th>
					                <th>外发文档数量</th>
					            </tr>
					        </thead>
					        <tbody>
					        
					        </tbody>
					    </table>
					    </form>
					    <form id="search_form" action="page/department.jhtml" data-func-name="refreshPage();" data-list-formid="list_form">
							<input type="hidden" name="id" >
						</form>
				    </div>

					<div class="totaltable wb50">
						<form id="list_form_flow" >
						<table class="table" cellspacing="0" width="100%">
					        <thead>
					            <tr>
					                <th>序号</th>
					                <th>申请人</th>
					                <th>外发文档数量</th>
					            </tr>
					        </thead>
					        <tbody>
					        
					        </tbody>
					    </table>
					    </form>
					    <form id="search_form_flow" action="flow/page/department.jhtml" data-func-name="refreshPageFlow();" data-list-formid="list_form_flow">
							<input type="hidden" name="id" >
						</form>
				    </div>
				</div>
			</div>
		</div>
	</div>

		
	<script type="text/javascript">
	//departmentId=选中节点id(单个), 初始为1
	var zTree, departmentId = 1;
	
	//ztree 节点点击事件回调函数
	function zTreeOnClick(event, treeId, treeNode){
		departmentId = treeNode.id;
		$("input[name='id']").val(departmentId);
		pieInit({
			id: "outside_file",
			url: "${base}/admin/chart_detail/outside/pie/department.jhtml?id=" + departmentId
		});
		pieInit({
			id: "flow_outside_file",
			url: "${base}/admin/chart_detail/outside/flow/pie/department.jhtml?id=" + departmentId
		});
		refreshPage();
		refreshPageFlow();
	}
	
	
	//ztree 异步成功回调函数
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		var node = zTree.getNodeByParam("id",departmentId);
	    zTree.selectNode(node);
	};
	
	//ztree设置
	var setting = {
	
		//设置是否允许同时选中多个节点，这里设为false
		view: {
			selectedMulti: false,
			fontCss : {"font-size":"20px","letter-spacing": "1px"},
			showIcon: true,
		},
		//异步加载
		async: {
			enable: true,
			url:"${base}/admin/department/tree.jhtml",
			type:"get",
			autoParam: ["id"]
		},
		
		
		//回调函数
		callback: {
			onClick: zTreeOnClick,
			onAsyncSuccess: zTreeOnAsyncSuccess,
		},
		simpleData: {
			enable: true,
			idKey: "id",
			pIdKey: "pId",
			rootPId: 0
		},
		
	};
	
	
	//ztree初始节点数据
	//var zNodes = [{id:0 , name:"组织架构", isParent:true, iconSkin:"z_icon01", open:true}];
	var zNodes = function(){
		$.ajax({
			type:"get",
			url:"${base}/admin/department/tree_init.jhtml",
			success:function(data){
				return data;
			},
			error:function(){
				return [{id:0 , name:"组织架构", isParent:true, iconSkin:"z_icon01", open:true}];
			}
		});
	};

	$(document).ready(function(){
		zTree = $.fn.zTree.init($("#dsmOrgTree"), setting, zNodes());
		pieItem({id:"outside_file",url:"${base}/admin/chart_detail/outside/pie/department.jhtml?id=" + departmentId});
		pieItem({id:"flow_outside_file",url:"${base}/admin/chart_detail/outside/flow/pie/department.jhtml?id=" + departmentId});
		resizeItemById("outside_file");
		resizeItemById("flow_outside_file");
		$("input[name='id']").val(departmentId);
		refreshPage();
		refreshPageFlow();
	});
	
	function pieInit(v){
		var container = $("#"+v.id);
		if (container.length === 1) {
			echarts.dispose(container.get(0));
		}
		pieItem({id:v.id,url:v.url});
	}
	//画饼
	function pieItem(v){
		var sp = $("#" + v.id).parent();
		$("#" + v.id).css({"width":sp.width(),"height":sp.height()})
		drawPie({
			url:v.url,
			id:v.id,
			title:false,
			success:function(title){
				sp.parent().find(".total").text(title);
			}
		});
	}
	//饼图缩放
	function resizeItemById(id){
		$(window).resize(function(){
			var container = $("#"+id);
			container.css({"width": container.parent().css("width"),"height": container.parent().css("height")});
			var domItem = container.get(0);
			echarts.getInstanceByDom(domItem).resize();
		});
	}
	
	
	//刷新分页列表
	function refreshPage(){
		refreshPageList({id :"search_form",
			pageSize:10,
			dataFormat :function(_data){
				var _name = _data.name.split(":")[0];
				var _id = _data.id;
				var _text = "<tr>"+
							"<td>"+_data.order+"</td>"+
							"<td>"+_name+"</td>"+
							"<td><a href='#'>"+_data.value+"</a></td>"+
							"</tr>";
				return _text;
			}});
		
	}
	//刷新分页列表
	function refreshPageFlow(){
		refreshPageList({id :"search_form_flow",
			pageSize:10,
			dataFormat :function(_data){
				var _name = _data.name.split(":")[0];
				var _id = _data.id;
				var _text = "<tr>"+
							"<td>"+_data.order+"</td>"+
							"<td>"+_name+"</td>"+
							"<td><a href='#'>"+_data.value+"</a></td>"+
							"</tr>";
				return _text;
			}});
		
	}
	</script>
</body>
</html>