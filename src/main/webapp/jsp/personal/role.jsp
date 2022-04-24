<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/EmployeeController" var="controller"></c:set>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>角色管理</title>
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">

    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">

    <script src="/assets/plugins/layui/layui.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>

    <script src="/assets/plugins/bootstrap-4.1.3-dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery.form.min.js"></script><%--form表单提交--%>
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

    .hides {
        display: none !important;
    }
</style>
<body>
    <div class="x-nav">
          <span class="layui-breadcrumb">
            <a href="">人事管理</a>
            <a><cite>员工管理</cite></a>
          </span>
    </div>
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5">
                        <div class="layui-inline layui-show-xs-block" style="width: 150px;">
                            <input value="" type="text" id="RoleName" placeholder="角色名称" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="layui-inline layui-show-xs-block" style="float: right; width: 108px;">
                            <button type="button" class="layui-btn layui-btn-sm" style="background: #5FB878" onclick="selectRole()">
                                查询
                            </button>
                            <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" onclick="RoleInser()">
                                新增
                            </button>
                        </div>
                    </form>
                </div>
                <div class="layui-card-body row">
                    <div class="col-12">
                        <table id="tbRole"  lay-filter="tbRole"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- 新增修改角色模态窗体 -->
<div class="modal fade" id="modRole">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="width:340px;margin:0 27%;">
            <form class="layui-form" id="forRole" action="" role="form" method="post">
                <%--模态框头部--%>
                <div class="modal-header">
                    <h5 class="modal-title">角色信息</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <%--模态框内容--%>
                <div class="modal-body pt-0 frew">
                    <div class="layui-tab layui-tab-brief">
                        <div class="layui-tab-content">
                            <div class="layui-tab-item layui-show" style="">
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label">
                                            <span class="x-red">*</span>角色名称</label>
                                        <div class="layui-input-inline">
                                            <input type="text" placeholder="请输入名称" autocomplete="off" class="layui-input" id="name">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label">名称排序</label>
                                        <div class="layui-input-inline">
                                            <input type="text" placeholder="请输入排序" autocomplete="off" class="layui-input" id="roleSort">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--模态框底部按钮--%>
                            <div class="modal-body pt-0 pb-0 frew">
                                <div class="layui-form" style="">
                                    <div class="layui-form-item" style="margin-bottom: 0px">
                                        <div class="layui-input-block layui-layer-btn-c" style="float: right; padding-right: 10px;">
                                            <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" onclick="cancel()">取消</button>
                                            <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-filter="*" id="submitTo">提交</button>
                                        </div>
                                    </div>
                                </div>
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
    var layer, layuiTable, element, layuiForm;//layui模块全局变量
    var tbRole;//角色表
    var Roleid;//角色ID
    var IUbit;//新增 / 修改状态

    $(function(){
        //加载&初始化layui模块
        layui.use(['layer','table','form'], function(){
            layer = layui.layer;
            layuiTable = layui.table;
            layuiForm = layui.form;

            //角色表
            tbRole = layuiTable.render({
                elem: '#tbRole',
                //url: '${controller}/TableRole',
                cols: [[
                    //{ type: 'radio' },
                    { type: 'numbers', title: '序号', width: 79, unresize: true },
                    { field: 'roleid', title: '角色ID', hide: true },
                    { field: 'rolename', title: '角色名称', align: 'center', unresize: true },
                    { field: 'rolesort', title: '排序', align: 'center', unresize: true },
                    { title: '操作', width: 95, align: 'center', fixed: 'right', unresize: true, templet: setRole },
                ]],
                page: {
                    limit: 5,//每页显示的条数
                    limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50],//每页条数的选择项
                },
                text: {
                    none: "没有对应的角色信息"
                },
                data: []
            });

            //监听表格行单击事件
            layuiTable.on('row(tbRole)', function (obj) {
                //标注选中行样式
                obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");
                //选中行，勾选复选框
                //obj.tr.find("div.layui-unselect.layui-form-radio")[0].click();
            });

            selectRole();//角色表条件查询
        });
    })

    //表格按钮
    function setRole(data) {
        var RoleID = data.roleid;
        return '<a title="编辑" onclick="RoleUpdate('+ RoleID +')" style="padding-right: 10px;">'+'<i class="layui-icon">&#xe642;</i>'+'</a>'+
            '<a title="删除" onclick="RoleDelete('+ RoleID +')">'+'<i class="layui-icon">&#xe640;</i>'+'</a>';
    }

    //取消按钮
    function cancel(){
        $("#modRole").modal("hide");//关闭模态框
    }

    //角色表查询
    function selectRole() {
        var rolename = $("#RoleName").val();

        tbRole.reload({
            url: '${controller}/TableRole',
            where: { Rolename: rolename},
            page: { curr: 1 },
        })
    }

    //新增按钮
    function RoleInser(RoleID) {
        $("#modRole").modal('show');
        $("#forRole").resetForm();
        IUbit=true;//新增修改状态
        Roleid=RoleID;
    }

    //修改按钮
    function RoleUpdate(RoleID) {
        $("#modRole").modal('show');
        $("#forRole").resetForm();
        IUbit=false;//新增修改状态
        Roleid=RoleID;
        //回填数据
        $.post("${controller}/backfillRole",{RoleID: RoleID},function (data) {
            $("#name").val(data[0].rolename);
            $("#roleSort").val(data[0].rolesort);
        })
    }

    //提交按钮
    $("#submitTo").click(function () {
        var name = $("#name").val();//名称
        var roleSort = $("#roleSort").val();//排序

        if(name!=""){
            $.post("${controller}/IURole", {roleid: Roleid, rolename: name, rolesort: roleSort, IUbit: IUbit},function (returnJson) {
                if (returnJson.state==true) {
                    layer.msg(returnJson.msg);
                    tbRole.reload();
                    $("#modRole").modal("hide");//关闭模态框
                }
                else {
                    layer.msg(returnJson.msg);
                }
            })
        }else {
            layer.msg("请输入角色名称");
        }
    })

    //删除按钮
    function RoleDelete(RoleID) {
        layer.confirm("你确定要删除该角色吗？", { icon: 3, title: "提示" }, function (layerIndex) {
            layer.close(layerIndex);
            $.post("${controller}/DeleteRole", { RoleID: RoleID }, function (returnJson) {
                if (returnJson.state==true) {
                    layer.msg(returnJson.msg);
                    tbRole.reload();
                }
                else {
                    layer.msg(returnJson.msg);
                }
            });
        });
    }

</script>


</html>
