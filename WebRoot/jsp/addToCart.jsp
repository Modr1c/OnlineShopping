<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.lzd.factory.DAOFactory"%>
<%@page import="com.lzd.dao.ShoppingCartDao"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>加入购物车</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
<body>
	<%
		String strUid = (String) session.getAttribute("uid");
		int uid = 0;
		if (strUid != null) {
			uid = Integer.parseInt(strUid);
		}
		int gid = Integer.valueOf(request.getParameter("gid"));
		int number = Integer.valueOf(request.getParameter("buyNumber"));
		ShoppingCartDao dao = DAOFactory.getShoppingCartServiceInstance();
		boolean flag = dao.addGoods(uid, gid, number);
		if (flag) {
			response.sendRedirect("shoppingCart.jsp");
		} else {
	%>
	加入购物车失败，请重试。
	<%
		}
	%>
</body>
</html>
