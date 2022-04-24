<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/StudentController" var="student"></c:set>
<c:set value="http://localhost:8070/ExamController" var="ctx"></c:set>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考试流程</title>
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">
    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">
    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet"/>

    <style type="text/css">
        #formSelect input,#formDownFrame input,.inputDate{
            height: 30px;
        }
        #formSelect .layui-form-select,#formDownFrame .layui-form-select{
            margin-left: 10px;
            width: 150px;
        }
        #LayuiTab{
            position: relative;
        }
        #formDownFrame{
            position:absolute;
            top:5px;
            right:0px;
        }
        .disabls{
            cursor: not-allowed;
            background: #e6e6e6;
        }
        /*去除button点击后的外轮廓*/
        button:focus{outline:0;}

        #formAppointment .layui-form-select{
            width: 146px;
            height: 40px;
        }

    </style>

</head>
<body>
<div class="container-fluid">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" id="LayuiTab">
        <div class="pt-2 pl-2" style="font-size: 16px;font-weight: bold;">
            <%--&diamond; &clubs; &hearts; &spades;--%>
            <span>&thetasym;</span>
            考试流程处理
        </div>
        <ul class="layui-tab-title">
            <li class="layui-this" onclick="TwoExamin(false)">科<span class="Examin">1</span>待合格</li>
            <li onclick="TwoExamin(true)">科<span class="Examin">1</span>已合格</li>
        </ul>
        <div class="layui-tab-content py-0">
            <form id="formDownFrame" class="layui-form" method="post" action="" style="font-size: 14px">
                <select lay-filter="DownFrame" name="DownExamin">
                    <option value="1">科目一</option>
                    <option value="2">科目二</option>
                    <option value="3">科目三</option>
                    <option value="4">科目四</option>
                </select>
            </form>
            <!-- 条件查询 -->
            <div class="row">
                <div class="col-sm-10">
                    <form id="formSelect" class="layui-form" method="post" action="" style="font-size: 14px">
                        <div class="row">
                            <%--姓名--%>
                            <input type="text" class="layui-input col-sm-2 mr-2" style="margin-left: 20px;" name="SignUpName" autocomplete="off" placeholder="姓名/证件号/手机号" />
                            <%--报名点--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="NamePointID" id="NamePoint"></select>
                            </div>
                            <%--招生部门--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="DepartmentID" id="Department"></select>
                            </div>
                            <%--车型--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="modelID" lay-filter="modelCar" id="modelcar"></select>
                            </div>
                            <%--班级--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="classID" id="classid" lay-filter="regis"></select>
                            </div>
                            <select lay-filter="examination" name="examination" id="examination">
                                <option value="" class="succeed">待约考</option>
                                <option value="0" class="failure">预约中</option>
                                <option value="1" class="failure">预约成功</option>
                                <option value="2" class="failure">预约失败</option>
                                <option value="4" class="failure">不及格</option>
                                <option value="all">全部</option>
                            </select>
                        </div>
                        <div class="row pt-3">
                            <label class="layui-form-label p-1 text-right">报名时间</label>
                            <input type="text" class="layui-input col-sm-2" name="signUpTime" id="signUpTime" autocomplete="off" placeholder="开始日期 ~ 结束日期">

                            <label class="layui-form-label p-1 text-right">考试时间</label>
                            <input type="text" class="layui-input col-sm-3" name="testTime" id="testTime" autocomplete="off" placeholder="开始时间 ~ 结束时间" />

                            <label class="layui-form-label p-1 text-right">预约时间</label>
                            <input type="text" class="layui-input col-sm-3" name="bookingTime" id="bookingTime" autocomplete="off" placeholder="开始时间 ~ 结束时间" />
                        </div>
                    </form>
                </div>
                <div class="col-sm-2">
                    <div class="layui-btn-container float-right mt-4">
                        <button type="button" class="layui-btn layui-btn-sm" onclick="SearchExamin()">查 询</button>
                        <button type="button" class="layui-btn layui-btn-sm layui-btn-checked" onclick="Appointmentdetailed()">预约详情</button>
                    </div>
                </div>
            </div>
            <!-- 表格 -->
            <div class="row">
                <div class="col-sm-12">
                    <table id="tabExaminProcess" lay-filter="tabExaminProcess"></table>
                </div>
            </div>
        </div>
    </div>
    <!-- 预约模态框 -->
    <div class="modal fade" id="modAppointment">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="width: 690px;margin-left: 0px;">
                <div class="modal-header py-3">
                    <h5 class="modal-title">考试预约</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body pt-0 frew">
                    <form id="formAppointment" class="layui-form px-2" method="post" action="${ctx}/addAppointment" style="font-size: 14px" onsubmit=" return false;">
                        <input type="hidden" name="studentid"/>
                        <input type="hidden" name="teststate"/>
                        <input type="hidden" name="testdetailid"/>
                        <div class="row mt-2">
                            <label class="layui-form-label pr-1 text-center" style="width: 75px">姓名</label>
                            <input type="text" class="layui-input col-sm-2" name="name" autocomplete="off" readonly>

                            <label class="layui-form-label pr-1 text-center" style="width: 75px">身份证</label>
                            <input type="text" class="layui-input" style="width: 180px" name="identitycard" readonly>

                            <label class="layui-form-label pr-1 text-center" style="width: 75px">手机号</label>
                            <input type="text" class="layui-input" style="width: 150px" name="phoneone" autocomplete="off" lay-verify="phone">
                        </div>
                        <div class="row mt-2">
                            <label class="layui-form-label pr-1 text-center" style="width: 75px"><span style="color:red">* </span>科目</label>
                            <select name="subjectid" id="subjectid" disabled></select>

                            <label class="layui-form-label pr-1 text-center" style="width: 75px"><span style="color:red">* </span>考场</label>
                            <select name="testroomid" id="testroomid" lay-verify="selectType"></select>

                            <label class="layui-form-label pr-1 text-center" style="width: 75px"><span style="color:red">* </span>时间</label>
                            <input class="layui-input" name="testtime" id="AppointmentTime" style="width: 150px" placeholder="预约时间" autocomplete="off" lay-verify="datetime">
                        </div>
                        <div class="row mt-2">
                            <div class="col-sm-12">
                                <div class="layui-btn-container float-right">
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" data-dismiss="modal">取 消</button>
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal FourField" lay-submit lay-filter="AddAppointment">确 定</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 成绩详情模态框 -->
    <div class="modal fade" id="modAchievement">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="width: 1170px;margin-left: -230px;">
                <div class="modal-header py-3">
                    <h5 class="modal-title"><span id="titleDetail">成绩详情</span></h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body pt-0 frew">
                    <form id="formPreferAudit" class="layui-form px-2" method="post" action="" style="font-size: 14px">
                        <!-- 表格 -->
                        <div class="row mt-2">
                            <div class="col-sm-12">
                                <table id="tabAchievement" lay-filter="tabAchievement"></table>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/assets/plugins/layui/layui.js"></script>
