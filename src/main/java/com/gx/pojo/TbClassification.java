package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;

@Data
public class TbClassification {

  @Id
  //主键回填
  @KeySql(useGeneratedKeys = true)
  private double classificationid;
  private long studentid;
  private long vehicleid;
  private long subjectid;
  private java.sql.Timestamp classificationtime;
  private java.sql.Timestamp boardingtime;
  private String boardingbit;
  private String classificationstatus;

}
