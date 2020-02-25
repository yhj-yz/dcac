var watermarks = {
	init : function(opt){
		var o = {};
		var c = $("#"+opt.id).empty();
		o.width = c.width();
		o.height = c.height();
		o.fontSize = parseInt(opt.fontSize)*1.333;
		o.fontFamily = opt.fontFamily;
		o.lean = opt.lean;
		o.lineNumber = parseInt(opt.lineNumber);
		o.viewType = parseInt(opt.viewType);
		o.fontAlpha = 1-parseInt(opt.fontAlpha)/100;
//		console.log(o.width+'----'+o.height)
		//已知高和宽的比例，通过正弦值求倾斜角度
		var angle = Math.atan(o.height/o.width)*180/Math.PI;
		o.data={
			'l1':{x:o.width*0.125,y:o.height*0.125,deg:-angle,text:[]},
			'l2':{x:o.width*0.125,y:o.height*0.875,deg:angle,text:[]},
			'r1':{x:o.width*0.875,y:o.height*0.125,deg:angle,text:[]},
			'r2':{x:o.width*0.875,y:o.height*0.875,deg:-angle,text:[]},
			'c':{x:o.width*0.5,y:o.height*0.5,deg:-angle,text:[]},
		};
		var getCtx = function(){
			if (typeof o.ctx == 'undefined'){
				o.id = opt.id +'_canvas0';
				c.append('<canvas id="'+o.id+'" class="watermarks_item" width="'+o.width+'" height="'+o.height+'">对不起，您的浏览器不支持Canvas</canvas>');
				o.ctx = $("#"+o.id)[0].getContext("2d");
				if (! o.showImg) {
					o.ctx.fillStyle = '#b0dfe5';
					o.ctx.fillRect(0,0,o.width,o.height);
				}
			}
			o.ctx.font=o.fontSize + "px " + o.fontFamily;
			o.ctx.fillStyle = opt.fontColor;
			o.ctx.globalAlpha=o.fontAlpha;
			o.ctx.save();
			return o.ctx;
		}
		var createCanvas = function(opt1){
			var ctx = getCtx();
			var offset = ctx.measureText(opt1.text).width/2;
			ctx.save();
			ctx.translate(opt1.x, opt1.y);
			if(o.lean){
				ctx.rotate(opt1.deg*Math.PI/180);
			}
			ctx.textBaseline="middle";
			ctx.fillText(opt1.text, -offset, 0, o.textMaxSize);
			ctx.restore();
			return ctx;
		};
		o.addText = function(opt1){//添加水印文字
			var type = parseInt(opt1.type);
			switch (type){
				case 1:
					o.data.c.text.push(opt1.text);
					break;
				case 2:
					o.data.l1.text.push(opt1.text);
					break;
				case 4:
					o.data.l2.text.push(opt1.text);
					break;
				case 8:
					o.data.r1.text.push(opt1.text);
					break;
				case 16:
					o.data.r2.text.push(opt1.text);
					break;
				default:
					break;
			}
			return o;
		};
		o.addImage = function(opt1){//添加水印图片(暂时只支持单个)
			var x,y,w,h;
			var layer=parseInt(opt1.layer);
			var viewType=parseInt(opt1.viewType);
			var imgAlpha=1-parseInt(opt1.imgAlpha)/100;
			o.img = new Image();
			o.showImg = true;
			o.imgSrc = opt1.src;
			o.imgOnload = function(){//图片加载完成回调函数
				getCtx();
				o.ctx.fillStyle = '#ffffff';
				o.ctx.globalAlpha=1;
				o.ctx.fillRect(0,0,o.width,o.height);
				if (layer == 0) {//img图层置于顶层
					o.ctx.restore();
					drawTxt();
				}
				o.ctx.globalAlpha = imgAlpha;
				switch(viewType){
					case 0://居中
						w = o.img.width > 0.9*o.width ? 0.9*o.width : o.img.width;
						h = o.img.height > 0.9*o.height ? 0.9*o.height : o.img.height;
						x = (o.width - w)/2;
						y = (o.height - h)/2;
						o.ctx.drawImage(o.img,x,y,w,h);
						break;
					case 1://拉伸
						w = o.width;
						h = o.height;
						x=0;
						y=0;
						o.ctx.drawImage(o.img,x,y,w,h);
						break;
					case 2://平铺
    					w = o.width;
						h = o.height;
						x=0;
						y=0;
						var ptrn = o.ctx.createPattern(o.img, 'repeat'); 
						o.ctx.fillStyle = ptrn;
						o.ctx.fillRect(x,y,w,h);
						break;
				}
				o.ctx.restore();
				if (layer == 1) {//img图层置于底层
					drawTxt();
				}
			}
			return o;
		};
		o.draw = function(){//开始画
			if (o.showImg) {
				o.img.onload = o.imgOnload;
				o.img.onerror = function(){
					o.showImg = false;
					drawTxt();
				};
				o.img.src = o.imgSrc;
			} else  {
				drawTxt();
			}
			return o;
		};
		var drawTxt = function(){//画文字
			if(o.viewType == 2){
				var txt = "";
				for (var d in o.data) {
					var arr = o.data[d]['text'];
					var opt2 = o.data[d];
					if (arr.length > 0 && d == 'c') {
						for(var i=0;i<arr.length;i++){
							txt += arr[i] + ' ';
						}
					}
				}
				if(txt.length>0){
					while (true){
						if(txt.length*o.fontSize > o.width*10){
							break;
						}
						txt = txt + txt;
					}
				}
				if(o.lineNumber){
					var segY = o.lean?o.height*2/(o.lineNumber + 1):o.height/(o.lineNumber + 1);
					var deg = o.lean?-angle:0;
					for (var i=0;i<o.lineNumber;i++) {
//						console.log(segY*(i+1))
						createCanvas({x:0,y:segY*(i+1),deg:deg,text:txt});
					}
				}
			} else {
				for (var d in o.data) {
					var arr = o.data[d]['text'];
					var opt2 = o.data[d];
					if (arr.length > 0) {
						if (d == 'c') {
							var x,y,len = arr.length;
							var seg = (o.height/2)/(len + 1);
							for(var i=0;i<len;i++){
								var opt3 = opt2;
								opt3.x = o.width/2;
								opt3.y = (o.height/4 + seg*(i+1));
								if(o.lean){
									var yy = (opt3.y - o.height*0.5)*0.5;
									var xx = yy*o.width/o.height;
									opt3.y += yy;
									opt3.x += xx;
								}
								opt3.text = arr[i];
								createCanvas(opt3);
							}
						} else{
							var txt = '';
							for(var i=0;i<arr.length;i++){
								txt += arr[i] + ' ';
							}
							opt2.text = txt;
							createCanvas(opt2);
						}
					}
				}
			}
		};
		o.destroy = function(){
			$(".watermarks_item").remove();
		};
		o.clearText = function(){
			for (var d in o.data) {
				o.data[d]['text'] = [];
			}
		};
		return o;
	},
	destroy : function(){
		$(".watermarks_item").remove();
	}
}