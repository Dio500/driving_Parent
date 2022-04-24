package com.gx.mapper;

import com.gx.pojo.*;
import com.gx.utils.SelectVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

//@Mapper//不需要spring配置中扫描地址
//@Repository//需要spring配置中扫描地址
public interface StudentMapper {

    //报名点下拉框
    List<SelectVo> selectEnroll();

    //车型下拉框
    List<SelectVo> selectmodelCar();

    //班制下拉框
    List<SelectVo> selectClass();

    //查询班制全部数据
    //List<SelectVo> selectModelClass();

    //招生部门下拉框

    List<SelectVo> selectDepartment();

    //证件类型下拉框
    List<SelectVo> selectCardType();

    //招生来源下拉框
    List<SelectVo> selectregistrations();

    //缴费编号
    TbPaymoney selectTicket();

    //学号
    TbStudent selectNumbers();

    //训练场下拉框
    List<SelectVo> selectGroundName();

    //教练下拉框
    List<SelectVo> selectemployee();

    //业务类型下拉框
    List<SelectVo> selectbusinessType();

    //缴费查询
    //List<TbPaymentdetail> selectPay();

    //学员多条件查询
    List<StudentManage> selectStudent( @Param("RegistrationPoint")Integer RegistrationPoint,
                                       @Param("Class")Integer Class,
                                       @Param("Model")Integer Model,
                                       @Param("Department")Integer Department,
                                       @Param("NameCardPhone")String NameCardPhone,
                                       @Param("ReferralName")String ReferralName,
                                       @Param("Gender")Boolean Gender,
                                       @Param("AgeStart")Integer AgeStart,
                                       @Param("AgeEnd")Integer AgeEnd
    );
    List<StudentManage> selectStudent();

    //查询付款类型
    List<SelectVo> selectPaymentType();

    //根据付款类型id查询付款信息
    StudentManage selectPaymenttype(@Param("Selectid")Integer Selectid);

    //班级费用明细
    List<StudentManage> selectclassCost(@Param("classID")Integer classID);

    //新增报名表
    int insertRegistration(StudentManage studentManage);

    //新增学员表
    int insertStudent(StudentManage studentManage);

    //新增缴费明细表
    int insertPaymentDetail(StudentManage studentManage);

    //新增缴费表
    int insertPaymoney(StudentManage studentManage);

    //根据学生ID查询学生信息
    StudentManage backfillStudent(Integer studentID);

    //根据学生ID、班级ID查询缴费明细
    List<StudentManage> selectPaymentdetail(@Param("studentID")Integer studentID,@Param("classID")Integer classID,@Param("Status")String Status);

    //修改报名表
    int updateRegistration(StudentManage studentManage);

    //修改学员表
    int updateStudent(StudentManage studentManage);

    //修改缴费明细表
    int updatePaymentDetail(StudentManage studentManage);

    //修改缴费表
    int updatePaymoney(StudentManage studentManage);

    //删除报名表
    int deleteRegistration(Integer StudentID);

    //删除学员表
    int deleteStudent(Integer StudentID);

    //删除缴费明细表
    int deletePaymentDetail(@Param("paymentdetailID")Integer paymentdetailID);

    //删除缴费表
    int deletePaymoney(Integer StudentID);


    //===============================================换班管理==============================================//

    //换班、五次不过、退学管理多条件查询
    List<StudentManage> selManageByPage(@Param("SignUpName")String SignUpName,@Param("DateBegin")Date DateBegin,
                                        @Param("DateFinish")Date DateFinish,@Param("NamePointID")Integer NamePointID,
                                        @Param("DepartmentID")Integer DepartmentID,@Param("SMState")String SMState,
                                        @Param("SMAudit")Integer SMAudit,@Param("arrearage")String arrearage);

    //根据证件号查询学员信息
    StudentManage selStudentByIdCard(@Param("IdNumber")String IdNumber,@Param("StuState")String StuState,@Param("studentID")Integer studentID);

    //根据学员报名ID或学员管理ID查询学员费用明细信息
    List<StudentManage> selPayDetailByID(@Param("StudentsID")Integer StudentsID);

    //申请表最后一条数据票号
    String selectApplication(@Param("SMState")String SMState);

    //新增申请表
    int insertApplication(StudentManage studentManage);

    //根据学生ID查询缴费表
    TbPaymoney selPayByStudentid(@Param("StudenID")Integer StudenID);

    //根据原班级ID查询班级费用明细表
    List<TbClasscost> selClassCostByclassid(@Param("classID")Integer classID);

    //修改缴费明细表优惠状态
    int updatePayDetailStatus(@Param("paymentdetailID")Integer paymentdetailID,@Param("preferentialStatus")Integer preferentialStatus);

    //修改申请表优惠状态
    int updateAppStatus(@Param("applicationID")Integer applicationID,
        @Param("applicationstatus")Integer applicationstatus,@Param("userID")Integer userID);

    //根据款项Id和缴费ID删除缴费明细表
    //int delPayDetailByfundid(@Param("fundID")Integer fundID,@Param("pamoneyID")Integer pamoneyID);

    //修改学生表班级、车型
    int updateStudentClassModel(@Param("studenID")Integer studenID,@Param("modelID")Integer modelID,@Param("classID")Integer classID);



    //根据学员ID，查询换班申请信息
    StudentManage backfillapplication(@Param("StudentID")Integer StudentID);

    //查询申请信息
    StudentManage SelApplication(@Param("ApplicationID")Integer ApplicationID);

    //查询全部优惠信息
    List<StudentManage> selectPreferentialStatus(@Param("SignUpName")String SignUpName,@Param("NamePointID")Integer NamePointID,
                                                 @Param("DepartmentID")Integer DepartmentID,@Param("Audit")String Audit,
                                                 @Param("DateBegin")Date DateBegin,@Param("DateFinish")Date DateFinish);

    //修改缴费明细表状态
    int updatepreferential(@Param("payDetailID")Integer payDetailID,@Param("Audit")Integer Audit);

}
