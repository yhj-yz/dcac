/**
 * 查看授权使用情况用到的柱状图
 * @param opt
 * 		{url:'获取json数据',id:'canvas标签id'}
 * @returns
 */
function drawBar(opt) {
	var start = function() {
		$.ajax({
			type: "get",
			url: opt.url,
			dataType: "json",
			success: function(data) {
				initBar(data);
				if (typeof(opt.success) === "function") {
					opt.success(data.title);
				}
			},
			error: function(e) {
				alert(JSON.stringify(e));
			}
		});
	}
	var color1 = "#03C4FC";
	var color2 = "#03fcac";
	var initBar = function(options) {
		var ctx = $("#" + opt.id);
		var data = {
			xLabels: options.labels,//x轴显示文字
			datasets: [{
				label: options.label1,//第一组标题
				backgroundColor: [color1, color1, color1, color1, color1, color1, color1],//第一组颜色
				data: options.data1,//第一组数据
			}, {
				label: options.label2,//第二组标题
				backgroundColor: [color2, color2, color2, color2, color2, color2, color2],
				data: options.data2,
			}, ]
		};
		var myBarChart = new Chart(ctx, {
			type: 'bar',
			data: data,
			options: {
				responsive: true,//图片大小是否自适应，默认为true
				maintainAspectRatio: false,
				scales: {
					xAxes: [{
						stacked: true,
					}],
					yAxes: [{
						stacked: false,
						gridLines: {
							offsetGridLines: false
						},
					}]
				}
			}
		});
		$(window).resize(function(){
			ctx.css({"width": ctx.parent().css("width"),"height": ctx.parent().css("height")});
		});
	}
	start();
}

/**
 * 文件数量统计用到的饼状图
 * @param opt
 * 		{url:'获取json数据',id:'canvas标签id'}
 * @returns
 */
function drawPie(opt){
	var start = function(){
		$.ajax({
			type:"get",
			url:opt.url,
			dataType:"json",
			success:function(data){
				pieInit(data);
				if (typeof(opt.success) === "function") {
					opt.success(data.title);
				}
			},error:function(e){
				alert(JSON.stringify(e));
			}
		});
	}
	var default_color = ["#FF6384","#36A2EB","#FFFF00","#FF9900","#33FFFF","#FFCCFF","#00FF99","#CCFF00","#FF66FF","#FFCC00"]
	var pieInit = function (options){
		var arr = new Array();
		for(var i = 0; i < options.labels.length; i++){
			arr.push(options.labels[i] + ": " + options.data[i]);
		}
		var ctx = $("#"+opt.id);
		var data = {
		    labels: arr,
		    datasets: [
		        {
		            data: options.data,
		            backgroundColor: options.color ? options.color : default_color,
		            hoverBackgroundColor: options.color ? options.color : default_color,
		        }]
		};
		var myPieChart = new Chart(ctx,{
		    type: 'pie',
		    data: data,
		    options: {
		     	legend:{
		     		position: "right",
		     	},
		     	responsive:false,
		        animation:{
		            animateScale:false,
		        },
		        title: {
		            display: typeof(opt.title)=="undefined"?true:opt.title,//标题是否显示
		            text: options.title,
		        },
		        tooltips: {
		           	callbacks: {
		           		title: function() {
							return '';
						},
		           		label: function (tooltipItem, data) {
		           			var x_value = data.datasets[0].data[tooltipItem.index];
		           			var x_total = eval(data.datasets[0].data.join('+'));
		           			var x_percent = data.datasets[0].data[tooltipItem.index]/x_total;
		           			return options.labels[tooltipItem.index] + ': ' + Number(x_percent*100).toFixed(1) + '%';
		           		}
		           	},
		        }
		    }
		});
	}
	start();
}