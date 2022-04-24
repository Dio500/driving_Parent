package com.gx.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Data
public class TbStudent {
  private Integer studentid;//
  private Integer classid;
  private Integer cardtypeid;
  private Integer studentgroupid;
  private Integer employeeid;
  private Integer traininggroundid;
  private Integer healthid;
  private Integer interviewid;
  private Integer acceptanceid;
  private Integer registrationid;
  private Integer courseid;
  private String name;
  private Boolean sex;
  private String nationality;
  private String identitycard;
  @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
  @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
  private Date idcardvaliditydate;

  @DateTimeFormat(pattern = "yyyy-MM-dd")//入参格式化
  @JsonFormat(pattern = "yyyy-MM-dd" ,timezone = "GMT+8")//出参格式化
  private Date birthday;
  private String studystate;
  private String phoneone;
  private String phonetwo;
  private String photograph;
  private String idcardaddress;
  private String residentialaddress;
  private String numbers;
}
