<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String picUrl = request.getParameter("Picurl");
    String  step = request.getParameter("step");
    String defaultPic ="uploadhead/image/man.GIF";
    if("3".equals(step))
        defaultPic = "uploadhead/User/UserHeadImage/"+picUrl;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>上传头像</title>
<link href="uploadhead/css/main.css" type="text/css" rel="Stylesheet" />
    <%--<script src="ucenter/js/jquery/jquery.min.js"></script>--%>
    <script type="text/javascript" src="uploadhead/js/jquery1.2.6.pack.js"></script>
    <script type="text/javascript" src="uploadhead/js/ui.core.packed.js" ></script>
    <script type="text/javascript" src="uploadhead/js/ui.draggable.packed.js" ></script>
    <script type="text/javascript" src="uploadhead/js/CutPic.js"></script>
    <script type="text/javascript">
        function Step1() {
            $("#Step2Container").hide();
        }

        function Step2() {
            $("#CurruntPicContainer").hide();
        }
        function Step3() {
            $("#Step2Container").hide();
        }
    </script>
</head>
<body>
   

    <div>
     <div class="left">
         <!--当前照片-->
         <div id="CurruntPicContainer">
            <div class="title"><b>当前照片</b></div>
            <div class="photocontainer">
                <img id="imgphoto" src="ucentergethead"  />
            </div>
         </div>
         <!--Step 2-->
         <div id="Step2Container">
           <div class="title"><b> 裁切头像照片</b></div>
           <div class="uploadtooltip">您可以拖动照片以裁剪满意的头像</div>                              
                   <div id="Canvas" class="uploaddiv">
                   
                            <div id="ImageDragContainer">                               
                               <img id="ImageDrag" src="ucenter/img/a0.jpg" class="imagePhoto"  style="border-width:0px;" />
                            </div>
                            <div id="IconContainer">                               
                               <img id="ImageIcon" src="ucenter/img/a0.jpg" class="imagePhoto"  style="border-width:0px;" />
                            </div>                          
                    </div>
                    <div class="uploaddiv">
                       <table>
                            <tr>
                                <td id="Min">
                                        <img alt="缩小" src="uploadhead/image/_c.gif" onmouseover="this.src='uploadhead/image/_c.gif';" onmouseout="this.src='uploadhead/image/_h.gif';" id="moresmall" class="smallbig" />
                                </td>
                                <td>
                                    <div id="bar">
                                        <div class="child">
                                        </div>
                                    </div>
                                </td>
                                <td id="Max">
                                        <img alt="放大" src="uploadhead/image/c.gif" onmouseover="this.src='uploadhead/image/c.gif';" onmouseout="this.src='uploadhead/image/h.gif';" id="morebig" class="smallbig" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <form action="/ZoomImageDemo/servlet/ZoomImage" method="post">
                    <input type="hidden" name="picture" value=""/>
                    <div class="uploaddiv">
                        <input type="submit" name="btn_Image" value="保存头像" id="btn_Image" />
                    </div>           
                    <div>
                    图片实际宽度： <input name="txt_width" type="text" value="1" id="txt_width" /><br />
                    图片实际高度： <input name="txt_height" type="text" value="1" id="txt_height" /><br />
                    距离顶部： <input name="txt_top" type="text" value="82" id="txt_top" /><br />
                    距离左边： <input name="txt_left" type="text" value="73" id="txt_left" /><br />
                    截取框的宽： <input name="txt_DropWidth" type="text" value="120" id="txt_DropWidth" /><br />
                    截取框的高： <input name="txt_DropHeight" type="text" value="120" id="txt_DropHeight" /><br />
                    放大倍数： <input name="txt_Zoom" type="text" id="txt_Zoom" />
                   </div>  </form>
         </div>
     
     </div>
     <form name="form1" method="post" id="form1" enctype="multipart/form-data">
         <div class="right">
             <!--Step 1-->
             <div id="Step1Container">
                <div class="title"><b>更换照片</b></div>
                <div id="uploadcontainer">
                    <div class="uploadtooltip">请选择新的照片文件，文件需小于2.5MB</div>
                    <div class="uploaddiv"><input type="file" name="fuPhoto" id="fuPhoto" title="选择照片" /></div>
                    <div class="uploaddiv"><input type="button" onclick="upload()" name="btnUpload" value="上 传" id="btnUpload" /></div>
                </div>

             </div>
         </div>
     </form>
    </div>

<script>
    function upload() {
        var formData = new FormData($('#form1')[0]);
        $.ajax({
            url:"ucenterupload",
            data:formData,
            type:"post",
            dataType:"json",
            async:false,
            contentType:false,
            cache:false,
            processData:false,
            success:function(data) {
                if(data.status == "ok") {
                    $('#CurruntPicContainer').hide();
                    $('#Step2Container').show();
                    $('#ImageDrag').src="ucentergetheadtemp?filepath="+data.data;
                    $('#ImageIcon').src="ucentergetheadtemp?filepath="+data.data;
                }
            }

        });
    }
</script>
    <%
      if(null==picUrl||"".equals(picUrl))
      {%>
        <script type='text/javascript'>Step1();</script>
        <%}else if(!"".equals(picUrl)&& "2".equals(step)){
      %>
    <script type='text/javascript'>Step2();</script>
        <%}else if(!"".equals(picUrl)&& "3".equals(step)){
      %>
    <script type='text/javascript'>Step3();</script>
        <%}%>

</body>
</html>