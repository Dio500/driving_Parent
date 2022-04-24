<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="/assets/plugins/login/static" var="Login"></c:set>
<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<html>
<head>

    <meta charset="UTF-8">
    <title>员工管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">

    <script type="text/javascript" src="${Xadmin}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${Xadmin}/js/xadmin.js"></script>

    <link rel="stylesheet" href="/assets/css/index.css">
    <link rel="stylesheet" href="/assets/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/assets/css/style.css">

    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>


</head>
<style>
    .layui-table-view .layui-form-radio>i {
        margin: 0;
        font-size: 20px;
        margin-top: 15px;
        margin-left: 25px;
    }
</style>
<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="">首页</a>
                <a href="">演示</a>
                <a>
                    <cite>导航元素</cite>
                </a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
    </a>
</div>
<div id="app">

    <div class="layui-fluid">
        <div class="layui-row layui-col-space15">

            <div class="layui-col-md12">

                <div class="layui-card">

                    <div class="layui-card-body">

                        <div class="layui-card-body row">
                            <div class="col-12">
                                <form class="layui-form layui-col-space5">

                                    <div class="layui-input-inline layui-show-xs-block">
                                        <div class="layui-input-inline layui-show-xs-block" style="width: 130px;">
                                            <select id="Enroll"></select>
                                        </div>
                                    </div>

                                    <div class="layui-input-inline layui-show-xs-block">
                                        <div class="layui-input-inline layui-show-xs-block" style="width: 130px;">
                                            <select id="mechanism"></select>
                                        </div>
                                    </div>
                                    <div class="layui-input-inline layui-show-xs-block">
                                        <div class="layui-input-inline layui-show-xs-block" style="width: 130px;">
                                            <select id="Registration"></select>
                                        </div>
                                    </div>
                                    <div class="layui-input-inline layui-show-xs-block">
                                        <div class="layui-input-inline layui-show-xs-block" style="width: 130px;">
                                            <select id="gender"></select>
                                        </div>
                                    </div>

                                    <div class="layui-input-inline layui-show-xs-block">
                                        <label class="layui-form-label"style="text-align: center;width:50px;">年龄:</label>
                                        <div class="layui-inline layui-show-xs-block" style="width:50px; margin-top: 4px;">
                                            <input type="text" name="price_min" placeholder="" autocomplete="off" class="layui-input">
                                        </div>
                                        <label style="">至</label>
                                        <div class="layui-inline layui-show-xs-block" style="width: 50px;  margin-top: 4px;">
                                            <input type="text" name="price_max" placeholder="" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>

                                    <div class="layui-input-inline layui-show-xs-block">
                                        <div class="layui-input-inline layui-show-xs-block" style="width: 130px;">
                                            <select id="StudentZ"></select>
                                        </div>
                                    </div>
                                    <div class="layui-input-inline layui-show-xs-block">
                                        <div class="layui-input-inline layui-show-xs-block" style="width: 130px;">
                                            <select id="registrations"></select>
                                        </div>
                                    </div>

                                    <div class="layui-input-inline layui-show-xs-block" style="width: 130px;">

                                        <select name="contrller">
                                            <option>欠费状态</option>
                                            <option>欠费</option>
                                            <option>不欠费</option>
                                        </select>

                                    </div>
                                    <div class="layui-inline layui-show-xs-block" style="width: 200px;">
                                        <input type="text" name="studentCard"  id="studentCard" placeholder="姓名/证件号/手机号" autocomplete="off" class="layui-input">
                                    </div>

                                    <div class="layui-inline layui-show-xs-block">
                                        <div class="layui-inline layui-show-xs-block" style="width: 200px;">
                                            <input type="text" name="username" placeholder="介绍人" autocomplete="off" class="layui-input">
                                        </div>

                                    </div>
                                    <div class="layui-inline layui-show-xs-block">
                                        <label style="">报名日期:</label>
                                        <div class="layui-inline layui-show-xs-block">
                                            <input class="layui-input" autocomplete="off" placeholder="开始日" name="start" id="start"></div>
                                        <div class="layui-inline layui-show-xs-block">
                                            <input class="layui-input" autocomplete="off" placeholder="截止日" name="end" id="end">
                                        </div>
                                    </div>
                                    <div class="layui-inline layui-show-xs-block">

                                        <button class="layui-btn" lay-submit="" lay-filter="sreach">
                                            <i class="layui-icon">&#xe615;</i>
                                        </button>

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="layui-card-body">

                        <div class="layui-card-body row">
                            <div class="col-12">
                                <table id="tbstudent"  lay-filter="tbstudent"></table>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script>



    var layer, laydate, layuiTable, form;//layui模块全局变量
    var tbstudent;//学生表

    $(function(){
        //加载&初始化layui模块
        layui.use(['layer','laydate','table','form'], function(){
            layer = layui.layer;
            laydate = layui.laydate;
            layuiTable = layui.table;
            form = layui.form;
            //执行一个laydate实例
            laydate.render({
                elem: '#start' //指定元素
            });
            //执行一个laydate实例
            laydate.render({
                elem: '#end' //指定元素
            });
            //员工表
            tbstudent = layuiTable.render({
                elem: '#tbstudent',
                url: 'http://localhost:8070/StudentController/SelectStudent',
                //where: { GradeId: 0, ClassId: 0, SpecialtyId: 0, NmeNumbers: "" },
                cols: [[

                    { type: 'radio' },
                    { type: 'numbers', title: '序号', width: 50, unresize: true },
                    { field: 'studentid', title: '学员ID', hide: true },
                    { field: 'name', title: '姓名', width: 100, align: 'center', unresize: true },
                    { field: 'sex', title: '性别', width: 60, align: 'center' },
                    { field: 'identitycard', title: '身份证', width: 180, align: 'center' },
                    { field: 'phoneone', title: '联系电话', width: 140, align: 'center' },
                    { field: 'modelname', title: '车型', width: 95, align: 'center' },
                    { field: 'registrationpointname', title: '报名点', width: 100, align: 'center' },
                    { field: 'referralname', title: '介绍人', width: 150, align: 'center' },
                    { field: 'organizationname', title: '招生部门',width:150, align: 'center' },
                    { field: 'classname', title: '车型-班制', width: 120, align: 'center' },
                    { field: 'residentialaddress', title: '地址', width: 150, align: 'center'},
                    { field: 'sourceenrollment', title: '招生来源', width: 110, align: 'center' },
                    { field: 'studentgroupname', title: '学员分组', width: 100, align: 'center' },
                    { field: 'idcardaddress', title: '备注', width: 70, align: 'center' },
                    { title: '操作',  width: 115, align: 'center', fixed: 'right', unresize: true ,templet: setStudent},
                ]],
                page: {
                    limit: 5,//每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                text: {
                    none: "没有对应的学员信息"
                },
                data: [],
                //toolbar: "#tabEmployeeToolbar"
            });

            //监听表格行单击事件
            layuiTable.on('row(tbstudent)', function (obj) {
                //标注选中行样式
                obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");
                //选中行，勾选复选框
                obj.tr.find("div.layui-unselect.layui-form-radio")[0].click();
            });
        });

        //报名点下拉框
        createSelect("#Enroll", "http://localhost:8070/StudentController/SelectEnroll");
        //部门下拉框
        createSelect("#mechanism", "http://localhost:8070/StudentController/Selectmechanism");

        //报名班制
        createSelect("#Registration", "http://localhost:8070/StudentController/SelectRegistration");

        //性别
        createSelect("#gender", "http://localhost:8070/StudentController/Selectgender");
        //学员分组
        createSelect("#StudentZ", "http://localhost:8070/StudentController/SelectStudentZ");

        //招生来源
        createSelect("#registrations", "http://localhost:8070/StudentController/Selectregistrations");

    })

    function setStudent(data) {
        var StudentID = data.studentid;
        var btnHtml = "";
        btnHtml += '<a title="编辑" onclick="StudentUpdate('+ StudentID +')" style="padding-right: 10px;">'+'<i class="layui-icon">&#xe642;</i>'+'</a>'+
            '<a title="删除" onclick="StudentDelete('+ StudentID +')">'+'<i class="layui-icon">&#xe640;</i>'+'</a>';
        return btnHtml;
    }


    //   下拉框封装方法
    function createSelect(selectId, url, value) {
        // console.log("11");
        $.post(url, function (returnJson) {
            //console.log(returnJson);
            if (selectId.indexOf('#') != 0) {
                selectId = '#' + selectId;
            }
            $(selectId).empty();//清空该元素
            //创建option
            for (k in returnJson) {
                $(selectId).append('<option value="' + returnJson[k].id + '">' + returnJson[k].text + '</option>');
            }
            //设置选中值
            if (value != undefined && value != null && value != '') {
                $(selectId).val(value);
            }
        });
    }

    //条件筛选
    // function searchTabStudent() {
    //     //获取查询条件
    //     var referralname = $("#referralname").val();//介绍人
    //     var Enroll = $("#Enroll").val();//报名点下拉框
    //     var mechanism = $("#mechanism").val();//部门下拉框
    //     var Registration = $("#Registration").val();//班制下拉框
    //     var gender = $("#gender").val();//性别
    //     var studentCard = $("#studentCard").val();//姓名证件号
    //     var StudentZ = $("#StudentZ").val();//学员分组下拉框
    //     var registrations = $("#registrations").val();//招生来源
    //
    //     if (referralname == "" || referralname == undefined) {
    //         referralname = "";
    //     }
    //     if (studentCard == "" || studentCard == undefined) {
    //         studentCard = "";
    //     }
    //     if (mechanism == "" || mechanism == undefined) {
    //         mechanism = 0;
    //     }
    //     if (Registration == "" || Registration == undefined) {
    //         Registration = 0;
    //     }
    //     if (gender == "" || gender == undefined) {
    //         gender = 0;
    //     }
    //     if (registrations == "" || registrations == undefined) {
    //         registrations = 0;
    //     }
    //     if (StudentZ == "" || StudentZ == undefined) {
    //         StudentZ = 0;
    //     }
    //     tbstudent.reload({
    //         url: '',
    //         where: {
    //             referralname: referralname,//介绍人
    //             Enroll: Enroll,//报名点下拉框
    //             mechanism: mechanism,//部门下拉框
    //             Registration: Registration,//班制
    //             gender: gender,//性别
    //             studentCard: studentCard,//证件号
    //             StudentZ: StudentZ,//学员分组
    //             registrations: registrations,//招生来源
    //         },
    //         page: {
    //             curr: 1
    //         }
    //     });
    // }


</script>
</body>

</html>
