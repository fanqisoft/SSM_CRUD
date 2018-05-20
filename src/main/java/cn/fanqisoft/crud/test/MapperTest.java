package cn.fanqisoft.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.fanqisoft.crud.bean.Department;
import cn.fanqisoft.crud.bean.Employee;
import cn.fanqisoft.crud.dao.DepartmentMapper;
import cn.fanqisoft.crud.dao.EmployeeMapper;

/**
 * 测试DAO层的工作
 * @author fanqi
 * 推介Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组建
 * 1. 导入Spring Test 模块
 * 2. @ContextConfiguration 注解中 locations 属性执行Spring 配置文件的位置
 * 3. 直接 @Autowired 要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	/**
	 * 测试 DepartmentMapper
	 */
	@Test
	public void testCRUD() {
		//1. 创建Spring IOC容器
		//ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		//DepartmentMapper dep = applicationContext.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);
		
		//1. 插入几个部门
		//departmentMapper.insertSelective(new Department(null,"开发部"));
		//departmentMapper.insertSelective(new Department(null,"测试部"));
		
		
		//2. 生成员工数据，测试员工插入
		//employeeMapper.insertSelective(new Employee(null, 1, "Jerry", "M", "Jerry@fanqisoft.cn"));
		
		//3. 批量插入多个员工,使用可以执行批量操作的sqlSession
		//EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		//		for(int i = 0 ; i < 1000 ; i++)
		//		{
		//			String uid = UUID.randomUUID().toString().substring(0, 5) + "" + i;
		//			mapper.insertSelective(new Employee(null, 1, uid, "M", uid + "@fanqisoft.cn"));
		//		}
		//		System.out.println("批量完成！");
		
	}

}
