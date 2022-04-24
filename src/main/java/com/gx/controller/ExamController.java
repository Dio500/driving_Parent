package com.gx.controller;

import com.gx.mapper.ExamMapper;
import com.gx.pojo.ExamManage;
import com.gx.pojo.StudentManage;
import com.gx.pojo.TbJurisdictions;
import com.gx.utils.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.BeanUtils;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("ExamController")
@ResponseBody
public class ExamController {

    SelectXLK xlk =new SelectXLK();

    @Resource
    private ExamMapper examMapper;

    @Resource(name="transactionManager")//事务
    private DataSourceTransactionManager transactionManager;
    DefaultTransactionDefinition transDefinition = new DefaultTransactionDefinition();

    //考前流程查询
    @RequestMapping("selExaminProcessPage")
    public Layui selExaminProcessPage(Integer page, Integer limit,String SignUpName,Integer NamePointID,Integer DepartmentID,Integer ModelID,
                                      Integer ClassID,String signbegin,String signfinish,String Examination,String probegin,String profinish,
                                      String DownExamin,Boolean ExaminState) throws ParseException {
        System.out.println(SignUpName+"--"+NamePointID+"--"+DepartmentID+"--"+signbegin+"--"+signfinish+"--"+probegin+"--"+
                profinish+"--"+Examination+"--"+DownExamin+"--"+ExaminState);

        Date SignBegin = null;Date SignFinish = null;
        Date ProBegin = null;Date ProFinish = null;
        Calendar calendar = Calendar.getInstance();
        //String类型转Date类型
        if (!signbegin.isEmpty() && !signfinish.isEmpty()) {
            SignBegin = new SimpleDateFormat( "yyyy-MM-dd").parse(signbegin);
            calendar.setTime(new SimpleDateFormat( "yyyy-MM-dd").parse(signfinish));
            calendar.add(Calendar.DATE,1); //把日期往后增加一天,整数往后推,负数往前移动
            SignFinish=calendar.getTime(); //这个时间就是日期往后推一天的结果
        }
        if (!probegin.isEmpty() && !profinish.isEmpty()) {
            ProBegin = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(probegin);
            calendar.setTime(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(profinish));
            calendar.add(Calendar.DATE,1); //把日期往后增加一天,整数往后推,负数往前移动
            ProFinish=calendar.getTime(); //这个时间就是日期往后推一天的结果
        }
        List<ExamManage> listExam = examMapper.selectexam(SignUpName,NamePointID,DepartmentID,ModelID,ClassID,
                SignBegin,SignFinish,ProBegin,ProFinish,Examination,DownExamin,ExaminState);
        PageService<ExamManage> fam = new PageService<ExamManage>();
        PageBean<ExamManage> pages = fam.findByPage(listExam, page, limit);// 分页
        return Layui.data(pages);
    }

    //体检、面签、受理新增/修改
    @RequestMapping("updateExaminProcess")
    public JsonReturn updateExaminProcess(String Datas,String DownExamin,Boolean ExaminState,String ExaminTime,Boolean IsQualify) throws JSONException{
        JsonReturn jsonReturn = new JsonReturn();
        JSONArray array =  new JSONArray(Datas);
        //System.out.println(DownExamin+"--"+ExaminState+"--"+ExaminTime+"--"+IsQualify);
        try{
            for (int i = 0; i < array.length(); i++) {
                ExamManage exam = new ExamManage();
                JSONObject obj = (JSONObject) array.get(i);

                String examtime = ("体检").equals(DownExamin) ? "healthtime" : (("面签").equals(DownExamin) ? "interviewtime" :  "acceptancetime");
                Date date;
                //自定义时间不为空
                if(!(obj.get(examtime)).equals(null) && !(obj.get(examtime)).equals("")){
                    date = new SimpleDateFormat("yyyy-MM-dd").parse(obj.get(examtime).toString());
                }
                //批量时间不为空
                else if(!(ExaminTime).equals(null) && !(ExaminTime).equals("")){
                    date = new SimpleDateFormat("yyyy-MM-dd").parse(ExaminTime);
                }else {
                    date = new Date();
                }

                if(("体检").equals(DownExamin)){
                    exam.setHealthtime(date);//体检时间
                    exam.setHealthbit(IsQualify);//体检状态
                    exam.setHealthremarks(obj.get("healthremarks").toString());//体检备注
                    //已体检、修改
                    if (ExaminState) {
                        exam.setHealthid((Integer) obj.get("healthid"));//体检ID
                        examMapper.updateHealth(exam);
                    }
                    //待体检、新增
                    else {
                        examMapper.insertHealth(exam);
                        exam.setStudentid((Integer) obj.get("studentid"));//学生ID
                        examMapper.updateStudentExam(exam);
                    }
                }
                else if(("面签").equals(DownExamin)){
                    exam.setInterviewtime(date);//面签时间
                    exam.setInterviewbit(IsQualify);//面签状态
                    exam.setInterviewremarks(obj.get("healthremarks").toString());//面签备注
                    //已面签、修改
                    if (ExaminState) {
                        exam.setInterviewid((Integer) obj.get("interviewid"));//面签ID
                        examMapper.updateInterview(exam);
                    }
                    //待面签、新增
                    else{
                        examMapper.insertInterview(exam);
                        exam.setStudentid((Integer) obj.get("studentid"));//学生ID
                        examMapper.updateStudentExam(exam);
                    }
                }
                else{
                    exam.setAcceptancetime(date);//受理时间
                    exam.setAcceptancebit(IsQualify);//受理状态
                    exam.setAcceptanceremarks(obj.get("healthremarks").toString());//受理备注
                    //已受理、修改
                    if (ExaminState) {
                        exam.setAcceptanceid((Integer) obj.get("acceptanceid"));//受理ID
                        examMapper.updateAcceptance(exam);
                    }
                    //待受理、新增
                    else {
                        examMapper.insertAcceptance(exam);
                        exam.setStudentid((Integer) obj.get("studentid"));//学生ID
                        examMapper.updateStudentExam(exam);
                    }
                }
                jsonReturn.setState(true);
                jsonReturn.setMsg("操作成功");
            }
        }catch (Exception e){
            e.printStackTrace();//显示报详情
            jsonReturn.setMsg("操作失败！");
        }
        return jsonReturn;
    }


