package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

@Data
public class TbAppointmentrulesdetail {
  @Id
  //主键回填
  @KeySql(useGeneratedKeys = true)
  private long appointmentrulesdetailid;
  private long appointmentruleid;
  private String choosescopebit;
  private String appointmentconditions;
  private String appointmenttime;
  private String appointmentdays;
  private String maximumlength;
  private String dailytotalnumber;
  private String weeklytotalnumber;
  private String howhournotcancelled;
  private String enabledbit;

}
