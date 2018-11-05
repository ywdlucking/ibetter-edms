package com.ywd.service.impl;


import java.util.List;

import javax.annotation.Resource;

import com.ywd.entity.DamageListGoods;
import com.ywd.repository.DamageListGoodsRepository;
import com.ywd.service.DamageListGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 商品报损单商品Service实现类
 * @author Administrator
 *
 */
@Service("damageListGoodsService")
public class DamageListGoodsServiceImpl implements DamageListGoodsService {

	@Autowired
	private DamageListGoodsRepository damageListGoodsRepository;

	@Override
	public List<DamageListGoods> listByDamageListId(Integer damageListId) {
		return damageListGoodsRepository.listByDamageListId(damageListId);
	}

	
	
}