    //考试流程预约查询
    @RequestMapping("selectTestDetail")
    public Layui selectTestDetail(Integer page, Integer limit,String SignUpName,Integer NamePointID,Integer DepartmentID,
        Integer ModelID,Integer ClassID,String signbegin,String signfinish,String testbegin,String testfinish,String bookingbegin,
        String bookingfinish,String DownExamin,Boolean ExaminState,String Examination) throws ParseException {
        /*System.out.println(SignUpName+"--"+NamePointID+"--"+DepartmentID+"--"+signbegin+"--"+signfinish+"--"+testbegin+"--"+
                testfinish+"--"+bookingbegin+"--"+bookingfinish+"--"+DownExamin+"--"+ExaminState+"--"+Examination);*/
        List<ExamManage> manageList = new ArrayList<>();

        Date SignBegin = null; Date SignFinish = null;
        Date TestBegin = null; Date TestFinish = null;
        Date BookingBegin = null; Date BookingFinish = null;
        Calendar calendar = Calendar.getInstance();
        //String类型转Date类型,报名时间
        if (!signbegin.isEmpty() && !signfinish.isEmpty()) {
            SignBegin = new SimpleDateFormat( "yyyy-MM-dd").parse(signbegin);//开始时间
            calendar.setTime(new SimpleDateFormat( "yyyy-MM-dd").parse(signfinish));
            calendar.add(Calendar.DATE,1); //把日期往后增加一天,整数往后推,负数往前移动
            SignFinish=calendar.getTime(); //这个时间就是日期往后推一天的结果
        }
        //考试时间
        if (!testbegin.isEmpty() && !testfinish.isEmpty()) {
            TestBegin = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(testbegin);//开始时间
            calendar.setTime(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(testfinish));
            calendar.add(Calendar.DATE,1); //把日期往后增加一天,整数往后推,负数往前移动
            TestFinish=calendar.getTime(); //这个时间就是日期往后推一天的结果
        }
        //预约时间
        if (!bookingbegin.isEmpty() && !bookingfinish.isEmpty()) {
            BookingBegin = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(bookingbegin);//开始时间
            calendar.setTime(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(bookingfinish));
            calendar.add(Calendar.DATE,1); //把日期往后增加一天,整数往后推,负数往前移动
            BookingFinish=calendar.getTime(); //这个时间就是日期往后推一天的结果
        }

        //科目待合格、合格
        List<ExamManage> listExam = examMapper.selectTestDetail(SignUpName,NamePointID,DepartmentID,ModelID,ClassID,
                Integer.parseInt(DownExamin),SignBegin,SignFinish,ExaminState);
        if(listExam != null){
            for (ExamManage manage:listExam) {
                //System.out.println(manage.getStudentid()+"--"+Integer.parseInt(DownExamin)+"--"+Examination);
                //查询该学生有无该科目的预约、考试记录
                ExamManage testRecord = examMapper.selectTestRecord(manage.getStudentid(),Integer.parseInt(DownExamin));

                //System.out.println(manage);
                //无预约、考试记录
                if(testRecord==null){
                    //下拉框选了待约考和全部
                    if("".equals(Examination) || "all".equals(Examination)){
                        //考试时间、预约时间都为空时
                        if(TestBegin==null && TestFinish==null && BookingBegin==null && BookingFinish==null){
                            manageList.add(manage);
                        }
                    }
                }else {
                    //取考试时间最后的一条数据
                    ExamManage exam = examMapper.appointmentTest(manage.getStudentid(),Integer.parseInt(DownExamin),
                            TestBegin,TestFinish,BookingBegin,BookingFinish,Examination);
                    if(exam!=null){
                        //获取源对象中为null的属性名
                        String[] nullPropertyNames = CheckFileSize.getNullPropertyNames(manage);
                        //System.out.println("manage中为null的属性" + Arrays.toString(nullPropertyNames));
                        //copyProperties通过反射将一个对象的值赋值给另外一个对象，第三个参数是一个String类型的数组，需要提供忽略的那些null的属性名
                        BeanUtils.copyProperties(manage, exam, nullPropertyNames);
                        manageList.add(exam);
                    }
                }
            }
        }
        PageService<ExamManage> fam = new PageService<ExamManage>();
        PageBean<ExamManage> pages = fam.findByPage(manageList, page, limit);// 分页
        return Layui.data(pages);
    }

