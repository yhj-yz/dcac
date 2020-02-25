<!--新增规则弹窗开始-->
<div class="add-print-pic-form " id="pop_rule" style="display:none;">
	<div class="dsmForms">
	<form id="popForm">
		<div class="dsm-form-item">
			<div class="dsm-inline">
				<label class="dsm-form-label">规则名称：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="规则名称" name="ruleName" class="dsm-input">
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">规则类型：</label>
				<div class="dsm-input-block">
					<div class="dsm-radio-one">
						<div class="dsm-radiobox">
							<input type="radio" id="t34" name="matchType" value="keyword" class="dsm-radio" checked="true">
							<label for="t34"></label>
						</div>
						<label class="radiolabel" for="t34">关键字</label>
					</div>

					<div class="dsm-radio-one">
						<div class="dsm-radiobox">
							<input type="radio" id="t35" name="matchType" value="filetype" class="dsm-radio" >
							<label for="t35"></label>
						</div>
						<label class="radiolabel" for="t35">文件类型</label>
					</div>

					<div class="dsm-radio-one">
						<div class="dsm-radiobox">
							<input type="radio" id="t36" name="matchType" value="regularexpression" class="dsm-radio" >
							<label for="t36"></label>
						</div>
						<label class="radiolabel" for="t36">正则表达</label>
					</div>
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">匹配内容：</label>
				<div class="dsm-input-block">
					<input type="text" autocomplete="off" placeholder="匹配内容" name="matchContent" class="dsm-input">
				</div>
				<span class="desc m-l-135">多个内容以|号分隔，如：合同|协议，最多支持3个</span>
			</div>
			<div class="dsm-inline" id="caseSensitive">
				<label class="dsm-form-label">是否区分大小写</label>
				<div class="dsmcheckbox enablecopy">
					<input type="checkbox" value="1" id="f412" name="caseSensitive" >
					<label for="f412"></label>
				</div>
			</div>
			<div class="dsm-inline">
				<label class="dsm-form-label">内容关系：</label>
				<div class="dsm-input-block">
					<div class="dsm-radio-one">
						<div class="dsm-radiobox">
							<input type="radio" id="t341" name="contentRelation" class="dsm-radio" checked="true" value="and">
							<label for="t341"></label>
						</div>
						<label class="radiolabel" for="t341">与</label>
					</div>

					<div class="dsm-radio-one">
						<div class="dsm-radiobox">
							<input type="radio" id="tt13" name="contentRelation" class="dsm-radio" value="or">
							<label for="tt13"></label>
						</div>
						<label class="radiolabel" for="tt13">或</label>
					</div>

				</div>
			</div>
		</div>
	</form>
	</div>
</div>
<!--新增规则弹窗结束-->
<script>
$(function(){
	jQuery.extend(jQuery.validator.messages, {
		  match: "*匹配内容不能超过3条",
		});
	jQuery.validator.addMethod("match", function(value, element) {  
	    var arr = value.split("|");
	    if( arr.length > 3){  
	        return false;
	    }
	    return true;  
	});
	$('#popForm').validate({
		rules: {
			"ruleName": {
				required: true,
				specialChar: true,
				maxlength: 32,
			},
			"matchContent": {
				required: true,
				match: true,
				maxlength: 1024,
			},
		},
	});
});
</script>
