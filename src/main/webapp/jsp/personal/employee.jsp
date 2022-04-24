<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>--%>

<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="/assets/plugins/login/static" var="Login"></c:set>
<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/EmployeeController" var="controller"></c:set>

<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>员工管理</title>
    <%--<meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />--%>

    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">
    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">
    <%--<script type="text/javascript" src="${Xadmin}/lib/layui/layui.js" charset="utf-8"></script>--%>
    <%--<script type="text/javascript" src="${Xadmin}/js/xadmin.js"></script>--%>

    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>
    <script src="/assets/plugins/layui/layui.js"></script>

    <script type="text/javascript" src="/assets/plugins/jquery.form.min.js"></script><%--form表单提交--%>
    <script type="text/javascript" src="/assets/plugins/js/customfunction.js"></script><%--表单回填--%>
    <script src="/assets/plugins/bootstrap-4.1.3-dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/xm-select-v1.2.2/xm-select.js"></script><%--多选下拉框--%>
    <%--<script type="text/javascript" src="/assets/plugins/whvse-treetable-lay-master/treeTable.js"></script>&lt;%&ndash;树形插件&ndash;%&gt;--%>
</head>
<style>
    .layui-table-view .layui-form-radio>i {
        margin-top: 15px;
    }
    .laytable-cell-1-0-0{
        width: 80px !important;
    }
    .layui-form-label{
        padding: 9px 15px 9px 0px;
    }

    .layui-inline {
        margin-right: 0px !important;
    }

    .layui-form-checkbox[lay-skin=primary] {
        height: 0px !important;
        margin-top: 0px !important;
    }

    .layui-form-item {
        margin-bottom: 5px;
    }

    .hides {
        display: none !important;
    }

    #coachMessage div label{
        width: 85px;
    }

    .layui-form-item .layui-input-inline {
        width: 197px;
    }
