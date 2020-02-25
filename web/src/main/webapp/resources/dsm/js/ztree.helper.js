var zTrees = {};
/**
 * 	简单封装了一下zTree，这是初始化方法，目前只支持三个事件的回调函数：鼠标左键点击、鼠标右键点击、异步加载成功
 * 			<li>初始化成功之后可在全局变量zTrees中通过zTrees['opt.id']获取zTree对象，通过该对象可以使用zTreeObj的方法</li>
 * @param opt
 * 			<li>opt.id: string类型参数，ztree容器页面元素id</li>
 * 			<li>opt.url: string类型参数，异步加载数据的url</li>
 * 			<ul>
 * 				<li>/department/tree.jhtml : 只有部门的树</li>
 * 				<li>/department/tree_user.jhtml : 包含部门和用户的树</li>
 * 				<li>/department/tree_teminal.jhtml : 包含部门和终端的树</li>
 * 				<li>... : 可以自己定义接口，返回数据格式参照前面的控制层</li>
 * 			</ul>
 * 			<li>opt.check: boolean类型参数，是否显示复选框</li>
 * 			<li>opt.zTreeOnClick: ztree节点 鼠标左键点击回调函数//function (event, treeId, treeNode){...}</li>
 * 			<li>opt.zTreeOnAsyncSuccess: ztree节点 异步加载完成回调函数//function (event, treeId, treeNode, msg){...}</li>
 * 			<li>opt.OnRightClick: ztree节点 鼠标右键点击回调函数//function (event, treeId, treeNode){...}</li>
 * 			<li>opt.rMenu.show: boolean类型参数，是否显示右键菜单，若为true，则必须给出opt.rMenu.id</li>
 * 			<li>opt.rMenu.id: string类型参数，右键菜单页面元素id</li>
 * @returns
 * 			<li>无返回值</li>
 */
function zTreeInit(opt){
	var o = {};
	var async = typeof opt.async !== "undefined" ? opt.async : true;
	//ztree 节点点击事件回调函数
	o.zTreeOnClick = function (event, treeId, treeNode){
		if(typeof opt.zTreeOnClick === "function"){
			opt.zTreeOnClick(event, treeId, treeNode);
		}
	}
	//ztree 异步成功回调函数
	o.zTreeOnAsyncSuccess = function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		if(typeof opt.zTreeOnAsyncSuccess === "function"){
			opt.zTreeOnAsyncSuccess(event, treeId, treeNode, msg);
		}
	};
	o.OnRightClick = function OnRightClick(event, treeId, treeNode) {
		$.fn.zTree.getZTreeObj(opt.id).selectNode(treeNode);
		if(opt.rMenu && opt.rMenu.show == true && opt.rMenu.id && treeNode){
			o.showRMenu(event.clientX, event.clientY);			
		}
		if(typeof opt.OnRightClick === "function"){
			opt.OnRightClick(event, treeId, treeNode);
		}
	}
	if(opt.rMenu && opt.rMenu.show == true && opt.rMenu.id){
		o.showRMenu = function showRMenu(x, y) {
			$("#" + opt.rMenu.id).show();
			$("#" + opt.rMenu.id).css({"top":y+"px", "left":x+"px", "visibility":"visible"});
			$("body").bind("mousedown", o.onBodyMouseDown);
		}
		o.onBodyMouseDown = function onBodyMouseDown(event){
			if (!(event.target.id == opt.rMenu.id || $(event.target).parents("#" + opt.rMenu.id).length>0)) {
				$("#" + opt.rMenu.id).css({"visibility" : "hidden"});
			}
		}
	}
	o.zNodes_init = function(){
		$.ajax({
			type:"get",
			url:opt.url,
			success:function(data){
				return data;
			},
			error:function(){
				return [{id:0 , name:"组织架构", isParent:true, iconSkin:"z_icon01", open:true}];
			}
		});
	};
	o.setting = {
			//设置是否允许同时选中多个节点，这里设为false
			view: {
				selectedMulti: false,
//				fontCss : {"font-size":"20px","letter-spacing": "1px"},
				showIcon: true,
			},
			//异步加载
			async: {
				enable: async,
				url: opt.url,
				type:"get",
				autoParam: ["id"]
			},
			/*edit: {
					enable: true,
					showRemoveBtn: false,
					showRenameBtn: false,
					drag: {
						isCopy: false,
						isMove: true
					}
				},*/
			//回调函数
			callback: {
				onClick: o.zTreeOnClick,
				onRightClick: o.OnRightClick,
				onAsyncSuccess: o.zTreeOnAsyncSuccess,
				//onDrop: zTreeOnDrop,
				//beforeDrag: zTreeBeforeDrag,
				//beforeDrop: zTreeBeforeDrop,
			},
			check: {
				enable: opt.check ? opt.check : false,
			},
			data: {
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId",
					rootPId: null
				},
			}
	};
	
	$(document).ready(function(){
		if(opt.data){
			zTrees[opt.id] = $.fn.zTree.init($("#" + opt.id), o.setting, opt.data);
		} else {
			zTrees[opt.id] = $.fn.zTree.init($("#" + opt.id), o.setting, o.zNodes_init());
		}
	});
}
