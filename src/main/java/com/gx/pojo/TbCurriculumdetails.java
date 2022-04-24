package com.sample;


public class TbCurriculumdetails {

  private long courseDetailsId;
  private long courseId;
  private java.sql.Timestamp courseBeginTime;
  private java.sql.Timestamp courseFinishTime;
  private String disparkBit;
  private String subscribePeople;


  public long getCourseDetailsId() {
    return courseDetailsId;
  }

  public void setCourseDetailsId(long courseDetailsId) {
    this.courseDetailsId = courseDetailsId;
  }


  public long getCourseId() {
    return courseId;
  }

  public void setCourseId(long courseId) {
    this.courseId = courseId;
  }


  public java.sql.Timestamp getCourseBeginTime() {
    return courseBeginTime;
  }

  public void setCourseBeginTime(java.sql.Timestamp courseBeginTime) {
    this.courseBeginTime = courseBeginTime;
  }


  public java.sql.Timestamp getCourseFinishTime() {
    return courseFinishTime;
  }

  public void setCourseFinishTime(java.sql.Timestamp courseFinishTime) {
    this.courseFinishTime = courseFinishTime;
  }


  public String getDisparkBit() {
    return disparkBit;
  }

  public void setDisparkBit(String disparkBit) {
    this.disparkBit = disparkBit;
  }


  public String getSubscribePeople() {
    return subscribePeople;
  }

  public void setSubscribePeople(String subscribePeople) {
    this.subscribePeople = subscribePeople;
  }

}
