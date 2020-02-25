/**
 * 查看授权使用情况用到的柱状图
 * @param opt
 * 		{url:'获取json数据',id:'canvas标签id'}
 * @returns
 */
function drawBar(opt) {
	
}

/**
 * 文件数量统计用到的饼状图
 * @param opt
 * 		{url:'获取json数据',id:'canvas标签id'}
 * @returns
 */
function drawPie(opt){
	// 基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById(opt.id));
    // 指定图表的配置项和数据
	var data2option = function(data){
		var dataset = data.data;
		var legend_dataset = [];
		var show_tooltip = true;
		for(var i=0;i<data.data.length;i++){
			var legend_obj={};
			legend_obj.name=data.data[i].name;
//			legend_obj.icon='path://M700 200 A 600 600 0 0 0 100 200 M700 200 L600 400  A 500 500 0 0 0 200 400 L100 200 z';
			legend_obj.icon='path://M490 80 A 1000 1000 0 0 0 89 80 M490 80 L390 100  A 440 440 0 0 0 190 100 L89 80 z';
//			legend_obj.icon='diamond';
			legend_dataset.push(legend_obj);
		}
		if (data.data.length === 0) {
			var obj={};
			var legend_obj={};
			obj.name='没有数据';
			obj.value=0;
			legend_obj.name='没有数据';
			legend_obj.icon='path://M490 80 A 1000 1000 0 0 0 89 80 M490 80 L390 100  A 440 440 0 0 0 190 100 L89 80 z';
			dataset.push(obj);
			legend_dataset.push(legend_obj);
			show_tooltip = false;
		}
		var option = {
			    title : {
//			        text: data.title,
//			        subtext: '纯属虚构',
//			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item',
			        show: show_tooltip,
//			        formatter: "{b} : {d}%",
			        formatter: function(params, ticket, callback){
			        	return params.name.split(":")[0] + " : " + params.percent + "%";
			        },
			    },
			    legend: {
			        orient: 'vertical',
			        left: 'right',
			        itemGap: 7,
			        data: legend_dataset,
			    },
			    series : [
			        {
//			            name: data.labels,
			            type: 'pie',
			            radius : '65%',
			            center: ['40%', '60%'],
			            data:dataset,
			            itemStyle: {
			                emphasis: {
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            },
			            hoverAnimation:false,//是否开启 hover 在扇区上的放大动画效果。
			            stillShowZeroSum :false,//是否在数据和为0（一般情况下所有数据为0） 的时候不显示扇区。
			            label: {
			            	normal: {
			            		show: show_tooltip,
			            	}
			            	
			            },
			        }
			    ],
			};
		return option;

	}
    
    
    var start = function(){
    	$.ajax({
    		type:"get",
    		url:opt.url,
    		dataType:"json",
    		success:function(data){
    			// 使用刚指定的配置项和数据显示图表。
    		    myChart.setOption(data2option(data));
    			if (typeof(opt.success) === "function") {
    				opt.success(data.title);
    			}
    		},error:function(e){
    			//alert(JSON.stringify(e));
    			// do nothing
    		}
    	});
    }
	start();
}
