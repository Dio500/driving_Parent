package com.gx.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class ExamManage {
    private Integer studentid;//学员ID
    private Integer classid;//班制ID
    private Integer modelid;//车型ID
    private Integer cardtypeid;//证件类型ID
    private Integer employeeid;//员工ID
    private Integer traininggroundid;//训练场ID
    private Integer healthid;//体检ID
    private Integer interviewid;//面签ID
    private Integer acceptanceid;//受理ID
    private Integer registrationid;//报名ID
    private Integer aboutclassid;//约课ID
    private String name;//姓名
    private Boolean sex;//性别
    private String nationality;//国籍
    private String identitycard;//证件号码
    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date idcardvaliditydate;//证件有效日期

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date birthday;//生日
    private String studystate;//就学状态
    private String phoneone;//电话1
    private String phonetwo;//电话2
    //private String photograph;//照片
    private String idcardaddress;//身份证地址
    private String residentialaddress;//居住地址
    private String numbers;//编号
    private String remarks;//备注
    private String modelclass; //车型班级

    private Integer departmentid;//部门ID
    private String drivingmodel;//车型
    private String classname;//班级名称
    //private BigDecimal classprice;//班级价格
    //private String pricedescription;//价格说明
    private String fastesttime;//最快拿证时间
    private String subjecttwocarallot;//科二车辆分配数量
    private String subjectthreecarallot;//科三车辆分配数量
    private String classdescription;//班型描述
    private String pickupform;//接送形式
    private String optionalcoachbit;//自选教练否
    private String onlinedisplaybit;//线上显示否
    private String enablebit;//启用否
    private String classsort;//班级排序

    private Integer parentdepartmentid;//部门父ID
    private String departmentname;//部门名称
    private String linkman;//联系人

    private String modelname;//车型名称
    private Integer registrationpointid;//报名点ID
    private Integer sourceenrollmentid;//招生来源ID
    private String referralname;//介绍人名称
    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date registrationtime;//报名时间
    private String sourceenrollmentname;//招生来源名称
    private String registrationpointname;//报名点名称

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date healthtime;//体检时间
    private Boolean healthbit;//体检状态
    private String healthremarks;//体检备注
    /*private Boolean disabledbit;//肢体残疾否
    private Boolean mentalillnessbit;//有无精神疾病
    private Boolean colorblindbit;//色盲否*/

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date interviewtime;//面签时间
    private Boolean interviewbit;//面签状态
    private String interviewremarks;//面签备注

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date acceptancetime;//受理时间
    private Boolean acceptancebit;//受理状态
    private String acceptanceremarks;//受理备注

    private Boolean examination;//是否及格
    /*private Date testtime;//测试时间
    private Boolean teststate;//测试状态
    private String testremarks;//测试备注*/


    private Integer testdetailid;//考试明细ID
    private Integer subjectid;//科目ID
    private Integer testroomid;//考场ID
    private BigDecimal subjectresult;//成绩
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" ,timezone = "GMT+8")//出参格式化
    private Date testtime;//考试时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" ,timezone = "GMT+8")//出参格式化
    private Date appointmenttime;//预约时间
    private Integer teststate;//考试状态

    private String subjectname;//科目

    private String testroomname;//考场名称
    private String testroomaddress;//考场地址

    private String employeename;//教练姓名
    private Integer testnumber;//考试次数
    private Integer result;//考试成绩
}
