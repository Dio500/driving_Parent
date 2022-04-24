package com.gx.controller;

import com.gx.mapper.EmployeeMapper;
import com.gx.pojo.*;
import com.gx.utils.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.function.Predicate;

@RestController
@RequestMapping("EmployeeController")
public class EmployeeController {

    @Resource
    private EmployeeMapper employeeMapper;
/*
    @Resource
    private SelectXLK selectXLK;
*/

    SelectXLK xlk = new SelectXLK();

    //TbStudent tbStudent = new TbStudent();

    //驾校下拉框
    @ResponseBody
    @RequestMapping("SelectFramework")
    public List<SelectVo> SelectFramework(){
        List<SelectVo> framework = employeeMapper.selectDepartment(0);//查询驾校
        ArrayList<SelectVo> selectList = xlk.selectXLK(framework,"请选择驾校",0);
        return selectList;
    }

    //角色下拉框
    @ResponseBody
    @RequestMapping("SelectRole")
    public List<SelectVo> SelectRole(){
        List<SelectVo> role = employeeMapper.selectRole();
        ArrayList<SelectVo> selectList = xlk.selectXLK(role,"请选择角色",0);
        return selectList;
    }

    //部门（机构）下拉框
    @ResponseBody
    @RequestMapping("SelectDepartment")
    public List<TreeResult> SelectDepartment(@RequestParam(name = "selectIds",required = false) List<String> selectIds) {
        //获取数据
        List<TreeResult> treeResults = employeeMapper.TreeDepartment();
        for (TreeResult treeResult : treeResults) {
            treeResult.setDisabled(treeResult.getPvalue().equalsIgnoreCase("0"));
        }
        TreePlusUtil menuTree =new TreePlusUtil(treeResults,selectIds);
        //此处需要你填写父级value值，可根据实际自行更改
        Predicate<TreeResult> predicate = TreeResult -> TreeResult.getPvalue().equalsIgnoreCase("0");
        List<TreeResult> list =menuTree.builTree(predicate);
        return list;
    }

    //驾校回填
    @ResponseBody
    @RequestMapping("SelectSchool")
    public TbDepartment SelectSchool(Integer parentID){
        TbDepartment data = new TbDepartment();
        TbDepartment tbDepartment = employeeMapper.selectSchool(parentID);
        if(tbDepartment.getParentdepartmentid()!=0){
            TbDepartment tbDepartments = employeeMapper.selectSchool(tbDepartment.getParentdepartmentid());
            data=tbDepartments;
        }
        else {
            data=tbDepartment;
        }
        return data;
    }

    //车型下拉框
    @ResponseBody
    @RequestMapping("SelectModel")
    public List<SelectVo> SelectModel(){
        List<SelectVo> model = employeeMapper.selectModel();
        ArrayList<SelectVo> selectList = xlk.selectXLK(model,"请选择车型",1);
        return selectList;
    }

    //科目下拉框
    @ResponseBody
    @RequestMapping("SelectSubjects")
    public List<SelectVo> SelectSubjects(){
        List<SelectVo> subjects = employeeMapper.selectSubjects();
        ArrayList<SelectVo> selectList = xlk.selectXLK(subjects,"",0);
        return selectList;
    }

    //车辆下拉框
    @ResponseBody
    @RequestMapping("SelectCar")
    public List<SelectVo> SelectCar(){
        List<SelectVo> car = employeeMapper.selectCar();
        ArrayList<SelectVo> selectList = xlk.selectXLK(car,"请选择车辆",1);
        return selectList;
    }

    //训练场下拉框
    @ResponseBody
    @RequestMapping("SelectTraining")
    public List<SelectVo> SelectTraining(){
        List<SelectVo> training = employeeMapper.selectTraining();
        ArrayList<SelectVo> selectList = xlk.selectXLK(training,"请选择训练场",1);
        return selectList;
    }

    //员工查询
    @ResponseBody
    @RequestMapping("SelectEmployee")
    public Layui SelectEmployee(Integer page, Integer limit,
           String Employeenumber,Integer Framework,Integer Role,Boolean Working,Boolean Account,Boolean Employeetype){
        /*System.out.println(Employeenumber+"--"+Framework+"--"+Role+"--"+Working+"--"+Account+"--"+Employeetype);*/
        System.out.println(Framework);

        // 查询员工信息
        List<EmployeeManage> listemployee = employeeMapper.selectEmployee(Employeenumber,Framework,Role,Working,Account,Employeetype);

        PageService<EmployeeManage> fam = new PageService<EmployeeManage>();
        PageBean<EmployeeManage> pages = fam.findByPage(listemployee, page, limit);// 分页
        return Layui.data(pages);
    }

