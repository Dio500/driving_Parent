package com.gx.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
/*@Table(name = "tb_user")*/
public class TbUser {
    private Integer userid;//用户ID
    private Integer roleid;//角色ID
    private String username;//用户名
    private String account;//账号
    private String cipher;//密码
    private Boolean effectivebit;//生效否
    private BigDecimal concessional;//可优惠金额
}
