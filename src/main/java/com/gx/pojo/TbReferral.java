package com.sample;


public class TbReferral {

  private long referralId;
  private String name;
  private String telephone;
  private String referralType;
  private String enrollmentNumber;
  private String description;


  public long getReferralId() {
    return referralId;
  }

  public void setReferralId(long referralId) {
    this.referralId = referralId;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getTelephone() {
    return telephone;
  }

  public void setTelephone(String telephone) {
    this.telephone = telephone;
  }


  public String getReferralType() {
    return referralType;
  }

  public void setReferralType(String referralType) {
    this.referralType = referralType;
  }


  public String getEnrollmentNumber() {
    return enrollmentNumber;
  }

  public void setEnrollmentNumber(String enrollmentNumber) {
    this.enrollmentNumber = enrollmentNumber;
  }


  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

}
