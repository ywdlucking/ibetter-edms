package com.ywd.service;

import java.util.List;

import com.ywd.entity.Customer;
import org.springframework.data.domain.Sort.Direction;


/**
 * 客户Service接口
 *
 */
public interface CustomerService {

	
	/**
	 * 根据条件分页查询客户信息
	 * @param customer
	 * @param page
	 * @param pageSize
	 * @param direction
	 * @param properties
	 * @return
	 */
	public List<Customer> list(Customer customer, Integer page, Integer pageSize, Direction direction, String... properties);
	
	/**
	 * 获取总记录数
	 * @param customer
	 * @return
	 */
	public Long getCount(Customer customer);
	
	/**
	 * 添加或者修改客户信息
	 * @param customer
	 */
	public void save(Customer customer);
	
	/**
	 * 根据id删除客户
	 * @param id
	 */
	public void delete(Integer id);
	
	/**
	 * 根据id查询实体
	 * @param id
	 * @return
	 */
	public Customer findById(Integer id);

	/**
	 * 根据名称模糊查询客户信息
	 * @param name
	 * @return
	 */
	public List<Customer> findByName(String name);
}
