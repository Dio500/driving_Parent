package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import java.math.BigDecimal;

@Data
public class fromEmployee {
    private String employeename;//员工姓名
    private String telephone;//电话
    private String employeetype;//员工类型
    private String identitycard;//身份证
    private String birthday;//生日
    private String sex;//性别
    private Integer departmentid;//部门ID
    private String position;//岗位
    private String drivingid;//校区ID
    private String workingbit;//在职否
    private java.sql.Timestamp entrytime;//入职时间
    private java.sql.Timestamp departuretime;//离职时间
    private String drivingnumbwe;//驾驶证号
    private String initialdate;//初领日期
    private Integer drivingmodelid;//准驾车型ID
    private String location;//地址


    private Integer teachingmodelid;//准教车型ID

    private String sorting;//排序

    private String coachbit;//教练否
    private BigDecimal concessional;//可优惠金额

    private String employeegroupingname;//员工分组名称

    private String organizationname;//机构名称

    private String departmentname;//部门名称

    private String rolename;//角色名称

    private String registrationpointname;//报名点名称
    private String address;//地址
    private String bycoachbit;//学员分教练否
    private String enablebie;//启用否
    private String sortnumber;//排序序号
    private String phone;//电话

    private Integer coachid;//教练ID

    private Integer traininggroundid;//训练场ID
    private Integer subjectid;//科目ID
    private Integer vehicleid;//车辆ID
    private String coachtype;//类型
    private String trainpeople;//培训人数
    private String senioritynumber;//资格证号

    private String senioritygrade;//资格等级
    private String introduce;//教练介绍
    private Boolean splitcarbit;//自动分车
    private Boolean appcarbit;//app车辆管理
}
