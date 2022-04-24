<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/StudentController" var="ctx"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>优惠审核</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">
    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">
    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style type="text/css">
        body{
            font-size: 14px;
            background: #f1f1f1;
        }
        #formPreferAudit input,#formSelect input{
            height: 30px;
        }
        #formSelect .layui-form-select{
            margin-left: 10px;
            width: 150px;
        }
        .disabls{
            cursor: not-allowed;
            background: #e6e6e6;
        }
        /*去除button点击后的外轮廓*/
        button:focus{outline:0;}
    </style>
</head>

<body>
<nav aria-label="breadcrumb">
    <ol class="breadcrumb m-0">
        <li class="breadcrumb-item">学员管理</li>
        <li class="breadcrumb-item active" aria-current="page">优惠审核</li>
    </ol>
</nav>
<div class="container-fluid">
    <div class="row mt-2">
        <label class="col-sm-11 col-form-label" style="line-height:20px;font-size:22px;color:#000;font-family:'华文中宋'">优惠审核</label>
    </div>
    <!-- 条件查询 -->
    <div class="row mt-2">
        <div class="col-sm-10">
            <form id="formSelect" class="layui-form" method="post" action="" style="font-size: 14px">
                <div class="row">
                    <input type="text" class="layui-input col-sm-2 ml-2" name="SignUpName" autocomplete="off" placeholder="姓名/证件号/手机号" />
                    <select name="Audit" lay-filter="Audit">
                        <option value="0">可审核</option>
                        <option value="1">审核成功</option>
                        <option value="2">审核失败</option>
                        <option value="">全部</option>
                    </select>
                    <select name="NamePointID" class="NamePoint" id="NamePointOne"></select>
                    <select name="DepartmentID" class="Department" id="DepartmentOne"></select>
                    <label class="layui-form-label p-1 text-right">报名时间</label>
                    <input type="text" class="layui-input col-sm-2" name="SignUpTime" id="test" autocomplete="off" placeholder="开始日期 - 结束日期">
                </div>
            </form>
        </div>
        <div class="col-sm-2">
            <div class="layui-btn-container float-right">
                <button type="button" class="layui-btn layui-btn-sm" onclick="SearchPreferAudit()">查&nbsp;&nbsp;&nbsp;询</button>
            </div>
        </div>
    </div>
    <!-- 表格 -->
    <div class="row">
        <div class="col-sm-12">
            <table id="tabPreferAudit" lay-filter="tabPreferAudit"></table>
        </div>
    </div>
    <!-- 优惠明细模态框 -->
    <div class="modal fade" id="modPreferAudit">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="width: 1130px;margin-left: -160px;">
                <div class="modal-header py-3">
                    <h5 class="modal-title">优惠审核</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body pt-0 frew">
                    <form id="formPreferAudit" class="layui-form px-2" method="post" action="" style="font-size: 14px" enctype="multipart/form-data" >
                        <!-- 表格 -->
                        <div class="row mt-2">
                            <div class="col-sm-12">
                                <table id="tabPayDetail" lay-filter="tabPayDetail"></table>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/assets/plugins/layui/layui.js"></script>
