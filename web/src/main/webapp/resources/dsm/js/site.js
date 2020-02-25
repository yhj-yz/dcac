/*!
 * dsm v5.0 (http://www.huatusoft.com)
 * Copyright 2017 vamtoo
 * By vamtoo.yanhaojian
 */
layer.config({
    resize: false,
    isOutAnim: false,
    scrollbar: false,
    shade:0.1

});
var dsmDialog = {
    open: function(layerobj) {
        layer.open(layerobj);
        $(document.activeElement).blur();
    },
    toComfirm:function(title,obj,funyes,funcancel){

        layer.confirm(title,obj,funyes,funcancel);
    },
   msg:function(title){        
        layer.msg(title, {
            time: 2000,
            icon: 10,
            shade: 0,
            content:"<div class='sucTip-content'><span class='alert-txt sucTip-txt'>"+title+"</span></div> "
        });
    },
    error:function(content){  
        layer.msg(content, {
            time:2000,
            icon: 11,
            shade: 0,
            btn:false,
            content:"<div class='failTip-content'><span class='alert-txt failTip-txt'>"+content+"</span></div> "
        });    
    },
    close:function(index){      
        layer.close(index);
    }

}
$(function(){

    $('.dsm-select').data('dropupAuto', false).data('liveSearch', true).selectpicker({});

    $("[data-toggle='popover']").popover();
    $('[data-toggle="tooltip"]').tooltip();
    $(document).on('click', '[data-ride="collapse"] a', function (e) {

        if($(this).attr('href')!="#"){
            $('[data-ride="collapse"] a').removeClass('testnav');
            $(this).addClass('testnav');
        }
        var $this = $(e.target), $active;
        $this.is('a') || ($this = $this.closest('a'));
        $active = $this.parent().siblings( ".active" );
        $active && $active.toggleClass('active').find('> ul:visible').slideUp(10);
        ($this.parent().hasClass('active') && $this.next().slideUp(10)) || $this.next().slideDown(10);
        $this.parent().toggleClass('active');
        $this.next().is('ul') && e.preventDefault();

        
    });
    $(document).on('click', '.js_closeBtn', function (e) {
        $(".dsm-admin").toggleClass("closed");
        if($(".dsm-admin").hasClass("closed")){
            $(".navbar>.nav").attr("data-ride","");
        }else{
            $(".navbar>.nav").attr("data-ride","collapse");
            
        }
        $(".navitem").removeClass("active");
        $(".navitem ul").css("display","none");
        //$(".subnav").css("display","none");
        
    });
	/*按钮组中的搜索交互*/
    $(".btn-toolbar .searchbox .icon-search").hover(function(){
        $(this).parent().find(".dsm-input").addClass("on");
    },function(){
        $(this).parent().find(".dsm-input").removeClass("on");
        $(this).parent().find(".dsm-input").blur();
    });
	/*下拉弹出框交互*/
    $(".dsmdropdown-toggle").hover(function(){
        if($(this).hasClass('icon')){
            $(this).parent().parent().addClass("open");
        }else{
            $(this).parent().addClass("open");
        }
    },function(){
        if($(this).hasClass('icon')){
            $(this).parent().parent().removeClass("open");
        }else{
            $(this).parent().removeClass("open");
        }
    });
    $(".dropdown-div").hover(function(){
        $(this).parent().addClass("open");
    },function(){
        $(this).parent().removeClass("open");
    });
	/*按钮组中的搜索交互*/
    $(".btn-toolbar .searchbox .dsm-input").hover(function(){
        $(this).addClass("on");
    },function(){
        if($(this).val()==""){
            $(this).removeClass("on");
            $(this).blur();
        }
    });
	/*左侧导航缩小时交互*/
    $(".dsm-side .navitem a").hover(function(){
        var itemheights=77;

        var viewHeight=document.body.scrollHeight;
        var offsetTop=$(this).offset().top;

		/*为了防止出现的浮动框影响滚动条，暂时先特殊处理*/
        if($(this).hasClass('hoverspecial')){
            itemheights=280;
        }
        var objHeight=offsetTop-itemheights;
        $(".navhoverbox").css("top",objHeight+"px")
        if($(this).html()!=""){
            $(".navhoverbox").html($(this).next().prop("outerHTML")+'<div class="nav-cur-l"></div>').addClass("in");
        }

    },function(){
        $(".navhoverbox").removeClass("in");
    });

    $(".logininfo.dsmbgblue").hover(function(){

        //var viewWidth=document.body.scrollWidth;
        //var offsetTop=$(this).offset().top;
        //var objHeight=offsetTop
        //$(".hiduserbox").css("left",objHeight+"px")

        $(".hiduserbox").removeClass("hidden");

    },function(){
        $(".hiduserbox").addClass("hidden");

    });

	/*左侧导航缩小时交互*/
    $(".navhoverbox").hover(function(){
        $(this).addClass("in");

    },function(){
        $(this).removeClass("in");
    });
    $(".hiduserbox").hover(function(){
        $(this).removeClass("hidden");

    },function(){
        $(this).addClass("hidden");
    });
	/*人员选择器点击按钮弹出选择框*/
    $(document).on("click", ".js_choseUsersBtn", function(){
        var thisBtn=$(this);
        var sid=$(this).data("ushow");
        var html=$("#"+sid).html();
        var uid=$(this).data("uhidden");
        var gid=$(this).data("ghidden");
        var gflag=$(this).data("gcheckbox");

        dsmDialog.open({
            type: 2,
            area:['860px','590px'],
            title:"选择人员",
            content : "DsmUserPicker-Form.html",
            success: function(layero, index){
                var body = layer.getChildFrame('body', index);
                var iframeWin = window[layero.find('iframe')[0]['name']];
                if(gflag=="1"){
                    iframeWin.initFirstDataBind(html,sid,uid,gid,true);
                }else{
                    iframeWin.initFirstDataBind(html,sid,uid,gid,false);
                }
            }
        });
    });
	/*左右选择器通用*/
    $(document).on("click", ".datachosebox .js_choseone", function(){
        var boxid=$(this).parent().parent().attr("id");
        addItemSelect($("#"+boxid+".datachosebox .cleft .itemone.active"),boxid);
    });

    $(document).on("click", ".datachosebox .js_delone", function(){
        var boxid=$(this).parent().parent().attr("id");
        delItemSelect($("#"+boxid+".datachosebox .cright .itemone.active"),boxid);

    });
    $(document).on("click", ".datachosebox .js_choseall", function(){

        var boxid=$(this).parent().parent().attr("id");
        addAllItem(boxid);
    });

    $(document).on("click", ".datachosebox .js_delall", function(){

        var boxid=$(this).parent().parent().attr("id");
        delAllItem(boxid);

    });

    $(document).on("dblclick", ".datachosebox .cleft .itemone", function(){

        var boxid=$(this).parent().parent().parent().parent().attr("id");
        addItemSelect($(this),boxid);
    });
    $(document).on("dblclick", ".datachosebox .cright .itemone.active", function(){

        var boxid=$(this).parent().parent().parent().parent().attr("id");
        delItemSelect($(this),boxid);

    });


    $(document).on("click", ".datachosebox .itembox .items .itemone", function(){
        $(this).addClass('active').siblings().removeClass('active');
    });
	/*左右选择器通用结束*/
	/*水印显示位置交互*/

    $(document).on("click", ".sxzyset .chosepos", function(){
        $(this).addClass('active').siblings().removeClass('active');
    });
	/*全选*/
    $(document).on("click", ".js_checkboxAll", function(){
        var vchecked=this.checked;
        $('[name='+$(this).data('allcheckfor')+']:checkbox').each(function(){
            this.checked=vchecked;
        });
    });



	/*水印显示位置交互结束*/
	/*人员选择器交互*/
    $(document).on("click", ".Js_remove", function(){
        $(this).parent().parent().remove();
    });

    $(document).on("click", ".userPickerBody .js_choseuser", function(){

        $(".userPickerBody input:checked[name='uids']").each(function(){
            if($(".userPickerBody .chosedUser[data-selaccount='"+$(this).data("uaccount")+"']").length==0){
                $(".filter-selected-list").prepend(getSelectedUserHtml(1,$(this).val(),$(this).data("uname"),$(this).data("uaccount")));
            }
        });
    });

    $(document).on("click", ".userPickerBody .JS_grchooseok", function(){
        $(".userPickerBody  input:checked[name='gids']").each(function(){
            if($(".userPickerBody .chosedUser[data-selid='"+$(this).val()+"'][data-utype='2']").length==0){
                $(".filter-selected-list").prepend(getSelectedUserHtml(2,$(this).val(),$(this).data("uname")));
            }
        });
    });
    $(document).on("click", ".js_PickerUserAdd", function(){
        var index = parent.layer.getFrameIndex(window.name);
        callBackInitPickerUserData(this);
        parent.layer.close(index);

    });
    $(document).on("click", ".js_PickerUserClean", function(){
        $(".filter-selected-list").html("");
    });
	/*人员选择器交互结束*/
	/*报表详细左侧隐藏显示树*/
    $(document).on("click", ".js_showchartzree", function(){
        $(this).toggleClass("active");
        $('.mainbox').toggleClass("closed");
    });

});

