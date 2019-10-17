package com.lzd.service;

import java.sql.SQLException;
import java.util.List;

import com.lzd.bean.Goods;
import com.lzd.dao.GoodsDao;
import com.lzd.db.DBConnection;
import com.lzd.db.GoodsDaoImpl;

public class GoodsService implements GoodsDao {

	private DBConnection dbconn = null;

	private GoodsDao dao = null;

	public GoodsService() throws SQLException {
		this.dbconn = new DBConnection();
		this.dao = new GoodsDaoImpl(this.dbconn.getConnection());
	}
	
	// 添加商品
	@Override
	public boolean addGoods(Goods goods) throws Exception {
		if (goods != null) {
			return this.dao.addGoods(goods);
		}
		return false;
	}

	// 编辑商品信息
	@Override
	public boolean editInfo(Goods goods) throws Exception {
		if (goods != null) {
			return this.dao.editInfo(goods);
		}
		return false;
	}

	// 删除商品
	@Override
	public boolean deleteGoods(int gid) throws Exception {
		if (this.dao.queryById(gid) != null & isInt(gid)) {
			return this.dao.deleteGoods(gid);
		}
		return false;
	}
	
	// 通过id获取指定商品
	@Override
	public Goods queryById(int gid) throws Exception {
		if (isInt(gid)) {
			return this.dao.queryById(gid);
		}
		return null;
	}

	// 通过id获取指定商品库存数量
	@Override
	public int queryNumberById(int gid) throws Exception {
		if (isInt(gid)) {
			return this.dao.queryNumberById(gid);
		}
		return 0;
	}

	// 获取所有商品
	@Override
	public List<Goods> getAllGoods() throws Exception {
		return this.dao.getAllGoods();
	}

	// 获取最新的商品
	@Override
	public List<Goods> getLatestGoods(int gid, String type) throws Exception {
		if (isInt(gid) & type != null) {
			return this.dao.getLatestGoods(gid, type);
		}
		return null;
	}

	// 类型
	@Override
	public String[] queryTypes() throws Exception {
		return this.dao.queryTypes();
	}

	// 获取某类型商品
	@Override
	public List<Goods> getTypeGoodsList(String type) throws Exception {
		if (type != null) {
			return this.dao.getTypeGoodsList(type);
		}
		return null;
	}

	public boolean isInt(int index) {
		if (index == 0) {
			return false;
		}
		String str = String.valueOf(index);
		return str.matches("[0-9]+$");
	}

}
