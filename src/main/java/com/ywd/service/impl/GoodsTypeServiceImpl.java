package com.ywd.service.impl;


import java.util.List;

import javax.annotation.Resource;

import com.ywd.entity.GoodsType;
import com.ywd.repository.GoodsTypeRepository;
import com.ywd.service.GoodsTypeService;
import org.springframework.stereotype.Service;


/**
 * 商品类别Service实现类
 *
 */
@Service("goodsTypeService")
public class GoodsTypeServiceImpl implements GoodsTypeService {

	@Resource
	private GoodsTypeRepository goodsTypeRepository;

	@Override
	public List<GoodsType> findByParentId(int parentId) {
		return goodsTypeRepository.findByParentId(parentId);
	}

	@Override
	public void save(GoodsType goodsType) {
		goodsTypeRepository.save(goodsType);
	}

	@Override
	public void delete(Integer id) {
		goodsTypeRepository.delete(id);
	}

	@Override
	public GoodsType findById(Integer id) {
		return goodsTypeRepository.findOne(id);
	}




}