    //学员新增
    @ResponseBody
    @RequestMapping("InsertEmployee")
    public JsonReturn InsertEmployee(EmployeeManage dates){
        JsonReturn jsonReturn = new JsonReturn();
        Boolean zhangHao = false;// 账号状态
        Boolean idCard = false;// 身份证状态

        //账号否状态
        if(dates.getEffectivebit()==null){ dates.setEffectivebit(false);}
        //教练否状态
        if(dates.getCoachbit()==null){ dates.setCoachbit(false); }
        //教练自动分车状态
        if(dates.getSplitcarbit()==null){ dates.setSplitcarbit(false); }
        //app车辆管理状态
        if(dates.getAppcarbit()==null){ dates.setAppcarbit(false); }

        List<EmployeeManage> listmember = employeeMapper.selectEmployee();//员工查询

        for (EmployeeManage listmembers : listmember) {
            // 身份证是否重复
            if (listmembers.getIdentitycard().equals(dates.getIdentitycard())) {
                idCard = true;
            }
            if(listmembers.getUserid() !=0 && dates.getEffectivebit()==true){
                // 账号是否重复
                if (listmembers.getAccount().equals(dates.getAccount())) {
                    zhangHao = true;
                }
            }
        }

        //身份证不重复
        if(idCard==false){
            //账号不重复
            if(zhangHao==false){
                //新增用户
                if(dates.getEffectivebit()==true){
                    dates.setUsername("用户" + dates.getTelephone());
                    employeeMapper.insertUser(dates);
                }
                else {
                    dates.setUserid(0);
                }
                //新增员工
                int addemployee =employeeMapper.insertEmployee(dates);

                if(addemployee>0){
                    //新增教练
                    if(dates.getCoachbit()==true){
                        int addcoach = employeeMapper.insertCoach(dates);

                        if(addcoach>0){
                            jsonReturn.setMsg("新增成功!");
                            jsonReturn.setState(true);
                        }else{
                            jsonReturn.setMsg("教练表新增失败");
                        }
                    }
                    else{
                        jsonReturn.setState(true);
                        jsonReturn.setMsg("新增成功！");
                    }
                }else {
                    jsonReturn.setMsg("员工表新增失败");
                }
            }else {
                jsonReturn.setMsg("已有对应的账号，可以直接登陆！");
            }
        } else {
            jsonReturn.setMsg("身份证与已有的用户身份证一致，请检查是否输入错误或已注册过账号！");
        }
        return jsonReturn;
    }

    //学员信息回填
    @ResponseBody
    @RequestMapping("BackfillEmployee")
    public EmployeeManage BackfillEmployee(Integer EmployeeID){
        EmployeeManage listemployee = employeeMapper.backfillEmployee(EmployeeID);//查询员工数据
        //System.out.println(listemployee);
        return listemployee;
    }

    //学员信息修改
    @ResponseBody
    @RequestMapping("UpdateEmployee")
    public JsonReturn UpdateEmployee(EmployeeManage dates){
        JsonReturn jsonReturn = new JsonReturn();
        EmployeeManage oldDate = employeeMapper.backfillEmployee(dates.getEmployeeid());//查询员工数据

        //账号否状态
        if(dates.getEffectivebit()==null){ dates.setEffectivebit(false); }
        if(oldDate.getEffectivebit()==null){ oldDate.setEffectivebit(false); }
        //教练否状态
        if(dates.getCoachbit()==null){ dates.setCoachbit(false); }
        if(oldDate.getCoachbit()==null){ oldDate.setCoachbit(false); }

        if(dates.getEffectivebit()==true && oldDate.getEffectivebit()==false){
            employeeMapper.insertUser(dates);//新增用户
        }
        else if(dates.getEffectivebit()==false && oldDate.getEffectivebit()==true){
            employeeMapper.deleteUser(oldDate.getUserid());//删除用户
        }
        else {
            employeeMapper.updateUser(dates);//修改用户
        }

        int updateEmployee = employeeMapper.updateEmployee(dates);//修改员工

        if(updateEmployee>0){
            //修改教练
            if(dates.getCoachbit()==true && oldDate.getCoachbit()==false){
                employeeMapper.insertCoach(dates);//新增教练
            }
            else if(dates.getCoachbit()==false && oldDate.getCoachbit()==true){
                employeeMapper.deleteCoach(oldDate.getCoachid());//删除
            }
            else{
                employeeMapper.updateCoach(dates);//修改教练
            }
        }else {
            jsonReturn.setMsg("员工表修改失败");
        }

        jsonReturn.setState(true);
        jsonReturn.setMsg("修改成功！");
        return jsonReturn;
    }

