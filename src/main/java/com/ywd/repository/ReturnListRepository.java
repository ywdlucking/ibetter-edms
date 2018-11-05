package com.ywd.repository;

import com.ywd.entity.ReturnList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;


/**
 * 退货单Repository接口
 *
 */
public interface ReturnListRepository extends JpaRepository<ReturnList, Integer>,JpaSpecificationExecutor<ReturnList>{

	/**
	 * 获取当天最大退货单号
	 * @return
	 */
	@Query(value="SELECT MAX(return_number) FROM t_return_list WHERE TO_DAYS(return_date)=TO_DAYS(NOW())",nativeQuery=true)
	public String getTodayMaxReturnNumber();
}
