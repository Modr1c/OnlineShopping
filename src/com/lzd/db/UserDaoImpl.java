package com.lzd.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.lzd.bean.User;
import com.lzd.dao.UserDao;

public class UserDaoImpl implements UserDao {

	private Connection conn = null;

	private PreparedStatement pstmt = null;

	public UserDaoImpl(Connection conn) {
		this.conn = conn;
	}
	
	//添加用户
	@Override
	public boolean addUser(User user) throws Exception {
		pstmt = null;
		String sql = "insert into users(uname,passwd,email,lastLogin)value(?,?,?,sysdate());";
		int result = 0;
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setString(1, user.getUname());
		pstmt.setString(2, user.getPasswd());
		pstmt.setString(3, user.getEmail());
		result = pstmt.executeUpdate();
		pstmt.close();
		if (result == 1) {
			return true;
		}
		return false;
	}
	
	//编辑电子邮箱
	@Override
	public boolean editEmail(int uid, String email) throws Exception {
		User user = queryByEmail(email);
		if (user != null && user.getUid() != uid) {
			return false;
		}
		pstmt = null;
		String sql = "update users set email=? where uid=?";
		int result = 0;
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setInt(2, uid);
		result = pstmt.executeUpdate();
		pstmt.close();
		if (result == 1) {
			return true;
		}
		return false;
	}

	//编辑登录时间
	@Override
	public boolean editLoginTime(int uid) throws Exception {
		pstmt = null;
		String sql = "update users set lastLogin=sysdate() where uid=?";
		int result = 0;
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setInt(1, uid);
		result = pstmt.executeUpdate();
		pstmt.close();
		if (result == 1) {
			return true;
		}
		return false;
	}

	// 编辑密码
	@Override
	public boolean editPasswd(int uid, String passwd) throws Exception {
		String sql = "update users set passwd=? where uid=" + uid;
		int result = 0;
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setString(1, passwd);
		result = pstmt.executeUpdate();
		pstmt.close();
		if (result == 1) {
			return true;
		}
		return false;
	}

	// 删除用户
	@Override
	public boolean deleteUser(int uid) throws Exception {
		String sql = "delete from Users where uid=?";
		int result = 0;
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setInt(1, uid);
		result = pstmt.executeUpdate();
		pstmt.close();
		if (result == 1) {
			return true;
		}
		return false;
	}
	
	// 通过用户名查找用户
	@Override
	public User queryByName(String uname) throws Exception {
		User user = null;
		ResultSet rs = null;
		String sql = "select * from users where uname =?";
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setString(1, uname);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			user = new User();
			int uid = rs.getInt("uid");
			String passwd = rs.getString("passwd");
			String email = rs.getString("email");
			user.setUid(uid);
			user.setUname(uname);
			user.setPasswd(passwd);
			user.setEmail(email);
			String date = rs.getDate("lastlogin").toString();
			String time = rs.getTime("lastlogin").toString();
			user.setLastLogin(date + "��" + time);
		}
		pstmt.close();
		rs.close();
		return user;
	}

	// ͨ通过电子邮箱查找用户
	@Override
	public User queryByEmail(String email) throws Exception {
		User user = null;
		ResultSet rs = null;
		String sql = "select * from users where email=?";
		pstmt = this.conn.prepareStatement(sql);
		pstmt.setString(1, email);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			user = new User();
			int uid = rs.getInt("uid");
			String uname = rs.getString("uname");
			String passwd = rs.getString("passwd");
			user.setUid(uid);
			user.setUname(uname);
			user.setPasswd(passwd);
			user.setEmail(email);
			String date = rs.getDate("lastlogin").toString();
			String time = rs.getTime("lastlogin").toString();
			user.setLastLogin(date + "��" + time);
		}
		pstmt.close();
		rs.close();
		return user;
	}

}
