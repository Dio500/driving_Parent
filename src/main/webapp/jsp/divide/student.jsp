<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="/assets/plugins/login/static" var="Login"></c:set>
<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/StudentController" var="controller"></c:set>
<html>
<head>

    <meta charset="UTF-8">
    <title>学员报名</title>
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">

    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">
    <%--<link rel="stylesheet" href="/assets/css/index.css">--%>
   <%-- <link rel="stylesheet" href="/assets/plugins/font-awesome/css/font-awesome.min.css">--%>
    <%--<link rel="stylesheet" href="/assets/css/style.css">--%>

    <%--<script type="text/javascript" src="${Xadmin}/lib/layui/layui.js" charset="utf-8"></script>--%>
    <%--<script type="text/javascript" src="${Xadmin}/js/xadmin.js"></script>--%>
    <script src="/assets/plugins/layui/layui.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>
    <script src="/assets/plugins/bootstrap-4.1.3-dist/js/popper.min.js"></script>
    <script src="/assets/plugins/bootstrap-4.1.3-dist/js/bootstrap.bundle.min.js"></script>
<%--    <script type="text/javascript" src="/assets/plugins/jquery.form."></script>--%>
</head>
<style>
    .layui-table-view .layui-form-radio>i {
        margin: 0;
        font-size: 20px;
        margin-top: 15px;
        margin-left: 25px;
    }
    .layui-table-view .layui-form-radio>i {
        margin-top: 15px;
    }
    .laytable-cell-1-0-0{
        width: 80px !important;
    }

    #fundTable tbody tb input{
        width: 100px;
    }
    .layui-form-item {
        margin-bottom: 5px;
    }
    .layui-form-label{
        padding: 9px 15px 9px 0px;
    }
    .layui-inline {
        margin-right: 0px !important;
    }
</style>
<body>
<div class="x-nav">
    <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">学员管理</a>
        <a><cite>学员报名</cite></a>
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
                            <div class="layui-inline layui-show-xs-block">
                                <button type="button"  onclick="selectSt()"  class="layui-btn layui-btn-normal" onclick="">查询
                                    <i class="layui-icon">&#xe615;</i>
                                </button>
                                <button type="button"  onclick="StudentAdd()"  class="layui-btn layui-btn-normal" onclick="">报名

                                </button>
                            </div>
                         </form>
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
<!-- 考生录入模态窗体 -->
    <div class="modal fade" id="formEntrepot">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="width:942px;margin:0 -7%;">
            <%--模态框头部--%>
            <div class="modal-header">
                <h5 class="modal-title">考生录入</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Close</span>
                </button>
            </div>
            <%--模态框内容--%>
            <div class="modal-body pt-0 frew">
                <form class="layui-form">
                    <div class="layui-tab-content">
                        <%--员工信息模态框--%>
                        <div class="layui-tab-item layui-show" style="">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">姓名</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="username" id="username" placeholder="请输入姓名" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">国籍</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="nationality" id="nationality" placeholder="请输入国籍" autocomplete="off" class="layui-input">
                                    </div>
                                </div>

                                <div class="layui-inline">
                                    <label class="layui-form-label">自编号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="number" id="number" placeholder="请输入自编号" autocomplete="off" class="layui-input"></div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">生日</label>
                                    <div class="layui-input-inline layui-show-xs-block">
                                        <input type="date"  placeholder="请选择出生日期" autocomplete="off" class="layui-input" name="" id="">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">证件号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="identityCard" id="identityCard" placeholder="请输入证件号" autocomplete="off" class="layui-input"></div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">证件类型</label>
                                    <div class="layui-input-inline">
                                        <select name="CardType" id="CardType">
                                            <option value="">证件类型</option>
                                            <option value="">身份证</option>
                                            <option value="">护照</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">电话1</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="phoneOne" id="phoneOne" placeholder="请输入电话1" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">电话2</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="phoneTwo" id="phoneTwo" placeholder="请输入电话2" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">截止日期</label>
                                    <div class="layui-input-inline layui-show-xs-block">
                                        <input type="date" autocomplete="off"  class="layui-input" name="" id="">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">性别</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="sex" value="男" title="男" checked="">
                                        <input type="radio" name="sex" value="女" title="女">
                                    </div>
                                </div>
                                <div class="layui-inline" style="margin-left: 37px;">
                                    <label class="layui-form-label">资料</label>
                                    <div class="layui-input-block">
                                        <input style="float: left;" type="radio" name="sex" value="" title="齐全" checked="">
                                        <input style="float: left;" type="radio" name="sex" value="" title="不齐全">
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 row">
                                <div class="col-8" style="">
                                    <div class="form-row" style="margin-top: 20px;">
                                        <label class="col-form-label col-2" style="">身份证地址</label>
                                        <div class="col-10" style="">
                                            <input type="text" name="IdCardAddress" id="IdCardAddress" placeholder="请输入地址" autocomplete="off" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-row" style="margin-top: 20px; margin-bottom: 20px;">
                                        <label class="col-form-label col-2">居住地址</label>
                                        <div class="col-10" style="">
                                            <input type="text" name="residentialAddress" id="residentialAddress" placeholder="请输入地址" autocomplete="off" class="form-control">
                                        </div>
                                    </div>
