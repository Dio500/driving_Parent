package com.gx.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class TbApplication {
  private Integer applicationid;
  private Integer studentid;
  private Integer modelid;
  private Integer classid;
  private Integer paymenttypeid;
  private Integer userid;
  private BigDecimal applicationmoney;
  private String introducer;
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")//入参格式化
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" ,timezone = "GMT+8")//出参格式化
  private Date applicationtime;
  private String applicationreason;
  private Integer applicationtype;
  private String applicationreferral;
  private Integer applicationstatus;
  private Integer ordmodelid;
  private Integer ordclassid;

  private Integer pamoneyid;
}
