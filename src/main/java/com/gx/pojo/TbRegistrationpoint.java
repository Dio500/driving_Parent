package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class TbRegistrationpoint {

  private Integer registrationpointid;
  private String registrationpointname;
  private String phone;
  private String address;
  private String bycoachbit;
  private String enablebie;
  private String sortnumber;
}