function callBackInitPickerUserData(btn){
    var viewId=$(btn).data("ushow");
    var uhiddenId=$(btn).data("uhidden");
    var ghiddenId=$(btn).data("ghidden");
    if(parent.$("#"+viewId)!=null){
        parent.$("#"+viewId).html($(".filter-selected-list").html());
    }
    if(parent.$("#"+uhiddenId)!=null){
        parent.$("#"+uhiddenId).val(getUserIds());
    }
    if(parent.$("#"+ghiddenId)!=null){
        parent.$("#"+ghiddenId).val(getGroupIds());
    }
}

function getUserIds(){
    var ids="";
    $(".filter-selected-list .chosedUser[data-utype='1']").each(function(){
        if(ids==""){
            ids+=$(this).data("selid");
        }else{
            ids+=","+$(this).data("selid");
        }
    });
    return ids;
}
function getGroupIds(){
    var gids="";
    $(".filter-selected-list .chosedUser[data-utype='2']").each(function(){
        if(gids==""){
            gids+=$(this).data("selid");
        }else{
            gids+=","+$(this).data("selid");
        }
    });
    return gids;
}
function getUserView(){
    var views="";
    $(".filter-selected-list .chosedUser").each(function(){
        if(views==""){
            views+=$(this).find(".js_utext").html();
        }else{
            views+=","+$(this).find(".js_utext").html();
        }
    });
    return views;
}
function getSelectedUserHtml(type,uid,uname,uaccount){
	/*type 1:人员  2：组*/
    if(type==1){
        return '<dd><span class="chosedUser" data-utype="'+type+'" data-selid="'+uid+'" data-selaccount="'+uaccount+'" ><span class="utext js_utext">'+uname+'['+uaccount+']</span><em class="remove J_remove"><i class="btnicon icon icon-o-close"></i></em></span></dd>'
    }
    else{
        return '<dd><span class="chosedUser"  data-utype="'+type+'"  data-selid="'+uid+'" ><span class="js_utext">【'+uname+'】</span><em class="remove J_remove"><i class="btnicon icon icon-o-close"></i></em></span></dd>'
    }
}
function addItemSelect(t,id){
    var additem=$(t);
    if(additem!=null){
		/*如果是最后一个，则将上一个item添加active*/
        var nextnode=$(additem).next();
        if(nextnode.length==0){
            nextnode=$(additem).prev();
        }
        $(nextnode).addClass("active");
        var outerHtml=$(additem).removeClass("active").prop('outerHTML')
        $("#"+id+".datachosebox .cright .itembox .items").prepend(outerHtml);
        $("#"+id+".datachosebox .cright .itembox .items .itemone:first").addClass('active').siblings().removeClass('active');
        $(additem).remove();
    }
}