</style>
<body>
    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">人事管理</a>
        <a><cite>员工管理</cite></a>
      </span>
    </div>
    <div class="layui-fluid">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-body ">
                        <form class="layui-form layui-col-space5">
                            <div class="layui-inline" style="width: 150px;">
                                <input value="" type="text" id="employeenumber" placeholder="姓名/证件号/手机号" autocomplete="off" class="layui-input" >
                            </div>
                            <%--组织机构--%>
                            <div class="layui-input-inline" style="width: 130px;">
                                <select id="framework">
                                    <%--<option>请选择</option>--%>
                                </select>
                            </div>
                            <%--角色--%>
                            <div class="layui-input-inline" style="width: 130px;">
                                <select class="role" id="selectRole">
                                    <%--<option>请选择</option>--%>
                                </select>
                            </div>
                            <div class="layui-input-inline" style="width: 130px;">
                                <select id="working">
                                    <option value="">在职</option>
                                    <option value="true">是</option>
                                    <option value="false">否</option>
                                </select>
                            </div>

                            <div class="layui-input-inline" style="width: 130px;">
                                <select id="accountBit">
                                    <option value="">开通账号</option>
                                    <option value="true">是</option>
                                    <option value="false">否</option>
                                </select>
                            </div>
                            <div class="layui-input-inline" style="width: 130px;">
                                <select id="employeetype">
                                    <option value="">员工类型</option>
                                    <option value="true">内部员工</option>
                                    <option value="false">外部员工</option>
                                </select>
                            </div>
                            <div class="layui-inline" style="float: right; width: 110px;">
                                <button type="button" class="layui-btn layui-btn-sm" style="background: #5FB878" onclick="selectEmployee()">
                                    查询
                                </button>
                                <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" onclick="addEmployee()">
                                    新增
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="layui-card-body row">
                        <div class="col-12">
                            <table id="tbEmployee" lay-filter="tbEmployee"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 新增修改员工模态窗体 -->
    <div class="modal fade" id="modEmployee">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="width:942px;margin:0 -7%;">
                <form class="layui-form" id="formiuEmployee" action="" role="form" method="post">
                    <%--模态框头部--%>
                    <div class="modal-header">
                        <h5 class="modal-title">员工信息</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">Close</span>
                        </button>
                    </div>
                    <%--模态框内容--%>
                    <div class="modal-body pt-0 frew">
                        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                            <ul class="layui-tab-title">
                                <li id="liEmployee" class="layui-this">员工信息</li>
                                <li id="liAccount" class="hides">账号信息</li> <%-- class="hides"--%>
                                <li id="liCoach" class="hides">教练信息</li>
                            </ul>
                            <div class="layui-tab-content">
                                <%--隐藏域--%>
                                <input type="hidden" name="employeeid"/>
                                <input type="hidden" name="userid"/>
                                <input type="hidden" name="coachid"/>
                                <input type="hidden" name="username"/>
                                <input type="hidden" name="cipher"/>
                                <%--员工信息模态框--%>
                                <div class="layui-tab-item layui-show" style="">
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">
                                                <span class="x-red">*</span>姓名</label>
                                            <div class="layui-input-inline">
                                                <input type="text" placeholder="请输入员工姓名" autocomplete="off" class="layui-input" id="name" name="employeename">
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">
                                                <span class="x-red">*</span>手机号码</label>
                                            <div class="layui-input-inline layui-show-xs-block">
                                                <input type="text" placeholder="请输入手机号码" autocomplete="off" class="layui-input" id="phone" name="telephone" onkeyup="phoneDraw()">
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label"><span class="x-red">*</span>员工类型</label>
                                            <div class="layui-input-inline">
                                                <select id="employeeFrom" name="employeetype">
                                                    <option value="true" >内部员工</option>
                                                    <option value="false">外部员工</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">
                                                <span class="x-red">*</span>身份证号</label>
                                            <div class="layui-input-inline layui-show-xs-block">
                                                <input type="text"  placeholder="请输入身份证号" autocomplete="off" class="layui-input" id="idCard" name="identitycard" onkeyup="idCardDraw()">
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">出生日期</label>
                                            <div class="layui-input-inline layui-show-xs-block">
                                                <input type="date"  placeholder="请选择出生日期" autocomplete="off" class="layui-input" id="birthday" name="birthday" Readonly>
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">性别</label>
                                            <div class="layui-input-block" id="sex">
                                                <input type="radio" name="sex" value="true" title="男" checked>
                                                <input type="radio" name="sex" value="false" title="女">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label"><span class="x-red">*</span>部门</label>
                                            <div class="layui-input-inline" id="department"></div>
                                            <input type="hidden" id="departmentid" name="departmentid"/>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">岗位</label>
                                            <div class="layui-input-inline">
                                                <input type="text"  placeholder="请输入岗位" autocomplete="off" class="layui-input" id="position" name="position">
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">所属校区</label>
                                            <div class="layui-input-inline">
                                                <%--<select id="school" name="drivingid"></select>--%>
                                                <input type="text"  placeholder="请选择部门" autocomplete="off" class="layui-input" id="school" name="drivingid" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">在职状态</label>
                                            <div class="layui-input-block" style="padding-right: 10px;" id="workingbit">
                                                <input type="radio" name="workingbit" value="true" title="在职" checked>
                                                <input type="radio" name="workingbit" value="false" title="离职">
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">入职时间</label>
                                            <div class="layui-input-inline">
                                                <input type="date" class="layui-input"  autocomplete="off" placeholder="请选择入职时间" id="entrytime" name="entrytime">

                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">离职时间</label>
                                            <div class="layui-input-inline">
                                                <input type="date" class="layui-input"  autocomplete="off" placeholder="请选择离职时间" id="departuretime" name="departuretime">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">驾驶证号</label>
                                            <div class="layui-input-inline">
                                                <input type="text" class="layui-input" placeholder="驾驶证号" autocomplete="off" id="drivingnumbwe" name="drivingnumbwe">
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">初领日期</label>
                                            <div class="layui-input-inline">
                                                <input type="date" class="layui-input"  autocomplete="off" placeholder="驾驶证初领日期" id="initialdate" name="initialdate">
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">准驾车型</label>
                                            <div class="layui-input-inline">
                                                <select class="drivingType" name="drivingmodelid"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">员工分组</label>
                                            <div class="layui-input-inline">
                                                <select id="employeeGrouping" name="employeeGrouping"></select>
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">联系地址</label>
                                            <div class="layui-input-inline">
                                                <input type="text" placeholder="请输入联系地址" autocomplete="off" class="layui-input" id="location" name="location">
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">排序</label>
                                            <div class="layui-input-inline">
                                                <input type="text" placeholder="请输入排序" autocomplete="off" class="layui-input" id="sorting" name="sorting">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">劳动合同</label>
                                        <div class="layui-input-inline">
                                            <input type="date" class="layui-input" autocomplete="off" placeholder="劳动合同开始日期" id="start" name="laborstarttime"></div>
                                        <div class="layui-input-inline layui-show-xs-block">
                                            <input type="date" class="layui-input" autocomplete="off" placeholder="劳动合同结束日期" id="end" name="laborendtime">
                                        </div>
                                    </div>
                                </div>
                                <%--账号信息--%>
                                <div class="layui-tab-item">
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">
                                                <span class="x-red">*</span>登录账号</label>
                                            <div class="layui-input-inline">
                                                <input type="number" placeholder="默认为手机号" autocomplete="off" class="layui-input" id="account" name="account"></div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label"><span class="x-red">*</span>角色</label>
                                            <div class="layui-input-inline">
                                                <select class="role" name="roleid" id="role"></select>
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label" style="width: 99px;">
                                                <span class="x-red">*</span>可优惠金额</label>
                                            <div class="layui-input-inline layui-show-xs-block">
                                                <input type="number" placeholder="请输入报名最大可优惠金额" autocomplete="off" class="layui-input" style="width: 200px;" id="MaxDiscount" name="concessional">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--教练信息--%>
                                <div class="layui-tab-item" id="coachMessage">
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label"><span class="x-red">*</span>科目</label>
                                            <div class="layui-input-inline xm-select-demo" id="subject">
                                                <%--<select id="subject" name="subjectid"></select>--%>

                                            </div>
                                            <input type="hidden" id="subjects" name="subjects"/>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label"><span class="x-red">*</span>类型</label>
                                            <div class="layui-input-inline">
                                                <select id="coachtype" name="coachtype">
                                                    <option value="直属">直属</option>
                                                    <option value="挂靠">挂靠</option>
                                                    <option value="其他">其他</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">
                                                <span class="x-red"></span>培训人数</label>
                                            <div class="layui-input-inline">
                                                <input type="number" placeholder="最大培训人数" autocomplete="off" class="layui-input" id="trainpeople" name="trainpeople"></div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">车辆</label>
                                            <div class="layui-input-inline">
                                                <select id="car" name="vehicleid"></select>
                                            </div>
                                        </div>
                                        <div class="layui-input-block layui-inline" style="margin-left: 35px">
                                            <input type="checkbox" title="录用为介绍人时自动分车" lay-skin="primary" lay-filter="" id="splitcarbit" name="splitcarbit"/>
                                        </div>
                                        <div class="layui-input-block layui-inline" style="margin-left: 55px">
                                            <input type="checkbox" title="APP车辆管理（教练可录入车辆费用）" lay-skin="primary" lay-filter="" id="appcarbit" name="appcarbit"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">科二训练场</label>
                                            <div class="layui-input-inline">
                                                <select class="trainingGround" id="subjecttwotrainingid" name="subjecttwotrainingid"></select>
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">科三训练场</label>
                                            <div class="layui-input-inline">
                                                <select class="trainingGround" id="subjectthreetrainingid" name="subjectthreetrainingid"></select>
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">所属训练队</label>
                                            <div class="layui-input-inline">
                                                <select id="trainingTeam" name="trainingTeam"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">
                                                <span class="x-red"></span>资格证号</label>
                                            <div class="layui-input-inline">
                                                <input type="text" placeholder="职业资格证号" autocomplete="off" class="layui-input" id="senioritynumber" name="senioritynumber"></div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label">资格等级</label>
                                            <div class="layui-input-inline">
                                                <select id="senioritygrade" name="senioritygrade">
                                                    <option value="一级">一级</option>
                                                    <option value="二级">二级</option>
                                                    <option value="三级">三级</option>
                                                    <option value="四级">四级</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="layui-inline">
                                            <label class="layui-form-label"><span class="x-red">*</span>准教车型</label>
                                            <div class="layui-input-inline">
                                                <select class="drivingType" name="teachingmodelid" id="teachingmodel"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-form-item layui-form-text">
                                            <label class="layui-form-label">教练介绍</label>
                                            <div class="layui-input-block" style="margin-left: 80px;">
                                                <textarea placeholder="教练简介描述" class="layui-textarea" style="width: 769px" id="introduce" name="introduce"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--模态框底部按钮--%>
                    <div class="modal-body pt-0 frew">
                        <div class="layui-form" style="">
                            <div class="layui-form-item" style="margin-bottom: 0px">
                                <div class="layui-input-block layui-inline" style="margin-left: 25px">
                                    <input type="checkbox" title="账号" lay-skin="primary" lay-filter="inputAccount" id="inputAccount" name="effectivebit"/><%--checked--%>
                                    <input type="checkbox" title="教练" lay-skin="primary" lay-filter="inputCoach" id="inputCoach" name="coachbit"/>
                                </div>
                                <div class="layui-input-block layui-layer-btn-c" style="float: right; padding-right: 10px;">
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" onclick="cancel()">取消</button>
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" style="background: #5FB878">读取身份证</button>
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-filter="*" id="submitTo">提交</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<script>
    var functionObj = [${FunctionObj}];//获取角色功能权限
    var layer, layuiTable, element, layuiForm, laydate, treeTable;//layui模块全局变量
    var tbemployee;//员工表
    var tbdempartment;//部门树形表格
    var EmployeeID;//员工ID
    var subjectXmSelect;//多选下拉框
    //var AUurl;//新增 / 修改路径
    var AccountBit=-1, CoachBit=-1;//账号教练否状态

    $(function(){
        //组织机构下拉框
        createSelect("#framework", "${controller}/SelectFramework");
        //角色下拉框
        createSelect(".role", "${controller}/SelectRole");
        //训练场下拉框
        createSelect(".trainingGround", "${controller}/SelectTraining");
        //车型下拉框
        createSelect(".drivingType", "${controller}/SelectModel");
        //车辆下拉框
        createSelect("#car", "${controller}/SelectCar");

        //加载&初始化layui模块
        layui.use(['layer','table','element','form','laydate','tree'], function(){
            layer = layui.layer;
            layuiTable = layui.table;
            element = layui.element;//选项卡依赖element模块，否则无法进行功能性操作
            layuiForm = layui.form;
            laydate = layui.laydate;
            treeTable = layui.tree;//树形表格

            //执行一个laydate实例
            /*laydate.render({
                elem: '#entrytime' //指定元素
            });*/

            //员工表
            tbemployee = layuiTable.render({
                elem: '#tbEmployee',
                //url: '${controller}/SelectEmployee',
                cols: [[
                    //{ type: 'radio' },
                    { type: 'numbers', title: '序号', width: 79, unresize: true },
                    { field: 'employeeid', title: '员工ID', hide: true },
                    { field: 'employeename', title: '姓名', width: 100, align: 'center', unresize: true },
                    { field: 'sex', title: '性别', width: 79, align: 'center', unresize: true, templet: ZhuangTaiSex },
                    { field: 'identitycard', title: '证件号', width: 175, align: 'center', unresize: true },
                    { field: 'telephone', title: '联系电话', width: 120, align: 'center', unresize: true },
                    { field: 'organizationname', title: '机构', width: 110, align: 'center', unresize: true },
                    { field: 'rolename', title: '角色', width: 105, align: 'center', unresize: true },
                    { field: 'registrationpointname', title: '报名点', align: 'center', unresize: true },
                    { field: 'workingbit', title: '在职', width: 80, align: 'center', unresize: true, templet: setworkingBit},
                    { field: 'coachbit', title: '教练', width: 80, align: 'center', unresize: true, templet: setcoachBit},
                    { field: 'sorting', title: '排序', width: 80, align: 'center', unresize: true },
                    { title: '操作', width: 95, align: 'center', fixed: 'right', unresize: true, templet: setEmployee },
                ]],
                page: {
                    limit: 5,//每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                text: {
                    none: "没有对应的员工信息"
                },
                data: [],
                //toolbar: "#tabEmployeeToolbar"
            });

            //监听表格行单击事件
            layuiTable.on('row(tbEmployee)', function (obj) {
                //标注选中行样式
                obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");
                //选中行，勾选复选框
                //obj.tr.find("div.layui-unselect.layui-form-radio")[0].click();
                //console.log(obj);
            });

            layuiForm.on('checkbox(inputAccount)', function(data){
                //console.log(typeof data.elem.checked); //是否被选中，true或者false
                data.elem.checked == true ? $("#liAccount").removeClass("hides"): $("#liAccount").addClass("hides") && $("#liEmployee").click();
                AccountBit=-AccountBit;
            });


            layuiForm.on('checkbox(inputCoach)', function(data){
                data.elem.checked == true ? $("#liCoach").removeClass("hides"): $("#liCoach").addClass("hides") && $("#liEmployee").click();
                CoachBit=-CoachBit;
            });

            //部门树形下拉框查询
            tbdempartment = xmSelect.render({
                el: '#department',
                toolbar: {show: false},
                radio:true,
                tree: {
                    //是否显示树状结构
                    show: true,
                    //是否严格遵守父子模式
                    strict: false,
                },
                data: [],
                //监听树形下拉框选择
                on: function(data){
                    //change, 此次选择变化的数据,数组
                    var change = data.change;
                    $("#departmentid").val(change[0].value);
                    $.post("${controller}/SelectSchool",{parentID: change[0].pvalue},function (data) {
                        //console.log(data);
                        $("#school").val(data.departmentname);//回填驾校输入框
                    })
                },
            });

            //部门树形下拉框查询
            $.ajax({
                url: '${controller}/SelectDepartment?selectIds=0',
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    //console.log(data);
                    tbdempartment.update({
                        data: data,
                        //autoRow: true,//换行
                    })
                }
            });

            //教练科目多选下拉框
            subjectXmSelect = xmSelect.render({
                el: '#subject',
                language: 'zn',
                data: [],
                on: function(data){
                    console.log(data);
                    var arr = data.arr;
                    var pinjieid="";
                    for (let i = 0; i < arr.length; i++) {
                        pinjieid += arr[i].id+",";
                    }
                    //去掉最后的一个“,”
                    pinjieid = pinjieid.substring(0, pinjieid.length - 1);
                    $("#subjects").val(pinjieid);
                },
            })

            $.ajax({
                type:'get',url:'${controller}/SelectSubjects',
                success:function(data){
                    subjectXmSelect.update({
                        data: data,
                        autoRow: true,
                    })
                }
            })
            selectEmployee();//员工多条件查询
        });

    })

    //用户表性别
    function ZhuangTaiSex(data) {
        var Sex = data.sex;
        return '<a class="" style="">'+(Sex=="1" ? "男" : "女")+'</a>';
    }

    //在职否开关按钮
    function setworkingBit(data) {
        var workingBit = data.workingbit;
        return '<input type="checkbox" lay-skin="switch" '+(workingBit=="1" ?"checked":"")+' disabled>';
    }

    //教练否开关按钮
    function setcoachBit(data) {
        var coachBit = data.coachbit;
        return '<input type="checkbox" lay-skin="switch" '+(coachBit=="1" ? "checked" : "")+' disabled>';
    }

    //表格按钮
    function setEmployee(data) {
        EmployeeID = data.employeeid;
        var btnHtml = "";
        btnHtml += '<a title="编辑" onclick="EmployeeUpdate('+ EmployeeID +')" style="padding-right: 10px;">'+'<i class="layui-icon">&#xe642;</i>'+'</a>'+
            '<a title="删除" onclick="EmployeeDelete('+ EmployeeID +')">'+'<i class="layui-icon">&#xe640;</i>'+'</a>';
        return btnHtml;
    }

    //员工表查询
    function selectEmployee() {
        var objdata = new Object();
        var employeenumber = objdata.val1 = $("#employeenumber").val();
        var framework = objdata.val2 = $("#framework").val();
        var role = objdata.val3 = $("#selectRole").val();
        var working = objdata.val4 = $("#working").val();
        var account = objdata.val5 = $("#accountBit").val();
        var employeetype = objdata.val6 = $("#employeetype").val();
        //layuiForm.render("select")

        FZpanduan(objdata);//判断封装方法
        /*console.log(employeenumber+"--"+framework+"--"+role+"--"+working+"--"+account+"--"+employeetype);*/
        tbemployee.reload({
            url: '${controller}/SelectEmployee',
            where: { Employeenumber: employeenumber, Framework: framework, Role: role,
                Working: working, Account: account, Employeetype: employeetype },
            page: { curr: 1 },
        })
        layuiForm.render();//layui更新全部渲染
    }
    
    //员工新增
    function addEmployee() {
        /*layui.use(['layer'],function () {
            AUurl = "http://localhost:8070/EmployeeController/InsertEmployee";
            //var layer = layui.layer,$=layui.$;area:['960px','605px'],
            layer.open({type:1,anim: 4,title:'员工新增',area:'960px',shadeClose: true,//点击遮罩层关闭
            //btn: '关闭全部',btnAlign: 'c',//按钮居中shade: 0 ,//不显示遮罩
            content: layui.$('#modEmployee')//打开的内容
            });
        })*/
        var indexOf = JurisdictionIndexOf("新增");//调用权限方法封装
        if(indexOf>0){
            $("#modEmployee").modal('show');
            $("#formiuEmployee").resetForm();
            $("#modEmployee").prop("action", "${controller}/InsertEmployee");//新增路径
        }else {
            layer.msg("该用户无该权限！");
        }
    }

    //员工修改,数据回填
    function EmployeeUpdate(EmployeeID) {
        var indexOf = JurisdictionIndexOf("修改");//调用权限方法封装
        if(indexOf>0){
            $("#modEmployee").modal('show');
            $("#formiuEmployee").resetForm();

            $("#modEmployee").prop("action","${controller}/UpdateEmployee");
            //回填数据
            $.post("${controller}/BackfillEmployee",{EmployeeID: EmployeeID},function (data) {
                //console.log(data);
                loadDatatoForm("formiuEmployee",data);//表单数据回填
                //账号否教练否选项卡判断
                $("#liEmployee").click();
                data.effectivebit==true ? $("#liAccount").removeClass("hides") && (AccountBit=1) : $("#liAccount").addClass("hides") && (AccountBit=-1);
                data.coachbit==true ? $("#liCoach").removeClass("hides") && (CoachBit=1) : $("#liCoach").addClass("hides") && (CoachBit=-1);
                //console.log(data[0]);
                //科目多选下拉框
                if(data.subjects!=null){
                    var subjectList = [];
                    var subjects = data.subjects.split(',');
                    for (let i = 0; i < subjects.length; i++) {
                        subjectList.push(subjects[i])
                    }
                    subjectXmSelect.setValue(subjectList);
                }
                //部门树形下拉框
                if(data.departmentid !=null){
                    tbdempartment.setValue([data.departmentid]);
                    $.post("${controller}/SelectSchool",{parentID: data.parentdepartmentID},function (data) {
                        //console.log(data);
                        $("#school").val(data.departmentname);//回填驾校输入框
                    })
                }
                //性别单选按钮
                data.sex==true ? $("#sex input:first-child").prop("checked",true) : $("#sex input:nth-last-child(2)").prop("checked",true);
                //在职状态单选按钮
                data.workingbit==true ? $("#workingbit input:first-child").prop("checked",true) : $("#workingbit input:nth-last-child(2)").prop("checked",true);
                //员工类型
                $("#employeeFrom option").val(data.employeetype).prop('selected',true)

                layuiForm.render();//layui更新全部渲染
            })
        }else {
            layer.msg("该用户无该权限！");
        }
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
            layuiForm.render("radio");
        }
        $("#birthday").val(birthday);
    }

    //手机回填账号
    function phoneDraw() {
        var phone = $("#phone").val();//手机号
        $("#account").val(phone);
    }

    //取消按钮
    function cancel(){
        $("#modEmployee").modal("hide");//关闭模态框
        //layer.closeAll('page');//关闭所有页面层
    }

    //提交按钮
    $("#submitTo").click(function () {
        var name = $("#name").val();//姓名
        var phone = $("#phone").val();//手机
        var idCard = $("#idCard").val();//身份证
        var department = $("#departmentid").val();//部门
        var account = $("#account").val();//账号
        var role = $("#role").val();//角色
        var MaxDiscount = $("#MaxDiscount").val();//可优惠最大金额
        var subjects = $("#subjects").val();//科目
        //var coachtype = $("#coachtype").val();//教练类型
        var teachingmodel = $("#teachingmodel").val();//准教车型

        var accountNews = false,coachNews = false;

        //console.log(name+"--"+phone+"--"+idCard+"--"+department+"--"+account+"--"+role+"--"+MaxDiscount+"--"+subjects+"--"+teachingmodel);
        //姓名信息验证（不能是符号）
        if(name!=""){
            var userXingming = /^[1-9A-Za-z\u4e00-\u9fa5]{1,}$/;
            if (!userXingming.test(name)) {
                layer.msg("姓名信息有误，请不要输入符号");
                return;
            }
        }
        //身份证验证
        if(idCard!=""){
            var ShenFenZheng = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
            if (!ShenFenZheng.test(idCard)) {
                layer.msg("身份证输入有误，请输入正确的身份证号码！");
                return;
            }
        }

        //数据完整验证
        if(strValIsNotNull(name) && strValIsNotNull(phone) && strValIsNotNull(idCard) && (department !=0 && department !=null)){
            //账号否勾选
            if(AccountBit==1){
                if(strValIsNotNull(account) && (role !=0 && role !=null) && strValIsNotNull(MaxDiscount)){
                    accountNews=true;
                }
                else{
                    layer.msg("请将信息填写完整！");
                    return;
                }
            }
            //教练否勾选
            if(CoachBit==1){
                if(strValIsNotNull(subjects) && (teachingmodel !=0 && teachingmodel !=null)){
                    coachNews=true;
                }
                else{
                    layer.msg("请将信息填写完整！");
                    return;
                }
            }
            //账号、教练否勾选数据验证
            if(accountNews==true || coachNews==true || (accountNews==true && coachNews==true) || (AccountBit==-1 && CoachBit==-1)){
                $("#modEmployee").ajaxSubmit(function (returnJson) {
                    //console.log(returnJson);
                    if (returnJson.state==true) {
                        $("#modEmployee").modal("hide");//关闭模态框
                        layer.msg(returnJson.msg); //提示信息
                        tbemployee.reload();//刷新表格
                        subjectXmSelect.setValue([]);//清空多选下拉框
                        tbdempartment.setValue([]);//清空部门树形下拉框

                    } else {
                        layer.alert(returnJson.msg);
                    }
                });
            }
            else {
                layer.msg("请将信息填写完整！");
            }
        }else{
            layer.msg("请将信息填写完整！");
        }
    })
    
    //员工删除
    function EmployeeDelete(EmployeeID) {
        var indexOf = JurisdictionIndexOf("删除");//调用权限方法封装
        if(indexOf>0){
            layer.confirm("你确定要删除该员工吗？", { icon: 3, title: "提示" }, function (layerIndex) {
                layer.close(layerIndex);
                $.post("${controller}/DeleteEmployee", { EmployeeID: EmployeeID }, function (returnJson) {
                    if (returnJson.state==true) {
                        layer.msg(returnJson.msg);
                        tbemployee.reload();
                    }
                    else {
                        layer.msg(returnJson.msg);
                    }
                });
            });
        }else {
            layer.msg("该用户无该权限！");
        }
    }


    //权限方法封装
    function JurisdictionIndexOf(text) {
        var indexOf = 0;
        for (k in functionObj[0]) {
            if(functionObj[0][k].parentModuleName=="员工管理"){
                var typenames = functionObj[0][k].typeNames.split(',');
                var bits = functionObj[0][k].usingBits.split(',');
                for (let i = 0; i < typenames.length; i++) {
                    //有该权限
                    if(text==typenames[i] && bits[i]=="1"){
                        indexOf = 1;
                    }
                }
            }
        }
        return indexOf;
    }
</script>
</html>
