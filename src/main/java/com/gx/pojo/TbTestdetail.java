package com.sample;


public class TbTestdetail {

  private long testDetailId;
  private long testRoomId;
  private long testId;
  private String subjectResult;
  private java.sql.Timestamp testTtime;


  public long getTestDetailId() {
    return testDetailId;
  }

  public void setTestDetailId(long testDetailId) {
    this.testDetailId = testDetailId;
  }


  public long getTestRoomId() {
    return testRoomId;
  }

  public void setTestRoomId(long testRoomId) {
    this.testRoomId = testRoomId;
  }


  public long getTestId() {
    return testId;
  }

  public void setTestId(long testId) {
    this.testId = testId;
  }


  public String getSubjectResult() {
    return subjectResult;
  }

  public void setSubjectResult(String subjectResult) {
    this.subjectResult = subjectResult;
  }


  public java.sql.Timestamp getTestTtime() {
    return testTtime;
  }

  public void setTestTtime(java.sql.Timestamp testTtime) {
    this.testTtime = testTtime;
  }

}
