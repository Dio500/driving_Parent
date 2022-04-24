package com.gx.pojo;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class TbTrainingground {

  private Integer trainingGroundId;
  private Integer organizationId;
  private Integer subjectId;
  private Integer modelId;
  private String trainingGroundName;
  private String phone;
  private String accommodatingVehicle;
  private String droppingVehicle;
  private String address;
  private BigDecimal area;
  private String picture;
  private String sortNumber;
  private String enabledBit;

}
