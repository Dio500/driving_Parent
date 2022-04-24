package com.gx.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.sql.Blob;
import java.util.Date;

@Data
public class StudentManage {
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
    //private byte[] photograph;//照片
    private String photograph;//照片
    private String idcardaddress;//身份证地址
    private String residentialaddress;//居住地址
    private String numbers;//编号
    private String remarks;//备注

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

    private Integer classcostid;//班制费用ID
    private BigDecimal classcostmoney;//班级费用应缴金额
    private BigDecimal allclasscostmoney;//班级费用应缴总金额
    private Integer sessioncostid;//sesion缴费表唯一标识符

    private BigDecimal paidmoney;//实缴金额

    private Integer parentdepartmentid;//部门父ID
    private String departmentname;//部门名称
    private String linkman;//联系人
    private String departmentphone;//部门电话
    private String sequence;//部门排序

    private String modelname;//车型名称
    private String cardtype;//证件类型

    private Integer traininggroundmodelid;//训练场车型ID
    private String traininggroundname;//训练场名称
    private Integer subjectid;//科目ID
    private String phone;//电话
    private String accommodatingvehicle;//容纳车辆
    private String droppingvehicle;//投放车辆
    private String address;//地址
    private BigDecimal area;//面积
    private String picture;//图片
    private String trainingGroundSort;//训练场排序
    private String enabledbit;//启用否

    /*@DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date healthtime;//体检时间
    private String healthbit;//体检否
    private String healthremarks;//体检备注
    private Boolean disabledbit;//肢体残疾否
    private Boolean mentalillnessbit;//有无精神疾病
    private Boolean colorblindbit;//色盲否

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date interviewtime;//面签时间
    private String interviewbit;//面签否
    private String interviewremarks;//面签备注

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date acceptancetime;//受理时间
    private String acceptancebit;//受理否
    private String acceptanceremarks;//受理备注*/

    private Integer registrationpointid;//报名点ID
    private Integer sourceenrollmentid;//招生来源ID
    private Integer businesstypeid;//业务类型ID
    //private Integer entermodelid;//报名车型ID
    private Integer orddrivingmodelid;//原驾车型ID
    private String ordDrivingnumber;//原驾驶证号
    private String referralname;//介绍人名称
    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date registrationtime;//报名时间
    private Boolean materialsbit;//资料齐全否
    //private String registrationbit;//报名状态

    private String sourceenrollmentname;//招生来源名称

    private String businesstype;//业务类型名称

    private String registrationpointname;//报名点名称
    private String registrationpointphone;//报名点电话
    private String registrationpointaddress;//报名点地址
    private String bycoachbit;//学员分教练否
    private String enablebie;//启用否
    private String registrationpointsort;//报名点排序

    private Integer pamoneyid;//缴费ID
    private BigDecimal needpaymenttotalmoney;//需缴总金额
    private BigDecimal paymenttotalmoney;//缴费总金额
    private BigDecimal discounttotalmoney;//优惠总金额
    private String ticketnumber;//票号
    private BigDecimal arrearagemoney;//欠费总金额

    private Integer paymentdetailid;//缴费明细ID
    private Integer paymenttypeid;//付款类型ID
    private Integer fundid;//款项ID
    private Integer userid;//用户ID
    private BigDecimal requiredamount;//需缴金额
    private BigDecimal paymentamount;//缴费金额
    private BigDecimal arrearsmount;//欠费金额
    private BigDecimal preferentialamount;//优惠金额
    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date paymenttime;//缴费时间
    private String preferences;//优惠理由
    private Integer preferentialstatus;//优惠状态
    private String paymentremarks;//备注
    //private BigDecimal expenditure;//支出
    private Boolean entrytype;//入账类型
    private Boolean entrybit;//入账否
    private Boolean preferentialbit;//优惠否
    //private BigDecimal arrears;//欠费

    private String paymenttype;//付款类型

    private String fundnumber;//款项编号
    private String fundtype;//款项类型
    private BigDecimal needamount;//需缴金额
    private String sequencenumber;//排序序号
    private Boolean fundPurposeBit;//款项用途
    private Boolean startbit;//启用否

    private Integer sessionFunid;//sesion缴费ID
    private Integer coachid;//教练ID

    private Integer applicationid;//申请ID
    private BigDecimal applicationmoney;//金额
    private String introducer;//票号

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date applicationtime;//申请时间
    private String applicationreason;//申请原因
    private Integer applicationtype;//申请类型
    private Integer applicationstatus;//申请状态
    private String applicationreferral;//申请介绍人

    private Integer ordmodelid;//原车型ID
    private Integer ordclassid;//原班制ID
    private String ordmodelname;//原车型名称
    private String ordclassname;//原班制名称
    private String ordmodelclass;//原车型班制
    private String modelclass;//车型班制
    private String username;//用户ID
}
