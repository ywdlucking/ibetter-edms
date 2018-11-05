package com.ywd.service.impl;


import java.util.List;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import com.ywd.entity.DamageList;
import com.ywd.entity.DamageListGoods;
import com.ywd.entity.Goods;
import com.ywd.repository.DamageListGoodsRepository;
import com.ywd.repository.DamageListRepository;
import com.ywd.repository.GoodsRepository;
import com.ywd.repository.GoodsTypeRepository;
import com.ywd.service.DamageListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;


/**
 * 商品报损单Service实现类
 * @author Administrator
 *
 */
@Service("damageListService")
public class DamageListServiceImpl implements DamageListService {

	@Autowired
	private DamageListRepository damageListRepository;
	
	@Autowired
	private GoodsTypeRepository goodsTypeRepository;
	
	@Autowired
	private GoodsRepository goodsRepository;
	
	@Autowired
	private DamageListGoodsRepository damageListGoodsRepository;

	@Override
	public String getTodayMaxDamageNumber() {
		return damageListRepository.getTodayMaxDamageNumber();
	}

	@Transactional
	public void save(DamageList damageList, List<DamageListGoods> damageListGoodsList) {
		for(DamageListGoods damageListGoods:damageListGoodsList){
			damageListGoods.setType(goodsTypeRepository.findOne(damageListGoods.getTypeId())); // 设置类别
			damageListGoods.setDamageList(damageList); // 设置商品报损单
			damageListGoodsRepository.save(damageListGoods);
			// 修改商品库存
			Goods goods=goodsRepository.findOne(damageListGoods.getGoodsId());
			
			goods.setInventoryQuantity(goods.getInventoryQuantity()-damageListGoods.getNum());
			goods.setState(2);
			goodsRepository.save(goods);
		}
		damageListRepository.save(damageList); // 保存商品报损单
	}

	@Override
	public List<DamageList> list(DamageList damageList, Direction direction, String... properties) {
		return damageListRepository.findAll(new Specification<DamageList>() {
			
			@Override
			public Predicate toPredicate(Root<DamageList> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicate=cb.conjunction();
				if(damageList!=null){
					if(damageList.getbDamageDate()!=null){
						predicate.getExpressions().add(cb.greaterThanOrEqualTo(root.get("damageDate"), damageList.getbDamageDate()));
					}
					if(damageList.geteDamageDate()!=null){
						predicate.getExpressions().add(cb.lessThanOrEqualTo(root.get("damageDate"), damageList.geteDamageDate()));
					}
				}
				return predicate;
			}
		},new Sort(direction, properties));
	}

	@Override
	public DamageList findById(Integer id) {
		return damageListRepository.findOne(id);
	}


	

}
