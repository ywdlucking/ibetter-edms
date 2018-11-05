package com.ywd.service.impl;


import javax.annotation.Resource;

import com.ywd.entity.UserRole;
import com.ywd.repository.UserRoleRepository;
import com.ywd.service.UserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * 用户角色关联Service实现类
 *
 */
@Service("userRoleService")
@Transactional
public class UserRoleServiceImpl implements UserRoleService {

	@Autowired
	private UserRoleRepository userRoleRepository;
	
	@Override
	public void deleteByUserId(Integer userId) {
		userRoleRepository.deleteByUserId(userId);
	}

	@Override
	public void save(UserRole userRole) {
		userRoleRepository.save(userRole);
	}

	@Override
	public void deleteByRoleId(Integer roleId) {
		userRoleRepository.deleteByRoleId(roleId);
	}
}
