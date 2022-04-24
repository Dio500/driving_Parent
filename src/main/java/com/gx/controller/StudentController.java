package com.gx.controller;


import ch.qos.logback.core.util.FileUtil;
import com.gx.mapper.ExamMapper;
import com.gx.mapper.StudentMapper;

import com.gx.pojo.*;
import com.gx.utils.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController
@RequestMapping("StudentController")
@ResponseBody
public class StudentController {

    SelectXLK  xlk =new SelectXLK();

    @Resource
    private StudentMapper studentMapper;
    @Resource
    private ExamMapper examMapper;

    @Resource(name="transactionManager")//事务
    private DataSourceTransactionManager transactionManager;
    DefaultTransactionDefinition transDefinition = new DefaultTransactionDefinition();

    @RequestMapping("SelectEnroll")
    public List<SelectVo> SelectEnroll(){
        List<SelectVo> Enroll = studentMapper.selectEnroll();
        ArrayList<SelectVo> selectList = xlk.selectXLK(Enroll,"请选择报名点",0);
        return selectList;
    }

    @RequestMapping("SelectDepartment")
    public List<SelectVo> SelectDepartment(){
        List<SelectVo> Department = studentMapper.selectDepartment();
        ArrayList<SelectVo> selectList = xlk.selectXLK(Department,"请选择招生部门",0);
        return selectList;
    }

    @RequestMapping("Selectregistrations")
    public List<SelectVo> Selectregistrations(){
        List<SelectVo> registrations = studentMapper.selectregistrations();
        ArrayList<SelectVo> selectList = xlk.selectXLK(registrations,"请选择招生来源",1);
        return selectList;
    }

    @RequestMapping("SelectmodelCar")
    public List<SelectVo> SelectmodelCar(){
        List<SelectVo> modelCar = studentMapper.selectmodelCar();
        ArrayList<SelectVo> selectList = xlk.selectXLK(modelCar,"车型",1);
        return selectList;
    }

    @RequestMapping("SelectClass")
    public List<SelectVo> SelectClass(){
        List<SelectVo> selectclass = studentMapper.selectClass();
        ArrayList<SelectVo> selectList = xlk.selectXLK(selectclass,"班制",1);
        return selectList;
    }

    @RequestMapping("SelectModelClass")
    public List<SelectVo> SelectModelClass(Integer ModelCar){
        List<SelectVo> arraylist = new ArrayList<>();
        List<SelectVo> listClass = studentMapper.selectClass();
        //ArrayList<StudentMapper> selectList = xlk.selectXLK(employee,"班制",1);
        for (SelectVo list :listClass) {
            String[] drivingmodels = list.getName().split(",");//分割车型ID
            for (String item : drivingmodels) {
                if(Integer.parseInt(item) == ModelCar){
                    arraylist.add(list);
                }
            }
        }
        arraylist = xlk.selectXLK(arraylist,"班制",1);
        return arraylist;
    }

    @RequestMapping("SelectCardType")
    public List<SelectVo> SelectCardType(){
        List<SelectVo> cardType = studentMapper.selectCardType();
        ArrayList<SelectVo> selectList = xlk.selectXLK(cardType,"请选择证件类型",1);
        return selectList;
    }

    @RequestMapping("SelectbusinessType")
    public List<SelectVo> SelectbusinessType(){
        List<SelectVo> businessType = studentMapper.selectbusinessType();
        ArrayList<SelectVo> selectList = xlk.selectXLK(businessType,"请选择业务类型",1);
        return selectList;
    }

    @RequestMapping("SelectGroundName")
    public List<SelectVo> SelectGroundName(){
        List<SelectVo> GroundName = studentMapper.selectGroundName();
        ArrayList<SelectVo> selectList = xlk.selectXLK(GroundName,"请选择训练场",1);
        return selectList;
    }

    @RequestMapping("Selectemployee")
    public List<SelectVo> Selectemployee(){
        List<SelectVo> employee = studentMapper.selectemployee();
        ArrayList<SelectVo> selectList = xlk.selectXLK(employee,"请选择教练",1);
        return selectList;
    }

    //付款类型下拉框
    @RequestMapping("SelectPaymentType")
    public List<SelectVo> SelectPaymentType(){
        List<SelectVo> paymentType = studentMapper.selectPaymentType();
        ArrayList<SelectVo> selectList = xlk.selectXLK(paymentType,"",0);
        return selectList;
    }

/*    @ResponseBody
    @RequestMapping("SelectPayMoney")
    public List<SelectVo> SelectpayMoney(){
        List<SelectVo> Enroll = studentMapper.selectpayMoney();
        ArrayList<SelectVo> selectList = xlk.selectXLK(Enroll,"缴费类型",0);
        return selectList;
    }*/

