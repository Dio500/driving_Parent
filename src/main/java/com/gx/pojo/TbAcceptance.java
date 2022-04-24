package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import java.util.Date;

@Data
public class TbAcceptance {

  private Integer acceptanceid;
  private Date acceptancetime;
  private String acceptancebit;
  private String acceptanceremarks;

}
