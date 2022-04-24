<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/EmployeeController" var="controller"></c:set>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>部门管理</title>
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">

    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">

    <script src="/assets/plugins/layui/layui.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>

    <script src="/assets/plugins/bootstrap-4.1.3-dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery.form.min.js"></script><%--form表单提交--%>
    <%--<script type="text/javascript" src="/assets/plugins/whvse-treetable-lay-master/treeTable.js"></script>&lt;%&ndash;树形插件&ndash;%&gt;--%>
</head>
<style>

</style>
<body>
<div class="layui-card-body row">
    <div class="col-12">
        <table id="demoTreeTb"  lay-filter="demoTreeTb"></table>
    </div>
</div>
<!-- 新增修改部门模态窗体 -->
<div class="modal fade" id="modDepartment">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="width:370px;margin:0 27%;">
            <form class="layui-form" id="forDepartment" action="" role="form" method="post">
                <%--模态框头部--%>
                <div class="modal-header">
                    <h5 class="modal-title">部门信息</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <%--模态框内容--%>
                <div class="modal-body pt-0 frew">
                    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                        <div class="layui-tab-content">
                            <div class="layui-tab-item layui-show" style="">
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label">上级</label>
                                        <div class="layui-input-inline">
                                            <input type="text" autocomplete="off" class="layui-input" id="parentdepart" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label">
                                            <span class="x-red">*</span>名称</label>
                                        <div class="layui-input-inline">
                                            <input type="text" placeholder="请输入名称" autocomplete="off" class="layui-input" id="name">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label">联系人</label>
                                        <div class="layui-input-inline">
                                            <input type="text" placeholder="请输入联系人" autocomplete="off" class="layui-input" id="linkman">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label">电话</label>
                                        <div class="layui-input-inline">
                                            <input type="text" placeholder="请输入电话" autocomplete="off" class="layui-input" id="phone">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label">排序</label>
                                        <div class="layui-input-inline">
                                            <input type="text" placeholder="请输入排序" autocomplete="off" class="layui-input" id="sequence">
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
                            <div class="layui-input-block layui-layer-btn-c" style="float: right; padding-right: 10px;">
                                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" onclick="cancel()">取消</button>
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
    var treeTable;//layui模块全局变量
    var tbdempartment;//部门表
    var Departmentid;//部门ID
    var parentDepartment="";//上级名称
    var IUbit;//新增修改状态

    //$(function () {
        layui.config({
            base: '/assets/plugins/whvse-treetable-lay-master/'
        }).use(['treeTable'], function () {
            //var $ = layui.jquery;
            treeTable = layui.treeTable;

            // 渲染树形表格
            tbdempartment = treeTable.render({
                elem: '#demoTreeTb',
                url: '${controller}/TableDepartment',
                tree: {
                    iconIndex: 0,           // 折叠图标显示在第几列
                    isPidData: true,        // 是否是id、pid形式数据
                    idName: 'departmentid',  // id字段名称
                    pidName: 'parentdepartmentid' // pid字段名称
                },
                cols: [[
                    /*{type: 'numbers', align: 'center', width: 80,title: '序号'},*/
                    {field: 'departmentname', align: 'center', title: '部门名称'},
                    {field: 'linkman', align: 'center',  title: '联系人'},
                    {field: 'departmentphone', align: 'center', title: '电话'},
                    {field: 'sequence', align: 'center', title: '排序'},
                    { title: '操作', align: 'center', templet: setDepartment },
                ]]
            });
            /*treeTable.on('row(demoTreeTb)',function (obj) {
                console.log(obj.data.departmentname);
                parentDepartment = obj.data.departmentname;

            })*/
        });

    //表格按钮
    function setDepartment(data) {
        var DepartmentID = data.departmentid;
        return  '<a title="新增" onclick="DepartmentInser('+ DepartmentID +')" style="padding-right: 10px;">'+'<i class="layui-icon">&#xe654;</i>'+'</a>'+
            '<a title="编辑" onclick="DepartmentUpdate('+ DepartmentID +')" style="padding-right: 10px;">'+'<i class="layui-icon">&#xe642;</i>'+'</a>'+
            '<a title="删除" onclick="DepartmentDelete('+ DepartmentID +')" '+(data.parentdepartmentid==0 ? "hidden" :"")+'>'+'<i class="layui-icon">&#xe640;</i>'+'</a>';
    }

    //取消按钮
    function cancel(){
        $("#modDepartment").modal("hide");//关闭模态框
    }

    //新增按钮
    function DepartmentInser(DepartmentID) {
        $("#modDepartment").modal('show');
        $("#forDepartment").resetForm();
        IUbit=true;//新增修改状态
        Departmentid=DepartmentID;
        //回填上级
        $.post("${controller}/backfillHigher",{DepartmentID: DepartmentID, parentHigher: 0},function (data) {
            //console.log(data[0]);
            $("#parentdepart").val(data[0].departmentname);
        })

    }

    //修改按钮
    function DepartmentUpdate(DepartmentID) {
        $("#modDepartment").modal('show');
        $("#forDepartment").resetForm();
        IUbit=false;//新增修改状态
        Departmentid=DepartmentID;
        //回填上级
        $.post("${controller}/backfillHigher",{DepartmentID: DepartmentID, parentHigher: 1},function (data) {
            //console.log(data);
            data.length>1 ? $("#parentdepart").val(data[1].departmentname) : $("#parentdepart").val("无上级");
            $("#name").val(data[0].departmentname);
            $("#linkman").val(data[0].linkman);
            $("#phone").val(data[0].departmentphone);
            $("#sequence").val(data[0].sequence);
        })
    }

    //提交按钮
    $("#submitTo").click(function () {
        var name = $("#name").val();//名称
        var linkman = $("#linkman").val();//联系人
        var phone = $("#phone").val();//手机
        var sequence = $("#sequence").val();//排序

        if(name!=""){
            $.post("${controller}/IUDepartment", {DepartmentID: Departmentid, Name: name, Linkman: linkman, Phone: phone, Sequence: sequence, IUbit: IUbit},function (returnJson) {
                if (returnJson.state==true) {
                    layer.msg(returnJson.msg);
                    tbdempartment.reload();
                    $("#modDepartment").modal("hide");//关闭模态框
                }
                else {
                    layer.msg(returnJson.msg);
                }
            })
        }else {
            layer.msg("请输入部门名称");
        }
    })

    //删除按钮
    function DepartmentDelete(DepartmentID) {
        layer.confirm("你确定要删除该部门吗？", { icon: 3, title: "提示" }, function (layerIndex) {
            layer.close(layerIndex);
            $.post("${controller}/DeleteDepartment", { DepartmentID: DepartmentID }, function (returnJson) {
                if (returnJson.state==true) {
                    layer.msg(returnJson.msg);
                    tbdempartment.reload();
                }
                else {
                    layer.msg(returnJson.msg);
                }
            });
        });
    }
</script>
</html>
