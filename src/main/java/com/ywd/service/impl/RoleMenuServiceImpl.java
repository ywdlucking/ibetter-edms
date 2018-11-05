package com.ywd.service.impl;


import javax.annotation.Resource;

import com.ywd.entity.RoleMenu;
import com.ywd.repository.RoleMenuRepository;
import com.ywd.service.RoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



/**
 * 角色菜单关联Service实现类
 *
 */
@Service("roleMenuService")
@Transactional
public class RoleMenuServiceImpl implements RoleMenuService {

	@Autowired
	private RoleMenuRepository roleMenuRepository;
	
	@Override
	public void deleteByRoleId(Integer roleId) {
		roleMenuRepository.deleteByRoleId(roleId);
	}

	@Override
	public void save(RoleMenu roleMenu) {
		roleMenuRepository.save(roleMenu);
	}
}
