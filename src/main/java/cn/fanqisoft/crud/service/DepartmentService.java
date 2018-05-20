package cn.fanqisoft.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.fanqisoft.crud.bean.Department;
import cn.fanqisoft.crud.dao.DepartmentMapper;


@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;

	public List<Department> getDepts() {
		// TODO Auto-generated method stub
		List<Department> datas = departmentMapper.selectByExample(null);
		return datas;
	}

}