function delItemSelect(t,id){
    var delitem=$(t);
    if(delitem!=null){

        var nextnode=$(delitem).next();
        if(nextnode.length==0){
            nextnode=$(delitem).prev();
        }

        $(nextnode).addClass("active");
        var outerHtml=$(delitem).removeClass("active").prop('outerHTML')
        $("#"+id+".datachosebox .cleft .itembox .items").prepend(outerHtml);
        $("#"+id+".datachosebox .cleft .itembox .items .itemone:first").addClass('active').siblings().removeClass('active');
        $(delitem).remove();
    }

}
function addAllItem(id){
    var outerHtml=$(".datachosebox .cleft .itembox .items").html();
    $("#"+id+".datachosebox .cleft .itembox .items").html("");
    $("#"+id+".datachosebox .cright .itembox .items").prepend(outerHtml);
    $("#"+id+".datachosebox .cright .itembox .items .itemone").removeClass("active");
}
function delAllItem(id){

    var outerHtml=$(".datachosebox .cright .itembox .items").html();
    $("#"+id+".datachosebox .cright .itembox .items").html("");
    $("#"+id+".datachosebox .cleft .itembox .items").prepend(outerHtml);
    $("#"+id+".datachosebox .cleft .itembox .items .itemone").removeClass("active");
}

