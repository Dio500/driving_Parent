<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>--%>
<c:set value="/assets/plugins/login/static" var="Login"></c:set>
<c:set value="/assets/plugins/X-admin" var="Xadmin"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>员工管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="${Xadmin}/css/font.css">
    <link rel="stylesheet" href="${Xadmin}/css/xadmin.css">
    <script type="text/javascript" src="${Xadmin}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${Xadmin}/js/xadmin.js"></script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">学员管理</a>
        <a>
          <cite>五次不过</cite></a>
      </span>

    <button  style="margin-left: 30px;" class="layui-btn layui-btn-danger" onclick="">刷新</button>
    <button  class="layui-btn layui-btn-danger" onclick="">新增</button>
    <button class="layui-btn layui-btn-danger" onclick="">导出</button>
    <button class="layui-btn layui-btn-danger" onclick="">读取身份证</button>

</div>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5">

                        <div class="layui-input-inline layui-show-xs-block">
                            <select name="contrller">
                                <option>报名点</option>
                                <option>支付宝</option>
                                <option>微信</option>
                                <option>货到付款</option>
                            </select>
                        </div>
                        <div class="layui-input-inline layui-show-xs-block">
                            <select name="contrller">
                                <option>招生部门</option>
                                <option>支付宝</option>
                                <option>微信</option>
                                <option>货到付款</option></select>
                        </div>

                        <div class="layui-input-inline layui-show-xs-block">
                            <select name="contrller">
                                <option>审核状态</option>
                                <option>支付宝</option>
                                <option>微信</option>
                                <option>货到付款</option></select>
                        </div>

                        <div class="layui-inline layui-show-xs-block" style="width: 200px;">

                            <input type="text" name="username" placeholder="姓名/证件号/手机号" autocomplete="off" class="layui-input">
                        </div>

                        <div class="layui-inline layui-show-xs-block" style="margin-top: 6px;width: 530px;">
                            <label style="width: 100px;" class="layui-form-label">五次不过时间：</label>
                            <div class="layui-inline layui-show-xs-block">
                                <input class="layui-input" autocomplete="off" placeholder="开始日" name="start" id="start"></div>
                            <div class="layui-inline layui-show-xs-block">
                                <input class="layui-input" autocomplete="off" placeholder="截止日" name="end" id="end"></div>
                        </div>
                        <div class="layui-inline layui-show-xs-block">

                            <button class="layui-btn" lay-submit="" lay-filter="sreach">
                                <i class="layui-icon">&#xe615;</i>
                            </button>
                        </div>
                    </form>
                </div>

                <div class="layui-card-body ">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" name=""  lay-skin="primary">
                            </th>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>性别</th>
                            <th>手机</th>
                            <th>邮箱</th>
                            <th>地址</th>
                            <th>加入时间</th>
                            <th>状态</th>
                            <th>操作</th></tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <input type="checkbox" name=""  lay-skin="primary">
                            </td>
                            <td>1</td>
                            <td>小明</td>
                            <td>男</td>
                            <td>13000000000</td>
                            <td>admin@mail.com</td>
                            <td>北京市 海淀区</td>
                            <td>2017-01-01 11:11:42</td>
                            <td class="td-status">
                                <span class="layui-btn layui-btn-danger layui-btn-mini">
                                                  已删除
                                              </span>
                            <td class="td-manage">
                                <a title="恢复" onclick="member_del(this,'要删除的id')" href="javascript:;">
                                    <i class="layui-icon">&#xe669;</i>
                                </a>
                                <a title="删除" onclick="member_del(this,'要删除的id')" href="javascript:;">
                                    <i class="layui-icon">&#xe640;</i>
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" name=""  lay-skin="primary">
                            </td>
                            <td>1</td>
                            <td>小明</td>
                            <td>男</td>
                            <td>13000000000</td>
                            <td>admin@mail.com</td>
                            <td>北京市 海淀区</td>
                            <td>2017-01-01 11:11:42</td>
                            <td class="td-status">
                                <span class="layui-btn layui-btn-danger layui-btn-mini">
                                                  已删除
                                              </span>
                            <td class="td-manage">
                                <a title="恢复" onclick="member_del(this,'要删除的id')" href="javascript:;">
                                    <i class="layui-icon">&#xe669;</i>
                                </a>
                                <a title="删除" onclick="member_del(this,'要删除的id')" href="javascript:;">
                                    <i class="layui-icon">&#xe640;</i>
                                </a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="layui-card-body ">
                    <div class="page">
                        <div>
                            <a class="prev" href="">&lt;&lt;</a>
                            <a class="num" href="">1</a>
                            <span class="current">2</span>
                            <a class="num" href="">3</a>
                            <a class="num" href="">489</a>
                            <a class="next" href="">&gt;&gt;</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use(['laydate','form'], function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });
        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });


    /*用户-删除*/
    function member_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            //发异步删除数据
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
        });
    }



    function delAll (argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要恢复吗？'+data,function(index){
            //捉到所有被选中的，发异步进行删除
            layer.msg('恢复成功', {icon: 1});
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }
</script>
<script>var _hmt = _hmt || []; (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</body>

<script>
    layui.use(['laydate','form'], function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });
        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });

</script>
</body>

</html>
