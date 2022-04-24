package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

@Data
public class TbCarexpense {
  @Id
  //主键回填
  @KeySql(useGeneratedKeys = true)
  private long carexpenseid;
  private long vehicleid;
  private double amount;
  private java.sql.Timestamp time;
  private String remark;

}
