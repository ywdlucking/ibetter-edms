package com.ywd.service.impl;


import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import com.ywd.entity.PurchaseListGoods;
import com.ywd.repository.PurchaseListGoodsRepository;
import com.ywd.service.PurchaseListGoodsService;
import com.ywd.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;


/**
 * 进货单商品Service实现类
 * @author Administrator
 *
 */
@Service("purchaseListGoodsService")
public class PurchaseListGoodsServiceImpl implements PurchaseListGoodsService {

	@Autowired
	private PurchaseListGoodsRepository purchaseListGoodsRepository;

	@Override
	public List<PurchaseListGoods> listByPurchaseListId(Integer purchaseListId) {
		return purchaseListGoodsRepository.listByPurchaseListId(purchaseListId);
	}

	@Override
	public List<PurchaseListGoods> list(PurchaseListGoods purchaseListGoods) {
		return purchaseListGoodsRepository.findAll(new Specification<PurchaseListGoods>() {

			@Override
			public Predicate toPredicate(Root<PurchaseListGoods> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicate=cb.conjunction();
				if(purchaseListGoods!=null){
					if(purchaseListGoods.getType()!=null && purchaseListGoods.getType().getId()!=null && purchaseListGoods.getType().getId()!=1){
						predicate.getExpressions().add(cb.equal(root.get("type").get("id"), purchaseListGoods.getType().getId()));
					}
					if(StringUtil.isNotEmpty(purchaseListGoods.getCodeOrName())){
						predicate.getExpressions().add(cb.or(cb.like(root.get("code"), "%"+purchaseListGoods.getCodeOrName()+"%"), cb.like(root.get("name"), "%"+purchaseListGoods.getCodeOrName()+"%")));
					}
				}
				return predicate;
			}
		});
	}

}
