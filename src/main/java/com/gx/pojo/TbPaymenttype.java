package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class TbPaymenttype {

  private Integer paymentTypeId;
  private String paymentType;
}
