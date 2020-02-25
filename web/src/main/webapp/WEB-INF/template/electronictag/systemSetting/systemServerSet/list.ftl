<!DOCTYPE html>
<html lang="ch">        
<head>
	<meta charset="UTF-8">
	<title>客户端连接设置</title>

	<!--全局通用!-->
	[#include "/dsm/include/head.ftl"]
	<!--全局通用end!-->
	<!--[if lt IE 9]>
      <script src="js/html5shiv/html5shiv.js"></script>
      <script src="js/respond/respond.min.js"></script>
    <![endif]-->

</head>
<body>
	<div class="dsm-rightside">
		<div class="maincontent">
			<div class="mainbox clientconnect">
				<div class="table-view">
					<table class="table" cellspacing="0" width="100%">
				        <thead>
				            <tr>
				                <th>服务器名称</th>
				                <th>IP或域名</th>
				                <th>连接端口</th>
				                <th>连接状态</th>
				                <th></th>
				            </tr>
				        </thead>
				        <tbody>
			               <form id="systemSetting">
					        	[#list servers as s]
					            <tr class=s.serverName>
					                <td>${s.serverName}<input type="hidden" data-name="id" name="id" value="${s.id}" ><input type="hidden" data-name="serverName" value="${s.serverName}"></td>
					                <td><span class="show">${s.serverIp}</span> <input type="text"data-name="serverIp" name="serverIp" autocomplete="off" value="${s.serverIp}" placeholder="IP或域名" class="dsm-input edit hidden ipordomain ipaddress"></td>
					                <td><span class="show">${s.serverPort}</span> <input type="text"data-name="serverPort" name="serverPort" autocomplete="off" value="${s.serverPort}" placeholder="端口" class="dsm-input edit hidden port"><button type="button" class="btn btn-primary f-l whitebg edit hidden js_submit">确定</button></td>
					                <td><span> <i class="icon icon-redclose"></i></span></td>
					                <td>
					                	<a class="listdetail bg-green js_showdedit"> <i class="icon icon-pen"></i></a>
					                </td>
					            </tr>
					            [/#list]
			                </form>
				        </tbody>
				    </table>
				</div>
				
			</div>
				<div class="form-btns t-l">
                        <button type="submit" class="btn btn-lg btn-primary js_save">保存设置</button>
                        <button   class="btn btn-lg btn-primary js_resetting">重置</button>
                    </div>
		</div>
	</div>

	<script type="text/javascript">
	$(document).ready(function(){
        
        //点击名称弹框
        $(document).on('click', '.js_showdedit', function (e) {
        	if($(this).hasClass('editing')){
	        	noEditStyle(this);
        	}else{	
	        	editStyle(this);
        	}
        });
        function editStyle(obj){
        	$(obj).parent().parent().find('.show').addClass('hidden');
        	$(obj).parent().parent().find('.edit').removeClass('hidden');
        	$(obj).addClass('editing');
        }
        function noEditStyle(obj){
        	$(obj).parent().parent().find('.show').removeClass('hidden');
        	$(obj).parent().parent().find('.edit').addClass('hidden');
        	$(obj).removeClass('editing');
        }
		
		
        $(document).on('click', '.js_submit', function (e) {
            //验证端口
        	if(!checkPort()){
        		dsmDialog.error("请输入正确的端口号");
        		return;
        	}
        	var btn = $(this).prop("disabled", true);
        	noEditStyle(this);
        	var tr = $(this).parents("tr:first");
        	var ip = tr.find("input[name='serverIp']").val();
	    	var port = tr.find("input[name='serverPort']").val();
    		var icon = tr.find(".icon-redclose").removeClass("active").addClass("activeing");
    		var id = tr.find("input[name='id']").val();
    	/*	submitForm({id:id,ip:ip,port:port,success:function(){
    			tr.find("span:first").text(ip);
    			tr.find("span:eq(1)").text(port);
    			btn.prop("disabled", false);
    		},error:function(){
	    		btn.prop("disabled", false);
    		}});
    		*/
    		testConnect({ip:ip,port:port,success:function(){
	    		icon.removeClass("activeing").addClass("active");
	    		btn.prop("disabled", false);
	    		tr.find("td:eq(1)").find("span").text(ip);
	    		tr.find("td:eq(2)").find("span").text(port);
    		},error:function(){
	    		icon.removeClass("activeing").removeClass("active");
	    		btn.prop("disabled", false);
	    		tr.find("td:eq(1)").find("span").text(ip);
	    		tr.find("td:eq(2)").find("span").text(port);
    		}});
        });
        
        function submitForm(v){
        	$.ajax({
				dataType : "json",
				type:"post",
				data : {
					"id" : v.id,
					"serverIp" : v.ip,
					"serverPort" : v.port
				},
				url : "update.jhtml",
				success : function(data) {
					if (data.type === "success") {
						v.success();
					} else {
						dsmDialog.error(data.content);
						v.error();
					}
				},
				error : function(e) {
					v.error();
				}
			});
        }
        //测试连接方法
		function testConnect(v) {
			$.ajax({
				dataType : "json",
				data : {
					"ip" : v.ip,
					"port" : v.port
				},
				url : "test_connect.jhtml",
				success : function(data) {
					if (data === true) {
						v.success();
					} else {
						v.error();
					}
				},
				error : function(e) {
					v.error();
				}
			})
		
		}
		
		$("tbody tr").each(function(){
	    	var tr = $(this);
        	var ip = tr.find("input[name='serverIp']").val();
	    	var port = tr.find("input[name='serverPort']").val();
    		var icon = tr.find(".icon-redclose").removeClass("active").addClass("activeing");
    		testConnect({ip:ip,port:port,success:function(){
	    		icon.removeClass("activeing").addClass("active");
    		},error:function(){
	    		icon.removeClass("activeing").removeClass("active");
	    		//sp.prop("disabled", false);
    		}});
    	});
    	
    	function checkPort(){
    		var port = $("input[name='serverPort']:visible").val();
    		return new RegExp(/^([0-9]|[1-9]\d{1,3}|[1-5]\d{4}|6[0-5]{2}[0-3][0-5])$/).test(port);
    	}
    	
        //保存设置方法    	
    	$(document).on('click','.js_save',function(){
    	    var hiddenLength=$("[name='serverIp'].hidden").length
    	    if(hiddenLength<6){
    	     dsmDialog.error("请确定被修改的服务器信息");
    	     return;
    	    }
    	    addIndex();
    	    $frm=$("#systemSetting");
    	    $.ajax({
    	          data:$frm.serialize(),
    	          dataType:"json",
    	          type:"get",
    	          url:"${base}/admin/systemServerSet/save.jhtml",
    	          success:function(data){
                    dsmDialog.msg("保存成功");
                    setTimeout("window.location.reload()",1000)      
    	          }, error:function(data){
    	            dsmDialog.error("保存失败");
    	          }
    	    })
    	
    	})
    	function addIndex(){
			$("tbody tr").each(function(index, data){
				var $tr = $(data);
				var prefix = "systemEntities["+index+"].";
				$tr.find("input[data-name]").each(function(){
					var n = $(this).data("name");
					$(this).attr("name", prefix + n);
				});
			});
		}
    	
    	//重置方法
    	$(document).on("click",".js_resetting",function(){
    	  dsmDialog.toComfirm("是否重置？", {
								btn: ['确定','取消'],
								title:"重置"
							}, function(index){
							   
					    	    $.ajax({
					    	           dataType:"json",
					    	           type:"get",
					    	           url:"${base}/admin/systemServerSet/reset.jhtml",
					    	           success:function(data){
					    	            dsmDialog.msg("重置成功");
					    	            setTimeout("window.location.reload()",1000);
					    	           },
					    	           error:function(data){
					    	           dsmDialog.error("重置失败");
					    	           }
					    	    })
							   
							}, function(index){						
								dsmDialog.close(index);
							});
    	    
    	})
    	
    	
    	
	});
	</script>
</body>
</html>