<script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/assets/plugins/jquery.form.min.js"></script><%--form表单提交--%>
<script type="text/javascript" src="/assets/plugins/js/customfunction.js"></script><%--表单回填--%>
<script src="/assets/plugins/bootstrap-4.1.3-dist/js/popper.min.js"></script>
<script src="/assets/plugins/bootstrap-4.1.3-dist/js/bootstrap.bundle.min.js"></script>


<script type="text/javascript">
    var functionObj = [${FunctionObj}];//获取角色功能权限
    var layer, layuiTable, form;//保存layui模块以便全局使用
    var tabExaminProcess;//合格、待合格表
    var tabAppointment;//预约详情表
    var tabAchievement;//成绩详情表
    var ExaminState = false; // 状态
    var Examin = 1;
    var Jurid = [];//记录权限信息
    $(function(){
        //报名点下拉框查询
        createSelect("#NamePoint", "${student}/SelectEnroll");
        //部门下拉框查询
        createSelect("#Department", "${student}/SelectDepartment");
        //车型下拉框
        createSelect("#modelcar", "${student}/SelectmodelCar");
        //班制下拉框
        createSelect("#classid", "${student}/SelectClass");
        //科目下拉框查询
        createSelect("#subjectid", "${ctx}/SelectSubject");
        //考场下拉框查询
        createSelect("#testroomid", "${ctx}/SelectTestRoom?subjectID="+Examin);

        //加载&&初始化layui模块   注意：选项卡依赖element模块
        layui.use(['layer', 'table','element','form','laydate'], function () {
            layer = layui.layer;
            layuiTable = layui.table;
            form = layui.form;
            laydate = layui.laydate;

            //报名时间
            laydate.render({
                elem: '#signUpTime',trigger: 'click',range: '~' //或 range: 'true' 来自定义分割字符
            });
            //预约时间
            laydate.render({elem: '#AppointmentTime',min:0,max:30,type: 'datetime',trigger: 'click'});
            //考试时间
            laydate.render({elem: '#testTime',range: '~',type: 'datetime',trigger: 'click'});
            //预约时间
            laydate.render({elem: '#bookingTime',range: '~',type: 'datetime',trigger: 'click'});

            //初始化合格、待合格表
            tabExaminProcess = layuiTable.render({
                elem: '#tabExaminProcess',
                //url: "${ctx}/selExaminProcessPage",
                cols:[],
                page: {
                    limit: 10,//指定每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                data: [],
            });

            //监听表格行单击事件
            layuiTable.on('row(tabExaminProcess)', function (obj) {
                //标注选中行样式
                obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");
                //选中行，勾选复选框
                obj.tr.find("div.layui-unselect.layui-form-radio")[0].click();
            });

            //预约详情表
            tabAppointment = layuiTable.render({
                elem: '#tabAchievement',
                cols: [[
                    { type: "numbers", title: "序号", width: 80,  align: "center"},
                    { field: "name", title: "姓名", align: "center", width: 86, unresize: true },
                    { field: "subjectname", title: "科目", align: "center", width: 90, unresize: true },
                    { field: "testroomname", title: "考场", align: "center", width: 90, unresize: true },
                    { field: "testroomaddress", title: "考场地址", align: "center", width: 345, unresize: true },
                    { field: 'testtime', title: '考试时间',width: 160, align: 'center', unresize: true },
                    { field: 'appointmenttime', title: '预约时间',width: 160, align: 'center', unresize: true },
                    { title: '预约状态',  width: 100, align: 'center',  unresize: true ,templet: setPreferential }
                ]],
                text: {
                    none: "该学员暂无预约记录"
                },
                page: {
                    limit: 10, //指定每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50], //每页条数的选择项
                },
                data: [],
            });

            //成绩详情表
            tabAchievement = layuiTable.render({
                elem: '#tabAchievement',
                cols: [[
                    { type: "numbers", title: "序号", width: 80,  align: "center"},
                    { field: "name", title: "姓名", align: "center", width: 105, unresize: true },
                    { field: "subjectname", title: "科目", align: "center", width: 105, unresize: true },
                    { field: "testroomname", title: "考场", align: "center", width: 136, unresize: true },
                    { field: "testroomaddress", title: "考场地址", align: "center", width: 416, unresize: true },
                    { field: 'subjectresult', title: '考试成绩',width: 100, align: 'center', unresize: true ,templet: achievement},
                    { field: 'testtime', title: '考试时间',width: 170, align: 'center', unresize: true }
                ]],
                text: {
                    none: "该学员暂无考试记录"
                },
                page: {
                    limit: 10, //指定每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50], //每页条数的选择项
                },
                data: [],
            });

            //layui表单自定义验证
            form.verify({
                //下拉框
                selectType: function(value, item){
                    if(value=="" || value==0 || value==null){
                        return '该下拉框必须选择';
                    }
                }
            });

            //科目下拉框监听
            form.on('select(DownFrame)', function (data) {
                Examin = data.value;
                $(".Examin").text(data.value);
                SearchExamin();// 调用考试表多条件查询
            });

            //预约状态下拉框监听
            form.on('select(examination)',function (data){
                SearchExamin();// 调用考试表多条件查询
            });

            //监听提交(新增预约)
            form.on('submit(AddAppointment)', function(obj){
                //提交前移除禁用属性，不然后台拿不到值
                $("#subjectid").attr("disabled",false);
                layer.confirm("确定要预约吗？", { icon: 3, title: "提示" }, function (layerIndex) {
                    layer.close(layerIndex);
                    $("#formAppointment").ajaxSubmit(function (data) {
                        if (data.state==true) {
                            $("#modAppointment").modal("hide");
                            SearchExamin();
                        }
                        layer.msg(data.msg);
                    });
                });
                return false;//阻止表单跳转。如果需要表单跳转，去掉这段即可。
            });
            SearchExamin();// 调用考试表多条件查询
        });
    });

    //考试表多条件查询
    function SearchExamin(){
        //判断是否有权限
        //var UseBit = IsJurisd("查询",Jurid);
        if ("1"=="1") {
            var SignUpName = $("#formSelect [name='SignUpName']").val(); // 姓名/证件号/手机号
            var NamePointID = $("#formSelect [name='NamePointID']").val(); // 报名点ID
            var DepartmentID = $("#formSelect [name='DepartmentID']").val(); // 招生部门ID
            var ModelID = $("#formSelect [name='modelID']").val(); // 车型ID
            var ClassID = $("#formSelect [name='classID']").val(); // 班级ID
            var SignUpTime = $("#formSelect [name='signUpTime']").val(); // 报名时间
            var TestTime = $("#formSelect [name='testTime']").val(); // 考试时间
            var BookingTime = $("#formSelect [name='bookingTime']").val(); // 预约时间
            var DownExamin = $("#formDownFrame [name='DownExamin']").val(); // 获取科目下拉框值
            var examination = $("#formSelect [name='examination']").val(); // 预约状态

            var SignBegin = ""; // 报名开始时间
            var SignFinish = ""; // 报名结束时间
            if (SignUpTime!="") {
                SignBegin = SignUpTime.substring(0, 10);
                SignFinish = SignUpTime.substring(13);
            }
            var TestBegin = ""; // 考试开始时间
            var TestFinish = ""; // 考试结束时间
            if (TestTime!="") {
                TestBegin = TestTime.substring(0, 19);
                TestFinish = TestTime.substring(22);
            }
            var BookingBegin = ""; // 预约开始时间
            var BookingFinish = ""; // 预约结束时间
            if (BookingTime!="") {
                BookingBegin = BookingTime.substring(0, 19);
                BookingFinish = BookingTime.substring(22);
            }
            //重载表格
            tabExaminProcess.reload({
                url: "${ctx}/selectTestDetail",
                where: {
                    SignUpName: SignUpName,NamePointID: NamePointID,DepartmentID: DepartmentID,ModelID: ModelID,ClassID: ClassID,
                    signbegin: SignBegin,signfinish: SignFinish,testbegin: TestBegin,testfinish: TestFinish,bookingbegin: BookingBegin,
                    bookingfinish: BookingFinish,DownExamin: DownExamin,ExaminState: ExaminState,Examination:examination
                },
                cols:[[
                    { type: "radio", width: 80 },
                    /*{ type: "numbers", align: "center", width: 79, title: "序号" },*/
                    { field: "studentsid", hide: true },
                    { field: "subjectid", hide: true },
                    { field: "name", title: "姓名", align: "center", width: 86 },
                    { field: "sex", title: "性别", align: "center", width: 80, templet: setSex },
                    { field: "identitycard", title: "证件号", align: "center", width: 171 },
                    { field: "phoneone", title: "电话", align: "center", width: 120 },
                    { field: "modelclass", title: "车型-班级", align: "center", width: 115 },
                    { field: "registrationpointname", title: "报名点", align: "center", width: 130 },
                    { field: "registrationtime", title: "报名时间", align: "center", width: 105 },
                    { field: "testtime", title: "考试时间", align: "center", width: 165 },
                    { field: "departmentname", title: "招生部门", align: "center", width: 105 },
                    /*{ field: testtime, title: "考试时间", align: "center" , width: 120, templet: ExaminTime, event:"ExaminTime"},*/
                    { field: "teststate", title: "状态", width: 91, align: 'center', unresize: true, templet: setPreferential },
                    { title: '操作', align: 'center',  unresize: true ,templet: appointmentExam }
                ]],
                page: {
                    curr: 1 //重新从第一页开始
                },
            });
        } else {
            layer.msg('没有此权限！', {icon: 5});
        }
    }

    //自定义“性别”列
    function setSex(data){
        return data.sex ? "男" : "女";
    }

    //考试表约考状态
    function setPreferential(data){
        return data.teststate == null ? '<a style="color: #f37514; padding-left: 5px;">待约考</a>' :
            (data.teststate == 0 ? '<a style="color: #23b324; padding-left: 5px;">预约中</a>' :
                (data.teststate == 1 ? '<a style="color: #3e76e4; padding-left: 5px;">预约成功</a>' :
                    (data.teststate == 2 ? '<a style="color: #ff4747; padding-left: 5px;">预约失败</a>' :
                        (data.teststate == 3 ? '<a style="color: #3e76e4; padding-left: 5px;">及格</a>' :
                '<a style="color: #ff4747; padding-left: 5px;">不及格</a>'))));
    }

    //考试表约考按钮
    function appointmentExam(data){
        var btn="";
        var status = data.teststate;
        //已合格显示详情按钮
        if(ExaminState){
            btn='<button type="button" class="layui-btn layui-btn-xs" onclick="TsetAchievement('+ data.studentid +')">成绩详情</button>'
        }
        //待合格、已预约的禁用预约按钮
        else {
            //预约成功
            if(status==1){
                btn='<button type="button" class="layui-btn layui-btn-xs btn-outline-danger" onclick="Appointment('+ data.testdetailid +','+0+')">取消预约</button>'
            }
            //预约中
            else if(status==0){
                btn='<button type="button" class="layui-btn layui-btn-xs btn-outline-danger" onclick="Appointment('+ data.testdetailid +','+0+')">取消预约</button>'+
                    '<button type="button" class="layui-btn layui-btn-xs btn-outline-primary" onclick="Appointment('+ data.testdetailid +','+1+')">成功</button>'+
                    '<button type="button" class="layui-btn layui-btn-xs btn-outline-danger" onclick="Appointment('+ data.testdetailid +','+2+')">失败</button>';
            }
            //预约失败、没预约、不及格
            else {
                if(status==2){
                    btn='<button type="button" class="layui-btn layui-btn-xs btn-outline-success" onclick="TsetAppointment('+ data.studentid +','+Examin+','+ data.testdetailid +','+0+')">预约考试</button>'
                }else {
                    btn='<button type="button" class="layui-btn layui-btn-xs btn-outline-success" onclick="TsetAppointment('+ data.studentid +','+Examin+')">预约考试</button>'
                }
            }
        }
        return btn;
    }

    //取消预约、修改预约
    function Appointment(testdetailID,status){
        var operation = status == 0 ? "取消预约" : (status == 1 ? "修改为预约成功" : "修改为预约失败");
        layer.confirm('你确定要'+ operation +'吗？', { icon: 3, title: "提示" }, function (layerIndex) {
            layer.close(layerIndex);
            $.post("${ctx}/appointment", { testdetailID: testdetailID, status: status }, function (returnJson) {
                if (returnJson.state==true) {
                    layer.msg(returnJson.msg);
                    SearchExamin()
                }
                else {
                    layer.msg(returnJson.msg);
                }
            });
        });
    }

    //预约按钮
    function TsetAppointment(studentID,subjectID,testdetailID,states){
        $("#modAppointment").modal({ backdrop: 'static', keyboard: false });
        $.post("${ctx}/backfillAppointment",{studentID: studentID},function (jsonData){
            //回填表单数据
            loadDatatoForm("formAppointment", jsonData);
            if(states!=null){
                $("#formAppointment [name='teststate']").val(states);
                $("#formAppointment [name='testdetailid']").val(testdetailID);
            }
            layerselect("#subjectid", "${ctx}/SelectSubject",subjectID);
        })
    }

    //预约详情按钮
    function Appointmentdetailed(){
        $("#titleDetail").text("预约详情");//标题
        var checkStatus = layuiTable.checkStatus("tabExaminProcess");
        console.log(checkStatus);
        if(checkStatus.data.length>0){
            $("#modAchievement").modal({ backdrop: 'static', keyboard: false });//打开模态框
            tabAppointment.reload({
                url: "${ctx}/selectAchievement",
                where: { studentID: checkStatus.data[0].studentid, testStatus: false },
                page: { curr: 1 }
            });
        }else {
            layer.msg('请在表格里选择需要查看的学员 ！');
        }
    }

    //成绩详情按钮
    function TsetAchievement(StudentID){
        $("#titleDetail").text("成绩详情");//标题
        $("#modAchievement").modal({ backdrop: 'static', keyboard: false });//打开模态框
        tabAchievement.reload({
            url: "${ctx}/selectAchievement",
            where: { studentID: StudentID, testStatus: true },
            page: { curr: 1 }
        });
    }

    //详情成绩自定义列
    function achievement(data) {
        var color = 'color: #000000';
        if(data.subjectid == 2){
            if(data.subjectresult < 80){
                color = 'color: #f12828';
            }
        }else {
            if(data.subjectresult < 90){
                color = 'color: #f12828';
            }
        }
        return '<a style="'+ color +'">'+data.subjectresult+'</a>';
    }

    //合格、待合格选项卡
    function TwoExamin(state){
        ExaminState=state;
        if (ExaminState == true || ExaminState == "true") {
            $("#formSelect [name='examination']").val("all");//选择全部
        } else {
            $("#formSelect [name='examination']").val("");//选择待约考
        }
        form.render("select");//layui下拉框更新渲染
        SearchExamin();// 调用考试表多条件查询
    }

    function layerselect(selectId, url, value) {
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
            form.render("select");//layer更新渲染
        });
    }

</script>
</body>
</html>