    //学员删除
    @ResponseBody
    @RequestMapping("DeleteEmployee")
    public JsonReturn DeleteEmployee(Integer EmployeeID){
        JsonReturn jsonReturn = new JsonReturn();
        EmployeeManage dates = employeeMapper.backfillEmployee(EmployeeID);//查询员工数据
        //System.out.println(dates);
        if(dates.getUserid()!=null){
            employeeMapper.deleteUser(dates.getUserid());//删除用户数据
        }
        if(dates.getCoachid()!=null){
            employeeMapper.deleteCoach(dates.getCoachid());//删除教练数据
        }
        int DeleteEmployee = employeeMapper.deleteEmployee(dates.getEmployeeid());//删除员工数据
        if(DeleteEmployee>0){
            jsonReturn.setState(true);
            jsonReturn.setMsg("删除成功！");
        }
        return jsonReturn;
    }

    /*-------------------------------------部门管理---------------------------------------*/

    //部门数据查询
    @ResponseBody
    @RequestMapping("TableDepartment")
    public Layui TableDepartment(){
        List<TbDepartment> department = employeeMapper.tableDepartment(0,0);//查询部门
        PageBean<TbDepartment> pages = new PageBean<TbDepartment>();
        pages.setData(department);
        pages.setTotalRows(department.size());
        return Layui.data(pages);
    }

    //回填部门上级
    @ResponseBody
    @RequestMapping("backfillHigher")
    public List<TbDepartment> backfillHigher(Integer DepartmentID, Integer parentHigher){
        List<TbDepartment> departments = new ArrayList<>();

        List<TbDepartment> departmentone = employeeMapper.tableDepartment(DepartmentID,0);//当前行数据
        //修改回填
        if(parentHigher == 1){
            departments.add(departmentone.get(0));
            //有父ID
            if(departmentone.get(0).getParentdepartmentid()!=0){
                List<TbDepartment> departmenttwo = employeeMapper.tableDepartment(0,departmentone.get(0).getParentdepartmentid());//父行数据
                departments.add(departmenttwo.get(0));
            }
            else {
                departments=departmentone;
            }
        }else {
            departments= departmentone;
        }
        return departments;
    }

    //部门新增/修改
    @ResponseBody
    @RequestMapping("IUDepartment")
    public JsonReturn IUDepartment(Integer DepartmentID, String Name, String Linkman, String Phone, String Sequence,Boolean IUbit){
        JsonReturn jsonReturn = new JsonReturn();
        int IUDepartment;//新增、修改条数
        String Msgtext;
        if (IUbit==true){
            IUDepartment = employeeMapper.insertDepartment(DepartmentID,Name,Linkman,Phone,Sequence);//新增部门
            Msgtext="新增";

        }else {
            IUDepartment = employeeMapper.updateDepartment(DepartmentID,Name,Linkman,Phone,Sequence);//修改部门
            Msgtext="修改";
        }
        if(IUDepartment>0){
            jsonReturn.setState(true);jsonReturn.setMsg(Msgtext+"成功！");
        }else{
            jsonReturn.setMsg(Msgtext+"失败！");
        }
        return jsonReturn;
    }

    //部门删除
    @ResponseBody
    @RequestMapping("DeleteDepartment")
    public JsonReturn DeleteDepartment(Integer DepartmentID){
        JsonReturn jsonReturn = new JsonReturn();

        Integer departmentone = employeeMapper.hasSonDepartment(DepartmentID);//查询是否有子数据
        if(departmentone==0){
            int deleteDepartment = employeeMapper.deleteDepartment(DepartmentID);//删除部门
            if(deleteDepartment>0){
                jsonReturn.setState(true);
                jsonReturn.setMsg("删除成功！");
            }else {
                jsonReturn.setMsg("删除失败！");
            }
        }else {
            jsonReturn.setMsg("该数据存在子数据，不能进行删除！");
        }
        return jsonReturn;
    }

    /*-------------------------------------角色管理---------------------------------------*/

