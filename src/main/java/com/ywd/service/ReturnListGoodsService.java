package com.ywd.service;


import com.ywd.entity.ReturnListGoods;

import java.util.List;

/**
 * 退货单商品Service接口
 *
 */
public interface ReturnListGoodsService {
    /**
     * 根据退货单id查询所有退货单商品
     * @param returnListId
     * @return
     */
    public List<ReturnListGoods> listByReturnListId(Integer returnListId);

    /**
     * 根据条件查询退货单商品
     * @param returnListGoods
     * @return
     */
    public List<ReturnListGoods> list(ReturnListGoods returnListGoods);
	
}
