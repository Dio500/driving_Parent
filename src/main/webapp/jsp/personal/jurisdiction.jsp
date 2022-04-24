<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@ page import="com.gx.pojo.TbJurisdictions" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<c:set value="http://localhost:8070/EmployeeController" var="controller"></c:set>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>权限管理</title>
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">

    <link href="/assets/plugins/bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/assets/plugins/layui/css/layui.css">

    <script src="/assets/plugins/layui/layui.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery-3.2.1.min.js"></script>

    <script src="/assets/plugins/bootstrap-4.1.3-dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/jquery.form.min.js"></script><%--form表单提交--%>
    <script type="text/javascript" src="/assets/plugins/js/customfunction.js"></script><%--表单回填、下拉框、权限封装--%>
    <%--<script type="text/javascript" src="/assets/plugins/whvse-treetable-lay-master/treeTable.js"></script>&lt;%&ndash;树形插件&ndash;%&gt;--%>
</head>
<style>

</style>
<body>
<div class="layui-card-body row">
        <div class="col-6">
            <h4 class="modal-title" style="font-weight: bold;">权限管理</h4>
        </div>
        <div class="col-6">
            <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" style="float: right" onclick="conserve()">保存</button>
        </div>
    <div class="col-3">
        <table id="tabRole"  lay-filter="tabRole"></table>
    </div>
    <div class="col-9">
        <table id="demoTreeTb"  lay-filter="demoTreeTb"></table>
    </div>
</div>
<!-- 新增修改权限模态窗体 -->
<div class="modal fade" id="modJurisdiction">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="width:370px;margin:0 27%;">
            <form class="layui-form" id="forJurisdiction" action="" role="form" method="post">
                <%--模态框头部--%>
                <div class="modal-header">
                    <h5 class="modal-title">权限信息</h5>
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
                                            <input type="text" autocomplete="off" class="layui-input" id="parentmodule" readonly>
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
<%--<jsp:include page="../index.jsp"/>--%>
<script>
    var functionObj = [${FunctionObj}];//获取角色功能权限
    var Jurisdictionids="";//改变的角色权限ID
    var treeTable, layuiTable, form;//layui模块全局变量
    var tbmodule;//模块表
    var roleID=1;//角色ID

    layui.config({
        base: '/assets/plugins/whvse-treetable-lay-master/'
    }).use(['treeTable','table','form'], function () {
        //var $ = layui.jquery;
        treeTable = layui.treeTable;
        layuiTable = layui.table;
        form = layui.form;

        //角色表
        tbRole = layuiTable.render({
            elem: '#tabRole',
            url: '${controller}/SelectTabRole',
            cols: [[
                { field: 'roleid', title: '角色ID', hide: true },
                { field: 'rolename', title: '角色名称', align: 'center', unresize: true },
                { field: 'rolesort', title: '排序', hide: true }
            ]],
            text: {
                none: "没有对应的角色信息"
            },
            done: function(res, curr, count){
                $("#tabRole").next().find('.layui-table-box').find('tr[data-index="0"]').addClass('layui-table-click');
            }
        });

        //监听表格行单击事件
        layuiTable.on('row(tabRole)', function (obj) {
            obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");//标注选中行样式
            roleID=obj.data.roleid;//角色ID
            Jurisdictionids="";
            //重载表格
            tbmodule.reload({
                url: '${controller}/TableModule',
                where: {roleID: obj.data.roleid}
            })
        });

        // 渲染树形表格
        tbmodule = treeTable.render({
            elem: '#demoTreeTb',
            url: '${controller}/TableModule',
            where: {roleID: roleID},
            tree: {
                iconIndex: 1,           // 折叠图标显示在第几列
                isPidData: true,        // 是否是id、pid形式数据
                idName: 'moduleid',  // id字段名称
                pidName: 'parentmoduleid' // pid字段名称
            },
            cols: [[
                {type: 'numbers', align: 'center', width: 80,title: '序号'},
                {field: 'modulename', align: 'left', title: '菜单权限'},
                { title: '按钮权限', align: 'center', templet: setJurisdiction },
            ]]
        });

        //权限复选框监听
        form.on('checkbox(moduleclick)', function(data){
            var jurisdictionid= data.elem.name;
            var numberbit = 0;
            if(Jurisdictionids !=""){
                var splitid = Jurisdictionids.split(",");
                //重复的ID移除，不重复的添加到字符串中
                for (let k = 0; k < splitid.length; k++) {
                    if(jurisdictionid==splitid[k]){
                        Jurisdictionids = Jurisdictionids.replace(jurisdictionid+",","");//截取选择的权限ID,并将它变为空
                    }else {
                        numberbit++;
                    }
                }
                if(numberbit == splitid.length){
                    Jurisdictionids += jurisdictionid+",";
                }
            }else {
                Jurisdictionids += jurisdictionid+",";
            }
            //console.log(Jurisdictionids);
        });
    });

    //表格按钮
    function setJurisdiction(data) {
        var btns = "";
        if(data.parentmoduleid!=0){
            var detailids = data.moduledetailsids.split(',');
            var jurisids = data.jurisdictionsids.split(',');
            var typenames = data.typenames.split(',');
            var bits = data.usingbits.split(',');
            for (let i = 0; i < typenames.length; i++) {
                btns += '<input type="checkbox" title="'+ typenames[i] +'" lay-skin="primary" lay-filter="moduleclick" name="'+jurisids[i]+'" id="'+ detailids[i] +'" value="true" '+(bits[i]=="1" ?"checked":"")+'/>';
            }
            return btns;
        }
    }

    //提交按钮
    function conserve(){
        var indexOf = JurisdictionIndexOf("修改");//调用权限方法封装
        if(indexOf>0){
            //console.log($(this));
            if(roleID != 1){
                $.post("${controller}/updateJurisdiction",{JurisdictionIDs: Jurisdictionids},function (returnJson) {
                    if (returnJson.state==true) {
                        Jurisdictionids="";
                        layer.msg(returnJson.msg);
                        tbmodule.reload();
                        //window.parent.closeAllTab();//调用父jsp的方法
                    }else {
                        layer.msg(returnJson.msg);
                    }
                })
            }else {
                layer.msg("管理员的权限无法修改！");
            }

        }else {
            layer.msg("该用户无该权限！");
        }
    }

    //权限方法封装
    function JurisdictionIndexOf(text) {
        var indexOf = 0;
        for (k in functionObj[0]) {
            if(functionObj[0][k].parentModuleName=="权限管理"){
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