<script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/assets/plugins/jquery.form.min.js"></script><%--form表单提交--%>
<script type="text/javascript" src="/assets/plugins/js/customfunction.js"></script><%--表单回填--%>
<script src="/assets/plugins/bootstrap-4.1.3-dist/js/popper.min.js"></script>
<script src="/assets/plugins/bootstrap-4.1.3-dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
    var layer, layuiTable, form;//保存layui模块以便全局使用
    var tabPreferAudit;
    var tabPayDetail;
    var Jurid = [];//记录权限信息
    $(function(){
        //报名点下拉框查询
        createSelect(".NamePoint", "${ctx}/SelectEnroll");
        //车型下拉框查询
        createSelect(".DriveType", "${ctx}/SelectmodelCar");
        //证件类型下拉框查询
        createSelect("PaperType", "${ctx}/SelectCardType");
        //招生来源下拉框查询
        createSelect("Recruit", "${ctx}/Selectregistrations");
        //业务类型下拉框查询
        createSelect("BusinessType", "${ctx}/SelectbusinessType");
        //训练场下拉框查询
        createSelect("TrainGround", "${ctx}/SelectGroundName");
        //部门下拉框查询
        createSelect(".Department", "${ctx}/SelectDepartment");
        //教练下拉框查询
        createSelect("Coach", "${ctx}/Selectemployee");

        //加载&&初始化layui模块
        layui.use(['layer', 'table', 'form','element','laydate'], function () {
            layer = layui.layer;
            layuiTable = layui.table;
            form = layui.form;
            element = layui.element;
            laydate = layui.laydate;

            //日期范围选择
            laydate.render({
                elem: '#test',
                trigger: 'click',
                range: true //或 range: '~' 来自定义分割字符
            });

            form.on('select(Audit)', function(){
                SearchPreferAudit();//调用优惠审核多条件查询
            });

            //优惠表
            tabPreferAudit = layuiTable.render({
                elem: '#tabPreferAudit',
                //url: "${ctx}/selPreferAudit",
                cols: [[//表头
                    { type: 'numbers', title: '序号', width: 80, fixed: 'left', unresize: true },
                    { field: "studentid", title: "学员ID", hide: true },
                    { field: "name", title: "姓名", align: "center", fixed: 'left', width: 100 },
                    { field: "identitycard", title: "证件号", align: "center", width: 175 },
                    { field: "studystate", title: "当前状态", align: "center", width: 115 },
                    { field: "phoneone", title: "电话", align: "center", width: 120 },
                    { field: "modelclass", title: "车型-班制", align: "center" , width: 135 },
                    { field: "classcostmoney", title: "班级原价", align: "center", width: 100 },
                    { field: "needpaymenttotalmoney", title: "应缴", align: "center", width: 100 },
                    { field: "paymenttotalmoney", title: "实缴", align: "center", width: 100 },
                    { field: "discounttotalmoney", title: "优惠", align: "center", width: 100 },
                    { field: "arrearagemoney", title: "欠费", align: "center", width: 100 },
                    { field: "registrationtime", title: "报名时间", align: "center", width: 138 },
                    { field: "departmentname", title: "招生部门", align: "center", width: 100 },
                    { field: "registrationpointname", title: "报名点", align: "center", width: 120 },
                    /*{ field: "audit",title: "审核状态", templet: setAudit, width: 100, align: 'center', fixed: 'right' },*/
                    { title: "操作", templet: setOperate, width: 80, align: 'center', fixed: 'right' }
                ]],
                page: {
                    limit: 10,//指定每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                data: [],
            });

            //优惠明细表
            tabPayDetail = layuiTable.render({
                elem: '#tabPayDetail',
                cols: [[
                    /*{ type: "numbers", title: "序号", width: 80,  align: "center"},*/
                    { field: "paymentdetailid", hide: true },
                    { field: "fundtype", title: "款项", align: "center", width: 95, unresize: true },
                    { field: "paymenttype", title: "收款方式", align: "center", width: 90, unresize: true },
                    { field: "requiredamount", title: "应缴金额", align: "center", width: 90, unresize: true },
                    { field: 'paymentamount', title: '实缴金额',width: 90, align: 'center', unresize: true },
                    { field: 'preferentialamount', title: '优惠金额',width: 90, align: 'center', unresize: true },
                    { field: "arrearsmount", title: "欠费金额", align: "center", width: 90, unresize: true },
                    { field: "preferences", title: "优惠理由", align: "center", width: 100, unresize: true },
                    { field: "paymenttime", title: "缴费时间", align: "center", width: 110, unresize: true },
                    { field: "paymentremarks", title: "备注", align: "center", width: 113,  unresize: true },
                    { title: "审核状态", width: 90, align: 'center', fixed: 'right',unresize: true, templet: preferentialBit },
                    { title: "操作", width: 110, align: 'center', fixed: 'right',unresize: true,templet: setPreferential }
                ]],
                page: {
                    limit: 10,//指定每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                data: [],
            });
            //调用优惠审核多条件查询
            SearchPreferAudit();
        });
    });

    //设置优惠表表操作按钮
    function setOperate(data) {
        return '<button type="button" class="layui-btn layui-btn-xs" onclick="openUpdateModel('+ data.studentid +')">详情</button>';
    }

    //申请表审核状态
    function preferentialBit(data){
        return data.preferentialstatus == 0 ? '<a style="color: #f09445; padding-left: 5px;">未审核</a>' :
              (data.preferentialstatus == 1 ? '<a style="color: #3e76e4; padding-left: 5px;">已通过</a>' :
                  '<a style="color: #ff4747; padding-left: 5px;">未通过</a>');
    }

    //申请明细表审核自定义按钮
    function setPreferential(data){
        var payDetailid = data.paymentdetailid;//缴费明细ID
        var status = data.preferentialstatus;//审核状态
        return '<button type="button" class="layui-btn layui-btn-xs layui-btn-radius layui-btn-normal '+(status!=0 ? "disabls" : "")+'" '+
            'onclick="updateAudit('+ payDetailid +','+ true +')" '+(status!=0 ? "disabled" : "")+'>通过</button>'+
            '<button type="button" class="layui-btn layui-btn-xs layui-btn-radius layui-btn-danger '+(status!=0 ? "disabls" : "")+'" '+
            'onclick="updateAudit('+ payDetailid +','+ false +')" '+(status!=0 ? "disabled" : "")+'>失败</button>';
    }

    //优惠审核多条件查询
    function SearchPreferAudit() {
        //判断是否有权限
        //var UseBit = IsJurisd("查询",Jurid);
        if ("1"=="1") {
            var objdatas = new Object();
            //获取查询条件
            var SignUpName = objdatas.val1 = $("#formSelect [name='SignUpName']").val(); // 姓名/证件号/手机号
            var Audit = objdatas.val2 = $("#formSelect [name='Audit']").val(); // 审核状态
            var NamePointID = objdatas.val3 = $("#formSelect [name='NamePointID']").val(); // 报名点
            var DepartmentID = objdatas.val4 = $("#formSelect [name='DepartmentID']").val(); // 招生部门
            var SignUpTime = objdatas.val4 = $("#formSelect [name='SignUpTime']").val(); // 报名时间
            var DateBegin = ""; // 开始时间
            var DateFinish = ""; // 结束时间
            if (SignUpTime!="") {
                DateBegin = SignUpTime.substring(0, 10);
                DateFinish = SignUpTime.substring(13);
            }
            FZpanduan(objdatas);//为空判断封装方法
            //方法级渲染的重载
            tabPreferAudit.reload({
                url: "${ctx}/selPreferAudit",
                where: {
                    SignUpName: SignUpName,NamePointID: NamePointID,DepartmentID: DepartmentID,
                    Audit: Audit,datebegin: DateBegin,datefinish: DateFinish,
                },
                page: { curr: 1 }
            });
        } else {
            layer.msg('没有此权限！', {icon: 5});
        }
    }

    //打开优惠审核详情模态框
    function openUpdateModel(StudentID){
        //判断是否有权限
        //var UseBit = IsJurisd("查询",Jurid);
        console.log(StudentID);
        if ("1"=="1") {
            tabPayDetail.reload({
                url: "${ctx}/selPayDetail",
                where: {StudentID: StudentID}
            });
            //打开模态框
            $("#modPreferAudit").modal({ backdrop: 'static', keyboard: false });
        } else {
            layer.msg('没有此权限！', {icon: 5});
        }
    }

    //审核
    function updateAudit(payDetailID,audit){
        //判断是否有权限
        //var UseBit = IsJurisd("审核",Jurid);
        if ("1"=="1") {
            var Audit = audit==true ? 1 : 2;
            //console.log(payDetailID+"--"+Audit);
            layer.confirm("确定要审核该条优惠信息吗？", { icon: 3, title: "提示" }, function () {
                $.post("${ctx}/preferentialAudit",{payDetailID: payDetailID,Audit: Audit},function (data){
                    if (data.state==true) {
                        tabPayDetail.reload();
                        SearchPreferAudit();
                    }
                    layer.msg(data.msg);
                });
            });
        } else {
            layer.msg('没有此权限！', {icon: 5});
        }
    }

</script>
</body>
</html>
