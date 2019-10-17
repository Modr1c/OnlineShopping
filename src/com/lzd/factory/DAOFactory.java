package com.lzd.factory;

import com.lzd.dao.AlreadyBuyDao;
import com.lzd.dao.GoodsDao;
import com.lzd.dao.ShoppingCartDao;
import com.lzd.dao.UserDao;
import com.lzd.service.AlreadyBuyService;
import com.lzd.service.GoodsService;
import com.lzd.service.ShoppingCartService;
import com.lzd.service.UserService;

public class DAOFactory {

	public static UserDao getUserServiceInstance() throws Exception {
		return new UserService();
	}

	public static GoodsDao getGoodsServiceInstance() throws Exception {
		return new GoodsService();
	}

	public static ShoppingCartDao getShoppingCartServiceInstance()
			throws Exception {
		return new ShoppingCartService();
	}

	public static AlreadyBuyDao getAlreadyBuyServiceInstance() throws Exception {
		return new AlreadyBuyService();
	}
}