    //考试预约回填
    @RequestMapping("backfillAppointment")
    public ExamManage backfillAppointment(Integer studentID){
        ExamManage examManage = examMapper.backFillAppointment(studentID);
        return examManage;
    }

    //新增考试预约
    @RequestMapping("addAppointment")
    public JsonReturn addAppointment(ExamManage data){
        JsonReturn jsonReturn = new JsonReturn();
        if(data.getTeststate() != null){
            examMapper.removalAppointment(data.getTestdetailid());
        }
        int appointment = examMapper.addAppointment(data);
        if(appointment>0){
            jsonReturn.setState(true);
            jsonReturn.setMsg("预约申请成功");
        }else {
            jsonReturn.setMsg("预约申请失败");
        }
        return jsonReturn;
    }

    //取消预约，修改为预约成功、失败
    @RequestMapping("appointment")
    public JsonReturn appointment(Integer testdetailID,Integer status){
        JsonReturn jsonReturn = new JsonReturn();
        Integer number = 0;
        if(status == 0){
            //取消预约
            int removal = examMapper.removalAppointment(testdetailID);
            number++;
        }else {
            //修改为预约成功、失败
            int update = examMapper.updateAppointment(testdetailID,status);
            number++;
        }
        if(number>0){
            jsonReturn.setState(true);
            jsonReturn.setMsg("操作成功！");
        }else {
            jsonReturn.setMsg("操作失败，请稍后重试！");
        }
        return jsonReturn;
    }

    //科目下拉框
    @RequestMapping("SelectSubject")
    public List<SelectVo> SelectSubject(){
        List<SelectVo> modelCar = examMapper.selectSubject();
        ArrayList<SelectVo> selectList = xlk.selectXLK(modelCar,"请选择科目",1);
        return selectList;
    }

    //考场下拉框
    @RequestMapping("SelectTestRoom")
    public List<SelectVo> SelectTestRoom(Integer subjectID){
        List<SelectVo> selectclass = examMapper.selectTestRoom(subjectID);
        ArrayList<SelectVo> selectList = xlk.selectXLK(selectclass,"请选择考场",1);
        return selectList;
    }

    //学生预约、成绩详情
    @RequestMapping("selectAchievement")
    public Layui selectAchievement(Integer page, Integer limit, Integer studentID, Boolean testStatus){
        System.out.println(studentID);
        List<ExamManage> listAchievement = examMapper.selectAchievement(studentID,testStatus);
        PageService<ExamManage> fam = new PageService<ExamManage>();
        PageBean<ExamManage> pages = fam.findByPage(listAchievement, page, limit);// 分页
        return Layui.data(pages);
    }

