<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="http://localhost:8070/jsp" var="Jsp"></c:set>
<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>

<%--<%
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for (Cookie Cookies:cookies) {
            request.setAttribute(Cookies.getName(),Cookies.getValue());
        }
    }
%>--%>
<!DOCTYPE HTML>
<html class="x-admin-sm">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>驾校通系统-</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">
    <%--<link rel="stylesheet" href="${Xadmin}/css/theme1.css">--%>
    <script src="${Xadmin}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${Xadmin}/js/xadmin.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>
    <style>
        /*使页面全部变灰*/
        /*html {
            -webkit-filter: grayscale(100%);
            -moz-filter: grayscale(100%);
            -o-filter: grayscale(100%);
            filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
        }*/
    </style>
</head>
<body class="index">
    <!-- 顶部开始 -->
    <div class="container">
        <div class="logo" style="text-align: center;">
            <a href="${Jsp}/index.jsp">驾校通</a>
        </div>
        <div class="left_open">
            <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
        </div>
        <ul class="layui-nav left fast-add" lay-filter="">
            <li class="layui-nav-item">
                <a href="javascript:;">+新增</a>
                <dl class="layui-nav-child">
                    <!-- 二级菜单 -->
                    <dd>
                        <a onclick="xadmin.open('最大化','http://www.baidu.com','','',true)">
                            <i class="iconfont">&#xe6a2;</i>弹出最大化</a></dd>
                    <dd>
                        <a onclick="xadmin.open('弹出自动宽高','http://www.baidu.com')">
                            <i class="iconfont">&#xe6a8;</i>弹出自动宽高</a></dd>
                    <dd>
                        <a onclick="xadmin.open('弹出指定宽高','http://www.baidu.com',500,300)">
                            <i class="iconfont">&#xe6a8;</i>弹出指定宽高</a></dd>
                    <dd>
                        <a onclick="xadmin.add_tab('在tab打开','member-list.html')">
                            <i class="iconfont">&#xe6b8;</i>在tab打开</a></dd>
                    <dd>
                        <a onclick="xadmin.add_tab('在tab打开刷新','member-del.html',true)">
                            <i class="iconfont">&#xe6b8;</i>在tab打开刷新</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav right" lay-filter="">
            <li class="layui-nav-item">
                <a href="javascript:;">${CookieUserName}</a>
                <%--<input type="text" id="account" value="${CookieAccount}" placeholder="请输入账号" />--%>
                <dl class="layui-nav-child">
                    <!-- 二级菜单 -->
                    <dd><a onclick="xadmin.open('个人信息','http://www.baidu.com')">个人信息</a></dd>
                    <dd><a onclick="xadmin.open('切换帐号','http://www.baidu.com')">切换帐号</a></dd>
                    <dd><a href="http://localhost:8070/LoginServlet/Login">退出</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item to-index">
                <a href="/">前台首页</a>
            </li>
        </ul>
    </div>
    <!-- 顶部结束 -->
    <!-- 中部开始 -->
    <!-- 左侧菜单开始 -->
    <div class="left-nav">
        <div id="side-nav">
            <ul id="nav">
                <li>
                    <a href="javascript:;" class="manageA" id="studentManage">
                        <i class="iconfont left-nav-li" lay-tips="学员管理">&#xe6b8;</i>
                        <cite>学员管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('报名受理','student/student')" id="Registration">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>报名受理</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('优惠审核','student/discount')" id="Preferential">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>优惠审核</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('学员档案','student/studentfile',true)" id="StudentFile">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>学员档案</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('毕业生档案','student/graduation')" id="GraduateFile">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>毕业生档案</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('换班管理','student/shift')" id="ShiftManagement">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>换班管理</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('五次不过','student/Fives')" id="FiveTimes">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>五次不过</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('退学管理','student/dropout')" id="DropoutManagement">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>退学管理</cite>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;" class="manageA" id="examinationProcess">
                        <i class="iconfont left-nav-li" lay-tips="考前流程">&#xe723;</i>
                        <cite>考前流程</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('体检面签受理','examination/examinprocess')" id="ExaminationAcceptance">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>体检面签受理</cite>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;" class="manageA" id="examinationManage">
                        <i class="iconfont left-nav-li">&#xe723;</i>
                        <cite>考试管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('考试流程处理','examination/process')" id="TestProcess">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>考试预约管理</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('交管考试记录','examination/recording')" id="ExaminationRecord">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>交管考试记录</cite>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;" class="manageA" id="splitCarManage">
                        <i class="iconfont left-nav-li">&#xe723;</i>
                        <cite>分车管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('科二学员分车','divide/keji')" id="DivisionTwoStudents">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>科二学员分车</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('科三学员分车','divide/Three')" id="DivisionThreeStudents">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>科三学员分车</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('全时段学员分车','divide/all')" id="TotalTime">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>全时段学员分车</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('学员分车列表','StudentsCar.html')" id="ListOfStudents">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>学员分车列表</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('教练在车信息','coachCar')" id="CoachInformation">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>教练在车信息</cite>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;" class="manageA" id="agreedCourseManage">
                        <i class="iconfont left-nav-li">&#xe726;</i>
                        <cite>约课管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('时间段设置','')" id="TimeSetting">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>时间段设置</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('规则设置','')" id="RuleSetting">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>规则设置</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('自动排课设置','')" id="SchedulingSettings">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>自动排课设置</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('约排课日历','admin-rule.html')" id="ScheduleCalendar">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>约排课日历</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('约课记录','admin-rule.html')" id="ClassRecord">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>约课记录</cite>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;" class="manageA" id="financeManage">
                        <i class="iconfont left-nav-li">&#xe6b4;</i>
                        <cite>财务管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('学员收支记录','unicode.html')" id="StudentRecord">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>学员收支记录</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('补缴欠费','')" id="Repayments">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>补缴欠费</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('财务编辑','')" id="FinancialEditor">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>财务编辑</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('作废记录','')" id="Invalidation">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>作废记录</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('财务出入账','')" id="FinancialAccount">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>财务出入账</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('财务流水账','')" id="JournalAccount">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>财务流水账</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('财务统计','')" id="FinancialStatistics">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>财务统计</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('财务款项配置','')" id="FinancialAllocation">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>财务款项配置</cite>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;" class="manageA" id="personneManage">
                        <i class="iconfont left-nav-li">&#xe6b4;</i>
                        <cite>人事管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('部门管理','personal/department')" id="DivisionalManagement">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>部门管理</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('角色管理','personal/role')" id="RoleManagement">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>角色管理</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('权限管理','personal/jurisdiction')" id="AuthorityManagement">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>权限管理</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('员工管理','personal/employee')" id="EmployeeManagement">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>员工管理</cite>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;" class="manageA" id="reportStatistics">
                        <i class="iconfont left-nav-li">&#xe6b4;</i>
                        <cite>统计报表</cite>
                        <i class="iconfont nav_right">&#xe697;</i></a>
                    <ul class="sub-menu">
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('招生统计','')" id="AdmissionsStatistics">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>招生统计</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('招生来源统计','')" id="SourceStatistics">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>招生来源统计</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('在陪人数统计','')" id="AccompanyingNumber">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>在陪人数统计</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('介绍人统计报表','')" id="ReferralStatistics">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>介绍人统计报表</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('合格率','')" id="yield">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>合格率</cite>
                            </a>
                        </li>

                    </ul>
                </li>
                <li>
                    <a href="javascript:;" class="manageA" id="drivingSchoolManage">
                        <i class="iconfont left-nav-li">&#xe6b4;</i>
                        <cite>驾校统计</cite>
                        <i class="iconfont nav_right">&#xe697;</i>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('班制管理','')" id="ClassManagement">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>班制管理</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('报名点管理','')" id="RegistrationManagement">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>报名点管理</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('训练场管理','')" id="TrainingManagement">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>训练场管理</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('车辆信息','')" id="VehicleInformation">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>车辆信息</cite>
                            </a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('车辆维护','')" id="VehicleMaintenance">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>车辆维护</cite></a>
                        </li>
                        <li>
                            <a class="functionA" onclick="xadmin.add_tab('车辆费用汇总','')" id="VehicleCost">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>车辆费用汇总</cite>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <!-- <div class="x-slide_left"></div> -->
    <!-- 左侧菜单结束 -->
    <!-- 右侧主体开始 -->
    <div class="page-content">
        <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
            <ul class="layui-tab-title">
                <li class="home">
                    <i class="layui-icon">&#xe68e;</i>我的桌面
                </li>
            </ul>
            <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
                <dl>
                    <dd data-type="this">关闭当前</dd>
                    <dd data-type="other">关闭其它</dd>
                    <dd data-type="all">关闭全部</dd>
                </dl>
            </div>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe src='' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
                </div>
            </div>
            <div id="tab_show"></div>
        </div>
    </div>
    <div class="page-content-bg"></div>
    <style id="theme_style"></style>
    </body>
