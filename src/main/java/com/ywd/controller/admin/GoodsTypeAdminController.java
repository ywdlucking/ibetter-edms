package com.ywd.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.ywd.entity.GoodsType;
import com.ywd.entity.Log;
import com.ywd.service.GoodsService;
import com.ywd.service.GoodsTypeService;
import com.ywd.service.LogService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

/**
 * 后台管理角色Controller
 * @author Administrator
 *
 */
@RestController
@RequestMapping("/admin/goodsType")
public class GoodsTypeAdminController {

	
	@Autowired
	private GoodsTypeService goodsTypeService;

	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private LogService logService;

	/**
	 * 添加商品类别
	 * @param name
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	@RequiresPermissions(value="商品管理")
	public Map<String,Object> save(String name,Integer parentId)throws Exception{
		Map<String,Object> resultMap=new HashMap<>();
		GoodsType goodsType=new GoodsType();
		goodsType.setName(name);
		goodsType.setpId(parentId);
		goodsType.setIcon("icon-folder");
		goodsType.setState(0);
		goodsTypeService.save(goodsType);
		
		GoodsType parentGoodsType=goodsTypeService.findById(parentId);
		parentGoodsType.setState(1);
		goodsTypeService.save(parentGoodsType);
		
		logService.save(new Log(Log.ADD_ACTION,"添加商品类别信息"));
		resultMap.put("success", true);
		return resultMap;
	}
	
	/**
	 * 商品类别删除
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete")
	@RequiresPermissions(value="商品管理")
	public Map<String,Object> delete(Integer id)throws Exception{
		Map<String,Object> resultMap=new HashMap<>();
		if(goodsService.findByTypeId(id).size()==0){
			GoodsType goodsType=goodsTypeService.findById(id);
			if(goodsTypeService.findByParentId(goodsType.getpId()).size()==1){
				GoodsType parentGoodsType=goodsTypeService.findById(goodsType.getpId());
				parentGoodsType.setState(0);
				goodsTypeService.save(parentGoodsType);
			}
			logService.save(new Log(Log.DELETE_ACTION,"删除商品类别信息"+goodsType));
			goodsTypeService.delete(id);
			resultMap.put("success", true);
		}else{
			resultMap.put("success", false);
			resultMap.put("errorInfo", "该类别下含有商品，不能删除！");
		}
		return resultMap;
	}

	/**
	 * 根据父节点获取所有复选框权限菜单
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/loadTreeInfo")
	@RequiresPermissions(value="商品管理")
	public String loadTreeInfo()throws Exception{
		logService.save(new Log(Log.SEARCH_ACTION,"查询所有商品类别信息"));
		return getAllByParentId(-1).toString();
	}
	
	/**
	 * 根据父节点id和权限菜单id集合获取所有复选框菜单集合
	 * @param parentId
	 * @return
	 */
	public JsonArray getAllByParentId(Integer parentId){
		JsonArray jsonArray=this.getByParentId(parentId);
		for(int i=0;i<jsonArray.size();i++){
			JsonObject jsonObject=(JsonObject) jsonArray.get(i);
			if("open".equals(jsonObject.get("state").getAsString())){
				continue;
			}else{
				jsonObject.add("children", getAllByParentId(jsonObject.get("id").getAsInt()));
			}
		}
		return jsonArray;
	}
	
	/**
	 * 根据父节点查询所有子节点
	 * @param parentId
	 * @return
	 */
	public JsonArray getByParentId(Integer parentId){
		List<GoodsType> goodsTypeList=goodsTypeService.findByParentId(parentId);
		JsonArray jsonArray=new JsonArray();
		for(GoodsType goodsType:goodsTypeList){
			JsonObject jsonObject=new JsonObject();
			jsonObject.addProperty("id", goodsType.getId()); // 节点Id
			jsonObject.addProperty("text", goodsType.getName()); // 节点名称
			if(goodsType.getState()==1){
				jsonObject.addProperty("state", "closed"); // 根节点
			}else{
				jsonObject.addProperty("state", "open"); // 叶子节点
			}
			jsonObject.addProperty("iconCls", goodsType.getIcon()); // 节点图标
			JsonObject attributeObject=new JsonObject(); // 扩展属性
			attributeObject.addProperty("state", goodsType.getState()); // 节点状态
			jsonObject.add("attributes", attributeObject); 
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}

}
