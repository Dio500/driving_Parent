package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

@Data
public class TbAboutclass {
  @Id
  //主键回填
  @KeySql(useGeneratedKeys = true)
  private long aboutclassid;
  private long appointmentrulesdetailid;
  private double subjecttwohours;
  private double subjectthreehours;
  private double subjecttwousehours;
  private double subjectthreeusehours;
}
