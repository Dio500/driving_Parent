<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--<%@ include file="index.jsp"%>--%>
<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="/assets/plugins/login/static" var="Login"></c:set>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%--meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
    <title>驾校通系统-登录</title>
    <%--<meta name="viewport" content="width=device-width, initial-scale=1.0" />--%>

    <link rel="stylesheet" href="${Login}/login/bootstrap.min.css" />
    <%--图片切换--%>
    <link rel="stylesheet" href="${Login}/login/css/camera.css" />

    <%--<link rel="stylesheet" href="${Login}/login/bootstrap-responsive.min.css" />--%>

    <link rel="stylesheet" href="${Login}/login/matrix-login.css" />
    <link rel="stylesheet" href="${Login}/login/font-awesome.css" />
    <%--<script type="text/javascript" src="${Login}/js/jquery-1.5.1.min.js"></script>--%>
    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>
    <!-- 软键盘控件start -->
    <link href="${Login}/login/keypad/css/framework/form.css" rel="stylesheet" type="text/css"/>
    <!-- 软键盘控件end -->
    <style type="text/css">

      /* body{
        -webkit-transform: rotate(-3deg);
        -moz-transform: rotate(-3deg);
        -o-transform: rotate(-3deg);
        padding-top:20px;
        }*/

        .cavs{
            z-index:1;
            position: fixed;
            width:95%;
            margin-left: 20px;
            margin-right: 20px;
        }

        /*使页面全部变灰*/
        /*html {
            -webkit-filter: grayscale(100%);
            -moz-filter: grayscale(100%);
            -o-filter: grayscale(100%);
            !* filter: grayscale(100%); *!
            filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
        }*/
    </style>
    <script>
        //window.setTimeout(showfh,3000);
        var timer;
        function showfh(){
            fhi = 1;
            //关闭提示晃动屏幕，注释掉这句话即可
            timer = setInterval(xzfh2, 10);
        };
        var current = 0;
        function xzfh(){
            current = (current)%360;
            document.body.style.transform = 'rotate('+current+'deg)';
            current ++;
            if(current>360){current = 0;}
        };
        var fhi = 1;
        var current2 = 1;
        function xzfh2(){
            if(fhi>50){
                document.body.style.transform = 'rotate(0deg)';
                clearInterval(timer);
                return;
            }
            current = (current2)%360;
            document.body.style.transform = 'rotate('+current+'deg)';
            current ++;
            if(current2 == 1){current2 = -1;}else{current2 = 1;}
            fhi++;
        };
    </script>
</head>
<body>
<!--小键盘承载器-->
<canvas class="cavs"></canvas>
<div style="width:100%;text-align: center;margin: 0 auto;position: absolute;">
    <!-- 登录 -->
    <div id="windows1">
        <div id="loginbox" >
            <form action="" method="post" name="loginForm" id="loginForm">
                <div class="control-group normal_text">
                    <h3>
                        <img src="${Login}/login/logo.png" alt="Logo" />
                    </h3>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
							<span class="add-on bg_lg">
							<i><img height="37" src="${Login}/login/user.png" /></i>
							</span><input type="text" id="account" value="${CookieAccount}" placeholder="请输入账号" />
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_ly">
                                <i><img height="37" src="${Login}/login/suo.png" /></i>
                            </span>
                            <input type="password" id="passWord" placeholder="请输入密码" class="keypad" keypadMode="full" allowKeyboard="true" value="${CookieCipher}"/>
                        </div>
                    </div>
                </div>
                <div style="float:right;padding-right:10%;">
                    <div style="float: left;margin-top:3px;margin-right:2px;">
                        <font color="white">记住该账户</font>
                    </div>
                    <div style="float: left;">
                        <input type="checkbox" class="custom-control-input" name="rememberMe" id="rememberMe" value="true" onclick="this.value=(this.value=='true')?'false':'true'" checked/>
                    </div>
                </div>
                <div class="form-actions">
                    <div style="width:86%;padding-left:8%;">

                        <div style="float: left; height:30px; width:30px">
                            <i><img style="height:30px; width:30px" src="${Login}/login/yan.png" /></i>
                        </div>
                        <div style="float: left;" class="codediv">
                            <input type="text" name="code" id="validCode" class="login_code" style="height:21px;" autocomplete="off"/>
                        </div>
                        <div class="" style="float: left;">
                            <img src="http://localhost:8070/LoginServlet/Identity" style="height:30px; width:65px" id="validCodeImg"/>
                        </div>
                        <c:if test="${pd.isZhuce == 'yes' }">
                            <span class="pull-right" style="padding-right:3%;"><a href="javascript:changepage(1);" class="btn btn-success">注册</a></span>
                        </c:if>
                        <span class="pull-right"><a id="MemBtnLogin" class="flip-link btn btn-info">登录</a></span>
                    </div>
                </div>
            </form>
            <div class="controls">
                <div class="main_input_box">
                    <font color="white"><span id="nameerr">驾校通管理系统</span></font>
                </div>
            </div>
        </div>
    </div>
    <!-- 注册 -->
    <%--<div id="windows2" style="display: none;">
        <div id="loginbox">
            <form action="" method="post" name="loginForm" id="loginForm">
                <div class="control-group normal_text">
                    <h3>
                        <img src="${Login}/login/logo.png" alt="Logo" />
                    </h3>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
							<span class="add-on bg_lg">
							<i>用户</i>
							</span><input type="text" name="USERNAME" id="USERNAME" value="" placeholder="请输入用户名" />
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
							<span class="add-on bg_ly">
							<i>密码</i>
							</span><input type="password" name="PASSWORD" id="PASSWORD" placeholder="请输入密码" class="keypad" keypadMode="full" allowKeyboard="true" value=""/>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
							<span class="add-on bg_ly">
							<i>重输</i>
							</span><input type="password" name="chkpwd" id="chkpwd" placeholder="请重新输入密码" class="keypad" keypadMode="full" allowKeyboard="true" value=""/>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
							<span class="add-on bg_lg">
							<i>姓名</i>
							</span><input type="text" name="NAME" id="name" value="" placeholder="请输入姓名" />
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
							<span class="add-on bg_lg">
							<i>邮箱</i>
							</span><input type="text" name="EMAIL" id="EMAIL" value="" placeholder="请输入邮箱" />
                        </div>
                    </div>
                </div>
                <div class="form-actions">
                    <div style="width:86%;padding-left:8%;">

                        <div style="float: left;padding-top:2px;">
                            <i><img src="${Login}/login/yan.png" /></i>
                        </div>
                        <div style="float: left;" class="codediv">
                            <input type="text" name="rcode" id="rcode" class="login_code"
                                   style="height:16px; padding-top:4px;" />
                        </div>
                        &lt;%&ndash;<div style="float: left;">
                            <i><img style="height:22px;" id="zcodeImg" alt="点击更换" title="点击更换" src="" /></i>
                        </div>&ndash;%&gt;
                        <span class="pull-right" style="padding-right:3%;"><a href="javascript:changepage(2);" class="btn btn-success">取消</a></span>
                        <span class="pull-right"><a onclick="register();" class="flip-link btn btn-info" id="to-recover">提交</a></span>
                    </div>
                </div>
            </form>
            <div class="controls">
                <div class="main_input_box">
                    <font color="white"><span id="nameerr">Copyright © XX科技 2100</span></font>
                </div>
            </div>
        </div>
    </div>--%>

