<%@page import="com.lzd.bean.Goods"%>
<%@page import="com.lzd.dao.GoodsDao"%>
<%@page import="com.lzd.service.GoodsService"%>
<%@page import="com.lzd.bean.ShoppingCart"%>
<%@page import="java.util.List"%>
<%@page import="com.lzd.factory.DAOFactory"%>
<%@page import="com.lzd.dao.ShoppingCartDao"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<title>购物车</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/another_style.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/memenu.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/memenu.js"></script>
<script type="text/javascript" src="js/simpleCart.min.js"></script>
<script type="text/javascript">
	function confirmBuy() {
		return confirm("确定支付吗？");
	}
	function confirmDelete() {
		return confirm("确认删除订单吗");
	}
</script>
</head>
<body>
	<jsp:include page="head.jsp"></jsp:include>
	<div class="container">
		<div class="check-out">
			<h1>所有订单</h1>
			<table>
				<tr>
					<th>商品</th>
					<th>数量</th>
					<th>价格</th>
					<th>运费</th>
					<th>总价</th>
				</tr>
				<%
					String strUid = (String) session.getAttribute("uid");
					int uid = 0;
					if (strUid != null) {
						uid = Integer.parseInt(strUid);
					}
					ShoppingCartDao dao = DAOFactory.getShoppingCartServiceInstance();
					GoodsDao goodsDao = DAOFactory.getGoodsServiceInstance();
					List<ShoppingCart> cartList = dao.getAllGoods(uid);
					float allTotalPrice = 0;
					if (cartList != null & cartList.size() > 0) {
						ShoppingCart cart;
						Goods goods;
						String photoPath;
						int number;
						float price;
						float totalPrice;
						int gid;
						for (int i = 0; i < cartList.size(); i++) {
							cart = cartList.get(i);
							goods = goodsDao.queryById(cart.getGid());
							photoPath = "images/" + goods.getGname() + "1.jpg";
							number = cart.getNumber();
							price = goods.getPrice();
							gid = goods.getGid();
							totalPrice = number * price + goods.getCarriage();
							allTotalPrice = allTotalPrice + totalPrice;
				%>
				<tr>
					<td class="ring-in"><a
						href="jsp/goodsDescribed.jsp?gid=<%=goods.getGid()%>"
						class="at-in"> <img src="<%=photoPath%>"
							class="img-responsive" alt="">
					</a>
						<div class="sed">
							<h5>
								商品名：<%=goods.getGname()%></h5>
							<br>
							<p>
								加入购物车时间：<%=cart.getSdate()%></p>
						</div>
						<div class="clearfix"></div></td>
					<td><%=number%></td>
					<td><%=price%>元</td>
					<td><%=goods.getCarriage()%>元</td>
					<td><%=totalPrice%>元</td>
					<td><a
						href="jsp/deleteGoods.jsp?gid=<%=gid%>&number=<%=number%>"
						onclick="return confirmDelete()">删除</a></td>
				</tr>
				<%
					}
					}
				%>
			</table>
			<a>总计：<%=allTotalPrice%>元
			</a> &nbsp;&nbsp;&nbsp;
			<%
				if (cartList != null & cartList.size() > 0) {
			%>
			<a href="jsp/buyGoods.jsp" class="to-buy"
				onclick="return confirmBuy()">&nbsp;&nbsp;&nbsp;支付&nbsp;&nbsp;&nbsp;</a>
			<%
				} else {
			%>
			<a class="to-buy">&nbsp;&nbsp;&nbsp;支付&nbsp;&nbsp;&nbsp;</a>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>