package com.lzd.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.lzd.bean.Goods;
import com.lzd.dao.GoodsDao;
import com.mysql.jdbc.Statement;

public class GoodsDaoImpl implements GoodsDao {

	private Connection conn = null;

	private PreparedStatement pstmt = null;

	public GoodsDaoImpl(Connection conn) {
		this.conn = conn;
	}

	@Override
	public boolean addGoods(Goods goods) throws Exception {
		pstmt = null;
		String sql = "insert into goods(gname,gphoto,types,producer,price,carriage,pdate,paddress,described,number)value(?,?,?,?,?,?,?,?,?,?);";
		int result = 0;
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setString(1, goods.getGname());
		pstmt.setString(2, goods.getPhoto());
		pstmt.setString(3, goods.getType());
		pstmt.setString(4, goods.getProducer());
		pstmt.setFloat(5, goods.getPrice());
		pstmt.setFloat(6, goods.getCarriage());
		pstmt.setString(7, goods.getPdate());
		pstmt.setString(8, goods.getPaddress());
		pstmt.setString(9, goods.getDescribed());
		pstmt.setInt(10, goods.getNumber());
		result = pstmt.executeUpdate();
		pstmt.close();
		if (result == 1) {
			return true;
		}
		return false;
	}

	@Override
	public boolean editInfo(Goods goods) throws Exception {
		pstmt = null;
		String sql = "update goods set gname=?,gphoto=?,types=?,producer=?,price=?,carriage=?,pdate=?,paddress=?,described=?,number=? where gid="
				+ goods.getGid();
		int result = 0;
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setString(1, goods.getGname());
		pstmt.setString(2, goods.getPhoto());
		pstmt.setString(3, goods.getType());
		pstmt.setString(4, goods.getProducer());
		pstmt.setFloat(5, goods.getPrice());
		pstmt.setFloat(6, goods.getCarriage());
		pstmt.setString(7, goods.getPdate());
		pstmt.setString(8, goods.getPaddress());
		pstmt.setString(9, goods.getDescribed());
		pstmt.setInt(10, goods.getNumber());
		result = pstmt.executeUpdate();
		pstmt.close();
		if (result == 1) {
			return true;
		}
		return false;
	}

	@Override
	public boolean deleteGoods(int gid) throws Exception {
		String sql = "delete from goods where gid=?";
		int result = 0;
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setInt(1, gid);
		result = pstmt.executeUpdate();
		pstmt.close();
		if (result == 1) {
			return true;
		}
		return false;
	}

	@Override
	public Goods queryById(int gid) throws Exception {
		Goods goods = null;
		ResultSet rs = null;
		String sql = "select * from goods where gid =?";
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setInt(1, gid);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			goods = new Goods();
			goods.setGid(rs.getInt("gid"));
			goods.setGname(rs.getString("gname"));
			goods.setNumber(rs.getInt("number"));
			goods.setPhoto(rs.getString("gphoto"));
			goods.setType(rs.getString("types"));
			goods.setProducer(rs.getString("producer"));
			goods.setPrice(rs.getFloat("price"));
			goods.setCarriage(rs.getFloat("carriage"));
			goods.setPdate(rs.getString("pdate"));
			goods.setPaddress(rs.getString("paddress"));
			goods.setDescribed(rs.getString("described"));
		}
		pstmt.close();
		rs.close();
		return goods;
	}

	@Override
	public int queryNumberById(int gid) throws Exception {
		ResultSet rs = null;
		String sql = "select number from goods where gid =?";
		int number = 0;
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setInt(1, gid);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			number = rs.getInt("number");
		}
		pstmt.close();
		rs.close();
		return number;
	}

	@Override
	public List<Goods> getLatestGoods(int gid, String type) throws Exception {
		List<Goods> goodsList = new ArrayList<Goods>();
		Goods goods;
		ResultSet rs = null;
		String sql = "select gid,gname,price from goods where gid != ? and types=? order by gid desc limit 4";
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setInt(1, gid);
		pstmt.setString(2, type);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			goods = new Goods();
			goods.setGid(rs.getInt("gid"));
			goods.setGname(rs.getString("gname"));
			goods.setPrice(rs.getFloat("price"));
			goodsList.add(goods);
		}
		return goodsList;
	}

	@Override
	public List<Goods> getAllGoods() throws Exception {
		String sql = "select * from goods order by gid desc";
		Statement st = null;
		ResultSet rs = null;
		st = (Statement) conn.createStatement();
		rs = st.executeQuery(sql);
		List<Goods> goodsList = new ArrayList<Goods>();
		Goods goods;
		while (rs.next()) {
			int gid = rs.getInt("gid");
			String gname = rs.getString("gname");
			int number = rs.getInt("number");
			String photo = rs.getString("gphoto");
			String type = rs.getString("types");
			String producer = rs.getString("producer");
			float price = rs.getFloat("price");
			float carriage = rs.getFloat("carriage");
			String pdate = rs.getDate("pdate").toString();
			String paddress = rs.getString("paddress");
			String described = rs.getString("described");
			goods = new Goods(gname, number, photo, type, producer, price,
					carriage, pdate, paddress, described);
			goods.setGid(gid);
			goodsList.add(goods);
		}
		return goodsList;
	}

	@Override
	public String[] queryTypes() throws Exception {
		String sql = "select distinct types from goods";
		Statement st = null;
		ResultSet rs = null;
		st = (Statement) conn.createStatement();
		rs = st.executeQuery(sql);
		String[] types = new String[10];
		int i = 0;
		while (rs.next()) {
			types[i] = rs.getString("types");
			i++;
		}
		return types;
	}

	@Override
	public List<Goods> getTypeGoodsList(String type) throws Exception {
		List<Goods> goodsList = new ArrayList<Goods>();
		Goods goods;
		ResultSet rs = null;
		String sql = "select gid,gname from goods where types=? order by gid desc;";
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setString(1, type);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			goods = new Goods();
			goods.setGid(rs.getInt("gid"));
			goods.setGname(rs.getString("gname"));
			goodsList.add(goods);
		}
		return goodsList;
	}

}
