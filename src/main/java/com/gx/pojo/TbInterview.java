package com.gx.pojo;

import lombok.Data;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class TbInterview {

  private Integer interviewId;
  private Date interviewTime;
  private String interviewBit;
  private String interviewRemarks;
}
