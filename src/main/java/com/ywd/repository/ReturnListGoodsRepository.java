package com.ywd.repository;

import com.ywd.entity.ReturnListGoods;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


/**
 * 退货单商品Repository接口
 *
 */
public interface ReturnListGoodsRepository extends JpaRepository<ReturnListGoods, Integer>,JpaSpecificationExecutor<ReturnListGoods>{

    /**
     * 根据退货单id删除所有退货单商品
     * @param returnListId
     * @return
     */
    @Query(value="delete FROM t_return_list_goods WHERE return_list_id=?1",nativeQuery=true)
    @Modifying
    public void deleteByReturnListId(Integer returnListId);

    /**
     * 根据退货单id查询所有退货单商品
     * @param returnListId
     * @return
     */
    @Query(value="SELECT * FROM t_return_list_goods WHERE return_list_id=?1",nativeQuery=true)
    public List<ReturnListGoods> listByReturnListId(Integer returnListId);
}
