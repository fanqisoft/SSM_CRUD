package cn.fanqisoft.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fanqisoft.crud.bean.Department;
import cn.fanqisoft.crud.bean.Msg;
import cn.fanqisoft.crud.service.DepartmentService;

/**
 * 处理和部门有关的请求
 * @author fanqi
 *
 */
@Controller
public class DeptartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 返回所有的部门信息
	 * @return
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> datas = departmentService.getDepts();
		return Msg.success().add("depts", datas);
	}
}
