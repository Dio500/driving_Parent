package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

@Data
public class TbAboutclassdetails {

  @Id
  //主键回填
  @KeySql(useGeneratedKeys = true)
  private long aboutclassdetailsid;
  private long aboutclassid;
  private long coursedetailsid;

}
