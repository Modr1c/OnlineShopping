package com.lzd.dao;

import java.util.List;

import com.lzd.bean.AlreadyBuy;

public interface AlreadyBuyDao {

	// 添加已购买商品
	public boolean addBuyGoods(int uid, int gid, int number) throws Exception;

	// 获取所有已购买商品
	public List<AlreadyBuy> getAllBuyGoods(int uid) throws Exception;

}
