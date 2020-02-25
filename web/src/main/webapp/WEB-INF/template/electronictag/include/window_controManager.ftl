
<!--添加普通配置 开始-->
<div class="popup_window tree" id="pop_ad_import">
	<div class="wind_header">
		<h4></h4>
		<input type="hidden" id="pId" value="" />
		<i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form>
	<div class="new_box">
		<div class="tree_box">
		<input type="text" name="name" value="" class="text" />
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="ImportByAD(this);return false;" class="btn_blue wind_save_button">${message("admin.common.submit")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.common.back")}</a>
	</div>
	</form>
  </div>  

<!--添加普通配置结束-->

<!--添加全局配置 开始-->
<div class="popup_window tree" id="pop_qj_import">
	<div class="wind_header">
		<h4></h4>
		<input type="hidden" id="qjpId" value="" />
		<i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form>
	<div class="new_box">
		<div class="tree_box">
		<p>作用域：</p><input type="text" name="AD" value="1" class="text" />
		<p><span style="color:red;">0:取合集； 1：只取全局配置</span></p>
		<p id="all"></p><input type="text" name="name" class="text" />
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="ImportByQJ(this);return false;" class="btn_blue wind_save_button">${message("admin.common.submit")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.common.back")}</a>
	</div>
	</form>
  </div>  

<!--添加全局配置结束-->


<!--添加程序配置 开始-->
  <div class="popup_window tree" id="pop_cx_import">
	<div class="wind_header">
		<h4></h4>
		<input type="hidden" id="cxPId" value="" />
		<i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form>
	<div class="new_box">
		<div class="tree_box">
		<p>软件版本</p><input type="text" name="name" value="" class="text" />
		<p>进程</p><input type="text" name="process" value="" class="text" />
		<p>是否特征配置</p><input type="text" name="isCharacter"value="1"  class="text"/>
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="ImportByCX(this);return false;" class="btn_blue wind_save_button">${message("admin.common.submit")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.common.back")}</a>
	</div>
	</form>
  </div>  

<!--添加程序配置结束-->


<!--修改配置 开始-->
  <div class="popup_window tree" id="pop_upd_import">
	<div class="wind_header">
		<h4></h4>
		<input type="hidden" id="pid" value="" />
		<i><a href="#" onclick="hideWindows();return false;"><img src="${base}/resources/dsm/imgae/closed_wind.png" /></a></i>
	</div>
	<form>
	<div class="new_box">
		<div class="tree_box">
		<input type="text" name="name" value="" class="text" />
		</div>
	</div>
	<div class="btn_wind">
		<a href="#" onclick="ImportByUpd(this);return false;" class="btn_blue wind_save_button">${message("admin.common.submit")}</a> 
		<a href="#" onclick="hideWindows();return false;" class="btn_blue wind_cancel_button">${message("admin.common.back")}</a>
	</div>
	</form>
  </div>  

<!--修改配置结束-->


<script>

 //普通添加配置保存功能 
  function ImportByAD(n){
    var $name=$(n).parents("form").find("input[name='name']").val();
    var id=$(n).parents("#pop_ad_import").find("#pId").val();

     $.ajax({
        data:{"name":$name,id:id},
        dataType:"json",
        type:"post",
        url:"${base}/admin/contrManagerController/saveConfigure.jhtml",
        success: function(data){
        confirmWin(data.content);
        //关闭弹框
        hideWindows();
        //保存成功后刷新树
         showTree();
        //焦点锁定在父节点
         
        },
        error: function(){
        confirmWin("操作有误");
        
        }
        
     })
  }
  //全局配置保存事件
  function ImportByQJ(n){
    var $name=$(n).parents("form").find("input[name='name']").val();
    var id=$(n).parents("#pop_qj_import").find("#qjpId").val();
    var AD=$(n).parents("form").find("input[name='AD']").val();
     $.ajax({
        data:{"name":$name,id:id,"AD":AD},
        dataType:"json",
        type:"post",
        url:"${base}/admin/contrManagerController/saveConfigure.jhtml",
        success: function(data){
        confirmWin(data.content);
        //关闭弹框
        hideWindows();
        //保存成功后刷新树
         showTree();
        //焦点锁定在父节点
         
        },
        error: function(){
        confirmWin("操作有误");
        
        }
        
     })
  
  }


  //程序配置保存事件
  function ImportByCX(n){
     var $name=$(n).parents("form").find("input[name='name']").val();
     var id=$(n).parents("#pop_cx_import").find("#cxPId").val();
     var $process=$(n).parents("form").find("input[name='process']").val();
     var $isCharacter=$(n).parents("form").find("input[name='isCharacter']").val();
     $.ajax({
         data:{"name":$name,id:id,"process":$process,"isCharacter":$isCharacter},
         dataType:"json",
         url:"${base}/admin/contrManagerController/saveConfigureCx.jhtml",
         type:"post",
         success: function(data){
         
         confirmWin(data.content);
           //关闭弹框
         hideWindows();
           //保存成功后刷新树
         showTree();
           //焦点锁定在父节点
         
         },
         
         error: function(){
          confirmWin("操作有误");
         }
      
     })
   
  }




//添加配置功能框

  function addConfigure(id){
  
    //隐藏右击弹框
    hideRMenu();
    //异步添加事件
    $.ajax({
        data:{id:id},
        dataType:"json",
        type:"get",
        url:"${base}/admin/contrManagerController/addConfigure.jhtml",
        success: function(data){
             var parentName=data.parent.name;
             var name=data.contrManager.name;
             if(parentName=="程序配置"){
           var $view=$("#pop_cx_import");
               $view.find("h4").text(data.contrManager.name);
               $view.find("#cxPId").val(id);
               $view.show();
             }
             if(name=="全局配置"||parentName=="全局配置"){
           var $view=$("#pop_qj_import");
               $view.find("h4").text(data.contrManager.name);
               $view.find("p#all").text(name);
               $view.find("#qjpId").val(id);
               $view.show();
             } else{
           var $frm=$("#pop_ad_import");
               $frm.find("h4").text(data.contrManager.name);
               $frm.find("#pId").val(id);
               $frm.show();
             
             }
              
        }
        
    })
  
  }
  
  
  //删除弹出框
  function removeConfigure(id){
    //隐藏右击弹框
    hideRMenu();
    //异步删除事件
    $.ajax({
        data:{id:id},
        dataType:"json",
        type:"get",
        url:"${base}/admin/contrManagerController/deleteConfigure.jhtml",
        success: function(data){
        confirmWin(data.content);
        //保存成功后刷新树
         showTree();
        }
    
    })
  
  }
  
  //修改弹框
  function updConfigure(id){
       //隐藏右击弹框
       hideRMenu();
       //异步添加事件
       $.ajax({
        data:{id:id},
        dataType:"json",
        type:"get",
        url:"${base}/admin/contrManagerController/toUpdConfigure.jhtml",
       
       success:function(data){
       alert(data.name)
           var $frm=$("#pop_upd_import");
               $frm.find("h4").text(data.name);
               $frm.find("#pid").val(id);
               $frm.find("input[name='name']").val(data.name);
               $frm.show();  
       }
       
       
       })
  
  
  }
  
  //修改配置保存功能 
  function ImportByUpd(n){
  var name=$(n).parents("form").find("input[name='name']").val();
    var id=$(n).parents("#pop_upd_import").find("#pid").val();

     $.ajax({
        data:{name:name,id:id},
        dataType:"json",
        type:"get",
        url:"${base}/admin/contrManagerController/updConfigure.jhtml",
        success: function(data){
        confirmWin(data.content);
        //关闭弹框
        hideWindows();
        //保存成功后刷新树
         showTree();
        //焦点锁定在父节点
         
        },
        error: function(){
        confirmWin("操作有误");
        
        }
        
     })
  }
  
  
  
  
  
  

</script>