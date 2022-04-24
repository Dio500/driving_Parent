package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import java.math.BigDecimal;

@Data
public class TbClass {

  private Integer classid;
  private Integer classgroupingid;
  private Integer modelid;
  private Integer organizationid;
  private String classname;
  private BigDecimal classprice;
  private String pricedescription;
  private String fastesttime;
  private String subjecttwocarallot;
  private String subjectthreecarallot;
  private String classdescription;
  private String pickupform;
  private String optionalcoachbit;
  private String onlinedisplaybit;
  private String enablebit;
  private String sortnumber;

}
