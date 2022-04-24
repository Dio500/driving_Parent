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
<title>考前流程</title>
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
</style>

</head>
<body>
<nav aria-label="breadcrumb">
    <ol class="breadcrumb m-0">
        <li class="breadcrumb-item">驾校管理系统</li>
        <li class="breadcrumb-item">学员</li>
        <li class="breadcrumb-item active" aria-current="page">考前流程</li>
    </ol>
</nav>
<div class="container-fluid">
	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" id="LayuiTab">
		<ul class="layui-tab-title">
			<li class="layui-this" onclick="TwoExamin(false)">待<span class="Examin">体检</span></li>
			<li onclick="TwoExamin(true)">已<span class="Examin">体检</span></li>
		</ul>
		<div class="layui-tab-content py-0">
			<form id="formDownFrame" class="layui-form" method="post" action="" style="font-size: 14px">
		   		<select lay-filter="DownFrame" name="DownExamin">
		   			<option value="体检">体检</option>
		   			<option value="面签">面签</option>
		   			<option value="受理">受理</option>
		   		</select>
	   		</form>
			<!-- 条件查询 -->
		   	<div class="row">
		   		<div class="col-sm-9">
		   			<form id="formSelect" class="layui-form" method="post" action="" style="font-size: 14px">
				   		<div class="row">
				   			<input type="text" class="layui-input col-sm-2 ml-2" name="SignUpName" autocomplete="off" placeholder="姓名/证件号/手机号" />
				   			<select name="NamePointID" id="NamePoint"></select>
				   			<select name="DepartmentID" id="Department"></select>
							<select name="modelID" lay-filter="modelCar" id="modelcar"></select>
							<select name="classID" id="classid" lay-filter="regis"></select>
							<select lay-filter="Examination" name="examination">
								<option value="true" class="succeed">体检合格</option>
								<option value="false" class="failure">体检不合格</option>
								<option value="">全部</option>
							</select>
				   		</div>
				   		<div class="row pt-2">
				   			<input type="text" class="layui-input col-sm-2 ml-2" name="ExaminTime" id="ExaminTime" autocomplete="off" placeholder="批量设置体检时间" hidden>
					   		<label class="layui-form-label p-1 text-right" id="ExaminHidden" hidden><span class="Examin">体检</span>时间</label>
					   		<input type="text" class="layui-input col-sm-3" name="ProTime" id="ProTime" autocomplete="off" placeholder="开始日期 - 结束日期" />

							<label class="layui-form-label p-1 text-right">报名时间</label>
							<input type="text" class="layui-input col-sm-3" name="SignUpTime" id="SMTime" autocomplete="off" placeholder="开始日期 - 结束日期">
						</div>
			   		</form>
		   		</div>
				<div class="col-sm-3">
					<div class="layui-btn-container float-right mt-4">
						<button type="button" class="layui-btn layui-btn-sm" onclick="SearchExamin()">查&nbsp;&nbsp;&nbsp;询</button>
						<button type="button" class="layui-btn layui-btn-sm layui-btn-normal" onclick="Qualify(true)"><span class="succeed">体检合格</span></button>
						<button type="button" class="layui-btn layui-btn-sm layui-btn-danger" id="healthNObit" onclick="Qualify(false)"><span class="failure">体检不合格</span></button>
					</div>
				</div>
		   	</div>
		   	<%--<span class="text-danger" style="font-size: 14px;">注：<span class="Examin">体检</span>时间默认为当天，如有不同请另行更改</span>--%>
		   	<!-- 表格 -->
		   	<div class="row">
			   	<div class="col-sm-12">
			   		<table id="tabExaminProcess" lay-filter="tabExaminProcess"></table>
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
	var tabExaminProcess;
	var ExaminState = false; // 状态
	var testtime = "healthtime"; // 测试时间
	var testremarks = "healthremarks"; // 测试备注
	var teststate = "healthbit";// 测试状态

	var Examin = "体检";
	var Jurid = [];//记录权限信息
	$(function(){
		//报名点下拉框查询
		createSelect("#NamePoint", "${student}/SelectEnroll");
		//部门下拉框查询
		createSelect("#Department", "${student}/SelectDepartment");
		//车型下拉框
		createSelect("#modelcar", "http://localhost:8070/StudentController/SelectmodelCar");
		//班制下拉框
		createSelect("#classid", "http://localhost:8070/StudentController/SelectClass");

		//加载&&初始化layui模块
		layui.use(['layer', 'table', 'form','element','laydate'], function () {
			layer = layui.layer,
			layuiTable = layui.table;
			form = layui.form;
			element = layui.element;
			laydate = layui.laydate;

			//报名时间
			laydate.render({
				elem: '#SMTime',
				trigger: 'click',
				range: '~' //或 range: '~' 来自定义分割字符
			});
			laydate.render({elem: '#ExaminTime',type: 'date',trigger: 'click'});
			//体检、面签、受理时间
			laydate.render({
				elem: '#ProTime',
				range: true, //或 range: '~' 来自定义分割字符
				type: 'date',
				trigger: 'click',
			});
			//表格时间
			//laydate.render({elem: '.inputDate',type: 'datetime',trigger: 'click'});

			//初始化考前流程
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
			/*layuiTable.on('row(tabExaminProcess)', function (obj) {
				//标注选中行样式
				obj.tr.addClass("layui-table-click").siblings().removeClass("layui-table-click");
				//选中行，勾选复选框
				obj.tr.find("div.layui-unselect.layui-form-checkbox")[0].click();
			});*/

			//event属性自定义单元格点击事件名，以便在 tool 事件中完成对该单元格的业务处理
			layuiTable.on('tool(tabExaminProcess)', function (obj) {
				var ExaminID = obj.data.studentid;
				if (obj.event=="ExaminTime") {
					laydate.render({
						elem: '#ExamintDate'+ExaminID,//防止ID一样
						type: 'date',
						trigger: 'click',//自定义弹出控件的事件 采用click弹出
						show:true,//直接显示
						//设定有限范围内的日期或时间值，不在范围内的将不可选中
						//(如：min:-7,max:7表示日期的有效范围限定在：过去一周到未来一周)
						max:0,//只限今天之前
						done: function (res){
							//更新layui表格数据
							obj.update({
								healthtime: res, interviewtime: res, acceptancetime: res
							});
						}
					});

				}
			});

			//科目下拉框监听
			form.on('select(Examination)',function (data){
				SearchExamin();// 调用考前流程多条件查询
			});

			//考前流程下拉框监听
			form.on('select(DownFrame)', function (data) {
				Examin = data.value;
				$("#formSelect")[0].reset();//重置表单

				// 设置标题
				var succeed = "";
				var failure = "";
				if (Examin=="体检") {
					succeed = "体检合格"; failure = "体检不合格";
					//体检时间、备注、状态
					testtime = "healthtime"; testremarks = "healthremarks"; teststate = "healthbit";
				}
				else{
					if(Examin=="面签"){
						//面签时间、备注、状态
						testtime = "interviewtime"; testremarks = "interviewremarks"; teststate = "interviewbit";
					}else {
						//受理时间、备注、状态
						testtime = "acceptancetime"; testremarks = "acceptanceremarks"; teststate = "acceptancebit";
					}
					succeed = Examin+"成功";
					failure = Examin+"失败";
				}
				SearchExamin();// 调用考前流程多条件查询
				$(".Examin").text(Examin);
				$("#ExaminTime").prop("placeholder", "批量设置"+Examin+"时间");
				$(".succeed").text(succeed);
				$(".failure").text(failure);
			});

			SearchExamin();// 调用考前流程多条件查询
			TwoExamin(false);
		});

	});

	//考前流程多条件查询
	function SearchExamin(){
		//判断是否有权限
		//var UseBit = IsJurisd("查询",Jurid);
		if ("1"=="1") {
			var objdatas = new Object();
			var SignUpName = objdatas.val1 = $("#formSelect [name='SignUpName']").val(); // 姓名/证件号/手机号
			var NamePointID = objdatas.val2 = $("#formSelect [name='NamePointID']").val(); // 报名点ID
			var DepartmentID = objdatas.val3 = $("#formSelect [name='DepartmentID']").val(); // 组织机构ID
			var ModelID = objdatas.val4 = $("#formSelect [name='modelID']").val(); // 车型ID
			var ClassID = objdatas.val5 = $("#formSelect [name='classID']").val(); // 班级ID
			var SignUpTime = objdatas.val6 = $("#formSelect [name='SignUpTime']").val(); // 报名时间
			var Examination = objdatas.val7 = $("#formSelect [name='examination']").val(); // 是否及格
			var ProTime = objdatas.val8 = $("#formSelect [name='ProTime']").val(); // 体检/面签/受理时间
			var DownExamin = objdatas.val9 = $("#formDownFrame [name='DownExamin']").val(); // 获取流程下拉框值
/*			if (SignUpName == undefined) {
				SignUpName = "";
			}
			if (NamePointID == undefined || NamePointID=="" || NamePointID==null) {
				NamePointID = 0;
			}
			if (DepartmentID == undefined || DepartmentID=="" || DepartmentID==null) {
				DepartmentID = 0;
			}
			if (ProTime == undefined) {
				ProTime = "";
			}*/

			var SignBegin = ""; // 报名开始时间
			var SignFinish = ""; // 报名结束时间
			if (SignUpTime!="") {
				SignBegin = SignUpTime.substring(0, 10);
				SignFinish = SignUpTime.substring(13);
			}
			var ProBegin = ""; // 体检/面签/受理开始时间
			var ProFinish = ""; // 体检/面签/受理结束时间
			if (ProTime!="") {
				ProBegin = ProTime.substring(0, 19);
				ProFinish = ProTime.substring(22);
			}
			FZpanduan(objdatas);//为空判断封装方法

			//重载表格
			tabExaminProcess.reload({
				url: "${ctx}/selExaminProcessPage",
				where: {
					SignUpName: SignUpName,NamePointID: NamePointID,DepartmentID: DepartmentID,ModelID: ModelID,ClassID: ClassID,
					signbegin: SignBegin,signfinish: SignFinish,probegin: ProBegin,profinish: ProFinish,
					Examination: Examination,DownExamin: DownExamin,ExaminState: ExaminState
				},
				cols:[[
					{ type: "checkbox", width: 80 },
					/*{ type: "numbers", align: "center", width: 79, title: "序号" },*/
					{ field: "healthid", hide: true },
					{ field: "interviewid", hide: true },
					{ field: "acceptanceid", hide: true },
					{ field: "studentsid", hide: true },
					{ field: "name", title: "姓名", align: "center", width: 90 },
					{ field: "sex", title: "性别", align: "center", width: 80, templet: setSex },
					{ field: "identitycard", title: "证件号", align: "center", width: 175 },
					{ field: "phoneone", title: "电话", align: "center", width: 118 },
					{ field: "studystate", title: "状态", align: "center", width: 90 },
					{ field: "modelclass", title: "车型-班级", align: "center", width: 120 },
					{ field: "registrationpointname", title: "报名点", align: "center", width: 128 },
					{ field: "registrationtime", title: "报名时间", align: "center", width: 110 },
					{ field: "departmentname", title: "招生部门", align: "center", width: 110 },
					{ field: testtime, title: DownExamin+"时间", align: "center" , width: 121, templet: ExaminTime, event:"ExaminTime"},
					{ field: teststate, title: DownExamin+"状态", align: 'center',width: 100, templet: ExamState },
					{ field: testremarks, title: "备注", align: "center" , width: 101, edit: true },
					/*{ title: "操作", width: 110, align: 'center', fixed: 'right',unresize: true, templet: setPreferential }*/
				]],
				page: {
					curr: 1 //重新从第一页开始
				}
			});
		} else {
			layer.msg('没有此权限！', {icon: 5});
		}
	}

	//自定义“性别”列
	function setSex(data){
		return data.sex ? "男" : "女";
	}

	//表时间自定义列
	//var Examid = 0;//表id;
	function ExaminTime(obj){
		var times = Examin == "体检" ? obj.healthtime : (Examin == "面签" ? obj.interviewtime : obj.acceptancetime);
		if (times==null) {
			times = "";
		}
		/*if(Examin == "体检"){
			times = obj.healthtime;
		}else if(Examin == "面签"){
			times = obj.interviewtime;
		}else {
			times = obj.acceptancetime;
		}
		if (times==null) {
			times = "";
		}*/
		var ExamintDate = "ExamintDate"+ obj.studentid;//防止ID一样(ID一致时间插件用不了)
		return '<input type="text" class="layui-input inputDate" autocomplete="off" placeholder="默认当天" id='+ExamintDate+' value="'+times+'" />'
	}

	//体检、面签、受理状态自定义列
	function ExamState(data){
		var status;//审核状态
		if(Examin == "体检"){
			status = data.healthbit;
		}else if(Examin == "面签"){
			status = data.interviewbit;
		}else {
			status = data.acceptancebit;
		}
		return status == null ? '<a style="color: #f09445; padding-left: 5px;">待审核</a>' :
				(status ? '<a style="color: #3e76e4; padding-left: 5px;">已通过</a>' :
						'<a style="color: #ff4747; padding-left: 5px;">未通过</a>');
	}

	//审核自定义按钮
