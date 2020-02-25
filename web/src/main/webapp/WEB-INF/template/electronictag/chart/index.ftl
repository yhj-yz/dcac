<!DOCTYPE html>
<html>
<head>
[#include "/dsm/include/head.ftl"]
<script type="text/javascript" src="${base}/resources/dsm/js/Chart.js"></script>
<title>控制台首页</title>
</head>
<body>

	<div id="test" style="width: 800; height: 1000">
		<canvas id="myChart1" width="450" height="450" style="float:left;"></canvas>
	</div>
	
<script>
$(function(){
	drawPie({
		url:"test_chartjs.jhtml",
		id:"myChart1"
	});
});
function drawPie(opt){
	var dataInit = function(){
		$.ajax({
			type:"get",
			url:opt.url,
			dataType:"json",
			success:function(s){
				var option1={
					id: opt.id,
					title: s.title,
					labels: s.labels,
					data: s.data,
				};
				chartInit(option1);
			},error:function(e){
				alert(JSON.stringify(e))
			}
		});
	}
	var default_color = ["#FF6384","#36A2EB","#FFFF00","#FF9900","#33FFFF","#FFCCFF","#00FF99","#CCFF00","#FF66FF","#FFCC00"]
	var chartInit = function (options){
		var arr = new Array();
		for(var i = 0; i < options.labels.length; i++){
			arr.push(options.labels[i] + ": " + options.data[i]);
		}
		var ctx = $("#"+options.id);
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
		            display: true,
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
	dataInit();
}
</script>
</body>
</html>