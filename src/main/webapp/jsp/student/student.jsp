<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="/assets/plugins/login/static" var="Login"></c:set>
<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/StudentController" var="controller"></c:set>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>学员管理</title>
    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">
    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet" />

    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">

    <%--<link rel="stylesheet" href="/assets/css/index.css">--%>
   <%-- <link rel="stylesheet" href="/assets/plugins/font-awesome/css/font-awesome.min.css">--%>
    <%--<link rel="stylesheet" href="/assets/css/style.css">--%>

    <%--<script type="text/javascript" src="${Xadmin}/lib/layui/layui.js" charset="utf-8"></script>--%>
    <%--<script type="text/javascript" src="${Xadmin}/js/xadmin.js"></script>--%>
    <script src="/assets/plugins/layui/layui.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery.form.min.js"></script><%--form表单提交--%>
    <script type="text/javascript" src="/assets/plugins/js/customfunction.js"></script><%--表单回填、下拉框、权限封装--%>

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
        width: 80px !important;
        padding: 9px 10px 9px 0px;
    }
    .layui-inline {
        margin-right: 0px !important;
    }

    #LayuiTab .layui-table-cell {
        overflow: visible;
    }

    #LayuiTab .layui-table-box {
        overflow: visible;
    }

    #LayuiTab .layui-table-body {
        overflow: visible;
    }

    /* 设置下拉框的高度与表格单元相同 */
    #LayuiTab td .layui-form-select {
        margin-top: -10px;
        margin-left: -15px;
        margin-right: -15px;
    }
    .layui-table-total{
        display: none;
    }

    #Card .layui-form-select, #Card input{
        width: 165px;
    }
    #Card label{
        width: 70px;
    }
    #pamoneytop input{
        border: none;
        width: 70px;
        color: #5290ff;
    }
</style>
<body>
<div class="layui-row">
    <div class="layui-col-md12">
        <div class="layui-card">
            <div class="layui-card-body">
                <form class="layui-form layui-col-space5">
                    <%--姓名/证件号/手机号--%>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" id="NameCardPhone" placeholder="姓名/证件号/手机号" autocomplete="off" class="layui-input">
                    </div>
                    <%--介绍人--%>
                    <div class="layui-inline" style="width: 100px;">
                        <input type="text" id="ReferralName" placeholder="介绍人" autocomplete="off" class="layui-input">
                    </div>
                    <%--车型--%>
                    <div class="layui-input-inline" style="width: 100px;">
                        <select class="modelCar" id="DrivingModel"></select>
                    </div>
                    <%--报名部门--%>
                    <%--<div class="layui-input-inline" style="width: 120px;">
                        <select id="department"></select>
                    </div>--%>
                    <%--班制--%>
                    <div class="layui-input-inline" style="width: 100px;">
                        <select class="Class" id="Class"></select>
                    </div>
                    <%--性别--%>
                    <div class="layui-input-inline" style="width: 100px;">
                        <select id="Gender">
                            <option value="">性别</option>
                            <option value="true">男</option>
                            <option value="false">女</option>
                        </select>
                    </div>
                    <%--年龄--%>
                    <div class="layui-input-inline">
                        <label class="layui-form-label"style="text-align:center; width:50px;">年龄</label>
                        <div class="layui-inline" style="width:60px; margin-top: 4px;">
                            <input type="number" id="AgeStart" autocomplete="off" class="layui-input">
                        </div>
                        <label style="">—</label>
                        <div class="layui-inline" style="width: 60px;  margin-top: 4px;">
                            <input type="number" id="AgeEnd" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <%--招生部门--%>
                    <div class="layui-input-inline" style="width: 150px;">
                        <select id="Department"></select>
                    </div>
                    <div class="layui-input-inline" style="padding-left: 200px;">
                        <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" onclick="StudentSelect()">查询
                            <i class="layui-icon">&#xe615;</i>
                        </button>
                        <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" onclick="StudentAdd()" >报名
                        </button>
                    </div>
                 </form>
            </div>
            <div class="layui-card-body">
               <table id="tbstudent"  lay-filter="tbstudent"></table>
            </div>
        </div>
    </div>