/*	function setPreferential(data){
		var status;//审核状态
		if(Examin == "体检"){
			status = data.healthbit;
		}else if(Examin == "面签"){
			status = data.interviewbit;
		}else {
			status = data.acceptancebit;
		}
		console.log(status);
		return '<button type="button" class="layui-btn layui-btn-xs layui-btn-radius layui-btn-normal '+(status!=null ? "disabls" : "")+'" '+
				'onclick="updateAudit('+ data.studentsid +','+ true +')" '+(status!=null ? "disabled" : "")+'>通过</button>'+
				'<button type="button" class="layui-btn layui-btn-xs layui-btn-radius layui-btn-danger '+(status!=null ? "disabls" : "")+'" '+
				'onclick="updateAudit('+ data.studentsid +','+ false +')" '+(status!=null ? "disabled" : "")+'>失败</button>';
	}*/

	//点击tab选项卡
	function TwoExamin(state){
		ExaminState=state;
		if (ExaminState == true || ExaminState == "true") {
			$("#ExaminHidden").prop("hidden", false);
			$("#ProTime").prop("hidden", false);
			$("#ExaminTime").prop("hidden", true);
			//禁用体检不及格按钮
			$("#healthNObit").prop("disabled",true);
			$("#healthNObit").addClass("disabls");
		} else {
			$("#ExaminHidden").prop("hidden", true);
			$("#ProTime").prop("hidden", true);
			$("#ExaminTime").prop("hidden", false);
            //取消禁用体检不及格按钮
            $("#healthNObit").prop("disabled",false);
            $("#healthNObit").removeClass("disabls");
		}
		//重置表单
		$("#formSelect")[0].reset();
		// 调用考前流程多条件查询
		SearchExamin();
	}

	//修改
	function Qualify(IsQualify) {
		//判断是否有权限
		//var UseBit = IsJurisd("审核",Jurid);
		if ("1"=="1") {
			var checkStatus = layuiTable.checkStatus("tabExaminProcess");
			var DownExamin = $("#formDownFrame [name='DownExamin']").val(); // 获取下拉框值
			var ExaminTime = $("#formSelect [name='ExaminTime']").val(); // 体检/面签/受理时间

			console.log(checkStatus.data);
			if (checkStatus.data.length > 0) {
				$.post("${ctx}/updateExaminProcess",
                { Datas: JSON.stringify(checkStatus.data), DownExamin: DownExamin,
                  ExaminState: ExaminState, ExaminTime: ExaminTime, IsQualify: IsQualify },
                function (data) {
					if (data.state==true) {
						//重置表单
						$("#formSelect")[0].reset();
						// 调用考前流程多条件查询
						SearchExamin();
					}
					layer.alert(data.msg);
				});
			} else {
				layer.alert("请选择数据！");
			}
		} else {
			layer.msg('没有此权限！', {icon: 5});
		}
	}

</script>
</body>
</html>