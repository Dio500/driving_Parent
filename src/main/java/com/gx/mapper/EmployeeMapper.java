package com.gx.mapper;

import com.gx.pojo.*;
import com.gx.utils.SelectVo;
import com.gx.utils.TreeResult;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmployeeMapper {

    //查询组织机构
    List<SelectVo> selectDepartment(@Param("parentdepartmentid")Integer parentdepartmentid);

    //部门树形
    List<TreeResult> TreeDepartment();

    //查询角色
    List<SelectVo> selectRole();

    //查询部门
    //List<SelectVo> selectOrganization();

    //查询驾校
    TbDepartment selectSchool(@Param("parentID")Integer parentID);

    //查询科目
    List<SelectVo> selectSubjects();

    //查询车辆
    List<SelectVo> selectCar();

    //查询训练场
    List<SelectVo> selectTraining();

    //查询车型
    List<SelectVo> selectModel();

    //查询员工@Param
    List<EmployeeManage> selectEmployee(@Param("Employeenumber")String Employeenumber, @Param("Framework")Integer Framework, @Param("Role")Integer Role, @Param("Working")Boolean Working, @Param("Account")Boolean Account, @Param("Employeetype")Boolean Employeetype);
    List<EmployeeManage> selectEmployee();

    //新增员工
    int insertEmployee(EmployeeManage employeeManage);

    //新增用户
    int insertUser(EmployeeManage employeeManage);

    //新增教练
    int insertCoach(EmployeeManage employeeManage);

    //回填员工数据
    EmployeeManage backfillEmployee(@Param("EmployeeID")Integer EmployeeID);

    //修改员工
    int updateEmployee(EmployeeManage employeeManage);

    //修改用户
    int updateUser(EmployeeManage employeeManage);

    //修改教练
    int updateCoach(EmployeeManage employeeManage);

    //删除员工
    int deleteEmployee(Integer employeeID);

    //删除用户
    int deleteUser(Integer userID);

    //删除教练
    int deleteCoach(Integer coachID);

    //------------------------部门管理--------------------------

    //部门查询
    List<TbDepartment> tableDepartment(@Param("DepartmentID")Integer DepartmentID,@Param("parentDepartmentID")Integer parentDepartmentID);

    //部门新增
    int insertDepartment(@Param("DepartmentID")Integer DepartmentID,@Param("Name")String Name,@Param("Linkman")String Linkman,@Param("Phone")String Phone,@Param("Sequence")String Sequence);

    //部门修改
    int updateDepartment(@Param("DepartmentID")Integer DepartmentID,@Param("Name")String Name,@Param("Linkman")String Linkman,@Param("Phone")String Phone,@Param("Sequence")String Sequence);

    //是否有子数据
    Integer hasSonDepartment(@Param("DepartmentID")Integer DepartmentID);

    //部门删除
    int deleteDepartment(@Param("DepartmentID")Integer DepartmentID);

    //------------------------角色管理---------------------------

    //角色查询
    List<TbRole> tableRole(@Param("RoleID")Integer RoleID,@Param("Rolename")String Rolename);

    //查询模块明细表
    List<TbJurisdictions> selectModuledetails();

    //角色新增
    int insertRole(TbRole tbRole);

    //新增权限表
    int insertJurisdiction(@Param("roleID")Integer roleID,@Param("moduleDetailsID")Integer moduleDetailsID);

    //角色修改
    int updateRole(TbRole tbRole);

    //角色是否有子数据
    Integer hasSonRole(@Param("RoleID")Integer RoleID);

    //角色删除
    int deleteRole(@Param("RoleID")Integer RoleID);

    //删除权限表
    int deleteJurisdiction(@Param("roleID")Integer roleID);

    //------------------------权限管理--------------------------

    //模块查询
    List<TbJurisdictions> tablemodule(Integer roleID);

    //修改角色权限
    int updateJurisdiction(@Param("jurisdictionsID")Integer jurisdictionsID);
}
