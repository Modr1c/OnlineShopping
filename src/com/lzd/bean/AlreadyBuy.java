package com.lzd.bean;

/*
已购买类
 */
public class AlreadyBuy {

	// 主键
	private int aid;
	// 用户ID
	private int uid;
	// 商品ID
	private int gid;
	// 购买数量
	private int number;
	// 购买时间
	private String buyTime;

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
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

	public String getBuyTime() {
		return buyTime;
	}

	public void setBuyTime(String buyTime) {
		this.buyTime = buyTime;
	}

}