function showHiddenBox(obj,val,upickerClass){

    if($(obj).val()==val){
        $("."+upickerClass).removeClass('hidden');

    }else{
        $("."+upickerClass).addClass('hidden');
    }
}
function clearCheckbox(id){
    $('#'+id+' [type="checkbox"]').each(function(){
        this.checked=false;
    });
}

//限制输入框为数字
function isNum(obj) {
    $(obj).val($(obj).val().replace(/[^0-9]/g, ''));
}

// 提示-弹框位于屏幕中间
function letDivCenter(divName){
    var top = ($(window).height() - $(divName).height())/2;
    // var width=($(divName).children(".alert-box").width())/2;
    var left = ($(window).width() -$(divName).width())/2;
    var scrollTop = $(document).scrollTop();
    var scrollLeft = $(document).scrollLeft();
    $(divName).css( {position : 'absolute', 'top' : top + scrollTop, left : left + scrollLeft } ).show();
    $(".btn-failTip-close").css({position:'absolute','top' : top + scrollTop+5, left : left + scrollLeft+$(divName).width()+10 } ).show();
}

//提示-成功窗口
function oprSuccess(title) {
    //启动成功失败提示
    $(".sucTip").removeClass("hidden");
    $(".btn-failTip-close").addClass("hidden");
    letDivCenter($(".sucTip"));
    $(".sucTip-txt").html(title);
    setTimeout(function () {
        $(".sucTip").addClass("hidden");
    },2000);//成功提示两秒退出
}
//提示-失败窗口
function oprFail(title,id,notice) {
    $(".failTip").removeClass("hidden");
    $(".btn-failTip-close").removeClass("hidden");
    $(".failTip").attr("data-id",id);
     letDivCenter($(".alert-box"));
    $(".failTip-txt").html(title);//错误提示需手动关闭或者点击空白区域
    $(".alert-con-notice").html(notice);
}

$(document).on("click", function ()
{
    $(".failTip").addClass("hidden"); //点击的不是div或其子元素
});
$(".failTip").click(function (event)
{
    if (event && event.stopPropagation) {
        event.stopPropagation();
    } else {
        event.cancelBubble = true;
    }
});

//提示-关闭失败提示
    $(document).on('click','.btn-failTip-close',function (e) {
    $(this).next(".failTip").addClass("hidden");
    $(".btn-failTip-close").addClass("hidden");
})
//窗体改变 弹框自适应居中
$(window).resize(function () {
    letDivCenter($(".alert-box"));
})

