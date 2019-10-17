package com.lzd.dao;

import java.util.List;

import com.lzd.bean.Goods;

public interface GoodsDao {

	// 添加商品
	public boolean addGoods(Goods goods) throws Exception;

	// 获取最新的商品
	public List<Goods> getLatestGoods(int gid, String type) throws Exception;

	// 获取所有商品
	public List<Goods> getAllGoods() throws Exception;

	// 编辑商品信息
	public boolean editInfo(Goods goods) throws Exception;

	// 删除商品
	public boolean deleteGoods(int gid) throws Exception;

	// 通过id获取指定商品
	public Goods queryById(int gid) throws Exception;

	// 通过id获取指定商品库存数量
	public int queryNumberById(int gid) throws Exception;

	// 类型
	public String[] queryTypes() throws Exception;

	// 获取某类型商品
	public List<Goods> getTypeGoodsList(String type) throws Exception;
}
