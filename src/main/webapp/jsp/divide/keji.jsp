<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="/assets/plugins/login/static" var="Login"></c:set>
<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<html>
<head>

    <meta charset="UTF-8">
    <title>科二学员分车</title>
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

        <script type="text/javascript" src="/assets/plugins/jquery.form."></script>
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
                <a href="">分车管理</a>
                <a>
                    <cite>科二学员分车</cite>
                </a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
    </a>
</div>


    <div class="layui-fluid" style="background: #FFFFFF !important;">
        <div class="layui-row layui-col-space15">

            <div class="layui-col-md12">

                <div class="layui-card" >

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
                                            <select id="gender">
                                                <option value="">性别</option>
                                                <option value="true">男</option>
                                                <option value="false">女</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="layui-input-inline layui-show-xs-block">
                                        <label class="layui-form-label"style="text-align: center;width:50px;">年龄:</label>
                                        <div class="layui-inline layui-show-xs-block" style="width:50px; margin-top: 4px;">
                                            <input type="text" name="price_min" placeholder="" autocomplete="off" class="layui-input">
                                        </div>
                                        <label style="">—</label>
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


                                    <div class="layui-inline layui-show-xs-block" style="width: 200px;">
                                        <input type="text" name="studentCard"  id="studentCard" placeholder="姓名/证件号/手机号" autocomplete="off" class="layui-input">
                                    </div>



                                    <div class="layui-inline layui-show-xs-block">
                                        <div class="layui-inline layui-show-xs-block" style="width: 200px;">
                                            <input type="text" name="JsName" id="JsName" placeholder="介绍人" autocomplete="off" class="layui-input">
                                        </div>

                                    </div>
                                    <div class="layui-inline">
                                        <label class="layui-form-label">日期</label>
                                        <div class="layui-input-inline layui-show-xs-block">
                                            <input type="date" autocomplete="off"  class="layui-input" name="" >
                                        </div>

                                        <div class="layui-input-inline layui-show-xs-block">
                                            <input type="date" autocomplete="off"  class="layui-input" name="" >
                                        </div>
                                    </div>
                                    <div class="layui-inline layui-show-xs-block">
                                        <button type="button"  onclick="selectSt()"  class="layui-btn layui-btn-normal" >查询
                                            <i class="layui-icon">&#xe615;</i>
                                        </button>
                                        <button type="button"  onclick="selectSt()"  class="layui-btn layui-btn-normal">分车

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

                    <div class="layui-card-body" style="width: 600px; float: left;">
                        <button type="button"  style="width: 600px;"  class="layui-btn layui-btn-normal" >
                            科二待学员选教练
                        </button>

                        <form class="layui-form layui-col-space5" style="margin: -0.5px;">
                            <div class="layui-input-inline layui-show-xs-block">

                                <div class="layui-input-inline layui-show-xs-block" style="width: 130px;">
                                    <select name="modelcar" id="modelCar">

                                    </select>
                                </div>
                            </div>
                            <div class="layui-input-inline layui-show-xs-block">

                                <div class="layui-input-inline layui-show-xs-block" style="width: 120px;">
                                    <select id="GroundName">

                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline layui-show-xs-block" style="width: 150px;">
                                <input type="text" name="studentCard"  id="45" placeholder="姓名/证件号/手机号" autocomplete="off" class="layui-input">
                            </div>

                            <div class="layui-inline layui-show-xs-block">
                                <div class="layui-inline layui-show-xs-block" style="width: 100px;">
                                    <input type="text" name="JsName" id="56" placeholder="车辆" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline layui-show-xs-block">
                                <button type="button"  onclick="selectSt()"  class="layui-btn layui-btn-normal" onclick="">
                                    <i class="layui-icon">&#xe615;</i>
                                </button>
                            </div>
                        </form>

                        <div class="layui-card-body  col-6">
                            <div class="col-6">
                                <table id="tbcoach"  lay-filter="tbcoach"></table>
                            </div>
                        </div>
                    </div>

                    <div class="layui-card-body" style="width: 600px; float: left;">
                        <button type="button"  style="width: 600px;"  class="layui-btn layui-btn-normal" >
                          已分车学员
                        </button>
                        <form class="layui-form layui-col-space5"  style="margin: -0.5px;">
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: 130px;">首次上车时间：</label>
                                <div class="layui-inline layui-show-xs-block">
                                    <input class="layui-input"  autocomplete="off" placeholder="时间" name="end" id="end">
                                </div>
                            </div>
                            <div class="layui-inline layui-show-xs-block">
                                <button type="button"  onclick=""  class="layui-btn layui-btn-normal" onclick="">
                                    确认分车
                                </button>
                            </div>
                        </form>
                        <div class="layui-card-body  col-6">
                            <div class="col-6">
                                <table id="tbcar"  lay-filter="tbcar"></table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <div class="layui-card-body">
            <div class="layui-card-body row">
                <div class="col-12">
                    <table id="tbvehicle"  lay-filter=""></table>
                </div>
            </div>
        </div>

    </div>