</div>
<!-- 考生录入模态窗体 -->
<div class="modal fade" id="modStudent">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="width:1015px;margin:0 -13%;">
            <%--模态框头部--%>
            <div class="modal-header">
                <h5 class="modal-title" style="font-weight: bold;">考生录入</h5>
                <button type="button" class="close" data-dismiss="modal" id="cancel">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Close</span>
                </button>
            </div>
            <%--模态框内容--%>
            <div class="modal-body pt-0 frew">
                <form class="layui-form" id="formStudent" action="" role="form" method="post" enctype="multipart/form-data">
                    <div class="layui-tab-content" id="Card">
                        <%--隐藏域--%>
                        <input type="hidden" name="registrationid" id="URegistrationID"/>
                        <input type="hidden" name="studentid" id="UStudentID"/>
                        <input type="hidden" name="pamoneyid" id="UPamoneyID"/>
                        <input type="hidden" name="userid" id="userid"/>
                        <%--员工信息模态框--%>
                        <div class="layui-tab-item layui-show" style="">
                            <div class="row">
                                <div class="col-10" style="">
                                    <div class="row">
                                        <label class="layui-form-label"><span class="x-red">* </span>姓名</label>
                                        <input type="text" name="name" id="username" placeholder="请输入姓名" autocomplete="off" class="layui-input" lay-verify="name">

                                        <label class="layui-form-label"><span class="x-red">* </span>国籍</label>
                                        <input type="text" name="nationality" id="nationality" placeholder="请输入国籍" autocomplete="off" class="layui-input" lay-verify="required">

                                        <label class="layui-form-label"><span class="x-red">* </span>证件类型</label>
                                        <select name="cardtypeid" id="CardType" lay-verify="selectType"></select>
                                    </div>
                                    <div class="row">
                                        <label class="layui-form-label"><span class="x-red">* </span>证件号</label>
                                        <input type="text" name="identitycard" id="idCard" placeholder="请输入证件号" autocomplete="off" class="layui-input" lay-verify="identity" onkeyup="idCardDraw()">

                                        <label class="layui-form-label"><span class="x-red">* </span>生日</label>
                                        <input type="date"  placeholder="请选择出生日期" autocomplete="off" class="layui-input" name="birthday" id="birthday" lay-verify="date">

                                        <label class="layui-form-label" style="margin-right: 30px;"><span class="x-red">* </span>性别</label>
                                        <div id="sex">
                                            <input type="radio" name="sex" value="true" title="男" checked>
                                            <input type="radio" name="sex" value="false" title="女">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="" style="height: 85px; width: 85px;">
                                        <img src="/assets/img/Snipaste_2021-04-28_08-42-40.png" alt="" width="100%" height="100%" id="UsImgStudentPicture" class="border border-primary ml-1" ondblclick="chooseImageFile('Picture')" />
                                        <input type="file" name="fileStudentImage" id="Picture" hidden="hidden" accept="image/*" onchange="showImgToView('Picture')" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <label class="layui-form-label">截止日期</label>
                                <input type="date" placeholder="身份证截止日期" autocomplete="off" class="layui-input" name="idcardvaliditydate">

                                <label class="layui-form-label"><span class="x-red">* </span>联系电话</label>
                                <input type="text" name="phoneone" id="phoneOne" placeholder="请输入电话" autocomplete="off" class="layui-input" lay-verify="phone">

                                <label class="layui-form-label">联系电话2</label>
                                <input type="text" name="phonetwo" id="phoneTwo" placeholder="请输入电话2" autocomplete="off" class="layui-input">

                                <label class="layui-form-label">自编号</label>
                                <input type="text" name="numbers" id="numbers" class="layui-input" readonly>
                            </div>
                            <div class="row">
                                <label class="layui-form-label">招生来源</label>
                                <select name="sourceenrollmentid" id="sourceenrollments"></select>

                                <label class="layui-form-label"><span class="x-red">* </span>报名时间</label>
                                <input type="date" class="layui-input"  autocomplete="off" placeholder="请输入报名时间" name="registrationtime" lay-verify="date">

                                <label class="layui-form-label"><span class="x-red">* </span>报名点</label>
                                <select id="onpointname" name="registrationpointid" lay-verify="selectType"></select>

                                <label class="layui-form-label">介绍人</label>
                                <input type="text" name="referralname"  id="referralnames" placeholder="请输入介绍人" autocomplete="off" class="layui-input">
                            </div>
                            <div class="row">
                                <label class="layui-form-label"><span class="x-red">* </span>业务类型</label>
                                <select name="businesstypeid" id="businessType" lay-verify="selectType"></select>

                                <label class="layui-form-label">原驾车型</label>
                                <select name="orddrivingmodelid" class="modelCar" id="originalDrivingModel"></select>

                                <label class="layui-form-label">原驾驶证</label>
                                <input type="text" name="ordDrivingnumber" id="originalDrivingNumber" placeholder="请输入原驾驶号" autocomplete="off" class="layui-input">

                                <label class="layui-form-label">资料</label>
                                <div id="materialsbit">
                                    <input type="radio" name="materialsbit" value="true" title="齐全" checked>
                                    <input type="radio" name="materialsbit" value="false" title="不齐全">
                                </div>
                            </div>
                            <div class="row">
                                <label class="layui-form-label"><span class="x-red">* </span>报名车型</label>
                                <select name="modelid" class="modelCar" lay-filter="modelCar" id="modelcar" lay-verify="selectType"></select>

                                <label class="layui-form-label"><span class="x-red">* </span>班制</label>
                                <select name="classid" class="Class" id="Regis" lay-filter="regis" lay-verify="selectType"></select>

                                <label class="layui-form-label">训练场</label>
                                <select name="traininggroundid" id="GroundName"></select>

                                <label class="layui-form-label">预选教练</label>
                                <select name="employeeid" id="employeeName"></select>
                            </div>
                            <div class="row">
                                <label class="layui-form-label">身份证地址</label>
                                <input class="layui-input" style="width: 410px;" autocomplete="off" placeholder="请输入身份证地址" name="idcardaddress">

                                <label class="layui-form-label">居住地址</label>
                                <input class="layui-input" style="width: 410px;" autocomplete="off" placeholder="请输入居住地址" name="residentialaddress">
                            </div>
                            <div class="row">
                                <label class="layui-form-label">备注</label>
                                <input type="text" name="remarks" style="width: 410px;" placeholder="请输入备注" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="row" style="display: block" id="pamoneytop">
                        <span class="ml-3" style="font-weight: bold; padding-right: 30px;">缴费信息</span>
                        <span class="text-muted">应缴金额: </span><span class="text-primary">￥</span>
                        <input name="needpaymenttotalmoney" id="NeedMoney" readonly/>
                        <span class="text-muted">已缴金额: </span><span class="text-primary">￥</span>
                        <input name="paymenttotalmoney" id="RayMoney" readonly/>
                        <input name="discounttotalmoney" id="DisMoney" hidden/><%--优惠金额--%>
                        <span class="text-muted">缴费票号: </span>
                        <input name="ticketnumber" id="TicketNumber" readonly/>
                        <span class="text-muted mr-4" style="float: right; font-weight: bold;font-size: 15px; color: #006dcc !important" lay-submit lay-filter="tijiao">立即提交</span>
                    </div>
                    <div id="LayuiTab">
                        <table id="sumMoney" lay-filter="sumMoney"></table>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    var layer, laydate, layuiTable, form;//layui模块全局变量
    var tbstudent;//学生表
    var tbSumMoney;
    var aCookie = document.cookie.split("; ");//获取cookie
    var objdata = new Object();
    //var classid;
    //var ticketnumber=0;

    $(function(){
        //招生部门下拉框
        createSelect("#Department","${controller}/SelectDepartment");
        //证件类型下拉框
        createSelect("#CardType", "${controller}/SelectCardType");
        //招生来源下拉框
        createSelect("#sourceenrollments", "${controller}/Selectregistrations");
        //业务类型下拉框
        createSelect("#businessType", "${controller}/SelectbusinessType");
        //车型下拉框
        createSelect(".modelCar", "${controller}/SelectmodelCar");
        //报名班制下拉框
        createSelect("#Class", "${controller}/SelectClass");
        //训练场下拉框
        createSelect("#GroundName", "${controller}/SelectGroundName");
        //报名点下拉框
        createSelect("#onpointname", "${controller}/SelectEnroll");
        //教练下拉框
        createSelect("#employeeName", "${controller}/Selectemployee");

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
                //url: '${controller}/SelectStudent',
                cols: [[
                    { type: 'numbers', title: '序号', width: 50, fixed: 'left', unresize: true },
                    { field: 'studentid', title: '学员ID', hide: true },
                    { field: 'images', title: '头像', width: 80, align: 'center', fixed: 'left', unresize: true ,templet: setImages},
                    { field: 'name', title: '姓名', width: 100, align: 'center', fixed: 'left', unresize: true },
                    { field: 'sex', title: '性别', width: 80, align: 'center', templet:sex },
                    { field: 'identitycard', title: '身份证', width: 180, align: 'center' },
                    { field: 'phoneone', title: '联系电话', width: 140, align: 'center' },
                    { field: 'modelname', title: '车型', width: 95, align: 'center' },
                    { field: 'registrationpointname', title: '报名点', width: 100, align: 'center' },
                    { field: 'referralname', title: '介绍人', width: 120, align: 'center' },
                    { field: 'departmentname', title: '招生部门',width:150, align: 'center' },
                    { field: 'classname', title: '班制', width: 120, align: 'center' },
                    { field: 'residentialaddress', title: '地址', width: 150, align: 'center'},
                    { field: 'sourceenrollmentname', title: '招生来源', width: 110, align: 'center' },
                    { field: 'remarks', title: '备注', width: 70, align: 'center' },
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
                //选中行，勾选复选框
                //obj.tr.find("div.layui-unselect.layui-form-radio")[0].click();
            });

            //班级费用明细表
            tbSumMoney = layuiTable.render({
                elem: '#sumMoney',
                url: '${controller}/SelectSumMoney',
                cols: [[
                    { type: 'numbers', title: '序号',  align: 'center', width: 80, unresize: true },
                    { field: 'paymentdetailid', title: '缴费明细ID', hide: true },
                    { field: 'fundtype', title: '款项', width: 110, align: 'center', unresize: true },
                    { field: 'paymenttype', title: '付款类型', width: 110, align: 'center', unresize: true, templet: paymentType },
                    { field: 'requiredamount', title: '应缴金额',width: 110, align: 'center', totalRow: true, unresize: true },
                    { field: 'paymentamount', title: '实缴金额',width: 110, align: 'center', totalRow: true, unresize: true, edit: true },
                    { field: 'preferentialamount', title: '优惠金额',width: 110, align: 'center', totalRow: true, unresize: true, edit: true },
                    { field: 'preferences', title: '优惠理由',width: 110,align: 'center', unresize: true, edit: true },
                    { field: 'arrearsmount', title: '欠费',width: 110, align: 'center', unresize: true, edit: true },
                    /*{ field: 'ticketnumber', title: '票号', align: 'center', unresize: true },*/
                    { field: 'paymentremarks', title: '备注', width: 128,align: 'center', unresize: true, edit: true }
                ]],
                text: {
                    none: "请选择班制"
                },
                data: [],
                totalRow: true,
                done: function(res, curr, count){
                    $('.layui-form-select').find('input').unbind("blur");
                    $('tr').each(function (e) {
                        var dataindex = $(this).attr("data-index");
                        var trthis = $(this);
                        $.each(res.data, function (index, value) {
                            if (value.LAY_TABLE_INDEX == dataindex) {
                                trthis.find('td[data-field="paymenttype"] input').val(value.paymenttype);
                            }
                        });
                    });

                    var classcostmoney = $("#sumMoney").next().find('.layui-table-total').find('td[data-field="requiredamount"] div').text();//应缴金额
                    $("#NeedMoney").val(classcostmoney);
                    var paidmoney = $("#sumMoney").next().find('.layui-table-total').find('td[data-field="paymentamount"] div').text();//实缴金额
                    $("#RayMoney").val(paidmoney);
                    var premoney = $("#sumMoney").next().find('.layui-table-total').find('td[data-field="preferentialamount"] div').text();//优惠金额
                    $("#DisMoney").val(premoney);
                }
            });

            //车型下拉框监听
            form.on('select(modelCar)', function(data){
                createSelect("#Regis", "${controller}/SelectModelClass?ModelCar="+data.value,null,"1212");
            });

            //班制下拉框监听
            form.on('select(regis)', function(data){
                $.post("${controller}/selectClassCost",{classID: data.value},function () {
                    tbSumMoney.reload();
                })
            });

            //班级费用明细表表格编辑监听
            layuiTable.on('edit(sumMoney)', function(obj){
                console.log(obj);
                var detailID=obj.data.classcostid !=null ? obj.data.classcostid :obj.data.paymentdetailid;
                objdata.requiredamount = obj.data.requiredamount;//应缴金额
                objdata.paymentamount = obj.data.paymentamount;//实缴金额
                objdata.preferentialamount = obj.data.preferentialamount;//优惠金额
                objdata.preferences = obj.data.preferences == null ? "" : obj.data.preferences;//优惠理由
                objdata.arrearsmount = obj.data.arrearsmount;//欠费
                objdata.paymentremarks = obj.data.paymentremarks == null ? "" : obj.data.paymentremarks;//备注
                //var arrear = parseInt(obj.data.classcostmoney)-(parseInt(obj.data.paidmoney)+parseInt(obj.data.preferentialamount));
                //var arrear = ((Number(obj.data.classcostmoney))-((Number(obj.data.paidmoney)+Number(obj.data.preferentialamount)))).toFixed(2);
                //console.log(obj.data);
                //修改欠费值
                //$("#sumMoney").next().find('.layui-table-body').find('tr[data-index="'+(obj.tr[0].dataset.index)+'"]').find('td[data-field="arrears"] div').text(arrear);
                //欠费值改变，修改实缴金额的值
                if(obj.field=="arrearsmount"){
                    var paidmoneys = ((Number(obj.data.requiredamount))-((Number(obj.data.preferentialamount)+Number(obj.data.arrearsmount)))).toFixed(2);
                    //$("#sumMoney").next().find('.layui-table-body').find('tr[data-index="'+(obj.tr[0].dataset.index)+'"]').find('td[data-field="paidmoney"] div').text(paidmoneys);
                    objdata.paymentamount = paidmoneys
                }
                //console.log(JSON.stringify(objdata));// needamount:"2800" --> "needamount":"2800"
                $.post("${controller}/SessionSumMoney",{Classcostid: detailID, Selectid: 0, Objdata: JSON.stringify(objdata)},function () {
                    if(obj.field=="paymentamount" || obj.field=="preferentialamount" || obj.field=="arrearsmount"){
                        tbSumMoney.reload();//刷新表格
                    }
                });
                //obj.update({arrears:arrear});//更新缓存中欠费的数据
            });

            //缴费明细下拉框监听
            form.on('select(paymentdetail)', function(data){
                /*console.log(data);
                console.log(data.elem.id);
                console.log(data.value);*/
                var selectid = parseInt(data.value);
                $.post("${controller}/SessionSumMoney",{Classcostid: data.elem.id, Selectid: selectid, Objdata: JSON.stringify(objdata)},function () {
                });
            });

            //layui表单自定义验证
            form.verify({
                //姓名下拉框
                name: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!new RegExp("^[1-9A-Za-z\u4e00-\u9fa5]{1,}$").test(value)){
                        return '用户名为空或包含特殊字符';
                    }
                },
                //下拉框
                selectType: function(value, item){
                    if(value=="" || value==0){
                        return '该下拉框必须选择';
                    }
                }
            });

            //提交按钮
            form.on('submit(tijiao)', function(data){
                //遍历cookie数组，获取用户ID
                for (var i = 0; i < aCookie.length; i++) {
                    var aCrumb = aCookie[i].split("=");
                    if (escape("CookieUserID") == aCrumb[0]){
                        //unescape()函数 用于对已经使用 escape()函数 编码的字符串进行解码，并返回解码后的字符串
                        $("#userid").val(unescape(aCrumb[1]));// 回填用户ID
                    }
                }
                $("#formStudent").ajaxSubmit(function (returnJson) {
                    if (returnJson.state==true) {
                        $("#modStudent").modal("hide");//关闭模态框
                        layer.msg(returnJson.msg); //提示信息
                        tbstudent.reload();//刷新表格
                    } else {
                        layer.alert(returnJson.msg);
                    }
                });
                return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
            });
            StudentSelect();//学员表条件查询
        });
    })

    //性别
    function sex(data) {
        var text =data.sex;
        return text==true ?'<a class="">男</a>':'<a class="">女</a>';
    }

    //学员表自定义工具栏
    function setStudent(data) {
        var StudentID = data.studentid;
        return '<a title="编辑" onclick="StudentUpdate('+ StudentID +')" style="padding-right: 10px;">'+'<i class="layui-icon">&#xe642;</i>'+'</a>'+
            '<a title="删除" onclick="StudentDelete('+ StudentID +')">'+'<i class="layui-icon">&#xe640;</i>'+'</a>';
    }

    //学员表头像自定义工具栏
    function setImages(data) {
        return '<img src="'+(data.photograph !=null ? data.photograph :"/assets/img/Snipaste_2021-04-28_08-42-40.png") +'" height="100%"/>';
    }

    /*function setSumMoney(data) {
        var paymentdetailID = data.paymentdetailid;
        return '<a title="删除" onclick="paymentDetailDelete('+ paymentdetailID +')">'+'<i class="layui-icon">&#xe640;</i>'+'</a>';
    }*/


    //条件查询
    function StudentSelect(){
        var objdatas = new Object();
        var NameCardPhone = $("#NameCardPhone").val();//姓名/证件号/手机号
        var ReferralName = $("#ReferralName").val();//介绍人
        var RegistrationPoint = $("#RegistrationPoint").val();//报名点
        var Class = $("#Class").val();//班制
        var Gender = $("#Gender").val();//性别
        var Department = $("#Department").val();//招生部门
        var Model = $("#DrivingModel").val();//车型

        var AgeOne = $("#AgeStart").val(); // 开始年龄
        var AgeTwo = $("#AgeEnd").val(); // 结束年龄
        var AgeStart = ""; // 开始年龄
        var AgeEnd = ""; // 结束年龄
        if(AgeOne == ""){ AgeOne=0 }
        if(AgeTwo == ""){ AgeTwo=150 }
        if(AgeOne<0){ $("#AgeStart").val(0); AgeOne=0; }
        if(AgeTwo<0){ $("#AgeEnd").val(0); AgeTwo=0; }
        if (AgeOne > AgeTwo) {
            AgeEnd = AgeOne;
            AgeStart = AgeTwo;
        } else if (AgeOne < AgeTwo) {
            AgeEnd = AgeTwo;
            AgeStart = AgeOne;
        } else {
            AgeEnd = parseInt(AgeTwo)+1;
            AgeStart = AgeOne;
        }
        tbstudent.reload({
            url: '${controller}/SelectStudent',
            where: {
                NameCardPhone: NameCardPhone, ReferralName: ReferralName, RegistrationPoint: RegistrationPoint, Class: Class,
                Gender: Gender, Department: Department, AgeStart: AgeStart, AgeEnd: AgeEnd, Model: Model
            },
            page: { curr: 1 }
        })
    }

    //身份证提取生日性别
    function idCardDraw() {
        var idCard = $("#idCard").val();//身份证
        var birthday = '';
        if(idCard.length==15 || idCard.length==18){
            //15位身份证
            if (idCard.length == 15) birthday = '19' + idCard.slice(6, 12);
            //18位身份证
            else if (idCard.length == 18) birthday = idCard.slice(6, 14);
            //提取生日
            birthday = birthday.replace(/(.{4})(.{2})/, '$1-$2-');
            //提取性别
            parseInt(idCard.slice(-2, -1)) % 2 == 1 ? $("input[name=sex][value=true]").prop('checked',true) : $("input[name=sex][value=false]").prop('checked',true);
            form.render("radio");
        }
        $("#birthday").val(birthday);
    }

    //缴费明细表付款类型下拉框
    function paymentType(data) {
        //新增用的是班级费用明细ID，回填用的是缴费明细ID
        var detailID = data.classcostid !=null ? data.classcostid :data.paymentdetailid;
        var sr = '<select lay-filter="paymentdetail" id="'+detailID+'">';
        $.ajax({
            url: '${controller}/SelectPaymentType', type: 'post', async: false, success: function (returnJson) {
                //console.log(returnJson);
                for (k in returnJson) {
                    sr += '<option value=' + returnJson[k].id + '>' + returnJson[k].text + '</option>';
                }
                sr += '</select>';
            }
        })
        return sr;
    }

    //缴费明细表款项下拉框
    /*function fundType() {
        var sr = '<select name="selectFund">';
        $.ajax({
            url: '${controller}/SelectFund', type: 'post', async: false, success: function (returnJson) {
                for (k in returnJson) {
                    sr += '<option value=' + returnJson[k].id + '>' + returnJson[k].text + '</option>';
                }
                sr += '</select>';
            }
        })
        return sr;
    }*/


    //学员报名按钮
    function StudentAdd() {
        $("#formStudent").prop("action", "${controller}/InsertStudent");//新增路径
        $("#UsImgStudentPicture").attr("src","/assets/img/Snipaste_2021-04-28_08-42-40.png");//清空图片
        $("#formStudent")[0].reset();//重置表单
        $("#modStudent").modal('show');//打开模态框
        $("#modelcar").attr("disabled",false);//取消禁用车型下拉框
        $("#Regis").attr("disabled",false);//取消禁用班制下拉框
        emptySession();//清空session
        var paymentNumber="",studentNumber="";
        $.ajax({
            url: '${controller}/SelectTicket', type: 'post', async: false, success: function (data) {
                paymentNumber=data[0]; studentNumber=data[1];
                for (let i = 0; i < 5; i++) {
                    if(paymentNumber.toString().length < 5){
                        paymentNumber="0"+paymentNumber;
                    }
                    if(studentNumber.toString().length < 5){
                        studentNumber="0"+studentNumber;
                    }
                }
            }
        })
        $("#TicketNumber").val("8"+paymentNumber);//缴费票号
        $("#numbers").val("1"+studentNumber);//学员编号
    }

    //回填学员信息
    function StudentUpdate(StudentID) {
        $("#formStudent").prop("action", "${controller}/UpdateStudent");//修改路径
        $("#UsImgStudentPicture").attr("src","/assets/img/Snipaste_2021-04-28_08-42-40.png");//清空图片
        $("#formStudent")[0].reset();//重置表单
        $("#modStudent").modal('show');//打开模态框
        $("#modelcar").attr("disabled",true);//禁用车型下拉框
        $("#Regis").prop("disabled",true);//禁用班制下拉框
        emptySession();//清空session

        $.post("${controller}/BackfillStudent",{StudentID: StudentID},function (data) {
            loadDatatoForm("formStudent",data);//表单数据回填
            //回填班制下拉框
            createSelect("#Regis", "${controller}/SelectModelClass?ModelCar="+data.modelid,data.classid,"11111");
            //图片回填
            $("#UsImgStudentPicture").attr("src",data.photograph!=null ?data.photograph :"/assets/img/Snipaste_2021-04-28_08-42-40.png");
            //性别单选按钮
            data.sex ? $("#sex input:first-child").prop("checked",true) : $("#sex input:nth-last-child(2)").prop("checked",true);
            //资料齐全否单选按钮
            data.materialsbit ? $("#materialsbit input:first-child").prop("checked",true) : $("#materialsbit input:nth-last-child(2)").prop("checked",true);
            tbSumMoney.reload();
        })
    }

    //学员删除
    function StudentDelete(StudentID) {
        layer.confirm("你确定要删除该学员吗？", { icon: 3, title: "提示" }, function (layerIndex) {
            layer.close(layerIndex);
            $.post("${controller}/DeleteStudent", { StudentID: StudentID }, function (returnJson) {
                if (returnJson.state==true) {
                    layer.msg(returnJson.msg);
                    tbstudent.reload();
                }
                else {
                    layer.msg(returnJson.msg);
                }
            });
        });
    }

