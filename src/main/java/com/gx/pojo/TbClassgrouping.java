package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

@Data
public class TbClassgrouping {

  @Id
  //主键回填
  @KeySql(useGeneratedKeys = true)
  private long classgroupingid;
  private String classgroupingname;

}
