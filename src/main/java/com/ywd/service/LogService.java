package com.ywd.service;

import java.util.List;

import com.ywd.entity.Log;
import org.springframework.data.domain.Sort.Direction;


/**
 * 日志Service接口
 *
 */
public interface LogService {

	/**
	 * 添加或者修改日志信息
	 * @param log
	 */
	public void save(Log log);
	
	/**
	 * 根据条件分页查询日志信息
	 * @param log
	 * @param page
	 * @param pageSize
	 * @param direction
	 * @param properties
	 * @return
	 */
	public List<Log> list(Log log, Integer page, Integer pageSize, Direction direction, String... properties);
	
	/**
	 * 获取总记录数
	 * @param log
	 * @return
	 */
	public Long getCount(Log log);
}
