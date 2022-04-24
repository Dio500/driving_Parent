package com.gx.pojo;
import lombok.Data;
import javax.persistence.Table;

//部门表
@Data
@Table(name = "tb_department")
public class TbDepartment {
    private Integer departmentid;//部门ID
    private Integer parentdepartmentid;//部门父ID
    private String departmentname;//部门名称
    private String linkman;//联系人
    private String departmentphone;//部门电话
    private String sequence;//部门排序
}
