package com.ywd.service.impl;


import java.util.List;
import com.ywd.entity.Supplier;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import com.ywd.repository.SupplierRepository;
import com.ywd.service.SupplierService;
import com.ywd.util.StringUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;


/**
 * 供应商Service实现类
 *
 */
@Service("supplierService")
public class SupplierServiceImpl implements SupplierService {

	@Resource
	private SupplierRepository supplierRepository;

	@Override
	public List<Supplier> findByName(String name) {
		return supplierRepository.findByName(name);
	}


	@Override
	public List<Supplier> list(Supplier supplier, Integer page, Integer pageSize, Direction direction, String... properties) {
		Pageable pageable=new PageRequest(page-1,pageSize);
		Page<Supplier> pageSupplier=supplierRepository.findAll(new Specification<Supplier>() {
			
			@Override
			public Predicate toPredicate(Root<Supplier> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicate=cb.conjunction();
				if(supplier!=null){
					if(StringUtil.isNotEmpty(supplier.getName())){
						predicate.getExpressions().add(cb.like(root.get("name"), "%"+supplier.getName()+"%"));
					}
				}
				return predicate;
			}
		},pageable);
		return pageSupplier.getContent();
	}

	@Override
	public Long getCount(Supplier supplier) {
		Long count=supplierRepository.count(new Specification<Supplier>() {

			@Override
			public Predicate toPredicate(Root<Supplier> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicate=cb.conjunction();
				if(supplier!=null){
					if(StringUtil.isNotEmpty(supplier.getName())){
						predicate.getExpressions().add(cb.like(root.get("name"), "%"+supplier.getName()+"%"));
					}
				}
				return predicate;
			}
			
		});
		return count;
	}

	@Override
	public void save(Supplier supplier) {
		supplierRepository.save(supplier);
	}

	@Override
	public void delete(Integer id) {
		supplierRepository.delete(id);
	}

	@Override
	public Supplier findById(Integer id) {
		return supplierRepository.findOne(id);
	}
	


}