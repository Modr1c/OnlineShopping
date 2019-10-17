<%@page import="com.lzd.bean.AlreadyBuy"%>
<%@page import="com.lzd.dao.AlreadyBuyDao"%>
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
<title>已购买</title>
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
		return confirm("确定支付订单吗？");
	}
</script>
</head>
<body>
	<jsp:include page="head.jsp"></jsp:include>
	<div class="container">
		<div class="check-out">
			<h1>购买历史</h1>
			<table>
				<tr>
					<th>商品</th>
					<th>数量</th>
					<th>价格</th>
					<th>运费</th>
					<th>总价</th>
					<th>购买时间</th>
				</tr>
				<%
					String strUid = (String) session.getAttribute("uid");
					int uid = 0;
					if (strUid != null) {
						uid = Integer.parseInt(strUid);
					}
					AlreadyBuyDao dao = DAOFactory.getAlreadyBuyServiceInstance();
					List<AlreadyBuy> abList = dao.getAllBuyGoods(uid);
					if (abList != null & abList.size() > 0) {
						GoodsDao goodsDao = DAOFactory.getGoodsServiceInstance();
						Goods goods;
						AlreadyBuy ab;
						int gid;
						int number;
						String buyTime;
						String photoPath;
						float price;
						float totalPrice;
						for (int i = 0; i < abList.size(); i++) {
							ab = abList.get(i);
							gid = ab.getGid();
							number = ab.getNumber();
							buyTime = ab.getBuyTime();
							goods = goodsDao.queryById(gid);
							photoPath = "images/" + goods.getPhoto().split("&")[0];
							price = goods.getPrice();
							totalPrice = number * price + goods.getCarriage();
				%>
				<tr>
					<td class="ring-in"><a
						href="jsp/goodsDescribed.jsp?gid=<%=goods.getGid()%>"
						class="at-in"> <img src="<%=photoPath%>"
							class="img-responsive" alt="">
					</a>
						<div class="sed">
							<h5>
								<%=goods.getGname()%></h5>
							<br>
						</div>
						<div class="clearfix"></div></td>
					<td><%=number%></td>
					<td><%=price%>元</td>
					<td><%=goods.getCarriage()%>元</td>
					<%
						
					%>
					<td><%=totalPrice%>元</td>
					<td><%=buyTime%></td>
				</tr>
				<%
					}
					}
				%>
			</table>
		</div>
	</div>
</body>
</html>