<!DOCTYPE html>
<html lang="ch">        
<head>
	<meta charset="UTF-8">
	<title>登录页面</title>

	[#include "/dsm/include/head.ftl"]

</head>
<body>
	<div class="dsmapp serverset">
		<div class="header">
			<div class="appinfo">				
				<a class="dsm-logo" href="#"><img src=""></a>
				<span class="companyname">杭州华途软件有限公司文档安全管理系统</span>
			</div>
		</div>
		<div class="main">
			<div class="serverSetForm">
				<h4>设置数据库连接</h4>
		    	<div class="dsm-form-item">
					<form>
		            <div class="dsm-inline">
	                    <label class="dsm-form-label">数据库地址：</label>
	                    <div class="dsm-input-block">
	                        <input type="text" autocomplete="off" placeholder="数据库地址" class="dsm-input" name="dbIp" value="${db.dbIp}">
	                    </div>
	                </div>
	                <div class="dsm-inline">
	                    <label class="dsm-form-label">数据库名称：</label>
	                    <div class="dsm-input-block">
	                        <input type="text" autocomplete="off" placeholder="数据库名称" class="dsm-input" name="dbName" value="${db.dbName}">
	                    </div>
	                </div>
	                <div class="dsm-inline">
	                    <label class="dsm-form-label">数据库账号：</label>
	                    <div class="dsm-input-block">
	                        <input type="text" autocomplete="off" placeholder="数据库账号：" class="dsm-input" name="username" value="${db.username}">
	                    </div>
	                </div>
	                <div class="dsm-inline">
	                    <label class="dsm-form-label">数据库密码：</label>
	                    <div class="dsm-input-block">
	                        <input type="password" autocomplete="off" placeholder="数据库密码：" class="dsm-input" name="pwd" value="${db.pwd}">
	                    </div>
	                </div>
	                </form>
		        </div>
					  
		        <div>
	                <button type="button" class="btn btn-lg btn-primary setbtn js_set">设置</button>
		        	<a href="../login.jsp" class="btn btn-lg btn-primary">取消</a>
		        </div>      
			</div>
		</div>
		<div class="footer">
			<span>数据版本：XXXXXXXXX</span>丨<span>数据版本：XXXXXXXXX</span>
		</div>
	</div>	
</body>
<script>
$(function() {
	// 表单验证
	var $inputForm = $("form");
	$inputForm.validate({
		rules: {
			dbIp: {
				required: true,
			},
			dbName: {
				required: true,
			},
			username: {
				required: true,
			},
			pwd: {
				required: true,
			},
		}
	});
	
	$(document).on("click", ".js_set", function(){
		if($inputForm.valid()){
			/*$.ajax({
				url: "update.jhtml",
				type: "post",
				data: $inputForm.serialize(),
				success: function(){
					var mask = layer.load(1, { shade: [0.4,'#fff'], success:function(){
						dsmDialog.msg('设置成功!');
						setTimeout("layer.closeAll('loading')",10000);
					}});
				}
			});*/
			var mask = layer.load(1, { shade: [0.4,'#fff'], success:function(){
				setTimeout(function(){
					dsmDialog.msg('设置成功!');
					layer.closeAll('loading');
				},3000);
			}});
		}
	});
})
	
</script>
</html>