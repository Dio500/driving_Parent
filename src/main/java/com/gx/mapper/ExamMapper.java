package com.gx.mapper;
import com.gx.pojo.ExamManage;
import com.gx.utils.SelectVo;
import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public interface ExamMapper {
    /*-----------------------------------------------考前流程-----------------------------------------------*/

    //考前流程查询
    List<ExamManage> selectexam(@Param("SignUpName")String SignUpName,@Param("NamePointID")Integer NamePointID,
                                @Param("DepartmentID")Integer DepartmentID,@Param("ModelID")Integer ModelID,
                                @Param("ClassID")Integer ClassID,@Param("SignBegin") Date SignBegin,
                                @Param("SignFinish")Date SignFinish,@Param("ProBegin")Date ProBegin,
                                @Param("ProFinish")Date ProFinish,@Param("Examination")String Examination,
                                @Param("DownExamin")String DownExamin,@Param("ExaminState")Boolean ExaminState);

    //新增体检表
    int insertHealth(ExamManage objs);
    //新增面签表
    int insertInterview(ExamManage objs);
    //新增受理表
    int insertAcceptance(ExamManage objs);

    //修改体检表
    int updateHealth(ExamManage objs);
    //修改面签表
    int updateInterview(ExamManage objs);
    //修改受理表
    int updateAcceptance(ExamManage objs);

    //删除体检表
    int deleteHealth(Integer healthID);
    //删除面签表
    int deleteInterview(Integer interviewID);
    //删除受理表
    int deleteAcceptance(Integer acceptanceID);

    //修改学生表
    int updateStudentExam(ExamManage objs);

    /*-----------------------------------------------考试预约-----------------------------------------------*/
    //科目合格、待合格查询
    List<ExamManage> selectTestDetail(@Param("SignUpName")String SignUpName,@Param("NamePointID")Integer NamePointID,
                                      @Param("DepartmentID")Integer DepartmentID,@Param("ModelID")Integer ModelID,
                                      @Param("ClassID")Integer ClassID,@Param("SubjectID")Integer SubjectID,
                                      @Param("SignBegin") Date SignBegin,@Param("SignFinish")Date SignFinish,
                                      @Param("ExaminState")Boolean ExaminState);

    //查询该学生有无该科目的考试记录
    ExamManage selectTestRecord(@Param("studentID")Integer studentID,@Param("subjectID")Integer subjectID);

    //考试时间倒序排序取第一条
    ExamManage appointmentTest(@Param("studentID")Integer studentID,@Param("subjectID")Integer subjectID,
                               @Param("TestBegin")Date ProBegin,@Param("TestFinish")Date ProFinish,
                               @Param("BookingBegin")Date BookingBegin,@Param("BookingFinish")Date BookingFinish,
                               @Param("Examination")String Examination);

    //预约回填
    ExamManage backFillAppointment(@Param("studentID")Integer studentID);

    //新增预约
    int addAppointment(ExamManage examManage);

    //取消预约
    int removalAppointment(@Param("testdetailID")Integer testdetailID);

    //修改为预约成功、失败
    int updateAppointment(@Param("testdetailID")Integer testdetailID,@Param("testStatus")Integer testStatus);

    //预约、成绩详情
    List<ExamManage> selectAchievement(@Param("studentID")Integer studentID,@Param("testStatus")Boolean testStatus);

    //科目下拉框
    List<SelectVo> selectSubject();

    //考场下拉框
    List<SelectVo> selectTestRoom(@Param("subjectID")Integer subjectID);

    /*-----------------------------------------------交管考试记录-----------------------------------------------*/
    //预约、考试记录
    List<ExamManage> selectBooking(@Param("SignUpName")String SignUpName,@Param("SubjectID")Integer SubjectID,
                                   @Param("TestRoomID")Integer TestRoomID,@Param("ModelID")Integer ModelID,
                                   @Param("ClassID")Integer ClassID,@Param("EmployeeID")Integer EmployeeID,
                                   @Param("NamePointID")Integer NamePointID,@Param("DepartmentID")Integer DepartmentID,
                                   @Param("TestBegin")Date TestBegin,@Param("TestFinish")Date TestFinish,
                                   @Param("ExaminState")Boolean ExaminState,@Param("Examination")Integer Examination);

    //考试预约回填
    ExamManage backFillTestDetail(@Param("TestDetailID")Integer TestDetailID);

    int updateTestResult(@Param("TestDetailID")Integer TestDetailID,@Param("Result")Integer Result,@Param("Teststate")Integer Teststate);
}
