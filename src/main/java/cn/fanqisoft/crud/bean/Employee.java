package cn.fanqisoft.crud.bean;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;

public class Employee {
    private Integer empId;

    private Integer deptId;
    
    @Pattern(regexp="(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
    		message="用户名必须是2-5位中文或者是5-16位英文和数字的组合")
    private String empName;

    private String gender;

    //@Email
    @Pattern(regexp="^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
    		message="邮箱格式不正确!")
    private String email;
    
    //希望查询员工的同时部门信息也是查询好的
    private Department department;
    
    

    @Override
	public String toString() {
		return "Employee [empId=" + empId + ", deptId=" + deptId + ", empName=" + empName + ", gender=" + gender
				+ ", email=" + email + ", department=" + department + "]";
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    /**
     * 无参构造器
     */
	public Employee() {
		super();
	}

	/**
	 * 有参构造器
	 * @param empId
	 * @param deptId
	 * @param empName
	 * @param gender
	 * @param email
	 */
	public Employee(Integer empId, Integer deptId, String empName, String gender, String email) {
		super();
		this.empId = empId;
		this.deptId = deptId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
	}
    
}