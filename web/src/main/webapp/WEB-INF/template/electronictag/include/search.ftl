[#assign search_data=searchMap?eval /]
<div class="dsm-searchbar">
	<div class="filter" id="search">
		[#list search_data?keys as key ]
		[#if key?ends_with('-checkb')][#-- checkbox查询 --]
			[#assign key_ck=key?substring(0,key?index_of('-checkb'))]
			<div id="f${key_ck}" class="simulate-list ks-overlay ks-overlay-hidden">
				<div class="ks-popup-content">
					<div class="ks-popup-content checkboxtype">
						[#list search_data["${key}"]?keys as key_item]
						<div class=" checkboxbt">
							<div class="dsmcheckbox">
								[#assign txt = search_data["${key}"]["${key_item}"] /]
								<input type="checkbox" value="${key_item!}" id="${key!}${key_item!}" class="checkb fiterpara" data-selected-desc="${txt?substring(txt?index_of("-")+1,txt?length)}" data-request="${key_ck}" name="${key_ck}">
								<label for="${key!}${key_item!}"></label>
							</div>
							<label for="dtype">${txt?substring(txt?index_of("-")+1,txt?length)}</label>
						</div>
						[/#list]
					</div>
				</div>
			</div>
		[#else][#-- text查询 --]
			<div id="f${key!}" class="simulate-list ks-overlay ks-overlay-hidden">
				<div class="ks-popup-content">
					[#if key?ends_with('-Wdate')][#-- 日期查询 --]
					[#assign key_date=key?substring(0,key?index_of('-Wdate'))]
					<input data-selected-desc="${search_data["${key!}"]}:" data-request="${key_date!}" class="fiterpara Wdate" readonly type="text" value="" onclick="WdatePicker()">-
					<input data-selected-desc="${search_data["${key!}"]}:" data-request="${key_date!}" class="fiterpara Wdate" readonly type="text" value="" onclick="WdatePicker()">
					[#else]
					<input data-selected-desc="${search_data["${key!}"]}:" data-request="${key!}" class="fiterpara" type="text" value="">
					[/#if]
					<button class="subfiter" type="button">确定</button>
				</div>
			</div>
		[/#if]
		[/#list]
		<div class="clearfix">
			<dl>
				<dt>筛选条件：</dt>
				[#list search_data?keys as key ]
				<dd>
					[#if key?ends_with('-checkb')][#-- checkbox查询 --]
						[#assign key_ck=key?substring(0,key?index_of('-checkb'))]
						[#list search_data["${key}"]?keys as key_item]
						[#if key_item_index==0]
						[#assign txt = search_data["${key}"]["${key_item}"] /]
						<span class="simulate-select" data-sim-obj="f${key_ck!}" data-sim-z="${key_ck!}"><span class="J_simulate_value">${txt?substring(0,txt?index_of("-"))}</span><em></em></span>
						[/#if]
						[/#list]
					[#else]
					<span class="simulate-select" data-sim-obj="f${key!}" data-sim-z="${key!}"><span class="J_simulate_value">${search_data["${key!}"]}</span><em></em></span>
					[/#if]
				</dd>
				[/#list]
			</dl>
		</div>
		<dl class="clearfix filter-selected-list"  data-searchform="${form}">
			<dt>已选条件：</dt>
			<button type="button" class="btn btn-primary f-r whitebg js_clearall">清除筛选条件</button>
		</dl>
	</div>
</div>