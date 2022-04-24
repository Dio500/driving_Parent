package com.gx.pojo;

import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class TbPaymoney {

  private Integer pamoneyid;
  private Integer studentid;
  private BigDecimal needpaymenttotalmoney;
  private BigDecimal paymenttotalmoney;
  private BigDecimal discounttotalmoney;
  private String ticketnumber;
  private Boolean arrearagebit;
}