</div>
<div id="templatemo_banner_slide" class="container_wapper">
    <div class="camera_wrap camera_emboss" id="camera_slide">
        <!-- 背景图片 -->
        <div data-src="/assets/img/carriage/ce7ca72798f73a982d46475a081ac52.jpg"></div>
        <div data-src="/assets/img/carriage/850e10a41c94cc3d76ab140696e1bf1.jpg"></div>
        <div data-src="/assets/img/carriage/5c7976615fc87db345a5a33de80f30c.jpg"></div>
        <div data-src="/assets/img/carriage/01913e0efce57694218de1c524a5ba6.jpg"></div>
        <div data-src="/assets/img/carriage/a5fb517f7fbe952b4fd68868e3db2b6.jpg"></div>
    </div>
    <!-- #camera_wrap_3 -->
</div>

<script src="${Login}/login/js/bootstrap.min.js"></script>
<script src="${Login}/js/jquery-1.7.2.js"></script>
<script src="${Login}/login/js/jquery.easing.1.3.js"></script>
<script src="${Login}/login/js/camera.min.js"></script>
<script src="/assets/plugins/js/customfunction.js"></script>
<%--<script src="${Login}/login/js/jquery.mobile.customized.min.js"></script>--%>
<%--背景图--%>
<script src="${Login}/login/js/templatemo_script.js"></script>
<%--线--%>
<script src="${Login}/login/js/ban.js"></script>

<%--<script type="text/javascript" src="${Login}/js/jQuery.md5.js"></script>
<script type="text/javascript" src="${Login}/js/jquery.tips.js"></script>
<script type="text/javascript" src="${Login}/js/jquery.cookie.js"></script>--%>
<!-- 软键盘控件start -->
<script type="text/javascript" src="${Login}/login/keypad/js/form/keypad.js"></script>
<script type="text/javascript" src="${Login}/login/keypad/js/framework.js"></script>
<!-- 软键盘控件end -->

<script type="text/javascript">
    $(function () {
        //验证码图片切换
        $("#validCodeImg").click(function() {
            $(this).prop("src","http://localhost:8070/LoginServlet/Identity?time=" + new Date().getTime());
        });

        //登陆按钮
        $("#MemBtnLogin").click(function(){
            var account = $('#account').val();
            var passWord = $('#passWord').val();
            var validCode = $('#validCode').val();
            var rememberMe = $('#rememberMe').val();

            if(account !="" && passWord !="" && validCode !=""){
                $.post("http://localhost:8070/LoginServlet/MemBtnLogin",{Account: account,PassWord: passWord,ValidCode: validCode,RememberMe: rememberMe},function(jsonData){
                    if(jsonData.state==true){
                        var times = 0;//保存时间
                        let date = jsonData.date[0];
                        //是否记住
                        if(jsonData.rememberme == "true") times = 7;
                        //保存到cookie (name,value,time)
                        saveCookie("CookieAccount",date.account,times);//账号
                        saveCookie("CookieCipher",date.cipher,times);//密码
                        saveCookie("CookieUserName",date.username,7);//用户名
                        saveCookie("CookieUserID",date.userid,7);//用户ID

                        window.location.href="http://localhost:8070/jsp/index.jsp";
                    }
                    else{
                        //$("#validCodeImg").click();切换验证码
                        alert(jsonData.msg);
                    }
                })
            }
            else{
                alert("请填写完整！");
            }
        });

        //回车键登陆
        onkeydown = function(event) {
            /*if(event.key == 13){
                $("#MemBtnLogin").click();
            }*/
            if (event.keyCode == 13) {
                $("#MemBtnLogin").click();
            }
        }
    })

    //字符串不能为空
    function strValIsNotNull(strVal) {
        return strVal != undefined && strVal != null && strVal != "";
    }
</script>
</body>
</html>