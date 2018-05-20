package cn.fanqisoft.crud.bean;

public class Department {
    private Integer deptId;

    private String deptName;

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
    
    /**
     * 无参构造器
     */
	public Department() {
		super();
	}
	/**
	 * 有参构造器
	 * @param deptId
	 * @param deptName
	 */
	public Department(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}
    
}