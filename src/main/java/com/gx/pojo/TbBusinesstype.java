package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

@Data
public class TbBusinesstype {

  @Id
  //主键回填
  @KeySql(useGeneratedKeys = true)
  private long businesstypeid;
  private String businesstype;

}
