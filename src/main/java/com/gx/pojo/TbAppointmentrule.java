package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

@Data
public class TbAppointmentrule {
  @Id
  //主键回填
  @KeySql(useGeneratedKeys = true)
  private long appointmentruleid;
  private String rulename;
  private String enabledbie;

}
