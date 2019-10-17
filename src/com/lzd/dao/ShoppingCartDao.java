package com.lzd.dao;

import java.util.List;

import com.lzd.bean.ShoppingCart;

public interface ShoppingCartDao {

	// 添加商品
	public boolean addGoods(int uid, int gid, int number) throws Exception;

	// 删除商品
	public boolean deleteGoods(int uid, int gid, int number) throws Exception;

	// 获取所有商品
	public List<ShoppingCart> getAllGoods(int uid) throws Exception;

	// 检查指定用户购物车中是否含有指定商品，如果有则返回购物车id和商品数量，否则返回空
	public String getDesignateGoodsMs(int uid, int gid) throws Exception;

	// 支付指定商品
	public boolean payGoods(int uid, int gid, int number) throws Exception;

	// 支付所有商品
	public boolean payAllGoods(int uid) throws Exception;

}
