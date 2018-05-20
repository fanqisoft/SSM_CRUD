package cn.fanqisoft.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;

import cn.fanqisoft.crud.bean.Employee;
import cn.fanqisoft.crud.bean.EmployeeExample;
import cn.fanqisoft.crud.bean.EmployeeExample.Criteria;
import cn.fanqisoft.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;
	/**
	 * 查询员工数据（分页查询）  按照员工ID进行排序
	 * @return
	 */
	public List<Employee> getAll() {
		EmployeeExample example = new EmployeeExample();
		example.setOrderByClause("`emp_id` ASC");
		return employeeMapper.selectByExampleWithDept(example);
	}
	/**
	 * 保存员工数据
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
		return ;
	}

	/**
	 * 检验用户名是否存在
	 * @param empName
	 * @return true -- 当前用户名可用    false -- 当前用户名不可用
	 */
	public boolean checkEmpName(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long result = employeeMapper.countByExample(example);
		return result == 0;   // true 代表数据库中没有记录  false 代表数据库中有记录
	}
	
	/**
	 * 根据员工ID返回员工信息
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	/**
	 * 更新员工数据
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	
	/**
	 * 删除员工信息(单个)
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	/**
	 * 批量删除员工信息
	 * @param ids
	 */
	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria =  example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
