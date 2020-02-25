<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html class="app">
<head>
[#include "/dsm/include/head.ftl"]
<link href="${base}/resources/dsm/css/organization-management.css" rel="stylesheet" />
<script>
$(function() {
	$("#nav").height($(window).height() - 250 + "px");
	$(".big_main").height($(window).height() - 10 + "px");
	
	//加载页面时就触发该方法
	test();
})

  
//保存方法
 function save(){
 var $frm=$("#serverSet")
 
  $.ajax({
          type:"post",
          data:$frm.serialize(),
           url:"${base}/admin/systemServerSet/save.jhtml",
       success:function(data){
          confirm(data.content);
          setTimeout(function(){window.location.href="list.jhtml";},1000);
    
       },
  })
 }
 
 //服务器ip和端口号验证方法
  function test(){
  var $frm=$("form")
     $.ajax({
       data:$frm.serialize(),
       type:"post",
        url:"${base}/admin/systemServerSet/test.jhtml",
    success: function(data){
    
    }
   
   })
  
  }
  
 

</script>
<title>系统设置-系统参数设置</title>
</head>
<body>

	<!--正文右-->
            <div class="big_main">
                <span class="main_title">服务器设置
                	<span class="stroke50"></span>
                </span>
                <!--域服务器菜单开始-->
                <!--域服务器菜单开始结束-->
                <!--btn开始-->
                
                <!--btn结束-->
                <div class="main_down_content">
                    
                    <!--右边表单开始-->
                    <div class="tab_container tab_container1">
                    	<!--查询开始-->
                        <!--查询结束-->
                        <!--表单开始-->
                        <div class="tab_big_box">
                                <div class="tabtitle_box">
                                    <div class="columnbg64"></div>
                                    <div class="stroke80"></div>
                                    <table class="widget_title" >
                                        <tr>
                                            <td style=" width:2%"></td>
                                            <td style=" width:15%">服务器类型</td>
                                            <td style=" width:30%">服务器IP</td>
                                            <td style=" width:25%">端口</td>
                                            <td style=" width:20%">测试连接</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="tab_body tab_body_btnbox">
                                	<div class="columnbg36"></div>
                                    <div class="stroke60"></div>
                                    <form id="serverSet">
                                    <input type="hidden" name="id" value="${systemServerSet.id}">
                                    <table  class="widget_body" >
                                        <tr class="tr_border" style="position:relative;">
                                            <td style=" width:2%;">
                                            	<div   class="stroke20"></div>
                                            </td>
                                            <td style=" width:15%; color:#fff;">验证服务器</td>
                                            <td style=" width:30%">
                                            	<input type="text" class="tr_input tr_input_on" name="webServer" value="${systemServerSet.webServer}"/>
                                            </td>
                                            <td style=" width:25%; color:#002f4c;">
                                            	<input type="text" class="tr_input" name="webPort" value="${systemServerSet.webPort}"/>
                                                <i><img  src="${base}/resources/dsm/imgae/refresh_icon.gif"/></i>
                                            </td>
                                            <td style=" width:20%; color:#002f4c"><i><img src="${base}/resources/dsm/imgae/test_conect_icon.png"/></i></td>
                                        </tr>
                                        <tr class="tr_border" style="position:relative;">
                                            <td style=" width:2%;">
                                            	<div   class="stroke20 columnbg10"></div>
                                            </td>
                                            <td style=" width:15%; color:#fff;">更新服务器（旧版本）</td>
                                            <td style=" width:30%">
                                            	<input type="text" class="tr_input" name="updServer" value="${systemServerSet.updServer}"/>
                                            </td>
                                            <td style=" width:25%; color:#002f4c;">
                                            	<input type="text" class="tr_input" name="updPort" value="${systemServerSet.updPort}"/>
                                                <i><img src="${base}/resources/dsm/imgae/refresh_icon.gif"/></i>
                                            </td>
                                            <td style=" width:20%; color:#002f4c"><i><img src="${base}/resources/dsm/imgae/test_conect_icon.png"/></i></td>
                                        </tr>
                                        <tr class="tr_border" style="position:relative;">
                                            <td style=" width:2%;">
                                            	<div   class="stroke20"></div>
                                            </td>
                                            <td style=" width:15%; color:#fff;">更新服务器</td>
                                            <td style=" width:30%">
                                            	<input type="text" class="tr_input" name="updServerNew" value="${systemServerSet.updServerNew}"/>
                                            </td>
                                            <td style=" width:25%; color:#002f4c;">
                                            	<input type="text" class="tr_input" name="updPortNew" value="${systemServerSet.updPortNew}"/>
                                                <i><img src="${base}/resources/dsm/imgae/refresh_icon.gif"/></i>
                                            </td>
                                            <td style=" width:20%; color:#002f4c"><i><img src="${base}/resources/dsm/imgae/test_conect_icon.png"/></i></td>
                                        </tr>
                                        <tr class="tr_border" style="position:relative;">
                                            <td style=" width:2%;">
                                            	<div   class="stroke20"></div>
                                            </td>
                                            <td style=" width:15%; color:#fff;">备用服务器</td>
                                            <td style=" width:30%">
                                            	<input type="text" class="tr_input" name="backUpServer" value="${systemServerSet.backUpServer}"/>
                                            </td>
                                            <td style=" width:25%; color:#002f4c;">
                                            	<input type="text" class="tr_input" name="backUpPort" value="${systemServerSet.backUpPort}"/>
                                                <i><img src="${base}/resources/dsm/imgae/refresh_icon.gif"/></i>
                                            </td>
                                            <td style=" width:20%; color:#002f4c"><i><img src="${base}/resources/dsm/imgae/test_conect_icon.png"/></i></td>
                                        </tr>
                                       </from>
                                    </table>
                                    <div class="btn_xtsz_box">
                                        <div class="btn_xtsz">
                                            <a href="#" onclick="save();return false;" class="xtsz_save_button">保存</a>
                                            <a href="#" onclick="reSet();return false;" class="xtsz_reset_button">重置</a>
                                        </div>
                                        <div class="columnbg60"></div>
                                    </div>
                                </div>
                        </div>
                        <!--表单结束-->
                        <!--页码开始-->
                        <!--页码结束-->
                    </div>
                    <!--右边表单结束-->
                </div><!--main_down_conent结束-->
            </div><!--main_conent结束-->

</body>
</html>
