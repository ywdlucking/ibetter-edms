package com.ywd.service;

import com.ywd.entity.User;
import org.springframework.data.domain.Sort;

import java.util.List;

/**
 * 用户Service接口
 *
 */
public interface UserService {

	/**
	 * 根据用户名查找用户实体
	 * @param userName
	 * @return
	 */
	public User findByUserName(String userName);

	/**
	 * 根据条件分页查询用户信息
	 * @param user
	 * @param page
	 * @param pageSize
	 * @param direction
	 * @param properties
	 * @return
	 */
	public List<User> list(User user, Integer page, Integer pageSize, Sort.Direction direction, String...properties);

	/**
	 * 获取总记录数
	 * @param user
	 * @return
	 */
	public Long getCount(User user);

	/**
	 * 添加或者修改用户信息
	 * @param user
	 */
	public void save(User user);

	/**
	 * 根据id删除用户
	 * @param id
	 */
	public void delete(Integer id);

	/**
	 * 根据id查询实体
	 * @param id
	 * @return
	 */
	public User findById(Integer id);
}
