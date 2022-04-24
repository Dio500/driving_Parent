<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="/assets/plugins/login/static" var="Login"></c:set>
<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/StudentController" var="ctx"></c:set>
<html>

<head>
    <meta charset="UTF-8">
    <title>换班管理</title>
    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">
    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet" />

    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">
    <script src="/assets/plugins/layui/layui.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery.form.min.js"></script><%--form表单提交--%>
    <script type="text/javascript" src="/assets/plugins/js/customfunction.js"></script><%--表单回填--%>

    <script src="/assets/plugins/bootstrap-4.1.3-dist/js/popper.min.js"></script>
    <script src="/assets/plugins/bootstrap-4.1.3-dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
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

    #formChangeShift input,#formSelect input{
        height: 30px;
    }

    #LayuiTab .layui-form-select{
        width: 110px !important;
        padding-top: 4px;
    }

    #formSelect .layui-form-select{
        margin-left: 10px;
        width: 150px;
    }

    #formChangeShift .layui-form-select{
        width: 157px;
    }

    #formChangeShift .layui-form-radio {
        line-height: 16px;
    }

    .Shift label{
        width: 70px;
    }
    .LayuiIcon{
        width: 35px;
        height: 30px;
        text-align: center;
        line-height: 30px;
        cursor: pointer;
    }
    .PayInfo input{
        width: 80px;
        border: none;
        margin: -5px 0px -2px 0px;
    }
    .FillCost{
        width: 45px;
        height: 30px;
        text-align: center;
        line-height: 30px;
        font-size: 12px;
    }
    #formAuditing label{
        width: 80px;
    }

    #formAuditing input{
        padding-bottom: 8px;
        width: 75px;
        autocomplete:off !important;
        border:none;
    }

</style>
<body>
<nav aria-label="breadcrumb">
    <ol class="breadcrumb m-0">
        <li class="breadcrumb-item">学员管理</li>
        <li class="breadcrumb-item active" aria-current="page">换班管理</li>
    </ol>
