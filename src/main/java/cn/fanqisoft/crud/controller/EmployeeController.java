package cn.fanqisoft.crud.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.fanqisoft.crud.bean.Employee;
import cn.fanqisoft.crud.bean.Msg;
import cn.fanqisoft.crud.service.EmployeeService;

/**
 * 处理员工CRUD请求
 * @author fanqi
 *
 */
@Controller
public class EmployeeController 
{
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 删除员工信息(支持多选)
	 * 批量删除 1-2-3
	 * 单个删除 1
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {  //批量删除
			String[] id2 = ids.split("-");
			List<Integer> ids2 = new ArrayList<Integer>();
			for (String id : id2) {
				ids2.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(ids2);
		}
		else {
			employeeService.deleteEmp(Integer.parseInt(ids));
		}	
		return Msg.success();
	}
	
	/**
	 * 更新员工数据
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer empId) {
		Employee employee =  employeeService.getEmp(empId);
		return Msg.success().add("emp", employee);
	}
	
	
	/**
	 * 检验用户名是否存在
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkEmpName")
	@ResponseBody
	public Msg checkEmpName(String empName) {
		//先判断用户名是否是合法的表达式
		String regName ="(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regName)) {
			return Msg.fail().add("va_msg", "用户名必须是2-5位中文或者是5-16位英文和数字的组合");
		}
		boolean result = employeeService.checkEmpName(empName);
		if(result == true) {
			return Msg.success();
		}
		else { 
			return Msg.fail().add("va_msg", "用户名不可用!");
		}
	}
	
	/**
	 * 员工保存方法
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String,Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError error:errors ) {
				map.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		employeeService.saveEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 查询员工数据（分页查询）
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,
			Model model) {
		//这不是一个分页查询
		//引入PageHelper分页插件
		//在查询之前只需要调用，传入页码，以及每页的大小。
		PageHelper.startPage(pn, 7);
		//startPage 后面紧跟的这个查询就是一个分页查询
		List<Employee> datas = employeeService.getAll();
		//使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了。
		//封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
		PageInfo<Employee> page = new PageInfo<>(datas,5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
	
	/**
	 * 查询员工数据（分页查询）   以Json的形式进行返回数据
	 * 注意: 要使 @ResponseBody注解生效 需要加入jackson  jar包
	 * @param pn  查询的页码
	 * @return   Json形式的员工数据(分页)
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1") Integer pn)
	{
		//这不是一个分页查询
		//引入PageHelper分页插件
		//在查询之前只需要调用，传入页码，以及每页的大小。
		PageHelper.startPage(pn, 7);
		//startPage 后面紧跟的这个查询就是一个分页查询
		List<Employee> datas = employeeService.getAll();
		//使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了。
		//封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
		PageInfo<Employee> page = new PageInfo<>(datas,5);
		return Msg.success().add("pageInfo", page);
	}
}