//判断是否有选项选中
function itemSelected_check(name){
    var chkIds = "";
    $("input[type='checkbox'][name='" + name + "']:checked").each(function () {
        var id = $(this).attr("value");
        chkIds = chkIds + ",{\"id\":\"" + id + "\"}";
    })
    chkIds = chkIds.substring(1, chkIds.length);
    return chkIds;
}
//获取传参
function getQueryString(name) { 
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
    var r = window.location.search.substr(1).match(reg); 
    if (r != null) 
        return unescape(r[2]); 
    return null; 
}
//异步提交表单
function submitForm(v){
	var index_0 = layer.load(2, {
	  shade: [0.4,'#fff'] //0.1透明度的白色背景
	});
	var $frm = $(v.frm);
	var data_0 = v.data ? v.data : $frm.serialize();
	$.ajax({
		type: "post",
		url: $frm.attr("action"),
		data: data_0,
		dataType:"json",
		success: function(data){
			layer.close(index_0);
			//提示
			if(data.type === "success"){
				dsmDialog.msg(data.content);
				if (typeof v.success === "function") {
					v.success();//参数中传回来的函数
				}
			} else {
				dsmDialog.error(data.content);
				if (typeof v.error === "function") {
					v.error();
				}
			}
		},
		error: function (e){
			dsmDialog.error("请求出错");
			if (typeof v.error === "function") {
				v.error();
			}
		}
	})
}

/**
 * 时间对象的格式化
 *
 * ##调用方法
 * var time = Date.parse("你的时间字符串");
 * dt = time.format("yyyy-MM-dd hh:mm:ss");
 */
Date.prototype.format = function(format){
	/*
	* format="yyyy-MM-dd hh:mm:ss";
	*/
		var o = {
		"M+" : this.getMonth() + 1,
		"d+" : this.getDate(),
		"h+" : this.getHours(),
		"m+" : this.getMinutes(),
		"s+" : this.getSeconds(),
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		"S" : this.getMilliseconds()
	}
	 
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4-RegExp.$1.length));
	}
	 
	for (var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
}

/**
 * 时间戳格式化
 * 
 * @param timestamp
 * 			时间戳
 * @param format
 * 			格式
 * @returns 格式化后的时间
 */
function parseDate(timestamp, format){
	var defaltFormat = format ? format : "yyyy-MM-dd hh:mm:ss";
	var time = new Date();
	time.setTime(timestamp);
	return time.format(defaltFormat);
}

$(document).on('keydown', 'input:text', function(event){
	if (event.which === 13 && !$(this).hasClass('js_search_txt')) {//如果input不是搜索，就阻止默认事件冒泡，并点击确认按钮；
		event.preventDefault();
		$(this).parents("form:first .form-btns button").click();
	}
});

$(document).keyup(function(event){
	if($('.layui-layer').length === 0 && $('.form-btns button').length === 1){//如果有确定（新增/修改）按钮，body和input确认键提交表单；
		if(event.which === 13 && (document.activeElement.tagName === 'INPUT' || document.activeElement.tagName === 'BODY' || document.activeElement.tagName === 'DIV')){
			$('.form-btns button').click();
		}
	}
	if($('.layui-layer').length === 1 && $('.layui-layer .layui-layer-btn a').length === 2){//如果有layer弹窗，body和input确认键点击第一个按钮（一般是确定），esc点击最后一个按钮（一般是取消）；
		if(event.which === 13 && (document.activeElement.tagName === 'INPUT' || document.activeElement.tagName === 'BODY' || document.activeElement.tagName === 'DIV')){
			$('.layui-layer .layui-layer-btn a:first').click();
		}
		if(event.which === 27){
			$('.layui-layer .layui-layer-btn a:last').click();
		}
	}
});

function initmLevel(type) {
    switch (type) {
        case (1):
            return "绝密";
            break;
        case (2):
            return "机密";
            break;
        case (3):
            return "秘密";
            break;
        case (4):
            return "内部";
            break;
        case (5):
            return "公开";
            break;
        default:
            return "未定义";
    }
}