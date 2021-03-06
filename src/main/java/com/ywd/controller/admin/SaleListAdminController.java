package com.ywd.controller.admin;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;

import com.google.gson.reflect.TypeToken;
import com.ywd.entity.Log;
import com.ywd.entity.SaleCount;
import com.ywd.entity.SaleList;
import com.ywd.entity.SaleListGoods;
import com.ywd.service.LogService;
import com.ywd.service.SaleListGoodsService;
import com.ywd.service.SaleListService;
import com.ywd.service.UserService;
import com.ywd.util.DateUtil;
import com.ywd.util.MathUtil;
import com.ywd.util.StringUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

/**
 * 后台管理销售单Controller
 *
 */
@RestController
@RequestMapping("/admin/saleList")
public class SaleListAdminController {

	@Autowired
	private SaleListService saleListService;
	
	@Autowired
	private SaleListGoodsService saleListGoodsService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private LogService logService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(true);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	
	/**
	 * 获取销售单号
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/genCode")
	@RequiresPermissions(value="销售出库")
	public String genCode()throws Exception{
		StringBuffer code=new StringBuffer("XS");
		code.append(DateUtil.getCurrentDateStr());
		String saleNumber=saleListService.getTodayMaxSaleNumber();
		if(saleNumber!=null){
			code.append(StringUtil.formatCode(saleNumber));
		}else{
			code.append("0001");
		}
		return code.toString();
	}
	
	/**
	 * 添加销售单 以及所有销售单商品
	 * @param saleList
	 * @param goodsJson
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	@RequiresPermissions(value="销售出库")
	public Map<String,Object> save(SaleList saleList, String goodsJson)throws Exception{
		Map<String,Object> resultMap=new HashMap<>();
		saleList.setUser(userService.findByUserName((String) SecurityUtils.getSubject().getPrincipal())); // 设置操作用户
		Gson gson=new Gson();
		List<SaleListGoods> plgList=gson.fromJson(goodsJson,new TypeToken<List<SaleListGoods>>(){}.getType());
		saleListService.save(saleList, plgList);
		logService.save(new Log(Log.ADD_ACTION,"添加销售单"));
		resultMap.put("success", true);
		return resultMap;
	}
	
	/**
	 * 根据条件查询所有销售单信息
	 * @param saleList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	@RequiresPermissions(value="销售单据查询")
	public Map<String,Object> list(SaleList saleList)throws Exception{
		Map<String,Object> resultMap=new HashMap<>();
		List<SaleList> saleListList=saleListService.list(saleList, Direction.DESC, "saleDate");
		resultMap.put("rows", saleListList);
		logService.save(new Log(Log.SEARCH_ACTION,"销售单查询"));
		return resultMap;
	}

	/**
	 * 根据条件获取商品销售信息
	 * @param saleList
	 * @param saleListGoods
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listCount")
	@RequiresPermissions(value="商品销售统计")
	public Map<String,Object> listCount(SaleList saleList,SaleListGoods saleListGoods)throws Exception{
		Map<String,Object> resultMap=new HashMap<>();
		List<SaleList> saleListList=saleListService.list(saleList, Direction.DESC, "saleDate");
		for(SaleList sl:saleListList){
			saleListGoods.setSaleList(sl);
			List<SaleListGoods> slgList=saleListGoodsService.list(saleListGoods);
			for(SaleListGoods slg:slgList){
				slg.setSaleList(null);
			}
			sl.setSaleListGoodsList(slgList);
		}
		resultMap.put("rows", saleListList);
		logService.save(new Log(Log.SEARCH_ACTION,"商品销售统计查询"));
		return resultMap;
	}
	
	/**
	 * 根据销售单id查询所有销售单商品
	 * @param saleListId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listGoods")
	@RequiresPermissions(value="销售单据查询")
	public Map<String,Object> listGoods(Integer saleListId)throws Exception{
		if(saleListId==null){
			return null;
		}
		Map<String,Object> resultMap=new HashMap<>();
		resultMap.put("rows", saleListGoodsService.listBySaleListId(saleListId));
		logService.save(new Log(Log.SEARCH_ACTION,"销售单商品查询"));
		return resultMap;
	}
	
	/**
	 * 删除销售单 以及销售单里的商品
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete")
	@RequiresPermissions(value="销售单据查询")
	public Map<String,Object> delete(Integer id)throws Exception{
		Map<String,Object> resultMap=new HashMap<>();
		saleListService.delete(id);
		logService.save(new Log(Log.DELETE_ACTION,"删除销售单信息："+saleListService.findById(id)));
		resultMap.put("success", true);
		return resultMap;
	}

	/**
	 * 修改销售单的支付状态
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/update")
	@RequiresPermissions(value="客户统计")
	public Map<String,Object> update(Integer id)throws Exception{
		Map<String,Object> resultMap=new HashMap<>();
		SaleList saleList=saleListService.findById(id);
		saleList.setState(1);
		saleListService.update(saleList);
		resultMap.put("success", true);
		return resultMap;
	}

	/**
	 * 按日统计分析
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/countSaleByDay")
	@RequiresPermissions(value="按日统计分析")
	public Map<String,Object> countSaleByDay(String begin,String end)throws Exception{
		Map<String,Object> resultMap=new HashMap<>();
		List<SaleCount> scList=new ArrayList<>();
		List<String> dates=DateUtil.getRangeDates(begin, end);
		List<Object> ll=saleListService.countSaleByDay(begin, end);
		for(String date:dates){
			SaleCount sc=new SaleCount();
			sc.setDate(date);
			boolean flag=false;
			for(Object o:ll){
				Object []oo=(Object[]) o;
				String dd=oo[2].toString().substring(0,10);
				if(dd.equals(date)){ // 存在
					sc.setAmountCost(MathUtil.format2Bit(Float.parseFloat(oo[0].toString()))); // 成本总金额
					sc.setAmountSale(MathUtil.format2Bit(Float.parseFloat(oo[1].toString()))); // 销售总金额
					sc.setAmountProfit(MathUtil.format2Bit(sc.getAmountSale()-sc.getAmountCost())); // 销售利润
					flag=true;
				}
			}
			if(!flag){
				sc.setAmountCost(0);
				sc.setAmountSale(0);
				sc.setAmountProfit(0);
			}
			scList.add(sc);
		}
		resultMap.put("rows", scList);
		resultMap.put("success", true);
		return resultMap;
	}

	/**
	 * 按月统计分析
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/countSaleByMonth")
	@RequiresPermissions(value="按月统计分析")
	public Map<String,Object> countSaleByMonth(String begin,String end)throws Exception{
		Map<String,Object> resultMap=new HashMap<>();
		List<SaleCount> scList=new ArrayList<>();
		List<String> dates=DateUtil.getRangeMonths(begin, end);
		List<Object> ll=saleListService.countSaleByMonth(begin, end);
		for(String date:dates){
			SaleCount sc=new SaleCount();
			sc.setDate(date);
			boolean flag=false;
			for(Object o:ll){
				Object []oo=(Object[]) o;
				String dd=oo[2].toString().substring(0,7);
				if(dd.equals(date)){ // 存在
					sc.setAmountCost(MathUtil.format2Bit(Float.parseFloat(oo[0].toString()))); // 成本总金额
					sc.setAmountSale(MathUtil.format2Bit(Float.parseFloat(oo[1].toString()))); // 销售总金额
					sc.setAmountProfit(MathUtil.format2Bit(sc.getAmountSale()-sc.getAmountCost())); // 销售利润
					flag=true;
				}
			}
			if(!flag){
				sc.setAmountCost(0);
				sc.setAmountSale(0);
				sc.setAmountProfit(0);
			}
			scList.add(sc);
		}
		resultMap.put("rows", scList);
		resultMap.put("success", true);
		return resultMap;
	}
}