</body>

<script>
    var layer, laydate, layuiTable, form;//layui模块全局变量
    var tbstudent , tbcoach  ,tbcar ,tbvehicle;//学生表

    //招生来源
    createSelect("#sourceenrollments", "http://localhost:8070/StudentController/Selectregistrations");
    // //教练
    // createSelect("#employeeName", "http://localhost:8070/StudentController/SelectemployeeName");
    //车型
    createSelect("#modelCar", "http://localhost:8070/StudentController/selectmodelCar");
    //业务类型
    createSelect("#businessType", "http://localhost:8070/StudentController/selectbusinessType");
    //原驾车型
    createSelect("#originalDriving", "http://localhost:8070/StudentController/selectmodelCar");
    //报名班制
    createSelect("#Regis", "http://localhost:8070/StudentController/SelectRegistration");
    //训练场
    // createSelect("#GroundName", "http://localhost:8070/StudentController/selectGroundName");
    //学员分组
    createSelect("#StudentZhu", "http://localhost:8070/StudentController/SelectStudentZ");
    //报名点下拉框
    createSelect("#onpointname", "http://localhost:8070/StudentController/SelectEnroll");

    //训练场
    createSelect("#GroundName", "http://localhost:8070/StudentController/selectGroundName");

    //车型
    createSelect("#modelCar", "http://localhost:8070/StudentController/selectmodelCar");

    $(function(){
        //加载&初始化layui模块
        layui.use(['layer','laydate','table','form'], function(){
            layer = layui.layer;
            laydate = layui.laydate;
            layuiTable = layui.table;
            form = layui.form;
            //执行一个laydate实例

            //员工表
            tbstudent = layuiTable.render({
                elem: '#tbstudent',
                //url: 'http://localhost:8070/StudentController/SelectStudent',
                //where: { GradeId: 0, ClassId: 0, SpecialtyId: 0, NmeNumbers: "" },
                cols: [[
                    { type: 'checkbox' },
                    { type: 'numbers', title: '序号', width: 50, unresize: true },

                    { field: 'studentid', title: '学员ID', hide: true },
                    { field: 'name', title: '姓名', width: 100, align: 'center', unresize: true },
                    { field: 'sex', title: '性别',  templet:sex,  width: 60, align: 'center' },
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
                    { field: 'studystate', title: '状态', width: 70,fixed: 'right',   align: 'center' },

                    // { title: '操作',  width: 115, align: 'center', fixed: 'right', unresize: true ,templet: setStudent},
                ]],
                page: {
                    limit: 5,//每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                text: {
                    none: "没有对应的学员信息"
                },
                data: [],
                // toolbar: "#"
            });

            //监听表格行单击事件
            layuiTable.on('row(tbstudent)', function (obj) {
                //标注选中行样式
                obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");
                //选中行，勾选复选框
                obj.tr.find("div.layui-unselect.layui-form-radio")[0].click();

            });

            selectSt();

        });

        //报名点下拉框
        createSelect("#Enroll", "http://localhost:8070/StudentController/SelectEnroll");
        //部门下拉框
        createSelect("#mechanism", "http://localhost:8070/StudentController/Selectmechanism");
        //报名班制
        createSelect("#Registration", "http://localhost:8070/StudentController/SelectRegistration");
        //学员分组
        createSelect("#StudentZ", "http://localhost:8070/StudentController/SelectStudentZ");
        //招生来源
        createSelect("#registrations", "http://localhost:8070/StudentController/Selectregistrations");

    })

    $(function(){
        //加载&初始化layui模块
        layui.use(['layer','laydate','table','form'], function(){
            layer = layui.layer;
            laydate = layui.laydate;
            layuiTable = layui.table;
            form = layui.form;
            //执行一个laydate实例

            //员工表
            tbcoach = layuiTable.render({
                elem: '#tbcoach',
                url: 'http://localhost:8070/DivideController/Selectcoach',
                cols: [[

                    { type: 'radio' ,width: 50  },
                    // { title: "车辆", templet: carName,  width: 140, align: "center" },
                    { field: 'employeename', title: '教练', width: 120, align: 'center' },
                    { field: 'modelname', title: '准教车型', width: 120, align: 'center' },
                    { field: '', title: '在车数', width: 100, align: 'center' },
                    // { title: '操作',  width: 115, align: 'center', fixed: 'right', unresize: true ,templet: setTeacher},
                ]],

                page: {
                    limit: 5,//每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                text: {
                    none: "没有对应的信息"
                },
                data: [],

            });

            //监听表格行单击事件
            layuiTable.on('row(tbcoach)', function (obj) {
                //标注选中行样式
                obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");
                //选中行，勾选复选框
                 obj.tr.find("div.layui-unselect.layui-form-radio")[0].click();
            });
        });

    })


    $(function(){
        //加载&初始化layui模块
        layui.use(['layer','laydate','table','form'], function(){
            layer = layui.layer;
            layuiTable = layui.table;
            form = layui.form;
            //执行一个laydate实例

            tbcar = layuiTable.render({
                elem: '#tbcar',
                url: 'http://localhost:8070/DivideController/SelectCar',
                cols: [[
                    { type: 'checkbox'},
                    { type: 'numbers', title: '序号', width: 50, unresize: true },
                    { field: 'studentid', title: '学员ID', hide: true },
                    { field: 'name', title: '姓名', width: 100, align: 'center', unresize: true },
                    { field: 'subjectname', title: '科目', width: 60, align: 'center' },
                    { field: 'identitycard', title: '证件号', width: 180, align: 'center' },
                    { field: 'phoneone', title: '状态', width: 140, align: 'center' },
                    { field: 'modelname', title: '日期', width: 95, align: 'center' },
                    //{ title: '操作',  width: 115, align: 'center', fixed: 'right', unresize: true ,templet: setStudent},

                ]],
                page: {
                    limit: 5,//每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                text: {
                    none: "没有对应的信息"
                },
                data: [],
            });

            //监听表格行单击事件
            layuiTable.on('row(tbcar)', function (obj) {
                //标注选中行样式
                obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");
                //选中行，勾选复选框
                obj.tr.find("div.layui-unselect.layui-form-radio")[0].click();
            });

        });

    })


    //性别Selectcoach
    function sex(data) {
        var text =data.applicationstatus;
        var demo="";
        demo +=text="1"?'<a class="">男</a>':'<a class="">女</a>'
        return demo;
    }

    function setStudent(data) {
        var StudentID = data.studentid;
        var btnHtml = "";
        btnHtml += '<a title="编辑" onclick="StudentUpdate('+ StudentID +')" style="padding-right: 10px;">'+'<i class="layui-icon">&#xe642;</i>'+'</a>'+
            '<a title="删除" onclick="StudentDelete('+ StudentID +')">'+'<i class="layui-icon">&#xe640;</i>'+'</a>';
        return btnHtml;
    }

    //修改学员信息
    function StudentUpdate() {
        layui.use(['layer'],function () {
            layer.open({type:1,anim: 4,area:['1200px','600px'],title:'修改学员信息',shadeClose: true,//点击遮罩层关闭
                //btn: '关闭全部',btnAlign: 'c',//按钮居中shade: 0 ,//不显示遮罩
                content: layui.$('#demo')//打开的内容
            });
        })
    }

    //条件查询
    function selectSt(){

        var objdata = new Object();
        var Enroll = objdata.val1 = $("#Enroll").val();
        var mechanism = objdata.val2 = $("#mechanism").val();
        var Registration = objdata.val3 = $("#Registration").val();
        var gender = objdata.val4 = $("#gender").val();
        var StudentZ = objdata.val5 = $("#StudentZ").val();
        var registrations = objdata.val6 = $("#registrations").val();
        var studentCard = objdata.val7 = $("#studentCard").val();
        var JsName = objdata.val8 = $("#JsName").val();

        //studentCard:studentCard,
        FZpanduan(objdata);//判断封装方法
        tbstudent.reload({
            url: 'http://localhost:8070/StudentController/SelectStudent',
            where: {
                registrationPoint: Enroll,
                departmentName: mechanism,
                Registration: Registration,
                studentGroupName: StudentZ,
                sourceEnrollment: registrations,
                studentCard:studentCard,
                sex: gender,
                JsName:JsName
            },
            page: { curr: 1 },
        })
    }
    //下拉框封装方法
    function createSelect(selectId, url, value) {
        console.log(value);
        $.post(url, function (returnJson) {
            //console.log(returnJson);
            // if (selectId.indexOf('#') != 0) {
            //     selectId = '#' + selectId;
            // }
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
    //判断封装方法
    function FZpanduan(objdata) {
        for (key in objdata) {
            //console.log(JSON.stringify(objdata));
            if(objdata[key]=="" || objdata[key]==null || objdata[key]==undefined){
                objdata[key]==""
            }
            //console.log(objdata[key]);
        }
        return objdata;
    }


    function opencar(){
        $('#').modal('show');
    }
    //车辆
    function setcar(data) {
        console.log(data);
        var select = "";
        select += ' <select type="text" placeholder="车辆" id="car" name="carname" class="carname">'
        return select;
        //车辆
        createSelect("#car", "http://localhost:8070/DivideController/Selectcar");
    }
    function  setTeacher(data){
        console.log(data);
        var coachID = data.coachID;
        var btn = "";
        btn += '<button class="layui-btn layui-btn-xs" onclick="opencar(' + coachID + ')">分车</button>';
        return btn;

    }

</script>
</body>

</html>
