package com.gx.pojo;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class TbClasscost {

  private Integer classcostid;
  private Integer classid;
  private Integer fundid;
  private BigDecimal classcostmoney;

}
