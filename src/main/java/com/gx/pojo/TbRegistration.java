package com.gx.pojo;

import lombok.Data;
import java.util.Date;

@Data
public class TbRegistration {

  private Integer registrationid;//报名ID
  private Integer registrationpointid;//报名点ID
  private Integer orddrivingid;//原驾车型ID
  private Integer sourceenrollmentid;//招生来源ID
  private String referralName;//介绍人名称
  private Date registrationtime;//报名时间
  private String ordDrivingNumber;//原驾驶证号
  private String registrationbit;//报名状态
}
