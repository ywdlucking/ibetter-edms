package com.ywd.service.impl;


import java.util.List;

import javax.annotation.Resource;

import com.ywd.entity.OverflowListGoods;
import com.ywd.repository.OverflowListGoodsRepository;
import com.ywd.service.OverflowListGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 商品报溢单商品Service实现类
 * @author Administrator
 *
 */
@Service("overflowListGoodsService")
public class OverflowListGoodsServiceImpl implements OverflowListGoodsService {

	@Autowired
	private OverflowListGoodsRepository overflowListGoodsRepository;

	@Override
	public List<OverflowListGoods> listByOverflowListId(Integer overflowListId) {
		return overflowListGoodsRepository.listByOverflowListId(overflowListId);
	}

	
	
}