<%--                                    <div class="col-12">--%>
<%--                                        <div class="form-row col-5">--%>
<%--                                            <label class="col-form-label col-3">性别</label>--%>
<%--                                            <div class="col-9">--%>
<%--                                                <input type="radio" name="sex" value="男" title="男" checked="">--%>
<%--                                                <input type="radio" name="sex" value="女" title="女">--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                        <div class="form-row col-6">--%>
<%--                                            <label class="col-form-label col-3">资料</label>--%>
<%--                                            <div class="col-9">--%>
<%--                                                <input type="radio" name="sex" value="男" title="齐全" checked="">--%>
<%--                                                <input type="radio" name="sex" value="女" title="不齐全">--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
                                </div>
                                <div class="col-4" style="background: #46a546;height: 120px;">


                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">招生来源</label>
                                    <div class="layui-input-inline">
                                        <select id="sourceenrollments"></select>
                                    </div>
                                </div>

                                <div class="layui-inline">
                                    <label class="layui-form-label">报名点</label>
                                    <div class="layui-input-inline layui-show-xs-block">
                                        <select id="onpointname"></select>
                                    </div>
                                </div>

                                <div class="layui-inline">
                                    <label class="layui-form-label">报名时间</label>
                                    <div class="layui-inline layui-show-xs-block">
                                        <input class="layui-input"  autocomplete="off" placeholder="开始日" name="end" id="end">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">业务类型</label>
                                    <div class="layui-input-inline">
                                        <select name="businessType" id="businessType">

                                        </select>
                                    </div>
                                </div>

                                <div class="layui-inline">
                                    <label class="layui-form-label">原驾车型</label>
                                    <div class="layui-input-inline">
                                        <select name="originalDriving" id="originalDriving">
                                        </select>

                                    </div>
                                </div>

                                <div class="layui-inline">
                                    <label class="layui-form-label" style="margin-left: 20px;">原驾驶号</label>
                                    <div class="layui-input-inline layui-show-xs-block">
                                        <input type="text" name="originalDrivingNumber" id="originalDrivingNumber" placeholder="请输入原驾驶号" autocomplete="off" class="layui-input">
                                    </div>
                                </div>

                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">报名车型</label>
                                    <div class="layui-input-inline">
                                        <select name="modelCar" id="1">

                                        </select>
                                    </div>
                                </div>

                                <div class="layui-inline">
                                    <label class="layui-form-label">班制</label>
                                    <div class="layui-input-inline">
                                        <select name="Registration" id="Regis">

                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">训练场</label>
                                    <div class="layui-input-inline">
                                        <select name="GroundName" id="GroundName">

                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">预选教练</label>
                                    <div class="layui-input-inline">
                                        <select name="employeeName" id="employeeName">
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline" style="margin-left: 20px;">
                                    <label class="layui-form-label">介绍人</label>
                                    <div class="layui-input-inline layui-show-xs-block">
                                        <input type="text" name="referralnames"  id="referralnames" placeholder="请输入介绍人" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">学员分组</label>
                                    <div class="layui-input-inline">
                                        <select name="StudentZhu" id="StudentZhu">

                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">备注：</label>
                                    <div class="layui-input-inline layui-show-xs-block">
                                        <input type="text" name="username" style="width: 500px;" placeholder="请输入备注" autocomplete="off" class="layui-input">
                                    </div>
                                </div>


                                <div class="layui-inline"style="float: right;">


                                    <button type="reset"  onclick="addFund()"  class="layui-btn layui-btn-primary layui-btn-normal">新增款项</button>
<%--                                    <button type="button"  onclick="addFund()"  class="layui-btn layui-btn-normal" onclick="">新增款项--%>
<%--&lt;%&ndash;                                        <i class="layui-icon">&#xe615;</i>&ndash;%&gt;--%>
<%--                                    </button>--%>
                                </div>
                            </div>



                            <table class="layui-table layui-form" id="fundTablesq">
                                <thead>
                                <tr>
