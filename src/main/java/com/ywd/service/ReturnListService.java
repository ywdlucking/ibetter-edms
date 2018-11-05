package com.ywd.service;

import com.ywd.entity.ReturnList;
import com.ywd.entity.ReturnListGoods;
import org.springframework.data.domain.Sort;

import java.util.List;

/**
 * 退货单Service接口
 *
 */
public interface ReturnListService {

	/**
	 * 获取当天最大退货单号
	 * @return
	 */
	public String getTodayMaxReturnNumber();
	
	/**
	 * 添加退货单 以及所有退货单商品  以及 修改 库存数量 
	 * @param returnList
	 * @param returnListGoodsList
	 */
	public void save(ReturnList returnList, List<ReturnListGoods> returnListGoodsList);

	/**
	 * 根据id查询实体
	 * @param id
	 * @return
	 */
	public ReturnList findById(Integer id);

	/**
	 * 根据条件查询退货单信息
	 * @param returnList
	 * @param direction
	 * @param properties
	 * @return
	 */
	public List<ReturnList> list(ReturnList returnList, Sort.Direction direction, String...properties);

	/**
	 * 根据id删除退货单信息 包括退货单里的所有商品
	 * @param id
	 */
	public void delete(Integer id);

	/**
	 * 更新退货单
	 * @param returnList
	 */
	public void update(ReturnList returnList);
}
