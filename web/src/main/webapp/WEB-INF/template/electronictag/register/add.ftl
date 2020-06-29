<!DOCTYPE html>
<html lang="ch">
<head>
	<meta charset="UTF-8">
	<title>注册</title>
	[#include "/include/head.ftl"]
	<script type="text/javascript" src="${base}/resources/dsm/js/page.js"></script>
	<style>
		.highlight {background-color: yellow}
	</style>
	<script type="text/javascript" src="${base}/resources/dsm/js/highlight.js"></script>
</head>
<body>
<div class="main" style="text-align: center">
	<form id="form" action="authentication/save.do" method="post">
		<div class="loginbox">
			<div class="loginbox-body">
				<div class="login-info" style="padding-top: 36px;">
					<div class="login-input">
						<input id="appId" type="text" class="dsm-input account l-input "
							   autocomplete="off"
							   placeholder="appId" name="appId">
					</div>
					<div class="login-input">
						<input type="password" class="dsm-input password l-input" id="productKey" autocomplete="off"
							   placeholder="productKey" name="productKey">
					</div>
					<div class="loginbox-footer">
						<a href="#"
						   class="btn btn-primary btn_login" onclick="register()">注册</a>
					</div>
				</div>
			</div>

		</div>
	</form>
</div>
<script type="text/javascript">

	function register(){
		$.ajax({
			data: $('#form').serialize(),
			type: "post",
			url: "save.do",
			dataType: "json",
			success: function (data) {
				if (data.status == "500") {
					dsmDialog.error(data.msg);
				} else {
					dsmDialog.msg(data.msg);
					dsmDialog.close(index);
					refreshPage();
				}
			},
			error: function () {
				dsmDialog.msg("网络错误,请稍后尝试");
			}
		});
	}
</script>
</body>
</html>