<%--                                    <th style="width: 30px;">#</th>--%>
                                    <th>款项</th>
                                    <th>付款类型</th>
                                    <th>付款金额</th>
                                    <th>优惠金额</th>
                                    <th>优惠理由</th>
                                    <th>欠费</th>
                                    <th>票号</th>
                                    <th>备注</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="studentTbody">

                                <tr>
<%--                                    <td>1</td>--%>

                                    <%--<td><select name="tbFund"></select></td>--%>

                                    <td>
                                        <select style="width:120px;" name="modelCar" id="8">

                                        </select>
                                    </td>

                                    <td>
                                        <select style="width:120px;" name="modelCar" id="6">

                                        </select>
                                    </td>

                                    <%--<td><select name="tbFundType"></select></td>--%>

                                    <td> <input type="text" name="username" style="" placeholder="实缴金额" autocomplete="off" class="layui-input"></td>
                                    <td> <input type="text" name="username" style="" placeholder="优惠金额" autocomplete="off" class="layui-input"></td>
                                    <td> <input type="text" name="username" style="" placeholder="优惠理由" autocomplete="off" class="layui-input"></td>
                                    <td> <input type="text" name="username" style="" placeholder="欠费" autocomplete="off" class="layui-input"></td>
                                    <td> <input type="text" name="username" style="" placeholder="票号" autocomplete="off" class="layui-input"></td>
                                    <td> <input type="text" name="username" style="" placeholder="备注" autocomplete="off" class="layui-input"></td>
                                    <td class="td-manage">
                                        <a   style="text-align: center;  margin-left: 30px;" title="删除" onclick="member_del(this,'要删除的id')" href="javascript:;">
                                            <i style="text-align: center;" class="layui-icon">&#xe640;</i>
                                        </a>
                                    </td>

                                </tr>
                                </tbody>
                            </table>

                            <div class="layui-form-item" style="text-align: center;">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit="" lay-filter="demo1" id="SaveStudent" >立即提交</button>
                                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>

