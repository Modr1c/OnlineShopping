<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="com.lzd.dao.GoodsDao"%>
<%@ page import="com.lzd.bean.Goods"%>
<%@ page import="java.util.List"%>
<%@ page import="com.lzd.factory.DAOFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	int gid = Integer.parseInt(request.getParameter("gid"));
%>
<%
	GoodsDao dao = DAOFactory.getGoodsServiceInstance();
	Goods goods = dao.queryById(gid);
	String name = goods.getGname();
	int number = goods.getNumber();	
	String[] photo = goods.getPhoto().split("&");		
	String type = goods.getType();
	String producer = goods.getProducer();
	float price = goods.getPrice();
	float carriage = goods.getCarriage();
	String pdate = goods.getPdate();
	String paddress = goods.getPaddress();
	String described = goods.getDescribed();
%>
<!DOCTYPE html>
<html>
<head>
<title>商品详情</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/another_style.css" rel="stylesheet" type="text/css"
	media="all" />
<link rel="stylesheet" href="css/flexslider.css" type="text/css"
	media="screen" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/imagezoom.js"></script>
<script type="text/javascript" src="js/memenu.js"></script>
<script defer src="js/jquery.flexslider.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".memenu").memenu();
	});
</script>
<script type="text/javascript">
	$(window).load(function() {
		$('.flexslider').flexslider({
			animation : "slide",
			controlNav : "thumbnails"
		});
	});
</script>
<script type="text/javascript">
	$(function() {
		var menu_ul = $('.menu-drop > li > ul'), menu_a = $('.menu-drop > li > a');
		menu_ul.hide();
		menu_a.click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass('active')) {
				menu_a.removeClass('active');
				menu_ul.filter(':visible').slideUp('normal');
				$(this).addClass('active').next().stop(true, true).slideDown(
						'normal');
			} else {
				$(this).removeClass('active');
				$(this).next().stop(true, true).slideUp('normal');
			}
		});

	});
</script>
<script type="text/javascript">
	function editHref() {
		var number = document.getElementById("buyNumber").value;
		if (number >
<%=number%>
	) {
			alert("要购买的数量大于库存，请重新选择");
			return false;
		}
		document.getElementById("carthref").href = document
				.getElementById("carthref").href
				+ number;
	}
</script>
</head>
<body>
	<jsp:include page="head.jsp"></jsp:include>
	<div class="single">
		<div class="container">
			<div class="col-md-9">
				<div class="col-md-5 grid">
					<div class="flexslider">
						<ul class="slides">
							<%
								if (photo != null & photo.length > 0) {
									for (int i = 0; i < photo.length; i++) {
							%>
							<li data-thumb="images/<%=photo[i]%>">
								<div class="thumb-image">
									<img src="images/<%=photo[i]%>" data-imagezoom="true"
										class="img-responsive">
								</div>
							</li>
							<%
								}
								}
							%>
						</ul>
					</div>
				</div>
				<div class="col-md-7 single-top-in">
					<div class="single-para simpleCart_shelfItem">
						<h1><%=name%></h1>
						<p><%=described%></p>
						<div class="star-on">
							<div class="review">
								<a>出产地：<%=producer%></a> <br> <a><%=paddress%></a> / <a>运费：<%=carriage%>元
								</a> / <a>库存：<%=number%></a>
							</div>
							<div class="clearfix"></div>
						</div>
						<label class="add-to item_price"><%=price%>元</label>
						<div class="available">
							<h6>购买数量 :</h6>
							<input name="buyNumber" type="number" min="1" max=<%=number%>
								value="1" id="buyNumber">
						</div>
						<a id="carthref" href="jsp/addToCart.jsp?gid=<%=gid%>&buyNumber="
							class="cart item_add" onclick="return editHref()">加入购物车</a>
					</div>
				</div>
			</div>
			<div class="col-md-3 product-bottom">
				<div class="product-bottom">
					<h3 class="cate">最新商品</h3>
					<%
						List<Goods> latestGoods = dao.getLatestGoods(gid, type);
						if (latestGoods != null & latestGoods.size() > 0) {
							for (int i = 0; i < latestGoods.size(); i++) {
								String goodsName = latestGoods.get(i).getGname();
								String goodsHref = "jsp/goodsDescribed.jsp?gid="
										+ latestGoods.get(i).getGid();
								String goodsPhoto = "images/" + goodsName + "1.jpg";
								float goodsPrice = latestGoods.get(i).getPrice();
					%>
					<div class="product-go">
						<div class=" fashion-grid">
							<a href=<%=goodsHref%> target="_blank"> <img
								class="img-responsive " src=<%=goodsPhoto%> alt=""></a>
						</div>
						<div class=" fashion-grid1">
							<h6 class="best2">
								<a href=<%=goodsHref%> target="_blank"><%=goodsName%></a>
							</h6>
							<span class=" price-in1"> <%=goodsPrice%>元
							</span>
						</div>
						<div class="clearfix"></div>
					</div>
					<%
						}
						}
					%>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</body>
</html>