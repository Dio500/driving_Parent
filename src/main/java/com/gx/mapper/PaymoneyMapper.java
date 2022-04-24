package com.gx.mapper;

import com.gx.pojo.TbPaymoney;
import com.gx.pojo.TbStudent;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

public interface PaymoneyMapper {

    List<TbPaymoney> SelectPaymoney();

}