    //编号
    @RequestMapping("SelectTicket")
    public List SelectTicket(){
        List<Integer> lists = new ArrayList<>();
        TbPaymoney ticket = studentMapper.selectTicket();//缴费表最后一条数据ID
        TbStudent number = studentMapper.selectNumbers();//学生表最后一条数据ID
        //判断数据为空
        if(ticket==null){ ticket.setPamoneyid(0);}
        if(number==null){ number.setStudentid(0);}
        lists.add(0,ticket.getPamoneyid()+1);
        lists.add(1,number.getStudentid()+1);
        return lists;
    }

    //学员查询
    @RequestMapping("SelectStudent")
    public Layui SelectStudent(Integer page, Integer limit, Integer RegistrationPoint, Integer Class, Integer Department,
            String NameCardPhone, String ReferralName, Boolean Gender, Integer AgeStart,Integer AgeEnd,Integer Model){
        //学员查询
        List<StudentManage> liststudent = studentMapper.selectStudent(RegistrationPoint,Class,Model,Department,NameCardPhone,ReferralName,Gender,AgeStart,AgeEnd);//学员查询
        // 分页
        PageService<StudentManage> fam = new PageService<StudentManage>();
        PageBean<StudentManage> pages = fam.findByPage(liststudent, page, limit);
        //System.out.println(pages);
        return Layui.data(pages);
    }

/*    //缴费查询
    @RequestMapping("SelectPay")
    public Layui SelectPay(Integer page, Integer limit){
        List<TbPaymentdetail> listemployee = studentMapper.selectPay();// 缴费查询
        PageService<TbPaymentdetail> fam = new PageService<TbPaymentdetail>();
        PageBean<TbPaymentdetail> pages = fam.findByPage(listemployee, page, limit);// 分页
        //System.out.println(pages);
        return Layui.data(pages);
    }*/

    //班级费用明细
    @RequestMapping("selectClassCost")
    public void insertSumMoney(HttpServletRequest request, Integer classID){
        List<StudentManage> classcost = studentMapper.selectclassCost(classID);//班级费用明细

        //Integer costid=0;
        for (StudentManage StudentManages:classcost) {
            //costid++;
            //StudentManages.setSessioncostid(costid);//session唯一标识符
            StudentManages.setRequiredamount((StudentManages.getClasscostmoney()));//应缴金额默认值
            StudentManages.setPaymentamount((StudentManages.getClasscostmoney()));//实缴金额默认值
            StudentManages.setPreferentialamount(new BigDecimal(0));//优惠金额默认值
            StudentManages.setArrearsmount(new BigDecimal(0));//欠费默认值
            StudentManages.setEntrytype(StudentManages.getFundPurposeBit());//入账类型
            //付款类型默认值
            StudentManages.setPaymenttypeid(1);
            StudentManages.setPaymenttype("微信支付");
        }
        request.getSession().setAttribute("SumMoneySession",classcost);//保存到session
    }

    //刷新Session表格
    @RequestMapping("SelectSumMoney")
    public Layui SelectSumMoney(HttpServletRequest request){
        //获取Session的数据
        List<StudentManage> sessionList = (List<StudentManage>)request.getSession().getAttribute("SumMoneySession");
        PageBean<StudentManage> pages = new PageBean<StudentManage>();
        if(sessionList!=null){
            pages.setData(sessionList);
            pages.setTotalRows(sessionList.size());
        }
        return Layui.data(pages);
    }

