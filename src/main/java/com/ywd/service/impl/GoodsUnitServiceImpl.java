package com.ywd.service.impl;


import java.util.List;

import javax.annotation.Resource;

import com.ywd.entity.GoodsUnit;
import com.ywd.repository.GoodsUnitRepository;
import com.ywd.service.GoodsUnitService;
import org.springframework.stereotype.Service;


/**
 * 商品单位Service实现类
 *
 */
@Service("goodsUnitService")
public class GoodsUnitServiceImpl implements GoodsUnitService {

	@Resource
	private GoodsUnitRepository goodsUnitRepository;


	@Override
	public void save(GoodsUnit goodsUnit) {
		goodsUnitRepository.save(goodsUnit);
	}

	@Override
	public void delete(Integer id) {
		goodsUnitRepository.delete(id);
	}

	@Override
	public GoodsUnit findById(Integer id) {
		return goodsUnitRepository.findOne(id);
	}

	@Override
	public List<GoodsUnit> listAll() {
		return goodsUnitRepository.findAll();
	}




}
