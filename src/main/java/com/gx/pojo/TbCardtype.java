package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

@Data
public class TbCardtype {
  private Integer cardtypeid;
  private String cardtype;
}