    //缴费查询
    @RequestMapping("SessionSumMoney")
    public void SessionSumMoney(HttpServletRequest request, Integer Classcostid, Integer Selectid, String Objdata) throws JSONException {
        JSONObject obj =  new JSONObject(Objdata);
        Map<String, String> map = new HashMap<>();

        Iterator<String> iterator = obj.keys();
        // for (Iterator<String> iterators = obj.keys(); iterators.hasNext();) {}
        while (iterator.hasNext()) {
            String key = iterator.next();
            String value = obj.getString(key);
            map.put(key, value);
        }
        //获取Session的数据
        List<StudentManage> sessionList = (List<StudentManage>)request.getSession().getAttribute("SumMoneySession");
        for (StudentManage studentManage:sessionList) {
            //班级费用id为null就判断缴费明细ID
            if(Classcostid == studentManage.getClasscostid() || Classcostid == studentManage.getPaymentdetailid()){
                //修改SumMoneySession的值
                if(Selectid==0){
                    studentManage.setRequiredamount(new BigDecimal(map.get("requiredamount")));//应缴金额
                    studentManage.setPreferentialamount(new BigDecimal(map.get("preferentialamount")));//优惠金额
                    studentManage.setArrearsmount(new BigDecimal(map.get("arrearsmount")));//欠费金额

                    //System.out.println(studentManage.getNeedamount()+"--"+studentManage.getPaidmoney()+"--"+studentManage.getPreferentialamount());
                    //欠费 = 应缴金额 - (实缴金额 + 优惠金额)
                    //BigDecimal Arrears = (new BigDecimal(map.get("requiredamount"))).subtract((new BigDecimal(map.get("paymentamount"))).add(new BigDecimal(map.get("preferentialamount"))));
                    //System.out.println(Arrears);
                    //studentManage.setArrearsmount(Arrears);//欠费

                    //实缴金额 = 应缴金额 - 优惠金额 - 欠费
                    BigDecimal Payment = new BigDecimal(map.get("requiredamount")).subtract(new BigDecimal(map.get("preferentialamount"))).subtract(new BigDecimal(map.get("arrearsmount")));
                    //System.out.println(Arrears);
                    studentManage.setPaymentamount(Payment);//实缴金额

                    //优惠理由
                    if(map.get("preferences")=="" || map.get("preferences")==null){
                        studentManage.setPreferences(studentManage.getFundtype());
                    }else {
                        studentManage.setPreferences(map.get("preferences"));
                    }
                    studentManage.setPaymentremarks(map.get("paymentremarks"));//备注
                }else {
                    StudentManage paymenttype = studentMapper.selectPaymenttype(Selectid);//根据付款类型id查询付款类型表
                    studentManage.setPaymenttypeid(paymenttype.getPaymenttypeid());//付款类型id
                    studentManage.setPaymenttype(paymenttype.getPaymenttype());//付款类型
                }
            }
            //System.out.println("-----------------------------------------");
            //System.out.println(studentManage.getClasscostmoney()+"--"+studentManage.getPaidmoney()+"--"+studentManage.getPreferentialamount()+"--"+studentManage.getArrears()+"--"+studentManage.getPreferences()+"--"+studentManage.getPaymentremarks());
        }
    }

    //新增款项sesion
    /*
    @RequestMapping("addFund")
    public List<StudentManage> addFund(HttpServletRequest request){
        List<StudentManage> fundList = new ArrayList<>();
        StudentManage nulldata = new StudentManage();
        //获取Session的数据
        List<StudentManage> sessionList = (List<StudentManage>)request.getSession().getAttribute("fundSession");

        if(sessionList!=null){
            nulldata.setSessionFunid(sessionList.get(sessionList.size()-1).getSessionFunid()+1);
            sessionList.add(nulldata);
        }else {
            nulldata.setSessionFunid(1);
            fundList.add(nulldata);
            request.getSession().setAttribute("fundSession",fundList);
        }
        //System.out.println(request.getSession().getAttribute("fundSession").toString());

        return sessionList;
    }*/

    //清空FundSession
    @RequestMapping("emptySumMoney")
    public void emptySumMoney(HttpServletRequest request){
        request.getSession().setAttribute("SumMoneySession",null);
    }

    //学员新增
    @RequestMapping("InsertStudent")
    public JsonReturn InsertStudent(HttpServletRequest request, StudentManage dates, MultipartFile fileStudentImage) throws IOException {
        JsonReturn jsonReturn = new JsonReturn();
        //开启事务
        transDefinition.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRES_NEW);
        TransactionStatus transStatus = transactionManager.getTransaction(transDefinition);

        Boolean idCard = false;// 身份证状态
        Integer paymentdetaildata = 0;//缴费明细成功条数
        Boolean imagebit = null;//图片大小状态

