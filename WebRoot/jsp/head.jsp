<%@page import="com.lzd.util.OnlineCounter"%>
<%@page import="com.lzd.bean.Goods"%>
<%@page import="java.util.List"%>
<%@page import="com.lzd.factory.DAOFactory"%>
<%@page import="com.lzd.dao.GoodsDao"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<%
	String uname = (String) session.getAttribute("uname");
	String uid = String.valueOf(session.getAttribute("uid"));
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/another_style.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/memenu.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/responsiveslides.min.js"></script>
<script type="text/javascript" src="js/memenu.js"></script>
<script>
	$(document).ready(function() {
		$(".memenu").memenu();
	});
</script>
<script type="text/javascript">
	function key() {
		return confirm("确定退出吗？");
	}
</script>
<script>
	function showtime() {
		var myDate = new Date();
		document.getElementById("time").innerHTML = myDate.getHours() + "点"
				+ myDate.getMinutes() + "分" + myDate.getSeconds() + "秒";
		setTimeout("showtime()", 1000);
	}
</script>
</head>
<body>
	<!--header-->
	<div class="header">
		<div class="header-top">
			<div class="container">
				<div class="col-sm-4 world">
					<ul>
						<li></li>
					</ul>
				</div>
				<div class="col-sm-4 logo">
					<a href="index.jsp"><img src="images/logo.png" alt=""></a>
				</div>
				<div class="col-sm-4 header-left">
					<p class="log">
						<%
							if (uname != null) {
												out.print("<a>" + uname + ",欢迎登录" + "</a>");
												out.print("<a href=\"jsp/showMessage.jsp\" target=\"_blank\">"
														+ "个人信息" + "</a>");
												out.print("<a href=\"servlet/LogoutServlet\" onClick=\"return key()\">"
														+ "退出" + "</a>");
											} else {
												out.print("<a href=\"jsp/login.jsp\">请登录</a>");
												out.print("<a>or</a>");
												out.print("<a href=\"jsp/register.jsp\">注册</a>");
											}
						%>
						<a id="time"><script type="text/javascript">
							showtime();
						</script> </a> <a>在线人数:<%=OnlineCounter.getOnline()%></a>
					</p>
					<div class="cart box_1">
						<a href="jsp/shoppingCart.jsp"> <img src="images/cart.png"
							alt="" />
							<h3>购物车</h3>
						</a>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="head-top">
				<div class="col-sm-8 h_menu4">
					<ul class="memenu skyblue">
						<li class=" grid"><a href="index.jsp">首页</a></li>
						<li><a>分类</a>
							<div class="mepanel">
								<div class="row">
									<%
										GoodsDao dao = DAOFactory.getGoodsServiceInstance();
										String[] types = dao.queryTypes();
										if (types != null & types.length > 0) {
											String type;
											List<Goods> goodsList;
											Goods goods;
											for (int i = 0; i < types.length; i++) {
												if (types[i] != null & !"".equals(types[i])) {
													type = types[i];
													goodsList = dao.getTypeGoodsList(type);
									%>
									<div class="col1">
										<div class="h_nav">
											<h4><%=type%></h4>
											<ul>
												<%
													if (goodsList != null & goodsList.size() > 0) {
																	for (int j = 0; j < goodsList.size(); j++) {
																		goods = goodsList.get(j);
												%>
												<li><a
													href="jsp/goodsDescribed.jsp?gid=<%=goods.getGid()%>"
													target="_blank"><%=goods.getGname()%></a></li>
												<%
													}
																}
												%>
											</ul>
										</div>
									</div>
									<%
										}
											}
										}
									%>
								</div>
							</div></li>
						<li><a href="jsp/shoppingCart.jsp">购物车</a></li>
						<li><a href="jsp/alreadyBuy.jsp">已购买</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>