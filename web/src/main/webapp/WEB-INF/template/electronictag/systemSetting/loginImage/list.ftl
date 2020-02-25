<!DOCTYPE html>
<html lang="ch">
<head>
    <meta charset="UTF-8">
    <title>终端管理页面</title>
    [#include "/dsm/include/head.ftl"]

</head>
<body>
    <div class="dsm-rightside">
        <div class="maincontent">
            <div class="mainbox" style="min-width: 1080px;">
            	<form id="loginimgForm"  method="post"  action="${base}/admin/systemLoginImage/save.jhtml" onsubmit="return check()"  enctype="multipart/form-data">
                <div class="dsmForms">
                    <div class="dsm-form-item">

                        <div class="dsm-inline">
                            <label class="dsm-form-label">公司LOGO：</label>
                            <div class="dsm-input-block">
                                <div class="Logobox">
                                    <img id="logoshow" src="${base}${loginMange.companyLogo}" border="0">
                                </div>
                                <div class="dsm-upload-button f-l m-r-f10">
                                    <input type="file" name="logo" class="dsm-upload-file js_imgfile" data-showid="logoshow"><span class="fbtname">浏览...</span>
                                </div>
                                <span class="logotip">推荐图片宽度220*50</span>
                            </div>
                        </div>
                        <div class="dsm-inline">
                            <label class="dsm-form-label">首页图片：</label>
                            <div class="dsm-input-block">
                                <div class="Logobox homepic">
                                    <img id="homeshow" src="${base}${loginMange.loginImage}" border="0">
                                </div>
                                <div class="dsm-upload-button f-l m-r-f10">
                                    <input type="file" name="loginimg" class="dsm-upload-file js_imgfile" data-showid="homeshow"><span class="fbtname">浏览...</span>
                                </div>
                                <span class="hometip">推荐图片宽度1920*500</span>
                            </div>
                        </div>
                        <div class="dsm-inline">
                            <label class="dsm-form-label">产品名称：</label>
                            <div class="dsm-input-block">
                                <input type="text" autocomplete="off" name="productName" value="${loginMange.productName}" placeholder="产品名称" class="dsm-input">
                            </div>
                        </div>

                    </div>
                    <div class="form-btns t-l">
                        <button type="submit" class="btn btn-lg btn-primary  ">保存设置</button>
                        <a href="#" class="btn btn-lg btn-primary js_resetting">重置</a>
                    </div>
                </div>
                </form>
            </div>

        </div>
    </div>
     <script type="text/javascript">
         var i=0;
        $(document).ready(function () {
            if(i==0&&"${successTip}"!=""){
              dsmDialog.msg("保存成功");
            }
            $(".js_imgfile").change(function () {
                var showid = $(this).data("showid");
                var $file = $(this);
                var fileObj = $file[0];
                var windowURL = window.URL || window.webkitURL;
                var dataURL;
                var $img = $("#" + showid);
                if (fileObj && fileObj.files && fileObj.files[0]) {
                    dataURL = windowURL.createObjectURL(fileObj.files[0]);
                    $img.attr('src', dataURL);
                } else {
                    dataURL = $file.val();
                    var imgObj = document.getElementById(showid);
                    imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                    imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;

                }
            });
        });

        $(document).on('click', '.js_resetting', function (e) { 
               dsmDialog.toComfirm("是否重置？", {
								btn: ['确定','取消'],
								title:"重置"
							}, function(index){
							    i=i+1;
							    $.ajax({
							           dataType:"json",
							           type:"get",
							           url:"${base}/admin/systemLoginImage/resetting.jhtml",
							           success:function(data){
							            dsmDialog.msg("重置成功");
							            setTimeout("window.location.href='${base}/admin/systemLoginImage/list.jhtml'",1000);
							           },
							           error:function(data){
							           dsmDialog.error("重置失败");
							           }
							    })
							         dsmDialog.close(index);
							}, function(index){						
								dsmDialog.close(index);
							});
        });
        
        //表单检查（文本框不为空，同时确保上传文件为图片格式）
        function check(){
          var suppotFile = new Array();
		   suppotFile[0] = "jpg";
		   suppotFile[1] = "gif";
		   suppotFile[2] = "png";
		   suppotFile[3] = "jpeg";
          var fileName1=$("[name='logo']").val();
          var fileName2=$("[name='loginimg']").val();
          if(fileName1.lastIndexOf(".") != -1){
             var fileType1 = (fileName1.substring(fileName1.lastIndexOf(".") + 1,fileName1.length)).toLowerCase();
              if(!contains(suppotFile,fileType1)){
                dsmDialog.error("公司LOGO:选择一个图片文件（格式为*.gif;*.jpg;*.jpeg;*.png")
                return false;
              }
          }
          if(fileName2.lastIndexOf(".") != -1){
             var fileType2 = (fileName2.substring(fileName2.lastIndexOf(".") + 1,fileName2.length)).toLowerCase();
             if(!contains(suppotFile,fileType2)){
                dsmDialog.error("首页图片:选择一个图片文件（格式为*.gif;*.jpg;*.jpeg;*.png")
                return false;
              }
          }
          if($("[name='productName']").val()==""){
            dsmDialog.error("产品名称不能为空");
            return false;
          }
        }
        
        //判断元素是否存在数组内
        function contains(arr, obj) {
		  var i = arr.length;
		  while (i--) {
		    if (arr[i] === obj) {
		      return true;
		    }
		  }
		  return false;
		}
        
    </script>
</body>
</html>
