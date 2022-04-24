package com.gx.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

@Data
public class EmployeeManage {
    //@Id
    private Integer employeeid;
    //主键回填
    //@KeySql(useGeneratedKeys = true)
    private Integer employeegroupingid;//员工分组id
    private Integer registrationpointid;//报名点id
    //private Integer organizationid;//机构id
    private Integer departmentid;//部门id

    private Integer roleid;//角色ID
    private Integer userid;//用户ID
    private String employeename;//员工姓名
    private Boolean sex;//性别
    private String identitycard;//身份证
    private String birthday;//生日
    private String telephone;//电话
    private String photo;//照片
    private Boolean employeetype;//员工类型
    private String position;//岗位
    //private java.sql.Timestamp entrytime;//入职时间
    //private java.sql.Timestamp departuretime;//离职时间

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")
    private Date entrytime;//入职时间

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")
    private Date departuretime;//离职时间

    private String drivingnumbwe;//驾驶证号

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date initialdate;//初领日期

    private String idcardaddress;//身份证地址
    private String location;//居住地址
    private String sorting;//排序
    private Boolean workingbit;//在职否
    private Boolean coachbit;//教练否
    private BigDecimal concessional;//可优惠金额
    //private java.sql.Timestamp laborstarttime;//劳动合同开始时间
    //private java.sql.Timestamp laborendtime;//劳动合同结束时间

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date laborstarttime;//劳动合同开始时间

    @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
    @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
    private Date laborendtime;//劳动合同结束时间

    private String username;//用户昵称
    private String account;//账号
    private String cipher;//密码
    private Boolean effectivebit;//用户生效否

    private String employeegroupingname;//员工分组名称

    private Integer parentdepartmentID;//部门父ID
    private String departmentname;//部门名称
    private String linkman;//联系人
    private String departmentphone;//电话
    private String sequence;//部门排序

    private String rolename;//角色名称
    private String rolesort;//角色排序

    private String registrationpointname;//报名点名称
    private String address;//地址
    private String bycoachbit;//学员分教练否
    private String enablebie;//启用否
    private String sortnumber;//排序序号
    private String phone;//电话

    private Integer coachid;//教练ID
    private Integer modelid;//车型ID
    private Integer subjecttwotrainingid;//科二训练场ID
    private Integer subjectthreetrainingid;//科三训练场ID
    //private Integer subjectid;//科目ID
    private String subjects;//科目
    private Integer vehicleid;//车辆ID
    private String coachtype;//类型
    private String trainpeople;//培训人数
    private String senioritynumber;//资格证号

    private String senioritygrade;//资格等级
    private String introduce;//教练介绍
    private Boolean splitcarbit;//自动分车
    private Boolean appcarbit;//app车辆管理

    //--------------------------//
    //private String drivingid;//校区ID
    private Integer drivingmodelid;//准驾车型ID

    private Integer teachingmodelid;//准教车型ID
}
