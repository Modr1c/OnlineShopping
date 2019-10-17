package com.lzd.dao;

import com.lzd.bean.User;

public interface UserDao {

	// 添加用户
	public boolean addUser(User user) throws Exception;

	// 编辑电子邮箱
	public boolean editEmail(int uid, String email)
			throws Exception;

	// 编辑密码
	public boolean editPasswd(int uid, String passwd) throws Exception;

	// 编辑登录时间
	public boolean editLoginTime(int uid) throws Exception;

	// 删除用户
	public boolean deleteUser(int uid) throws Exception;

	// 通过用户名查找用户
	public User queryByName(String uname) throws Exception;

	// ͨ通过电子邮箱查找用户
	public User queryByEmail(String email) throws Exception;

}