<script>
    //是否开启刷新记忆tab功能
    //var is_remember = false;
</script>

<script>
    var is_remember = undefined;//开启刷新记忆tab功能
    var moduleObj = [${ModuleObj}];//Session模块权限
    var functionObj = [${FunctionObj}];//Session功能权限
    var MAobj = new Object();//模块数组
    var FAobj = new Object();//功能数组
    var roleID = "${SessionRoleID}";//角色ID
    //var userName = "${CookieUserName}";//用户名

    //权限限制部分
    $(function () {
        //session为空，从新登陆
        if(functionObj.length==0){
            //window.location.href="http://localhost:8070/LoginServlet/Login";
        }
        else{
            //非管理员账号不记忆tab
            if(roleID !="1"){
                sessionStorage.removeItem("TabBit");
                $('.layui-tab-title li[lay-id]').find('.layui-tab-close').click();
                is_remember = true;//关闭刷新记忆tab功能
            }
            $("#nav li a.manageA").each(function () {
                //模块名称：标签id; {"学员管理": "studentManage","考前流程": "examinationProcess"}
                MAobj[$(this).find('cite')[0].outerText] = this.id;
            })
            $("#nav li a.functionA").each(function () {
                //功能名称：标签id; {"五次不过": "FiveTimes","交管考试记录": "ExaminationRecord"}
                FAobj[$(this).find('cite')[0].outerText] = this.id;
            })
            for (k in moduleObj[0]) {
                var modIndex = 0;
                //循环该模块下的功能
                for (let i = 0; i < functionObj[0].length; i++) {
                    if(moduleObj[0][k].moduleID == functionObj[0][i].parentModuleID){
                        var funIndex = 0;
                        var names = functionObj[0][i].typeNames.split(',');
                        var bits = functionObj[0][i].usingBits.split(',');
                        for (let j = 0; j < names.length; j++) {
                            if(bits[j]=="1"){
                                funIndex++;
                            }
                        }
                        //无该功能的全部权限，隐藏该功能
                        if(funIndex == 0){
                            for (FA in FAobj) {
                                if(FA==functionObj[0][i].parentModuleName){
                                    $("#" + FAobj[FA]).remove();
                                }
                            }
                        }else{
                            modIndex++;
                        }
                    }
                }
                //该模块的功能均无权限，隐藏该模块
                if(modIndex == 0){
                    for (MA in MAobj) {
                        if(MA==moduleObj[0][k].parentModuleName){
                            $("#" + MAobj[MA]).remove();
                        }
                    }
                }
            }
            //console.log(MAobj);
        }
    })


</script>

</html>
