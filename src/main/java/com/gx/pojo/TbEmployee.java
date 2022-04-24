package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class TbEmployee {
  @Id
  private Integer employeeid;
  //主键回填
  @KeySql(useGeneratedKeys = true)

  private Integer userid;//用户id
  private Integer employeegroupingid;//员工分组id
  private Integer registrationpointid;//报名点id
  private Integer organizationid;//机构id
  private Integer roleid;//角色ID
  private String employeename;//员工姓名
  private Boolean sex;//性别
  private String identitycard;//身份证
  private String birthday;//生日
  private String telephone;//电话
  private String photo;//照片
  private Boolean employeetype;//员工类型
  private String position;//岗位

  private Date entrytime;//入职时间
  private Date departuretime;//离职时间
  private Date laborstarttime;//劳动合同开始时间
  private Date laborendtime;//劳动合同结束时间

  private String drivingnumbwe;//驾驶证号
  private String initialdate;//初领日期
  private String idcardaddress;//身份证地址
  private String location;//居住地址
  private String sorting;//排序
  private Boolean workingbit;//在职否
  private Boolean coachbit;//教练否

  public TbEmployee(Integer userid, Integer employeegroupingid, Integer registrationpointid, Integer organizationid, Integer roleid, String employeename, Boolean sex, String identitycard, String birthday, String telephone, String photo, Boolean employeetype, String position, Date entrytime, Date departuretime, Date laborstarttime, Date laborendtime, String drivingnumbwe, String initialdate, String idcardaddress, String location, String sorting, Boolean workingbit, Boolean coachbit) {
    this.userid = userid;
    this.employeegroupingid = employeegroupingid;
    this.registrationpointid = registrationpointid;
    this.organizationid = organizationid;
    this.roleid = roleid;
    this.employeename = employeename;
    this.sex = sex;
    this.identitycard = identitycard;
    this.birthday = birthday;
    this.telephone = telephone;
    this.photo = photo;
    this.employeetype = employeetype;
    this.position = position;
    this.entrytime = entrytime;
    this.departuretime = departuretime;
    this.laborstarttime = laborstarttime;
    this.laborendtime = laborendtime;
    this.drivingnumbwe = drivingnumbwe;
    this.initialdate = initialdate;
    this.idcardaddress = idcardaddress;
    this.location = location;
    this.sorting = sorting;
    this.workingbit = workingbit;
    this.coachbit = coachbit;
  }

  public TbEmployee() {
    super();
  }
}
