package com.gx.pojo;

import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class TbCourse {

  private Integer courseId;
  private String courseName;
  private String enabledBit;
}