    //预约数据
    /*@RequestMapping("selBookingData")
    public Layui selBookingData(Integer page, Integer limit,String SignUpName,Integer SubjectID,Integer TestRoomID,Integer ModelID,
        Integer ClassID,Integer Examination,Integer EmployeeID,Integer NamePointID,Integer DepartmentID,Integer TestNumber,
        String testbegin,String testfinish,Boolean ExaminState) throws ParseException {

        System.out.println("输出："+Examination+"--"+TestNumber+"--"+ExaminState+"--"+SubjectID);
        System.out.println(SubjectID+"--"+TestRoomID+"--"+ModelID+"--"+ClassID+"--"+EmployeeID+"--"+NamePointID+"--"+DepartmentID);

        Date TestBegin = null; Date TestFinish = null;
        Calendar calendar = Calendar.getInstance();
        //String类型转Date类型 考试时间
        if (!testbegin.isEmpty() && !testfinish.isEmpty()) {
            TestBegin = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(testbegin);//开始时间
            calendar.setTime(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(testfinish));
            calendar.add(Calendar.DATE,1); //把日期往后增加一天,整数往后推,负数往前移动
            TestFinish=calendar.getTime(); //这个时间就是日期往后推一天的结果
        }
        List<ExamManage> listdata = new ArrayList<>();
        List<ExamManage> listAchievement = examMapper.selectBooking(SignUpName,SubjectID,TestRoomID,ModelID,
                ClassID,EmployeeID,NamePointID,DepartmentID,TestBegin,TestFinish,ExaminState);

        System.out.println(listAchievement);
        //考试次数筛选
        if(TestNumber != null){
            for (ExamManage examManage : listAchievement) {
                System.out.println(examManage.getTestnumber());
                if(examManage.getTestnumber()==TestNumber){
                    listdata.add(examManage);
                }
            }
        }else {

            listdata=listAchievement;
        }
        PageService<ExamManage> fam = new PageService<ExamManage>();
        PageBean<ExamManage> pages = fam.findByPage(listdata, page, limit);// 分页
        return Layui.data(pages);
    }*/

    //考试信息
    @RequestMapping("selBookingData")
    public Layui selBookingData(Integer page, Integer limit,String Date) throws JSONException, ParseException {
        JSONObject objs =  new JSONObject(Date);
        Map<String, String> map = new HashMap<>();
        Iterator<String> iterator = objs.keys();
        while (iterator.hasNext()) {
            String key = iterator.next();
            String value = objs.getString(key);
            map.put(key, value);
        }
        Date TestBegin = null; Date TestFinish = null;
        Calendar calendar = Calendar.getInstance();
        //String类型转Date类型 考试时间
        if (!"".equals(map.get("TestBegin")) && !"".equals(map.get("TestFinish"))) {
            TestBegin = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(map.get("TestBegin"));//开始时间
            calendar.setTime(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss").parse(map.get("TestFinish")));
            calendar.add(Calendar.DATE,1); //把日期往后增加一天,整数往后推,负数往前移动
            TestFinish=calendar.getTime(); //这个时间就是日期往后推一天的结果
        }
        List<ExamManage> listdata = new ArrayList<>();

        //预约、考试记录
        List<ExamManage> listAchievement = examMapper.selectBooking(map.get("SignUpName"),Integer.parseInt(map.get("SubjectID")),
                Integer.parseInt(map.get("TestRoomID")),Integer.parseInt(map.get("ModelID")),Integer.parseInt(map.get("ClassID")),
                Integer.parseInt(map.get("EmployeeID")),Integer.parseInt(map.get("NamePointID")),Integer.parseInt(map.get("DepartmentID")),
                TestBegin,TestFinish,new Boolean(map.get("ExaminState")),Integer.parseInt(map.get("Examination")));

        //考试次数筛选
        if(!"".equals(map.get("TestNumber"))){
            for (ExamManage examManage : listAchievement) {
                System.out.println(examManage.getTestnumber());
                if(examManage.getTestnumber()==Integer.parseInt(map.get("TestNumber"))){
                    listdata.add(examManage);
                }
            }
        }else {
            listdata=listAchievement;
        }
        PageService<ExamManage> fam = new PageService<ExamManage>();
        PageBean<ExamManage> pages = fam.findByPage(listdata, page, limit);// 分页
        return Layui.data(pages);
    }

    //考试预约回填
    @RequestMapping("backfillTestDetail")
    public ExamManage backfillTestDetail(Integer TestDetailID){
        ExamManage examManage = examMapper.backFillTestDetail(TestDetailID);
        return examManage;
    }


    @ResponseBody
    @RequestMapping("addTestResult")
    public JsonReturn addTestResult(ExamManage date){
        JsonReturn jsonReturn = new JsonReturn();
        Integer result = date.getSubjectname() == "科目二"? 80 : 90;
        //设置及格状态
        if(date.getResult() >= result){
            date.setTeststate(3);
        }else {
            date.setTeststate(4);
        }
        //System.out.println(date.getTestdetailid()+"--"+date.getResult()+"--"+date.getSubjectname());
        int dates = examMapper.updateTestResult(date.getTestdetailid(),date.getResult(),date.getTeststate());
        if(dates>0){
            jsonReturn.setState(true); jsonReturn.setMsg("修改成功");
        }else {
            jsonReturn.setMsg("修改失败");
        }
        return jsonReturn;
    }
}
