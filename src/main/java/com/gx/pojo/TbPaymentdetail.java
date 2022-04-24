package com.gx.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TbPaymentdetail {

  private Integer paymentdetailid;//缴费明细id
  private Integer paymenttypeid;//支付类型id
  private Integer userid;//用户id
  private Integer classid;//班级id
  private Integer fundid;//款项id
  private Integer pamoneyid;//缴费id
  private BigDecimal requiredamount;//需缴金额
  private BigDecimal paymentamount;//缴费金额
  //private BigDecimal arrearsmount;//欠费金额
  private BigDecimal preferentialamount;//优惠金额
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")//入参格式化
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" ,timezone = "GMT+8")//出参格式化
  private Date paymenttime;//缴费时间
  private String preferences;//优惠理由
  private Integer preferentialstatus;//优惠审核状态
  private String paymentremarks;//备注
  private Boolean entrytype;//入账类型
  private Boolean entrybit;//入账否
}
