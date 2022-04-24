package com.gx.controller;

import com.gx.mapper.EmployeeMapper;
import com.gx.mapper.UserMapper;
import com.gx.pojo.EmployeeManage;
import com.gx.pojo.StudentManage;
import com.gx.pojo.TbJurisdictions;
import com.gx.pojo.TbUser;
import com.gx.service.UserService;
import com.gx.ValidateImage.GifCaptcha;
import com.gx.utils.JsonReturn;
import com.gx.utils.JsonReturns;
import com.gx.utils.Layui;
import com.gx.utils.PageBean;
import com.sun.deploy.net.URLEncoder;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.annotation.Reference;
import org.springframework.http.HttpCookie;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("LoginServlet")
public class LoginCorrelation {
    @Autowired
    private UserService userService;
    @Resource
    private EmployeeMapper employeeMapper;

    //登录
    @RequestMapping({"", "Login"}) //为空或者是Login都能进入该方法
    public ModelAndView Login(HttpServletRequest request){
        ModelAndView mv = new ModelAndView("/login");
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for (Cookie Cookies:cookies) {
                //System.out.println(Cookies.getName()+"----"+Cookies.getValue());
                request.setAttribute(Cookies.getName(),Cookies.getValue());
            }
        }
        return mv;
    }

    //生成验证码方法
    @GetMapping("Identity")
    public void identity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // com.ValidateImage.GifCaptcha,（宽，高，长度）
        GifCaptcha captcha = new GifCaptcha(200, 60, 5);
        ServletOutputStream out = response.getOutputStream();
        String keyString = captcha.out(out);// 验证码类随机字符串方法
        out.close();
        // 存到Session
        request.getSession().setAttribute("validCode", keyString);
        System.out.println("验证码为："+keyString);
    }

    //登录方法
    @RequestMapping(value = "MemBtnLogin",produces = "application/json; charset=utf-8")
    private JsonReturns<TbUser> MemBtnLogin(HttpServletResponse response,HttpServletRequest request,String Account,String PassWord,String ValidCode,String RememberMe) {
        JsonReturns<TbUser> jsonReturn = new JsonReturns();
        //创建session
        HttpSession session = request.getSession();
        // 取出Session中的验证码
        String sessionCode = session.getAttribute("validCode").toString();
        // equalsIgnoreCase忽略大小写
        if(sessionCode.equalsIgnoreCase(ValidCode)){

            TbUser user = userService.queryById(Account);
            // 没有该账号将执行catch
            try {
                // 密码
                if (PassWord.equalsIgnoreCase(user.getCipher().trim())) {
                    // 是否生效
                    if (user.getEffectivebit() == true) {
                        //创建Cookie对象
                        /*Cookie cookie1 = new Cookie("CookieAccount",user.getAccount());//账号
                        cookie1.setPath("/");
                        cookie1.setMaxAge(68400*7);
                        response.addCookie(cookie1);//响应Cookie信息*/

                        List cookielist =  new ArrayList<>();
                        cookielist.add(user);
                        jsonReturn.setRememberme(RememberMe);//记住否
                        jsonReturn.setDate(cookielist);//返回的数据

                        List<TbJurisdictions> module = employeeMapper.tablemodule(user.getRoleid());//查询模块

                        JSONArray ModuleObj = new JSONArray();//模块数组[]
                        JSONArray FunctionObj = new JSONArray();//功能数组[]
                        for (TbJurisdictions list:module) {
                            JSONObject obj = new JSONObject();//键值对集合
                            obj.put("moduleDetailsIDs",list.getModuledetailsids());//模块明细ID
                            obj.put("typeNames",list.getTypenames());//明细类型名称
                            obj.put("usingBits",list.getUsingbits());//模块权限状态
                            obj.put("moduleID",list.getModuleid());//模块ID
                            obj.put("parentModuleID",list.getParentmoduleid());//模块副ID
                            obj.put("parentModuleName",list.getModulename());//模块名称
                            if(list.getParentmoduleid() == 0){
                                ModuleObj.put(obj);
                            }else {
                                FunctionObj.put(obj);
                            }
                        }
                        //保存权限数据到session
                        session.setAttribute("ModuleObj", ModuleObj);//模块数组
                        session.setAttribute("FunctionObj", FunctionObj);//功能数组
                        session.setAttribute("SessionRoleID", user.getRoleid());//角色ID

                        //request.getSession().getServletContext().setAttribute();
                        jsonReturn.setState(true);
                        jsonReturn.setMsg("登录成功");
                    } else {
                        jsonReturn.setMsg("该用户已被禁用，无法登陆！");
                    }
                } else {
                    jsonReturn.setMsg("请输入正确的账号或密码");
                }
            } catch (Exception e) {
                jsonReturn.setMsg("用户不存在");
            }
        }else {
            jsonReturn.setMsg("请输入正确的验证码");
        }
        return jsonReturn;
    }

    //页面跳转
    @ResponseBody
    @RequestMapping("RoleMouble")
    public ModelAndView RoleMouble(HttpServletRequest request,String JSPurl){
        ModelAndView mv= new ModelAndView(JSPurl);
        return mv;
    }

    //学生信息回填
    /*@ResponseBody
    @RequestMapping("selectSession")
    public List<TbJurisdictions> selectSession(HttpServletRequest request) {
        //获取权限Session的数据
        List<TbJurisdictions> sessionList = (List<TbJurisdictions>)request.getSession().getAttribute("roleJurisdictions");
        return sessionList;
    }*/
}