/*    //缴费明细删除
    function paymentDetailDelete(paymentdetailID) {
        console.log(paymentdetailID);
    }*/

    //通过文件获取的接口来获取选择的图片并显示出来
    //FileReader接口提供了一个异步的API，通过这个API可以从浏览器中异步访问文件系统中的数据。因此，FileReader接口可以读取文件中的数据，并将读取的数据放入到内存中去
    //选择照片:用FileReader对象来读取本地数据，并且将数据结果赋值给image的src、

    //打开file表单,选择图片
    function chooseImageFile(inputFileID) {
        $("#" + inputFileID).click();
    }
    //创建FileReader对象
    var imgReader = new FileReader();
    //正则表达式 过滤图片文件
    regexImageFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
    //file表单改变事件，将选择的图片显示到img元素
    function showImgToView(inputFileId) {
        //选择图片文件
        var imgFile = $("#" + inputFileId).get(0).files[0];
        //console.log(imgFile);
        //判断上传文件是否为图片格式
        if (!regexImageFilter.test(imgFile.type)) {
            layer.msg("请选择有效的图片文件", { icon: 0, title: "提示" });
        }
        else {
            //readAsDataURL()方法可以获取API异步读取的文件数据，另存为数据URL;
            //FileReader对象的readAsDataURL方法可以将读取到的文件编码成Data URL。Data URL是一项特殊的技术，可以将资料(例如图片)内嵌在网页之中，不用放到外部文件。
            imgReader.readAsDataURL(imgFile);
        }
    }
    //读取文件 onload事件
    imgReader.onload = function (evt) {
        console.log(evt);
        //将该URL绑定到img标签的src属性上，就可以实现图片的上传预览效果了。
        $("#UsImgStudentPicture").attr("src", evt.target.result);
    };

    function emptySession() {
        $.post("${controller}/emptySumMoney",function (data) {
            tbSumMoney.reload();
        })
    }

    //下拉框封装方法
    function createSelect(selectId, url, value, layerselect) {
        $.post(url, function (returnJson) {
            $(selectId).empty();//清空该元素
            //创建option
            for (k in returnJson) {
                $(selectId).append('<option value="' + returnJson[k].id + '">' + returnJson[k].text + '</option>');
            }
            //设置选中值
            if (value != undefined && value != null && value != '') {
                $(selectId).val(value);
            }
            if(layerselect != null){
                form.render("select");//layer更新渲染
            }
        });

    }

</script>
</body>

</html>
