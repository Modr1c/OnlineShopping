package com.lzd.bean;

public class ShoppingCart {

	// 主键
	private int sid;
	// 用户ID
	private int uid;
	// 商品ID
	private int gid;
	// 商品库存
	private int number;
	// 加入购物车时间
	private String sdate;

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public int getGid() {
		return gid;
	}

	public void setGid(int gid) {
		this.gid = gid;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

}
