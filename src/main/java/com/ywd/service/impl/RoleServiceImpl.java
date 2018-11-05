package com.ywd.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import com.ywd.entity.Role;
import com.ywd.repository.RoleRepository;
import com.ywd.service.RoleService;
import com.ywd.util.StringUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;


/**
 * 角色Service实现类
 *
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Resource
	private RoleRepository roleRepository;
	
	@Override
	public List<Role> findByUserId(Integer id) {
		return roleRepository.findByUserId(id);
	}

	@Override
	public Role findById(Integer id) {
		return roleRepository.findOne(id);
	}

	@Override
	public List<Role> listAll() {
		return roleRepository.findAll();
	}

	@Override
	public List<Role> list(Role role, Integer page, Integer pageSize, Sort.Direction direction, String... properties) {
		Pageable pageable=new PageRequest(page-1,pageSize);
		Page<Role> pageUser=roleRepository.findAll(new Specification<Role>() {

			@Override
			public Predicate toPredicate(Root<Role> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicate=cb.conjunction();
				if(role!=null){
					if(StringUtil.isNotEmpty(role.getName())){
						predicate.getExpressions().add(cb.like(root.get("name"), "%"+role.getName()+"%"));
					}
					predicate.getExpressions().add(cb.notEqual(root.get("id"), 1));
				}
				return predicate;
			}
		},pageable);
		return pageUser.getContent();
	}

	@Override
	public Long getCount(Role role) {
		Long count=roleRepository.count(new Specification<Role>() {

			@Override
			public Predicate toPredicate(Root<Role> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicate=cb.conjunction();
				if(role!=null){
					if(StringUtil.isNotEmpty(role.getName())){
						predicate.getExpressions().add(cb.like(root.get("name"), "%"+role.getName()+"%"));
					}
					predicate.getExpressions().add(cb.notEqual(root.get("id"), 1));
				}
				return predicate;
			}

		});
		return count;
	}

	@Override
	public void save(Role role) {
		roleRepository.save(role);
	}

	@Override
	public void delete(Integer id) {
		roleRepository.delete(id);
	}

	@Override
	public Role findByRoleName(String roleName) {
		return roleRepository.findByRoleName(roleName);
	}
}
