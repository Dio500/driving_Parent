<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/StudentController" var="student"></c:set>
<c:set value="http://localhost:8070/ExamController" var="ctx"></c:set>
<html>

<head>
    <meta charset="UTF-8">
    <title>交管考试记录</title>
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">
    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">
    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<style>
    #formSelect input{
        height: 30px;
    }
    #formSelect .layui-form-select{
        margin-left: 10px;
        width: 150px;
    }
    #LayuiTab{
        position: relative;
    }
    /*去除button点击后的外轮廓*/
    button:focus{outline:0;}

    #formAppointment .layui-form-select{
        width: 146px;
        height: 40px;
    }
</style>
<body>
<div class="container-fluid">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" id="LayuiTab">
        <div class="pt-2 pl-2" style="font-size: 16px;font-weight: bold;">
            <%--&diamond; &clubs; &hearts; &spades;--%>
            <span>&thetasym;</span>
            交管考试记录
        </div>
        <ul class="layui-tab-title">
            <li class="layui-this" onclick="TwoExamin(false)">待考</li>
            <li onclick="TwoExamin(true)">已考</li>
        </ul>
        <div class="layui-tab-content py-0">
            <div class="row">
                <div class="col-sm-10">
                    <form id="formSelect" class="layui-form" method="post" action="" style="font-size: 14px">
                        <div class="row">
                            <%--姓名--%>
                            <input type="text" class="layui-input col-sm-2 mr-2" style="margin-left: 20px;" name="SignUpName" autocomplete="off" placeholder="姓名/证件号/手机号" />
                            <%--科目--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select lay-filter="subject" name="subject">
                                    <option value="1">科目一</option>
                                    <option value="2">科目二</option>
                                    <option value="3">科目三</option>
                                    <option value="4">科目四</option>
                                </select>
                            </div>
                            <%--考场--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="TestRoomID" lay-filter="TestRoomID" id="TestRoom"></select>
                            </div>
                            <%--车型--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="modelID" lay-filter="modelCar" id="modelcar"></select>
                            </div>
                            <%--班级--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="classID" id="classid" lay-filter="regis"></select>
                            </div>
                            <%--状态--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select lay-filter="examination" name="examination" id="examination">
                                    <option value="1" class="succeed">预约</option>
                                    <option value="3" class="failure">及格</option>
                                    <option value="4" class="failure">不及格</option>
                                </select>
                            </div>
                        </div>
                        <div class="row pt-3" style="padding-left: 10px">
                            <%--教练--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="employeeid" id="employee"></select>
                            </div>
                            <%--报名点--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="NamePointID" id="NamePoint"></select>
                            </div>
                            <%--招生部门--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select name="DepartmentID" id="Department"></select>
                            </div>
                            <%--考试次数--%>
                            <div class="layui-form-select ml-0 mr-3">
                                <select lay-filter="testNumber" name="testnumber" id="testNumber">
                                    <option value="">考试次数</option>
                                    <option value="0" class="succeed">0次</option>
                                    <option value="1" class="succeed">1次</option>
                                    <option value="2" class="succeed">2次</option>
                                    <option value="3" class="succeed">3次</option>
                                    <option value="4" class="failure">4次</option>
                                </select>
                            </div>
                            <%--考试时间--%>
                            <label class="layui-form-label p-1 text-right">考试时间</label>
                            <input type="text" class="layui-input col-sm-3" name="testTime" id="testTime" autocomplete="off" placeholder="开始时间 ~ 结束时间" />
                        </div>
                    </form>
                </div>
                <div class="col-sm-2">
                    <div class="layui-btn-container float-right mt-4">
                        <button type="button" class="layui-btn layui-btn-sm" onclick="SelectBooking()">查 询</button>
                        <%--<button type="button" class="layui-btn layui-btn-sm layui-btn-checked" onclick="Appointmentdetailed()">预约详情</button>--%>
                    </div>
                </div>
            </div>
            <!-- 表格 -->
            <div class="row">
                <div class="col-sm-12">
                    <table id="tbBookingData" lay-filter="tbBookingData"></table>
                </div>
            </div>
        </div>
    </div>
    <!-- 成绩录入模态框 -->
    <div class="modal fade" id="modAppointment">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="width: 690px;margin-left: 0px;">
                <div class="modal-header py-3">
                    <h5 class="modal-title">成绩录入</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body pt-0 frew">
                    <form id="formAppointment" class="layui-form px-2" method="post" action="${ctx}/addTestResult" style="font-size: 14px" onsubmit=" return false;">
                        <input type="hidden" name="studentid"/>
                        <input type="hidden" name="testdetailid"/>
                        <div class="row mt-2">
                            <label class="layui-form-label pr-1 text-center" style="width: 75px">姓名</label>
                            <input type="text" class="layui-input col-sm-2" name="name" autocomplete="off" readonly>

                            <label class="layui-form-label pr-1 text-center" style="width: 75px">身份证</label>
                            <input type="text" class="layui-input" style="width: 180px" name="identitycard" readonly>

                            <label class="layui-form-label pr-1 text-center" style="width: 75px">手机号</label>
                            <input type="text" class="layui-input" style="width: 150px" name="phoneone" autocomplete="off" lay-verify="phone" readonly>
                        </div>
                        <div class="row mt-2">
                            <label class="layui-form-label pr-1 text-center" style="width: 75px">科目</label>
                            <input type="text" class="layui-input" style="width: 112px" name="subjectname" readonly>

                            <label class="layui-form-label pr-1 text-center" style="width: 75px">考场</label>
                            <input type="text" class="layui-input" style="width: 180px" name="testroomname" readonly>

                            <label class="layui-form-label pr-1 text-center" style="width: 75px">时间</label>
                            <input class="layui-input" name="testtime" style="width: 150px" readonly>
                        </div>
                        <div class="row mt-2">
                            <label class="layui-form-label pr-1 text-center" style="width: 75px">成绩</label>
                            <input type="number" class="layui-input" style="width: 112px" name="result" onKeypress="return (/[\d]/.test(String.fromCharCode(event.keyCode)))" oninput="if(value<0)value=0;if(value>100)value=100">

                            <div class="col-sm-8">
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
<script>
    var functionObj = [${FunctionObj}];//获取角色功能权限
    var layer, laydate, layuiTable, form;//layui模块全局变量
    var tbBookingData;//考试表
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
        createSelect("#TestRoom", "${ctx}/SelectTestRoom?subjectID="+Examin);
        //教练下拉框
        createSelect("#employeeName", "${student}/Selectemployee");

        //加载&初始化layui模块
        layui.use(['layer','laydate','element','table','form'], function(){
            layer = layui.layer;
            laydate = layui.laydate;
            layuiTable = layui.table;
            form = layui.form;
            //考试时间
            laydate.render({elem: '#testTime',trigger: 'click',type: 'datetime',range: '~'});
            //考试表
            tbBookingData = layuiTable.render({
                elem: '#tbBookingData',
                //url: '${ctx}/selBookingData',
                cols: [[
                    { field: 'studentid', title: '学员ID', hide: true },
                    { field: 'testdetailid', title: '考试明细ID', hide: true },
                    { type: "numbers", title: "序号", width: 80,  align: "center"},
                    { field: 'name', title: '姓名', width: 90, align: 'center' },
                    { field: 'sex', title: '性别', width: 80, align: 'center', templet: setSex, unresize: true },
                    { field: 'identitycard', title: '身份证', width: 175, align: 'center', unresize: true },
                    { field: 'phoneone', title: '联系电话', width: 120, align: 'center', unresize: true },
                    /*{ field: 'registrationpointname', title: '报名点', width: 90, align: 'center' },*/
                    { field: 'departmentname', title: '驾校',width: 90, align: 'center' },
                    { field: 'modelclass', title: '车型-班制', width: 95, align: 'center' },
                    { field: 'testroomname', title: '考场', width: 90, align: 'center' },
                    { field: 'subjectname', title: '科目', width: 82, align: 'center' },
                    { field: 'subjectresult', title: '成绩', width: 86, align: 'center', templet: achievement },
                    { field: 'testtime', title: '考试时间', width: 160, align: 'center', unresize: true },
                    { field: 'testnumber', title: '考试次数', width: 86, align: 'center', unresize: true },
                    { field: 'employeename', title: '教练', width: 90, align: 'center' },
                    { title: '操作',  width: 98, align: 'center', fixed: 'right', unresize: true ,templet: setStudent},
                ]],
                page: {
                    limit: 5,//每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                text: {
                    none: "没有该科目对应的考试信息"
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

            //科目下拉框监听
            form.on('select(subject)', function (data) {
                Examin = data.value;
                SelectBooking();// 调用考试表多条件查询
            });

            //及格否下拉框
            form.on('select(examination)', function (data) {
                Examin = data.value;
                SelectBooking();// 调用考试表多条件查询
            });

            //监听提交(新增预约)
            form.on('submit(AddAppointment)', function(obj){
                //提交前移除禁用属性，不然后台拿不到值
                $("#subjectid").attr("disabled",false);
                if($("#formAppointment [name='result']").val()!=""){
                    layer.confirm("确定要提交吗？", { icon: 3, title: "提示" }, function (layerIndex) {
                        layer.close(layerIndex);
                        $("#formAppointment").ajaxSubmit(function (data) {
                            if (data.state==true) {
                                $("#modAppointment").modal("hide");
                                SelectBooking();
                            }
                            layer.msg(data.msg);
                        });
                    });
                    return false;//阻止表单跳转。如果需要表单跳转，去掉这段即可。
                }else {
                    layer.msg("请填写分数！")
                }
            });
            SelectBooking();//调用考试表多条件查询方法
        });
    })

    //自定义“性别”列
    function setSex(data){
        return data.sex ? "男" : "女";
    }

    //考试表自定义列
    function setStudent(data) {
        btn = "";
        if(ExaminState == false){
            btn += '<a title="编辑" onclick="StudentUpdate('+data.studentid+','+data.testdetailid+')"><i class="layui-icon">&#xe642;</i></a>';
        }else {
            btn += '<a title="详情" onclick="StudentSelect('+data.studentid+')"><i class="layui-icon">&#xe615;</i></a>';
        }
        return btn;
    }

    //考试表多条件查询
    function SelectBooking(){
        //判断是否有权限
        //var UseBit = IsJurisd("查询",Jurid);
        if ("1"=="1") {
            var datas = new Object();
            datas.SignUpName = $("#formSelect [name='SignUpName']").val(); // 姓名/证件号/手机号
            datas.SubjectID = $("#formSelect [name='subject']").val(); // 科目ID
            datas.TestRoomID = $("#formSelect [name='TestRoom']").val(); // 考场ID
            datas.ModelID = $("#formSelect [name='modelID']").val(); // 车型ID
            datas.ClassID = $("#formSelect [name='classID']").val(); // 班级ID
            datas.Examination = $("#formSelect [name='examination']").val(); // 预约、及格状态
            datas.EmployeeID = $("#employee").val(); // 教练ID
            datas.NamePointID = $("#formSelect [name='NamePointID']").val(); // 报名点ID
            datas.DepartmentID = $("#formSelect [name='DepartmentID']").val(); // 招生部门ID
            datas.TestNumber = $("#testNumber").val(); // 考试次数
            datas.ExaminState = ExaminState; // 待考、已考状态
            var TestTime = $("#testTime").val(); // 考试时间
            datas.TestBegin = ""; // 考试开始时间
            datas.TestFinish = ""; // 考试结束时间
            if (TestTime!="") {
                datas.TestBegin = TestTime.substring(0, 19);
                datas.TestFinish = TestTime.substring(22);
            }
            FZpanduan(datas);//为空判断封装方法
            //重载表格
            tbBookingData.reload({
                url: "${ctx}/selBookingData",
                where: { Date: JSON.stringify(datas) },
                page: { curr: 1 }
            });
        } else {
            layer.msg('没有此权限！', {icon: 5});
        }
    }

    //考试表自定义列编辑
    function StudentUpdate(studentID,testDetailID){
        //console.log(studentID+"-"+testDetailID);
        $("#modAppointment").modal({ backdrop: 'static', keyboard: false });
        $.post("${ctx}/backfillTestDetail",{TestDetailID: testDetailID},function (jsonData){
            //回填表单数据
            loadDatatoForm("formAppointment", jsonData);

            //$("#formAppointment [name='testdetailid']").val(testDetailID);
        })
    }

    //考试表自定义列详情
    function StudentSelect(studentID){
        $("#modAchievement").modal({ backdrop: 'static', keyboard: false });//打开模态框
        tabAchievement.reload({
            url: "${ctx}/selectAchievement",
            where: { studentID: studentID, testStatus: true },
            page: { curr: 1 }
        });
    }

    //详情成绩自定义列
    function achievement(data) {
        var color = 'color: #000000';
        data.subjectid==2 ?((data.subjectresult<80) ?color='color: #f12828' :color) :((data.subjectresult<90) ?color='color: #f12828' :color);
        return data.subjectresult != null ?'<a style="'+ color +'">'+data.subjectresult+'</a>' : "暂无成绩";
    }

    //预约、成绩选项卡
    function TwoExamin(state){
        ExaminState=state;
        if (ExaminState == true || ExaminState == "true") {
            $("#formSelect [name='examination']").val("3");//选择全部
        } else {
            $("#formSelect [name='examination']").val("1");//选择待约考
        }
        form.render("select");//layui下拉框更新渲染
        SelectBooking();// 调用考试表多条件查询
    }
</script>
</body>

</html>
