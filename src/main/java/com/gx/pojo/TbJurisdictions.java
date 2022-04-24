package com.gx.pojo;

import lombok.Data;

@Data
public class TbJurisdictions {

  private Integer jurisdictionsid;//权限ID
  private Integer roleid;//角色ID
  private Integer moduledetailsid;//模块明细ID
  private Integer usingbit;//启用否

  private Integer moduleid;//模块ID
  private Integer moduledetailstypeid;//模块明细类型ID
  //private String moduledetailsname;//模块明细名称

  private String moduledetailstypename;//模块明细类型名称

  private Integer parentmoduleid;//模块明细副ID
  private String modulename;//模块名称

  //private String moduledetailsnames;//模块明细名称别名
  private String moduledetailsids;//模块明细ID别名
  private String jurisdictionsids;//权限ID别名
  private String typenames;//明细类型名称别名
  private String usingbits;//启用否别名
}