</nav>
<div class="container-fluid">
    <div class="row mt-2">
        <label class="col-sm-11 col-form-label" style="line-height:20px;font-size:22px;color:#000;font-family:'华文中宋'">换班管理</label>
    </div>

    <!-- 条件查询 -->
    <div class="row mt-2">
        <div class="col-sm-10">
            <form id="formSelect" class="layui-form" method="post" action="" style="font-size: 14px">
                <div class="row">
                    <input type="text" class="layui-input col-sm-2 ml-2" name="SignUpName" autocomplete="off" placeholder="姓名/证件号/手机号" />
                    <select name="CsAudit" lay-filter="CsAudit">
                        <%--<option value="">审核状态</option>--%>
                        <option value="0">未审核</option>
                        <option value="1">审核通过</option>
                        <option value="2">审核失败</option>
                        <option value="">全部</option>
                    </select>
                    <select name="arrearage" lay-filter="arrearage">
                        <option value="">是否欠费</option>
                        <option value="true">是</option>
                        <option value="false">否</option>
                    </select>
                    <select name="NamePointID" id="NamePoint"></select>
                    <select name="DepartmentID" id="Department"></select>
                    <label class="layui-form-label p-1 text-right">换班时间</label>
                    <input type="text" class="layui-input col-sm-2" name="SMTime" id="test" autocomplete="off" placeholder="开始日期 - 结束日期">
                </div>
            </form>
        </div>

        <div class="col-sm-2">
            <div class="layui-btn-container float-right">
                <button type="button" class="layui-btn layui-btn-sm" onclick="SearchChangeShift()">查 询</button>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" id="openChangeShift">新 增</button>
            </div>
        </div>
    </div>
    <!-- 表格 -->
    <div class="row">
        <div class="col-sm-12">
            <table id="tabChangeShift" lay-filter="tabChangeShift"></table>
        </div>
    </div>
    <!-- 新增/修改模态框 -->
    <div class="modal fade" id="modChangeShift">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="width: 1020px;margin-left: -100px;">
                <div class="modal-header py-3">
                    <h5 class="modal-title">换班信息</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body pt-0 frew">
                    <form id="formChangeShift" class="layui-form px-2" method="post" action="" style="font-size: 14px" enctype="multipart/form-data" >
                        <input type="hidden" name="studentid"/>
                        <input type="hidden" name="smstate"/>
                        <input type="hidden" name="ordmodelid"/>
                        <input type="hidden" name="ordclassid"/>
                        <input type="hidden" name="userid"/>
                        <div class="row mt-2 pt-2 PayInfo">
                            <span class="ml-3" style="font-weight: bold; padding-right: 50px">学员信息</span>

                            <span class="text-muted">&nbsp;&nbsp;应缴金额:&nbsp;<span class="text-primary">￥</span></span>
                            <input type="text" name="AmountPay" class="text-primary" readonly value="0" />
                            <span class="text-muted">&nbsp;&nbsp;欠费金额:&nbsp;<span class="text-primary">￥</span></span>
                            <input type="text" name="AlreadyPay" class="text-primary" readonly value="0" />
                        </div>
                        <div class="row mt-2 Shift">
                            <label class="layui-form-label p-1 text-center">证件号</label>
                            <input type="text" class="layui-input col-sm-2 FourField" name="identitycard" autocomplete="off" placeholder="请输入证件号">
                            <span class="LayuiIcon border" id="LayuiIcon" onclick="searchStudent()"><i class="layui-icon">&#xe615;</i></span>

                            <label class="layui-form-label p-1 text-center">姓名</label>
                            <input type="text" class="layui-input col-sm-2" name="name" readonly>

                            <label class="layui-form-label p-1 text-center">手机号</label>
                            <input type="text" class="layui-input col-sm-2" name="phoneone" readonly>

                            <label class="layui-form-label p-1 text-center">报名时间</label>
                            <input type="text" class="layui-input col-sm-2" name="registrationtime" readonly>
                        </div>
                        <div class="row mt-2 Shift">
                            <label class="layui-form-label p-1 text-center">报名点</label>
                            <input type="text" class="layui-input" name="registrationpointname" readonly style="width: 201px;">

                            <label class="layui-form-label p-1 text-center">车型-班制</label>
                            <input type="text" class="layui-input col-sm-2" name="modelclass" readonly>

                            <label class="layui-form-label p-1 text-center">介绍人</label>
                            <input type="text" class="layui-input col-sm-2" name="referralname" readonly>

                            <label class="layui-form-label p-1 text-center">当前状态</label>
                            <input type="text" class="layui-input col-sm-2" name="studystate" readonly>
                        </div>
                        <div id="paymentdetailDiv">
                            <div class="row mt-2 pt-2 border border-bottom-0 border-right-0 border-left-0 PayInfo" >
                                <span class="ml-3" style="font-weight: bold;">缴费信息</span>
                            </div>
                            <!-- 表格 -->
                            <div class="row mt-2">
                                <div class="col-sm-12">
                                    <table id="tabPayDetail" lay-filter="tabPayDetail" ></table>
                                </div>
                            </div>
                        </div>
                        <div id="classcostDiv" hidden>
                            <div class="row mt-2 pt-2 border border-bottom-0 border-right-0 border-left-0 PayInfo" >
                                <span class="ml-3" style="font-weight: bold; padding-right: 90px">更换班级费用信息</span>

                                <span class="text-muted">&nbsp;&nbsp;应缴金额:&nbsp;<span class="text-primary">￥</span></span>
                                <input type="text" name="needpaymenttotalmoney" id="NeedMoney" class="text-primary" readonly value="0" />

                                <span class="text-muted">&nbsp;&nbsp;已缴金额:&nbsp;<span class="text-primary">￥</span></span>
                                <input type="text" name="paymenttotalmoney" id="RayMoney" class="text-primary" readonly value="0" />

                                <span class="text-muted">&nbsp;&nbsp;优惠金额:&nbsp;<span class="text-primary">￥</span></span>
                                <input type="text" name="discounttotalmoney" id="DisMoney" class="text-primary" readonly value="0" />
                            </div>
                            <!-- 表格 -->
                                <div class="" id="LayuiTab">
                                    <table id="tabClasscost" lay-filter="tabClasscost"></table>
                                </div>
                        </div>

                        <div class="row mt-2" style="padding-top:10px;padding-bottom:10px;">
                            <label class="layui-form-label p-1 text-center col-sm-1"><span style="color:red">*&nbsp;</span>付款方式</label>
                            <select name="paymenttypeid" id="PaymentType" lay-verify="DownFrame"></select>

                            <label class="layui-form-label p-1 text-center col-sm-1"><span style="color:red">*&nbsp;</span>金额</label>
                            <input type="text" class="layui-input" name="applicationmoney" id="appmoney" autocomplete="off" readonly style="width: 111px; color: red">
                            <span class="FillCost border" onclick="bufeiclick()">补费</span>

                            <label class="layui-form-label p-1 text-center col-sm-1">票号</label>
                            <input type="text" class="layui-input col-sm-2" name="introducer" readonly>

                            <label class="layui-form-label p-1 text-center col-sm-1">申请原因</label>
                            <input type="text" class="layui-input col-sm-2 FourField" name="applicationreason" autocomplete="off" placeholder="请输入内容">
                        </div>
                        <div class="row mt-2">
                            <label class="layui-form-label p-1 text-center col-sm-1"><span style="color:red">*&nbsp;</span>更换车型</label>
                            <select name="modelid" id="DriveType" lay-filter="DriveType" lay-verify="DownFrame"></select>

                            <label class="layui-form-label p-1 text-center col-sm-1"><span style="color:red">*&nbsp;</span>更换班制</label>
                            <select name="classid" id="ShiftClass" lay-filter="ShiftClass" lay-verify="DownFrame"></select>

                            <label class="layui-form-label p-1 text-center col-sm-1">换班介绍人</label>
                            <input type="text" class="layui-input col-sm-2 FourField" name="applicationreferral" autocomplete="off" placeholder="请输入换班介绍人">

                            <label class="layui-form-label p-1 text-center col-sm-1"><span style="color:red">*&nbsp;</span>换班时间</label>
                            <input type="text" class="layui-input col-sm-2 FourField" name="applicationtime" id="CsTime" autocomplete="off" placeholder="请输入换班时间" lay-verify="required">
                        </div>
                        <div class="row mt-2">
                            <div class="col-sm-12">
                                <div class="layui-btn-container float-right">
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" data-dismiss="modal">取&nbsp;&nbsp;&nbsp;消</button>
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal FourField" lay-submit lay-filter="SavaChangeShift">确&nbsp;&nbsp;&nbsp;定</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 审核模态框 -->
    <div class="modal fade" id="modAuditing">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="width: 690px;">
                <div class="modal-header py-3">
                    <h5 class="modal-title">换班审核</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body pt-0 frew">
                    <form id="formAuditing" class="layui-form px-2" method="post" action="${ctx}/updateAuditing" style="font-size: 14px" onsubmit=" return false;">
                        <input type="hidden" name="studentid"/>
                        <input type="hidden" name="applicationid"/>
                        <input type="hidden" name="applicationstatus"/>
                        <input type="hidden" name="ordclassid"/>
                        <input type="hidden" name="classid"/>
                        <input type="hidden" name="modelid"/>
                        <input type="hidden" name="userid"/>

                        <div class="row mt-2 pt-2 PayInfo">
                            <span class="ml-3" style="font-weight: bold;">学员信息</span>
                        </div>
                        <div class="row mt-4 Shift">
                            <%--<label class="text-center">证件号：</label>
                            <input type="text" style="width: 150px" name="identitycard" readonly/>--%>

                            <label class="text-center">姓名：</label>
                            <input type="text" name="name" readonly/>

                            <label class="text-center">当前状态：</label>
                            <input type="text" name="studystate" readonly/>

                            <label class="text-center">手机号：</label>
                            <input type="text" style="width: 100px" name="phoneone" readonly/>
                        </div>
                        <div class="row mt-2 pt-2 PayInfo">
                            <span class="ml-3" style="font-weight: bold;">更换班级信息</span>
                        </div>
                        <div class="row mt-4" style="padding-top:10px;padding-bottom:10px;">
                            <label class="text-center">原车型：</label>
                            <input type="text" name="ordmodelname" readonly/>

                            <label class="text-center">原班制：</label>
                            <input type="text" name="ordclassname" readonly/>

                            <label class="text-center">操作人：</label>
                            <input type="text" name="username" readonly/>

                            <label class="text-center">票号：</label>
                            <input type="text" name="introducer" style="width: 120px" readonly/>
                        </div>
                        <div class="row mt-2 mb-3">
                            <label class="text-center">更换车型：</label>
                            <input type="text" name="modelname" readonly/>

                            <label class="text-center">更换班制：</label>
                            <input type="text" name="classname" readonly/>

                            <label class="text-center">换班金额：</label>
                            <input type="text" name="applicationmoney" readonly/>

                            <label class="text-center">换班时间：</label>
                            <input type="text" name="applicationtime" readonly/>
                        </div>
                        <div class="row mt-2">
                            <div class="col-sm-12">
                                <div class="layui-btn-container float-right">
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-submit lay-filter="SavaAuditing">审核通过</button>
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" lay-submit lay-filter="SavaAuditing">审核失败</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script>
var layer, layuiTable, form;//保存layui模块以便全局使用
var tabChangeShift;
var tabPayDetail;
var tabClasscost;
var studentdate = false;//是否有学生数据
var arrearsBit = false;//欠费状态
var ordAmountPay;//原班级应缴金额
var ordAlreadyPay;//原班级欠费金额
var newAmountPay;//新班级应缴金额
var aCookie = document.cookie.split("; ");//获取cookie
var objdata = new Object();
var Jurid = [];//记录权限信息
var kkk = "${deef}";//用户名

