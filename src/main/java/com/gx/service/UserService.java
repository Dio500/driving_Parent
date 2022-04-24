package com.gx.service;

import com.gx.mapper.UserMapper;
import com.gx.pojo.TbUser;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

//业务层
@Service
public class UserService {
    @Resource
    private UserMapper userMapper;

    //根据账号查询用户
    public TbUser queryById(String account){
        TbUser user = new TbUser();
        user.setAccount(account);
        return userMapper.selectOne(user);
    }
}