<script>
    var layer, laydate, layuiTable, form;//layui模块全局变量
    var tbstudent;//学生表
    var num =1;

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
            //学员表
            tbstudent = layuiTable.render({
                elem: '#tbstudent',
                //url: 'http://localhost:8070/StudentController/SelectStudent',
                //where: { GradeId: 0, ClassId: 0, SpecialtyId: 0, NmeNumbers: "" },
                cols: [[
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
                // toolbar: "#"
            });

            //监听表格行单击事件
            layuiTable.on('row(tbstudent)', function (obj) {
                //标注选中行样式
                obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");
            });
            selectSt();

        });
         //报名点下拉框
        createSelect("#Enroll", "${controller}/SelectEnroll");
        //部门下拉框
        createSelect("#mechanism", "${controller}/Selectmechanism");
        //报名班制
        createSelect("#Registration", "${controller}/SelectRegistration");
        //招生来源
        createSelect("#registrations", "${controller}/Selectregistrations");

    })
    //训练场
    createSelect(".GroundName", "${controller}/selectGroundName");
    //车型
    createSelect("#modelCar", "${controller}/selectmodelCar");

    //新增款项按钮
    function addFund() {
        num++;
        var tbodyTr='<tr>' +
        // '<td>'+num+'</td>' +
        '<td> <select name="tbFundType" class="" id=""></select></td>' +
        '<td> <select name="tbFundType" class="modelCar" id="modelCar"></select></td>' +

        '<td> <input type="text" name="username" style="" placeholder="实缴金额" autocomplete="off" class="layui-input"></td>' +
        '<td> <input type="text" name="username" style="" placeholder="优惠金额" autocomplete="off" class="layui-input"></td>' +
        '<td> <input type="text" name="username" style="" placeholder="优惠理由" autocomplete="off" class="layui-input"></td>' +
        '<td> <input type="text" name="username" style="" placeholder="欠费" autocomplete="off" class="layui-input"></td>' +
        '<td> <input type="text" name="username" style="" placeholder="票号" autocomplete="off" class="layui-input"></td>' +
        '<td> <input type="text" name="username" style="" placeholder="备注" autocomplete="off" class="layui-input"></td>' +
          ' <td class="td-manage">'+
              ' <a   style="text-align: center;  margin-left: 30px;" title="删除" onclick="member_del(this)" href="javascript:;">'+
             '  <i style="text-align: center;" class="layui-icon">&#xe640;</i>'+
              '  </a>'+
           ' </td>'+
        '</tr>';
        $("#"+"studentTbody").append(tbodyTr);
        //车型
        createSelect("#modelCar", "${controller}/selectmodelCar");

    }

    $("#sq1").click(function () {
        console.log("111");
    })

    /*删除*/
    function member_del(obj,id){
        //发异步删除数据
        $(obj).parents("tr").remove();
        // layer.msg('已删除!',{icon:1,time:1000});
    }


    //性别
    function sex(data) {
        var text =data.applicationstatus;
        return text="1"?'<a class="">男</a>':'<a class="">女</a>';

    }

    function setStudent(data) {
        var StudentID = data.studentid;
        return '<a title="编辑" onclick="StudentUpdate('+ StudentID +')" style="padding-right: 10px;">'+'<i class="layui-icon">&#xe642;</i>'+'</a>'+
            '<a title="删除" onclick="StudentDelete('+ StudentID +')">'+'<i class="layui-icon">&#xe640;</i>'+'</a>';
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

     //新增学员信息
    function StudentAdd() {
        /*layui.use(['layer'],function () {
            layer.open({type:1,anim: 4,area:['1200px','600px'],title:'新增学员信息',shadeClose: true,//点击遮罩层关闭
                //btn: '关闭全部',btnAlign: 'c',//按钮居中shade: 0 ,//不显示遮罩
                content: layui.$('#demo')//打开的内容
            });
        })*/

        $("#formEntrepot").modal('show');
        //重置表单
        //$("#formEntrepot")[0].reset();
        //打开模态框
        //设置表单的Action
        //$("#formEntrepot").prop("action", "InsertEntrepot");
    }

    //新增
    function XZ(){
        var username = $("#InsertStudent [name='username']").val();
        var nationality = $("#InsertStudent [name='nationality']").val();
        var number = $("#InsertStudent [name='number']").val();
        var identityCard = $("#InsertStudent [name='identityCard']").val();
        var CardType = $("#InsertStudent [name='CardType']").val();
        var phoneOne = $("#InsertStudent [name='phoneOne']").val();
        var phoneTwo = $("#InsertStudent [name='phoneTwo']").val();
        var IdCardAddress = $("#InsertStudent [name='IdCardAddress']").val();
        var residentialAddress = $("#InsertStudent [name='residentialAddress']").val();
        var sourceenrollments = $("#InsertStudent [name='sourceenrollments']").val();
        var businessType = $("#InsertStudent [name='businessType']").val();
        var originalDriving = $("#InsertStudent [name='originalDriving']").val();
        var originalDrivingNumber = $("#InsertStudent [name='originalDrivingNumber']").val();
        var modelCar = $("#InsertStudent [name='modelCar']").val();
        var Registration = $("#InsertStudent [name='Registration']").val();
        var GroundName = $("#InsertStudent [name='GroundName']").val();
        var employeeName = $("#InsertStudent [name='employeeName']").val();
        var referralnames = $("#InsertStudent [name='referralnames']").val();
        var StudentZhu = $("#InsertStudent [name='StudentZhu']").val();
        if (StudentZhu != "" && CardType > 0) {
            $.post("${controller}/InsertStudent", {
                username: username,
                nationality: nationality,
                identityCard: identityCard,
                CardType: CardType,
                phoneOne: phoneOne,
                phoneTwo: phoneTwo,
                IdCardAddress: IdCardAddress,
                residentialAddress: residentialAddress,
                sourceenrollments:sourceenrollments,
                originalDrivingNumber: originalDrivingNumber,
                originalDriving: originalDriving,
                modelCar: modelCar,
                Registration: Registration,
                GroundName: GroundName,
                employeeName:employeeName,
                referralnames:referralnames,
                StudentZhu:StudentZhu
            }, function (data) {
                if (data.State) {
                    layer.msg(data.Text, { icon: 0 });
                } else {
                    layer.msg(data.Text, { icon: 0 });
                }
            }, 'json');

        }
    }

    //招生来源
    createSelect("#sourceenrollments", "${controller}/Selectregistrations");
    //车型
    createSelect("#modelCar", "${controller}/selectmodelCar");
    //业务类型
    createSelect("#businessType", "${controller}/selectbusinessType");
    //原驾车型
    createSelect("#originalDriving", "${controller}/selectmodelCar");
    //报名班制
    createSelect("#Regis", "${controller}/SelectRegistration");
    //训练场
    createSelect("#GroundName", "${controller}/selectGroundName");
    //报名点下拉框
    createSelect("#onpointname", "${controller}/SelectEnroll");

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

        // studentCard:studentCard,
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

    // $("#test").onclick(function (){
    //   console.log(5);
    //})
    //

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


</script>
</body>

</html>