$(function(){
    //报名点下拉框查询
    createSelect("#NamePoint", "${ctx}/SelectEnroll");
    //车型下拉框查询
    createSelect("#DriveType", "${ctx}/SelectmodelCar");
    //部门下拉框查询
    createSelect("#Department", "${ctx}/SelectDepartment");

    //加载&&初始化layui模块
    layui.use(['layer', 'table', 'form', 'laydate'], function () {
        layer = layui.layer,
        layuiTable = layui.table;
        form = layui.form;
        laydate = layui.laydate;

        //日期范围筛选
        laydate.render({
            elem: '#test',
            range: true, //或 range: '~' 来自定义分割字符
            trigger: 'click'
        });
        //换班时间
        laydate.render({elem: '#CsTime',trigger: 'click'});
        //换班审核表
        tabChangeShift = layuiTable.render({
            elem: '#tabChangeShift',
            //url: "${ctx}/selManageByPage",
            cols: [[//表头
                { type: 'numbers', title: '序号', width: 80, fixed: 'left', unresize: true },
                { field: "studentid", hide: true },
                { field: "applicationid",  hide: true },
                { field: "applicationstatus",  hide: true },
                { field: "name", title: "姓名",fixed: 'left', align: "center", width: 100 },
                { field: "identitycard", title: "证件号", align: "center", width: 175 },
                { field: "studystate", title: "当前状态", align: "center", width: 100 },
                { field: "phoneone", title: "电话", align: "center", width: 120 },
                { field: "registrationtime", title: "报名时间", align: "center", width: 120 },
                { field: "applicationtime", title: "换班时间", align: "center", width: 120 },
                { field: "registrationpointname", title: "报名点", align: "center", width: 100 },
                { field: "ordmodelclass", title: "原车型-班制", align: "center" , width: 120 },
                { field: "modelclass", title: "更换车型-班制", align: "center" , width: 120 },
                { field: "applicationmoney", title: "金额", align: "center" , width: 100 },
                { field: "applicationreferral", title: "介绍人", align: "center", width: 100 },
                { field: "departmentname", title: "招生部门", align: "center", width: 100 },
                { title: "审核状态", width: 100, align: 'center', fixed: 'right', templet: smAudit },
                { title: "操作", templet: setOperate, width: 160, align: 'center', fixed: 'right' }
            ]],
            page: {
                limit: 10,//指定每页显示的条数
                limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
            },
            data: [],
        });

        //初始化缴费明细表
        tabPayDetail = layuiTable.render({
            elem: '#tabPayDetail',
            //url: "${ctx}/SelectSumMoney",
            cols: [[//表头
                { type: "numbers", title: "序号", width: 80,  align: "center"},
                { field: "paymentdetailid", hide: true },
                { field: "fundid", hide: true },
                { field: "fundtype", title: "款项", align: "center", totalRowText: '合计：', width: 120, unresize: true },
                { field: "paymenttype", title: "收款方式", align: "center", width: 120, unresize: true },
                { field: "requiredamount", title: "应缴金额", align: "center", totalRow: true, width: 120, unresize: true },
                { field: 'paymentamount', title: '实缴金额',width: 110, align: 'center', totalRow: true, unresize: true },
                { field: 'preferentialamount', title: '优惠金额',width: 140, align: 'center', unresize: true, templet: preferentialBit },
                { field: "arrearsmount", title: "欠费", align: "center", totalRow: true, width: 110, unresize: true },
                { field: "paymenttime", title: "缴费时间", align: "center", width: 160, unresize: true },
            ]],
            totalRow: true,
            data: [],
            done: function (res, curr, count) {
                //计算总金额
                var AmountPay = $("#tabPayDetail").next().find('.layui-table-total').find('td[data-field="requiredamount"] div').text();
                var AlreadyPay = $("#tabPayDetail").next().find('.layui-table-total').find('td[data-field="arrearsmount"] div').text();
                var newclassPay = AmountPay;//换班后总金额
                if (ordAmountPay!="") {
                    AmountPay=ordAmountPay;
                    AlreadyPay=0;
                    $("#appmoney").val((Number(newclassPay)-Number(ordAmountPay)).toFixed(2));//修补费金额
                }
                $("#formChangeShift [name='AmountPay']").val(Number(AmountPay).toFixed(2)); // 更换班制后的应缴金额
                $("#formChangeShift [name='AlreadyPay']").val(Number(AlreadyPay).toFixed(2)); // 更换班制后的欠费金额

                newAmountPay = AmountPay;
                if(parseInt(AlreadyPay)>0){
                    arrearsBit = true;//欠费状态
                }
            }
        });

        //初始化班级费用明细
        tabClasscost = layuiTable.render({
            elem: '#tabClasscost',
            //url: "${ctx}/SelectSumMoney",
            cols: [[//表头
                { title: '序号', type: 'numbers', align: 'center', width: 100, unresize: true },
                { field: 'paymentdetailid', title: '缴费明细ID', hide: true },
                { field: 'fundtype', title: '款项', width: 110, align: 'center', unresize: true },
                { field: 'paymenttype', title: '付款类型', width: 110, align: 'center', unresize: true, templet: paymentType },
                { field: 'requiredamount', title: '应缴金额',width: 110, align: 'center', totalRow: true, unresize: true },
                { field: 'paymentamount', title: '实缴金额',width: 110, align: 'center', totalRow: true, unresize: true, edit: true },
                { field: 'preferentialamount', title: '优惠金额',width: 110, align: 'center', totalRow: true, unresize: true, edit: true },
                { field: 'preferences', title: '优惠理由',width: 110,align: 'center', unresize: true, edit: true },
                { field: 'arrearsmount', title: '欠费',width: 110, align: 'center', unresize: true, edit: true },
                /*{ field: 'ticketnumber', title: '票号', align: 'center', unresize: true },*/
                { field: 'paymentremarks', title: '备注', width: 110,align: 'center', unresize: true, edit: true }
            ]],
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
                $("#NeedMoney").val($("#tabClasscost").next().find('.layui-table-total').find('td[data-field="requiredamount"] div').text());//应缴金额
                $("#RayMoney").val($("#tabClasscost").next().find('.layui-table-total').find('td[data-field="paymentamount"] div').text());//实缴金额
                $("#DisMoney").val($("#tabClasscost").next().find('.layui-table-total').find('td[data-field="preferentialamount"] div').text());//优惠金额

                var amount = $("#formChangeShift [name='AmountPay']").val();//前班级应缴金额
                var already = $("#formChangeShift [name='AlreadyPay']").val();//前班级欠费金额

                if(Number($("#NeedMoney").val()) > 0){
                    $("#appmoney").val((Number($("#NeedMoney").val())-Number(amount)+Number(already)).toFixed(2));//修补费金额

                }else {
                    $("#appmoney").val("");
                }
            }
        });

        //班级费用明细表表格编辑监听
        layuiTable.on('edit(tabClasscost)', function(obj){
            var detailID=obj.data.classcostid !=null ? obj.data.classcostid :obj.data.paymentdetailid;
            objdata.requiredamount = obj.data.requiredamount;//应缴金额
            objdata.paymentamount = obj.data.paymentamount;//实缴金额
            objdata.preferentialamount = obj.data.preferentialamount;//优惠金额
            objdata.preferences = obj.data.preferences == null ? "" : obj.data.preferences;//优惠理由
            objdata.arrearsmount = obj.data.arrearsmount;//欠费
            objdata.paymentremarks = obj.data.paymentremarks == null ? "" : obj.data.paymentremarks;//备注

            //欠费值改变，修改实缴金额的值
            /*if(obj.field=="arrearsmount"){
                var paidmoneys = ((Number(obj.data.requiredamount))-((Number(obj.data.preferentialamount)+Number(obj.data.arrearsmount)))).toFixed(2);
                objdata.paymentamount = paidmoneys
            }*/
            //实缴金额改变，修改欠费金额的值
            if(obj.field=="paymentamount"){
                var arrears = (Number(obj.data.requiredamount)-((Number(obj.data.paymentamount))+Number(obj.data.preferentialamount))).toFixed(2);
                objdata.arrearsmount = arrears;//欠费金额
            }
            //console.log(JSON.stringify(objdata));// needamount:"2800" --> "needamount":"2800"
            $.post("${ctx}/SessionSumMoney",{Classcostid: detailID, Selectid: 0, Objdata: JSON.stringify(objdata)},function () {
                if(obj.field=="paymentamount" || obj.field=="preferentialamount" || obj.field=="arrearsmount"){
                    tabClasscost.reload({url: "${ctx}/SelectSumMoney"});//刷新表格
                }
            });
        });


        //车型下拉框监听事件（车型下拉框）
        form.on('select(DriveType)', function (data) {
            console.log(studentdate);
            if(studentdate == true){
                //$("#ShiftClass").attr("disabled",true);//禁用班级下拉框
                //更换班制下拉框
                layuiSelect("ShiftClass", "${ctx}/SelectModelClass?ModelCar="+data.value);
                //付款类型下拉框查询
                layuiSelect("PaymentType", "${ctx}/SelectPaymentType");
            }else {
                //$("#ShiftClass").attr("disabled",true);//禁用班级下拉框
                //form.render('select');
                layer.msg("请选择需要换班的学员！");
            }
        });

        //班制下拉框监听事件（班制下拉框）
        form.on('select(ShiftClass)', function (data) {
            //clearClassCost();//清空session
            var ClassID = $("#formChangeShift [name='ordclassid']").val(); // 原班制ID
            var ShiftClassID = data.value; // 更换后的班制ID
            //console.log(ClassID+"--"+ShiftClassID);
            if(ClassID != ShiftClassID){
                $.post("${ctx}/selectClassCost",{classID: ShiftClassID},function (data){
                    //刷新班级费用表格
                    tabClasscost.reload({url: "${ctx}/SelectSumMoney"});
                });
                //隐藏班级费用明细信息
                $("#paymentdetailDiv").prop("hidden",true);
                $("#classcostDiv").prop("hidden",false);
            }else {
                //隐藏班级费用明细信息
                $("#paymentdetailDiv").prop("hidden",false);
                $("#classcostDiv").prop("hidden",true);
                layer.alert("班制一致，请重选班制！");
                clearClassCost();
            }
        });

        //表单自定义验证
        form.verify({
            //验证下拉框是否为空
            DownFrame: function (value,item){
                if (value <= 0 || value == "" || value == null) {
                    return '必填项不能为空';
                }
            },
        });

        //审核下拉框筛选
        form.on('select(CsAudit)', function(){
            SearchChangeShift();//调用报名受理多条件查询
        });

        //是否欠费下拉框筛选
        form.on('select(arrearage)', function(){
            SearchChangeShift();//调用报名受理多条件查询
        });

        //监听提交(保存新增/修改班制表)
        form.on('submit(SavaChangeShift)', function(obj){
            var data = obj.field;

            if(data.ordclassid != data.classid){
                layer.confirm("该学员需补费"+ data.applicationmoney +"元，确定要换班吗", { icon: 3, title: "提示" }, function (layerIndex) {
                    layer.close(layerIndex);
                    $("#formChangeShift").ajaxSubmit(function (data) {
                        if (data.state==true) {
                            //刷新表格
                            tabChangeShift.reload();
                            //关闭模态框
                            $("#modChangeShift").modal("hide");
                        }
                        layer.msg(data.msg);
                    });
                });
            }else {
                layer.msg("班制一致，请重选班制！");
            }
            return false;//阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        //审核提交
        form.on('submit(SavaAuditing)',function (obj){
            $("#formAuditing [name='applicationstatus']").val(obj.elem.outerText == "审核通过" ? 1 : 2);//审核状态
            layer.confirm("确定要"+ obj.elem.outerText +"吗？", { icon: 3, title: "提示" }, function (layerIndex) {
                layer.close(layerIndex);
                $("#formAuditing").ajaxSubmit(function (data) {
                    if (data.state==true) {
                        //刷新表格
                        tabChangeShift.reload();
                        //关闭模态框
                        $("#modAuditing").modal("hide");
                    }
                    layer.msg(data.msg);
                });
            });
            console.log(obj.field);
        })

        //调用报名受理多条件查询
        SearchChangeShift();
    });
});

//缴费明细表付款类型下拉框
function paymentType(data) {
    var sr = '<select lay-filter="PTdetail" id="'+data.classcostid+'">';
    $.ajax({
        url: '${ctx}/SelectPaymentType', type: 'post', async: false, success: function (returnJson) {
            for (k in returnJson) {
                sr += '<option value=' + returnJson[k].id + '>' + returnJson[k].text + '</option>';
            }
            sr += '</select>';
        }
    })
    return sr;
}

//缴费明细表审核状态
function preferentialBit(data){
    var preferential = "";
    preferential = '<a>'+data.preferentialamount+'</a>';
    if(data.preferentialstatus != null){
        preferential += data.preferentialstatus == 0 ? '<a style="color: #f09445; padding-left: 5px;">未审核</a>' : (data.preferentialstatus == 1 ? '<a style="color: #3e76e4; padding-left: 5px;">已审核</a>' : '<a style="color: #ff4747; padding-left: 5px;">未通过</a>');
    }
    return preferential;
}

//清空缴费信息session
function clearPayDetail(){
    $.post("${ctx}/clearPayDetail",function () {
        tabPayDetail.reload();
    });
}

//清空班级费用信息session
function clearClassCost(){
    $.post("${ctx}/clearClassCost",function () {
        tabClasscost.reload();
    });
}

//设置换班表操作按钮
function setOperate(data) {
    var studentID = data.studentid;//学员ID
    var applicationID = data.applicationid;//审核ID
    var applicationStatus = data.applicationstatus;//审核状态
    var btn = "";
    btn += '<button type="button" class="layui-btn layui-btn-xs" onclick="openUpdateModel(' + studentID + ')">详情</button>';
    btn += '<button type="button" class="layui-btn layui-btn-xs layui-btn-normal" onclick="updateAudit('+applicationID+','+applicationStatus+')">审核</button>';
    return btn;
}

//自定义“审核”列
function smAudit(data){
    var austatus = data.applicationstatus;
    return austatus>0 ? (austatus==1 ? "<span class='text-primary'>审核通过</span>" : "<span class='text-danger'>申请失败</span>") : "<span class='text-warning'>未审核</span>";
}

//根据换班、五次不过、退学状态查询票号(回填票号)
function BackfillNumber(){
    //根据换班、五次不过、退学状态查询票号
    $.post("${ctx}/selShiftByState?SMState=换班",function (data) {
        $("#formChangeShift [name='introducer']").val(data.msg);
    });
}

//换班表多条件查询
function SearchChangeShift() {
    //判断是否有权限
    //var UseBit = IsJurisd("查询",Jurid);
    var UseBit = "1";
    if (UseBit=="1") {
        //获取查询条件
        var SignUpName = $("#formSelect [name='SignUpName']").val(); // 姓名/证件号/手机号
        var NamePointID = $("#formSelect [name='NamePointID']").val(); // 报名点ID
        var csAudit = $("#formSelect [name='CsAudit']").val(); // 审核状态
        var arrearage =$("#formSelect [name='arrearage']").val(); // 欠费否
        var SMTime = $("#formSelect [name='SMTime']").val(); // 换班时间
        var DepartmentID = $("#formSelect [name='DepartmentID']").val(); // 部门ID
        if (SignUpName == undefined) {
            SignUpName = "";
        }
        if (csAudit == undefined) {
            csAudit = "";
        }
        if (SMTime == undefined) {
            SMTime = "";
        }
        if (NamePointID == undefined || NamePointID=="" || NamePointID==null) {
            NamePointID = 0;
        }
        if (DepartmentID == undefined || DepartmentID=="" || DepartmentID==null) {
            DepartmentID = 0;
        }
        var datebegin = ""; // 开始时间
        var datefinish = ""; // 结束时间
        if (SMTime!="") {
            datebegin = SMTime.substring(0, 10);
            datefinish = SMTime.substring(13);
        }
        //console.log(SignUpName+"--"+NamePointID+"--"+csAudit+"--"+datebegin+"--"+datefinish+"--"+DepartmentID);
        //方法级渲染的重载
        tabChangeShift.reload({
            url: "${ctx}/selManageByPage",
            where: {
                SignUpName: SignUpName,
                NamePointID: NamePointID,
                csAudit: csAudit,
                datebegin: datebegin,
                datefinish: datefinish,
                DepartmentID: DepartmentID,
                arrearage: arrearage,
                SMState:1,
            },
            page: {
                curr: 1 //重新从第一页开始
            }
        });
    } else {
        layer.msg('没有此权限！', {icon: 5});
    }
}

//打开换班管理新增模态框
$("#openChangeShift").click(function(){
    //判断是否有权限
    //var UseBit = IsJurisd("新增",Jurid);
    var UseBit = "1";
    if (UseBit=="1") {
        studentdate = false;//无学生数据
        ordAmountPay = "";//应缴金额
        $("#formChangeShift")[0].reset();//重置表单
        //禁用下拉框
        $("#ShiftClass").empty(); // 班级
        $("#PaymentType").empty(); // 付款类型
        //清空session，避免残留数据
        clearPayDetail();clearClassCost();
        // 启用按钮
        $("#LayuiIcon").attr("onclick","searchStudent()"); // 搜索
        $("#formChangeShift select,.FourField").prop("disabled", false);// 确认
        //设置表单的action
        $("#formChangeShift").prop("action", "${ctx}/insertStudentManage");
        //打开模态框
        $("#modChangeShift").modal({ backdrop: 'static', keyboard: false });
    } else {
        layer.msg('没有此权限！', {icon: 5});
    }
});

//根据证件号查询学员信息
function searchStudent(){
    studentdate = true;
    var IdNumber = $("#formChangeShift [name='identitycard']").val(); // 证件号
    var IdCard = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;

    if (!IdCard.test(IdNumber)) {
        layer.msg("证件号错误！");
        return;
    }
    //回填表单信息
    $.post("${ctx}/selStudentByIdCard",{IdNumber: IdNumber,StuState: "换班",},function (jsonData){
        //console.log(jsonData.studystate);
        if (jsonData != "") {
            // 状态为“毕业、退学、五次不过”的不能进行换班处理
            if (jsonData.studystate=="报名" || jsonData.studystate=="在读") {
                //刷新表格
                tabPayDetail.reload({url: "${ctx}/selPayPage"});

                //回填其他表单数据
                loadDatatoForm("formChangeShift", jsonData);
                $("#formChangeShift [name='smstate']").val("换班"); // 回填状态
                $("#formChangeShift [name='ordclassid']").val(jsonData.classid); // 回填原班制ID
                $("#formChangeShift [name='ordmodelid']").val(jsonData.modelid); // 回填原车型ID

                var userid = getCookie("CookieUserID");//调用遍历cookie的方法
                $("#formChangeShift [name='userid']").val(userid);// 回填用户ID

                BackfillNumber();//回填票号
            } else {
                layer.alert("此学员已" +jsonData.studystate+"不需再换班！");
                //重置表单
                //$("#formChangeShift")[0].reset();
                //清空session，避免残留数据
                //clearClassCost();
                //根据换班、五次不过、退学状态查询票号(回填票号)
                //BackfillNumber();
            }

        } else {
            layer.alert("没有此学员！");
            //重置表单
            $("#formChangeShift")[0].reset();
        }
    });
}

//打开换班管理详情模态框
function openUpdateModel(studentID){
    //判断是否有权限
    //var UseBit = IsJurisd("新增",Jurid);
    var UseBit = 1;
    if (UseBit=="1") {
        //重置表单
        $("#formChangeShift")[0].reset();
        $("#LayuiIcon").removeAttr("onclick"); // 禁用搜索按钮按钮
        $("#formChangeShift select,.FourField").prop("disabled", true); // 禁用确认按钮
        form.render();
        //回填表单信息
        $.post("${ctx}/backfillShift?StudentID="+studentID,function (jsonData){
            //console.log(jsonData);
            //回填其他表单数据
            loadDatatoForm("formChangeShift", jsonData);
            //根据车型ID查询班制下拉框
            layuiSelect("ShiftClass", "${ctx}/SelectModelClass?ModelCar="+jsonData.modelid,jsonData.classid);
            //付款类型下拉框查询
            layuiSelect("PaymentType", "${ctx}/SelectPaymentType");
            //刷新表格
            ordAmountPay = jsonData.needpaymenttotalmoney;//原班级应缴金额
            tabPayDetail.reload({url:"${ctx}/SelectSumMoney"});

            $("#formChangeShift [name='AmountPay']").val(ordAmountPay);

            /*var amount = $("#formChangeShift [name='AmountPay']").val();//前班级应缴金额
            var already = $("#formChangeShift [name='AlreadyPay']").val();//前班级欠费金额

            console.log(amount+"--"+amount);
            if(Number($("#NeedMoney").val()) > 0){
                $("#appmoney").val((Number($("#NeedMoney").val())-Number(amount)+Number(already)).toFixed(2));//修补费金额

            }else {
                $("#appmoney").val("");
            }*/

            $("#paymentdetailDiv").prop("hidden",false);
            //$("#classcostDiv").prop("hidden",false);
            //layui.form.render();//更新from表单
        });
        //打开模态框
        $("#modChangeShift").modal({ backdrop: 'static', keyboard: false });
    } else {
        layer.msg('没有此权限！', {icon: 5});
    }
}


// 审核模态框
function updateAudit(applicationID,applicationStatus){
    //判断是否有权限
    var UseBit = "1";
    if (UseBit=="1") {
        if(applicationStatus == 0){
            //打开模态框
            $("#modAuditing").modal({ backdrop: 'static', keyboard: false });
            $.post("${ctx}/backfillAuditing",{ApplicationID: applicationID},function (jsonData){
                console.log(jsonData);
                //回填表单数据
                loadDatatoForm("formAuditing", jsonData);

                var userid = getCookie("CookieUserID");//调用遍历cookie的方法
                $("#formAuditing [name='userid']").val(userid);// 回填用户ID
            })
        }else {
            layer.msg('此数据已审核，不需重复此操作！');
        }

        /*if (Audit==false || Audit=="false") {
            layer.confirm("确定要审核该条报名受理信息吗？", { icon: 3, title: "提示" }, function () {
                $.post("${ctx}/updStuManageAudit?StuManageID="+StuManageID,function (data) {
                    if (data.state==true) {
                        //刷新表格
                        tabChangeShift.reload();
                    }
                    layer.alert(data.msg);
                });
            });
        } else {
            layer.alert("此数据已审核，不需重复此操作！");
        }*/
    } else {
        layer.msg('没有此权限！', {icon: 5});
    }
}

//layui创建下拉框
function layuiSelect(selectId, url, value) {
    $.ajax({ url: url, dataType: 'json', type: 'post',
        success: function (data) {
            if (selectId.indexOf('#') != 0) {
                selectId = '#' + selectId;
            }
            $(selectId).empty();
            //$(selectId).append(new Option("请选择", 0));
            $.each(data, function (index, item) {
                $(selectId).append(new Option(item.text, item.id));// 下拉菜单里添加元素
            });
            //设置选中值
            if (value != undefined && value != null && value != '') {
                $(selectId).val(value);
            }
            layui.form.render("select");//layui 更新渲染
        }
    })
}

</script>
</body>

</html>
