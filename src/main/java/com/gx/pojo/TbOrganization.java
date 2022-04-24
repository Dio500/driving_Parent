package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

//机构表
@Data
public class TbOrganization {

  @Id
  private Integer organizationid;

  private Integer departmentid;
  private String organizationname;
}
