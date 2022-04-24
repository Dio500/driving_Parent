package com.gx.pojo;

import lombok.Data;

import javax.persistence.Table;

@Data
@Table(name = "tb_coach")
public class TbCoach {

  private Integer coachid;
  private Integer employeeid;
  private Integer modelid;
  private Integer traininggroundid;
  private Integer vehicleid;
  private String subjects;
  private String coachtype;
  private String trainpeople;
  private String senioritynumber;
  private String senioritygrade;
  private String introduce;
  private Boolean splitcarbit;
  private Boolean appcarbit;

  public TbCoach() {
    super();
  }

  public TbCoach(Integer employeeid, Integer modelid, Integer traininggroundid, String subjects, Integer vehicleid, String coachtype, String trainpeople, String senioritynumber, String senioritygrade, String introduce, Boolean splitcarbit, Boolean appcarbit) {
    this.employeeid = employeeid;
    this.modelid = modelid;
    this.traininggroundid = traininggroundid;
    this.subjects = subjects;
    this.vehicleid = vehicleid;
    this.coachtype = coachtype;
    this.trainpeople = trainpeople;
    this.senioritynumber = senioritynumber;
    this.senioritygrade = senioritygrade;
    this.introduce = introduce;
    this.splitcarbit = splitcarbit;
    this.appcarbit = appcarbit;
  }
}