    //角色表查询
    @ResponseBody
    @RequestMapping("TableRole")
    public Layui TableRole(Integer page, Integer limit, String Rolename){
        // 查询员工信息
        List<TbRole> listemployee = employeeMapper.tableRole(0,Rolename);

        PageService<TbRole> fam = new PageService<TbRole>();
        PageBean<TbRole> pages = fam.findByPage(listemployee, page, limit);// 分页
        return Layui.data(pages);
    }

    //回填部门上级
    @ResponseBody
    @RequestMapping("backfillRole")
    public List<TbRole> backfillRole(Integer RoleID){
        List<TbRole> roleone = employeeMapper.tableRole(RoleID,"");//当前行数据
        return roleone;
    }

    //角色新增/修改
    @ResponseBody
    @RequestMapping("IURole")//Integer RoleID, String Name, String RoleSort
    public JsonReturn IURole(TbRole tbRole,Boolean IUbit){
        JsonReturn jsonReturn = new JsonReturn();
        int IURole=0;//新增、修改条数
        String Msgtext;
        if (IUbit==true){
            IURole = employeeMapper.insertRole(tbRole);//新增角色
            Msgtext="新增";
            List<TbJurisdictions> moduledetailsList = employeeMapper.selectModuledetails();//查询模块明细表
            for (TbJurisdictions tbjurisdictions:moduledetailsList) {
                employeeMapper.insertJurisdiction(tbRole.getRoleid(),tbjurisdictions.getModuledetailsid());//新增权限表
            }
        }else {
            IURole = employeeMapper.updateRole(tbRole);//修改角色
            Msgtext="修改";
        }
        if(IURole>0){
            jsonReturn.setState(true);jsonReturn.setMsg(Msgtext+"成功！");
        }else{
            jsonReturn.setMsg(Msgtext+"失败！");
        }
        return jsonReturn;
    }

    //角色删除
    @ResponseBody
    @RequestMapping("DeleteRole")
    public JsonReturn DeleteRole(Integer RoleID){
        JsonReturn jsonReturn = new JsonReturn();

        Integer Roleone = employeeMapper.hasSonRole(RoleID);//查询是否有子数据
        if(Roleone==0){
            int deleteRole = employeeMapper.deleteRole(RoleID);//删除角色
            if(deleteRole>0){
                int deletejurisdiction = employeeMapper.deleteJurisdiction(RoleID);
                if(deletejurisdiction>0){
                    jsonReturn.setState(true);
                    jsonReturn.setMsg("角色删除成功！");
                }else {
                    jsonReturn.setMsg("权限删除失败！");
                }
            }else {
                jsonReturn.setMsg("角色删除失败！");
            }
        }else {
            jsonReturn.setMsg("该数据存在子数据，不能进行删除！");
        }
        return jsonReturn;
    }


    /*-------------------------------------权限管理---------------------------------------*/

    //角色表查询
    @ResponseBody
    @RequestMapping("SelectTabRole")
    public Layui SelectTabRole(){
        List<TbRole> tbrole = employeeMapper.tableRole(0,"");
        PageBean<TbRole> pages = new PageBean<TbRole>();
        pages.setData(tbrole);
        pages.setTotalRows(tbrole.size());
        return Layui.data(pages);
    }

    //模块数据查询
    @ResponseBody
    @RequestMapping("TableModule")
    public Layui TableModule(Integer roleID){
        List<TbJurisdictions> Module = employeeMapper.tablemodule(roleID);//查询模块
        PageBean<TbJurisdictions> pages = new PageBean<TbJurisdictions>();
        pages.setData(Module);
        pages.setTotalRows(Module.size());
        return Layui.data(pages);
    }

    //模块数据修改
    @ResponseBody
    @RequestMapping("updateJurisdiction")
    public JsonReturn updateJurisdiction(String JurisdictionIDs){
        JsonReturn jsonReturn = new JsonReturn();
        Integer modulenumbers=0;
        String[] IDS = JurisdictionIDs.split(",");
        for (int i = 0; i < IDS.length; i++) {
            int updata =  employeeMapper.updateJurisdiction(Integer.parseInt(IDS[i]));//修改权限表
            if(updata>0){ modulenumbers++; }
        }
        if(IDS.length==modulenumbers){
            jsonReturn.setState(true);
            jsonReturn.setMsg("权限修改成功！");
        }else {
            jsonReturn.setMsg("权限修改失败！");
        }
        return jsonReturn;
    }
}