        if(fileStudentImage != null){
            imagebit = ArrImage(dates,fileStudentImage);//调用图片验证、编码方法
            if(imagebit == false){
                jsonReturn.setMsg("图片大小不能大于500kb");
            }
        }
        //图片验证
        if((fileStudentImage!=null && imagebit==true) || fileStudentImage==null){
            try {
                List<StudentManage> listmember = studentMapper.selectStudent();//学员查询
                for (StudentManage listmembers : listmember) {
                    // 身份证是否重复
                    if (listmembers.getIdentitycard().equals(dates.getIdentitycard())) {
                        idCard = true;
                    }
                }
                //身份证不重复
                if(idCard==false){
                    int registrationdata = studentMapper.insertRegistration(dates);//新增报名表
                    if(registrationdata>0){
                        int studentdata = studentMapper.insertStudent(dates);//新增学员
                        if(studentdata>0){
                            //Decimal类型: a.compareTo(b) ==-1(a小于b)、 ==0(a等于b)、 ==1(a大于b)、 >-1(a大于等于b)、 <1(a小于等于b)
                            int paymoneydata = studentMapper.insertPaymoney(dates);//新增缴费表
                            //System.out.println(1/0);
                            if(paymoneydata>0){
                                //获取Session的数据
                                List<StudentManage> sessionList = (List<StudentManage>)request.getSession().getAttribute("SumMoneySession");
                                for (StudentManage sessionlist:sessionList) {
                                    paymentdetaildata++;
                                    sessionlist.setUserid(dates.getUserid());//用户ID
                                    //判断是否优惠
                                    if(sessionlist.getPreferentialamount().compareTo(new BigDecimal("0")) ==1){
                                        sessionlist.setPreferentialstatus(0);
                                    }
                                    sessionlist.setPamoneyid(dates.getPamoneyid());//缴费ID
                                    sessionlist.setClassid(dates.getClassid());//班级ID
                                    studentMapper.insertPaymentDetail(sessionlist);//新增缴费明细表
                                }
                                if(paymentdetaildata==sessionList.size()){
                                    jsonReturn.setState(true);
                                    jsonReturn.setMsg("学员新增成功！");
                                }else {
                                    jsonReturn.setMsg("缴费明细表新增失败！");
                                }
                            }else {
                                jsonReturn.setMsg("缴费表新增失败！");
                            }
                        }else {
                            jsonReturn.setMsg("学生表新增失败！");
                        }
                    }else{
                        jsonReturn.setMsg("报名表新增失败！");
                    }
                }else {
                    jsonReturn.setMsg("身份证与已有的学员身份证一致，请检查是否输入错误或已报名！");
                }
                transactionManager.commit(transStatus);
            }catch (Exception e){
                e.printStackTrace();//显示报错
                transactionManager.rollback(transStatus);
                jsonReturn.setMsg("新增失败！");
            }
        }
        return jsonReturn;
    }

    //学生信息回填
    @RequestMapping("BackfillStudent")
    public StudentManage BackfillStudent(HttpServletRequest request,Integer StudentID) {
        StudentManage listestudent = studentMapper.backfillStudent(StudentID);//学员数据

        List<StudentManage> paymentdetail = studentMapper.selectPaymentdetail(StudentID,listestudent.getClassid(),"");//缴费明细数据
        request.getSession().setAttribute("SumMoneySession",paymentdetail);//保存到session
        return listestudent;
    }

    //学生信息修改
    @RequestMapping(value = "UpdateStudent",produces = "application/json; charset=utf-8")
    public JsonReturn UpdateStudent(HttpServletRequest request, StudentManage dates, MultipartFile fileStudentImage) throws IOException {

        JsonReturn jsonReturn = new JsonReturn();
        //开启事务
        transDefinition.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRES_NEW);
        TransactionStatus transStatus = transactionManager.getTransaction(transDefinition);

        Integer paymentdetaildata = 0;//缴费明细成功条数
        Boolean imagebit = null;//图片大小状态

        if(fileStudentImage != null){
            imagebit = ArrImage(dates,fileStudentImage);//调用图片验证、编码方法
            if(imagebit == false){
                jsonReturn.setMsg("图片大小不能大于500kb");
            }
        }
        //System.out.println(dates);
        //图片验证
        if((fileStudentImage!=null && imagebit==true) || fileStudentImage==null){
            try {
                int registrationdata = studentMapper.updateRegistration(dates);//修改报名表
                if(registrationdata>0){
                    int studentdata = studentMapper.updateStudent(dates);//修改学员表
                    if(studentdata>0){
                        int paymoneydata = studentMapper.updatePaymoney(dates);//修改缴费表
                        if(paymoneydata>0){
                            //获取Session的数据
                            List<StudentManage> sessionList = (List<StudentManage>)request.getSession().getAttribute("SumMoneySession");
                            for (StudentManage sessionlist:sessionList) {
                                sessionlist.setUserid(dates.getUserid());//用户ID
                                paymentdetaildata++;
                                //判断是否优惠
                                if(sessionlist.getPreferentialamount().compareTo(new BigDecimal("0")) ==1){
                                    sessionlist.setPreferentialstatus(0);
                                }
                                studentMapper.updatePaymentDetail(sessionlist);//修改缴费明细表
                            }
                            if(paymentdetaildata==sessionList.size()){
                                jsonReturn.setState(true);
                                jsonReturn.setMsg("学员修改成功！");
                            }else {
                                jsonReturn.setMsg("缴费明细表修改失败！");
                            }
                        }else {
                            jsonReturn.setMsg("缴费表修改失败！");
                        }
                    }else {
                        jsonReturn.setMsg("学生表修改失败！");
                    }
                }else{
                    jsonReturn.setMsg("报名表修改失败！");
                }
                transactionManager.commit(transStatus);
            }catch (Exception e){
                e.printStackTrace();//显示报详情
                transactionManager.rollback(transStatus);
                jsonReturn.setMsg("修改失败！");
            }
        }
        return jsonReturn;
    }

    //学生信息删除
    @RequestMapping("DeleteStudent")
    public JsonReturn DeleteStudent(Integer StudentID){
        JsonReturn jsonReturn = new JsonReturn();
        Integer paymentdetailNumber = 0;//缴费明细删除成功条数
        //开启事务
        transDefinition.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRES_NEW);
        TransactionStatus transStatus = transactionManager.getTransaction(transDefinition);

        try {
            StudentManage datas = studentMapper.backfillStudent(StudentID);//学员数据
            List<StudentManage> paymentdetail = studentMapper.selectPaymentdetail(StudentID,0,"");//缴费明细数据

            for (StudentManage manages:paymentdetail) {
                studentMapper.deletePaymentDetail(manages.getPaymentdetailid());//删除缴费明细表
                paymentdetailNumber++;
            }
            if(paymentdetail.size()==paymentdetailNumber){
                int paymoneydata = studentMapper.deletePaymoney(datas.getPamoneyid());//删除缴费表
                if(paymoneydata>0){
                    int registrationdata = studentMapper.deleteRegistration(datas.getRegistrationid());//删除报名表
                    if(registrationdata>0){
                        int studentdata = studentMapper.deleteStudent(datas.getStudentid());//删除学员表
                        if(studentdata>0){
                            jsonReturn.setState(true);
                            jsonReturn.setMsg("学员删除成功！");
                        }else {
                            jsonReturn.setMsg("学员删除失败！");
                        }
                    }else {
                        jsonReturn.setMsg("报名表删除失败！");
                    }
                }else {
                    jsonReturn.setMsg("缴费表删除失败！");
                }
            }else {
                jsonReturn.setMsg("缴费明细表删除失败！");
            }
            transactionManager.commit(transStatus);
        }catch (Exception e){
            e.printStackTrace();//显示报错
            transactionManager.rollback(transStatus);
            jsonReturn.setMsg("删除失败！");
        }
        return jsonReturn;
    }

    // 图片验证、编码封装
    private Boolean ArrImage(StudentManage dates, MultipartFile fileStudentImage) throws IOException {
        Boolean ImageSize;
        //限制图片大小
        if(CheckFileSize.checkFileSize(fileStudentImage.getSize(),500,"K")){
            BASE64Encoder base64Encoder =new BASE64Encoder();//base64
            //"data:" + image/png + ";base64," + 9jMJDNDSLW···
            dates.setPhotograph("data:" + fileStudentImage.getContentType()+";base64," + base64Encoder.encode(fileStudentImage.getBytes()).trim());
            /*System.out.println("fileStudentImage的输出为："+fileStudentImage);
            System.out.println("fileStudentImage.getContentType()的输出为："+fileStudentImage.getContentType());
            System.out.println("fileStudentImage.getBytes()的输出为："+base64Encoder.encode(fileStudentImage.getBytes()));*/
            ImageSize=true;
        }
        else {
            ImageSize=false;
        }
        return ImageSize;
    }


    //换班、五次不过、退学管理多条件查询
    @RequestMapping(value = "selManageByPage", produces = "application/json; charset=utf-8")
    private Layui selManageByPage(Integer page, Integer limit,String SignUpName,Integer NamePointID,Integer csAudit,
                                  Integer DepartmentID,String datebegin,String datefinish,String SMState,String arrearage) throws ParseException {

        //System.out.println(SignUpName+"--"+NamePointID+"--"+csAudit+"--"+DepartmentID+"--"+datebegin+"--"+datefinish+"--"+SMState+"--"+arrearage);
        Date DateBegin = new Date();
        Date DateFinish = new Date();
        //String类型转Date类型
        if (!datebegin.isEmpty()) {
            DateBegin = new SimpleDateFormat( "yyyy-MM-dd").parse(datebegin);
        } else {
            DateBegin=null;
        }
        if (!datefinish.isEmpty()) {
            DateFinish = new SimpleDateFormat( "yyyy-MM-dd").parse(datefinish);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(DateFinish);
            calendar.add(Calendar.DATE,1); //把日期往后增加一天,整数往后推,负数往前移动
            DateFinish=calendar.getTime(); //这个时间就是日期往后推一天的结果
        } else {
            DateFinish=null;
        }
        //查询数据
        List<StudentManage> list = studentMapper.selManageByPage(SignUpName, DateBegin, DateFinish, NamePointID, DepartmentID, SMState, csAudit, arrearage);
        for (StudentManage students : list) {
            students.setOrdmodelclass(students.getOrdmodelname() +"-"+ students.getOrdclassname());//原车型、班级
            students.setModelclass(students.getModelname() +"-"+ students.getClassname());//更改车型、班级
        }
        PageService<StudentManage> fam = new PageService<StudentManage>();
        PageBean<StudentManage> pages = fam.findByPage(list, page, limit);// 分页
        return Layui.data(pages);
    }

    //根据证件号查询学员信息
    @RequestMapping(value = "selStudentByIdCard", produces = "application/json; charset=utf-8")
    private StudentManage selStudentByIdCard(HttpServletRequest request,String IdNumber,String StuState) {
        //根据证件号查询学员信息
        StudentManage students = studentMapper.selStudentByIdCard(IdNumber,StuState,0);

        if(students != null){
            students.setModelclass(students.getModelname() +"-"+ students.getClassname());//车型班级
            //根据学员ID查询学员缴费明细信息
            List<StudentManage> payDetails = studentMapper.selectPaymentdetail(students.getStudentid(),students.getClassid(),"");
            for (StudentManage dates:payDetails) {
                BigDecimal Arrears = dates.getRequiredamount().subtract(dates.getPaymentamount());
                //优惠审核了就加上优惠金额
                if(null != dates.getPreferentialstatus() && dates.getPreferentialstatus() ==1){
                    Arrears = Arrears.add(dates.getPreferentialamount());
                }
                dates.setArrearsmount(Arrears);//欠费金额
            }
            request.getSession().setAttribute("PaymentDetail", payDetails);//保存到session
        }
        return students;
    }

    //查询班制费用明细（查询session数据）
    @RequestMapping("selPayPage")
    private Layui selPayPage(HttpServletRequest request,Integer curr,Integer nums) throws JSONException {
        //获取session中的费用明细
        List<StudentManage> sessionPay = (List<StudentManage>) request.getSession().getAttribute("PaymentDetail");
        PageBean<StudentManage> pages = new PageBean<StudentManage>();
        if(sessionPay!=null){
            pages.setData(sessionPay);
            pages.setTotalRows(sessionPay.size());
        }
        //PageService<StudentManage> ssv = new PageService<StudentManage>();
        //PageBean<StudentManage> pageBean = ssv.findByPage(sessionPay, curr, nums);
        return Layui.data(pages);
    }

    //清空缴费信息session，避免残留数据
    @RequestMapping("clearPayDetail")
    private void clearSession(HttpServletRequest request) {
        request.getSession().setAttribute("PaymentDetail", null);//清空缴费明细session
    }

    //清空班级费用信息session，避免残留数据
    @RequestMapping("clearClassCost")
    private void clearClassCost(HttpServletRequest request) {
        request.getSession().setAttribute("SumMoneySession", null);//清空班级费用明细session
    }

    //根据换班、五次不过、退学状态查询票号
    @RequestMapping("selShiftByState")
    private JsonReturn selShiftByState(String SMState) {
        JsonReturn jsonReturn = new JsonReturn();
        // 创建一个Date对象，获取当前时间
        Date now = new Date();
        // 指定格式化格式
        String Date = new SimpleDateFormat("yyyyMMdd").format(now);
        //申请表最后一条数据票号
        String SMNumber = studentMapper.selectApplication(SMState);
        //获取自增单号(每天重置单号)
        String Number = "";
        if(SMNumber==null || SMNumber=="") {//判断是否为空
            Number="0001";

        } else {
            String datetime = SMNumber.substring(2, 10);
            //判断编号中的日期是否与当前日期相等
            if(datetime.equals(Date)) {
                //获取到自增数
                int intOrder = Integer.parseInt(SMNumber.substring(10));
                intOrder++;
                Integer cf = 4;//默认值
                Double Mp = Math.pow(10,cf);//10000
                Integer Mp_1 = new Double(Mp).intValue() - 1;//9999
                //判断自增数是否等于小于 10的n次方减1
                if(intOrder <= Mp_1) {
                    Number=Integer.toString(intOrder);
                    //判断长度是否等于4，如果不等就往其前面补零
                    for (int i = 0; i < cf; i++)
                    {
                        Number = Number.length() < cf ? 0 + Number : Number;
                    }
                }
                else {
                    cf++;
                }
            } else {
                Number="0001";
            }
        }
        //拼接进货订单号
        String StockNumber = "";
        if (SMState.equals("换班")) {
            StockNumber = "HB" + Date + Number; // 换班
        } else if (SMState.equals("退学")) {
            StockNumber = "TX" + Date + Number; // 退学
        } else {
            StockNumber = "BG" + Date + Number; // 五次不过
        }
        jsonReturn.setState(true);
        jsonReturn.setMsg(StockNumber);
        return jsonReturn;
    }

    //新增换班
    @RequestMapping("insertStudentManage")
    private JsonReturn insertStudentManage(HttpServletRequest request,StudentManage dates) {
        //开启事务
        transDefinition.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRES_NEW);
        TransactionStatus transStatus = transactionManager.getTransaction(transDefinition);

        JsonReturn jsonReturn = new JsonReturn();
        Integer paymentdetaildata = 0;//缴费明细成功条数
        //清空session，避免数据残留
        //request.getSession().setAttribute("ClassCost", null);
        try {
            StudentManage tbapplication = studentMapper.backfillapplication(dates.getStudentid());//根据学员ID，回填换班申请最后一条信息

            //没有正在申请的换班记录
            if(tbapplication == null || tbapplication.getApplicationstatus() != 0){
                dates.setApplicationtype(1);//申请类型(换班)
                int insertApplication = studentMapper.insertApplication(dates);//新增申请表
                if(insertApplication>0){
                    List<StudentManage> tbpaymentdetail = studentMapper.selectPaymentdetail(dates.getStudentid(),dates.getOrdclassid(),"");//缴费明细数据
                    for (StudentManage detailList:tbpaymentdetail) {
                        //含有未审核的优惠信息
                        if(detailList.getPreferentialstatus() !=null && detailList.getPreferentialstatus() == 0){
                            //根据缴费明细ID修改缴费明细表优惠状态
                            studentMapper.updatePayDetailStatus(detailList.getPaymentdetailid(),2);
                        }
                    }

                    TbPaymoney tbPaymoney = studentMapper.selPayByStudentid(dates.getStudentid());//根据学员ID，查询缴费信息
                    //获取Session的数据
                    List<StudentManage> sessionList = (List<StudentManage>)request.getSession().getAttribute("SumMoneySession");
                    for (StudentManage sessionlist:sessionList) {
                        paymentdetaildata++;
                        sessionlist.setUserid(dates.getUserid());//用户Id
                        sessionlist.setClassid(dates.getClassid());//班级ID
                        sessionlist.setPamoneyid(tbPaymoney.getPamoneyid());//缴费ID
                        //判断是否优惠
                        if(sessionlist.getPreferentialamount().compareTo(new BigDecimal("0")) ==1){
                            sessionlist.setPreferentialstatus(0);//优惠状态
                        }
                        studentMapper.insertPaymentDetail(sessionlist);//新增缴费明细表
                    }
                    if(paymentdetaildata==sessionList.size()){
                        jsonReturn.setState(true);
                        jsonReturn.setMsg("换班申请成功，请耐心等待审核结果！");
                    }else {
                        jsonReturn.setMsg("缴费明细表修改失败！");
                    }
                }
                transactionManager.commit(transStatus);
            }else {
                jsonReturn.setMsg("申请失败,有正在申请的换班记录！");
            }
        }catch (Exception e){
            e.printStackTrace();//显示报详情
            transactionManager.rollback(transStatus);
            jsonReturn.setMsg("新增失败！");
        }
        return jsonReturn;
    }

    //回填换班详情
    @RequestMapping("backfillShift")
    private StudentManage backfillShift(HttpServletRequest request,Integer StudentID) {
        StudentManage students = studentMapper.selStudentByIdCard("","",StudentID);//学生信息

        StudentManage application = studentMapper.backfillapplication(StudentID);//学生申请换班信息
        application.setModelclass(application.getOrdmodelname() +"-"+ application.getOrdclassname());//原车型班级

        //共用了一个实体类，不设置为null将影响赋值
        students.setModelid(null);students.setClassid(null);

        //获取源对象中为null的属性名
        String[] nullPropertyNames = CheckFileSize.getNullPropertyNames(students);
        //System.out.println("students中为null的属性" + Arrays.toString(nullPropertyNames));

        //copyProperties通过反射将一个对象的值赋值给另外一个对象，第三个参数是一个String类型的数组，需要提供忽略的那些null的属性名
        BeanUtils.copyProperties(students, application, nullPropertyNames);

        BigDecimal ordmoney = new BigDecimal("0");
        List<StudentManage> ordpaymentdetail = studentMapper.selectPaymentdetail(StudentID,application.getOrdclassid(),"");//原班级缴费明细数据
        for (StudentManage ord:ordpaymentdetail) {
            ordmoney = ordmoney.add(ord.getRequiredamount());
        }
        application.setNeedpaymenttotalmoney(ordmoney);//原班级缴费总价格

        List<StudentManage> paymentdetail = studentMapper.selectPaymentdetail(StudentID,application.getClassid(),"");//新班级缴费明细数据
        request.getSession().setAttribute("SumMoneySession",paymentdetail);//保存到session

        return application;
    }

    //回填审核详情信息
    @RequestMapping("backfillAuditing")
    private StudentManage backfillAuditing(Integer ApplicationID) {
        StudentManage application = studentMapper.SelApplication(ApplicationID);//查询申请信息
        return application;
    }

    //换班审核
    @RequestMapping("updateAuditing")
    private JsonReturn updateAuditing(StudentManage dates) {
        JsonReturn jsonReturn = new JsonReturn();
        try{
            //System.out.println(dates.getApplicationid()+"--"+dates.getApplicationstatus()+"--"+dates.getUserid());
            //修改申请表状态
            int application = studentMapper.updateAppStatus(dates.getApplicationid(),dates.getApplicationstatus(),dates.getUserid());
            if(application>0){
                //修改学生表班级、车型
                int updatestudent = studentMapper.updateStudentClassModel(dates.getStudentid(),dates.getModelid(),dates.getClassid());
                if(updatestudent>0){
                    //审核通过（原班级ID），审核失败（新班级ID）
                    int delClassID = dates.getApplicationstatus() == 1 ? dates.getOrdclassid() : dates.getClassid();

                    List<StudentManage> paymentdetail = studentMapper.selectPaymentdetail(dates.getStudentid(),delClassID,"");//缴费明细数据
                    for (StudentManage manages:paymentdetail) {
                        studentMapper.deletePaymentDetail(manages.getPaymentdetailid());//删除缴费明细表
                    }
                    jsonReturn.setState(true);
                    jsonReturn.setMsg("审核成功");
                }else {
                    jsonReturn.setMsg("学生表修改失败");
                }
            }else {
                jsonReturn.setMsg("申请表修改失败");
            }
        }catch (Exception e){
            e.printStackTrace();//显示报详情
            jsonReturn.setMsg("审核失败！");
        }
        return jsonReturn;
    }

    //优惠查询
    @RequestMapping("selPreferAudit")
    private Layui selPreferAudit(Integer page,Integer limit,String SignUpName,Integer NamePointID,Integer DepartmentID,
        String Audit,String datebegin,String datefinish) throws ParseException {
        Date DateBegin = new Date();
        Date DateFinish = new Date();
        //String类型转Date类型
        DateBegin = !datebegin.isEmpty() ? DateBegin = new SimpleDateFormat( "yyyy-MM-dd").parse(datebegin) : null;

        if (!datefinish.isEmpty()) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new SimpleDateFormat( "yyyy-MM-dd").parse(datefinish));
            calendar.add(Calendar.DATE,1); //把日期往后增加一天,整数往后推,负数往前移动
            DateFinish=calendar.getTime(); //这个时间就是日期往后推一天的结果
        } else {
            DateFinish=null;
        }

        System.out.println(SignUpName+"--"+NamePointID+"--"+DepartmentID+"--"+Audit+"--"+DateBegin+"--"+DateFinish);
        //查询全部优惠信息
        List<StudentManage> list = studentMapper.selectPreferentialStatus(SignUpName,NamePointID,DepartmentID,Audit,DateBegin,DateFinish);

        PageService<StudentManage> fam = new PageService<StudentManage>();
        PageBean<StudentManage> pages = fam.findByPage(list, page, limit);// 分页
        return Layui.data(pages);
    }

    //查询班制费用明细（保存到session中）
    @RequestMapping("selPayDetail")
    private Layui selPayDetail(Integer page,Integer limit,Integer StudentID) {
        List<StudentManage> paymentdetail = studentMapper.selectPaymentdetail(StudentID,0,"优惠~");//缴费明细数据
        PageService<StudentManage> fam = new PageService<StudentManage>();
        PageBean<StudentManage> pages = fam.findByPage(paymentdetail, page, limit);// 分页
        return Layui.data(pages);
    }

    //优惠审核
    @RequestMapping("preferentialAudit")
    private JsonReturn preferentialAudit(Integer payDetailID,Integer Audit){
        JsonReturn jsonReturn = new JsonReturn();
        try{
            studentMapper.updatepreferential(payDetailID,Audit);//修改缴费明细表状态
            jsonReturn.setState(true);
            jsonReturn.setMsg("审核成功！");
        }catch (Exception e){
            e.printStackTrace();//显示报详情
            jsonReturn.setMsg("审核失败！");
        }
        return jsonReturn;
    }

}
