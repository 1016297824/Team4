<%@page import="comm.dhee.dto.M002PR10201"%>
<%@page import="java.util.Map"%>
<%@page import="javafx.scene.control.Alert"%>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="comm.dhee.dto.M002"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>華信商会(株) 販売管理業務システム</title>
<meta name="renderer" content="webkit">

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/datetimepicker/bootstrap-datetimepicker.min.css"
	media="screen" />


</head>
<body>

	<!-- Top Begin -->
	<div class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container">
			<!-- Title Begin -->
			<div class="navbar-header">
				<a class="navbar-brand" href="#">
					<b>華信商会(株) 販売管理業務システム</b>
				</a>
			</div>
			<!-- Title End -->

			<!-- Menu Begin -->
			<div>
				<ul class="nav navbar-nav navbar-right">
					<li>
						<a href="aPR10101.action">首頁</a>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"
							aria-expanded="false">
							<span>受注管理</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="aPR10101.action">受注入力</a>
							</li>
							<li>
								<a href="aPR10201.action" id="productck" onclick="show();">商品別出庫表作成</a>
							</li>
							<li>
								<a href="aPR10301.action">顧客別受注実績月報作成</a>
							</li>
							<li>
								<a href="aPR10401.action">商品別受注実績月報作成</a>
							</li>
							<li>
								<a href="aPR10501.action">在庫情報確認</a>
							</li>
						</ul>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"
							aria-expanded="false">
							<span>売掛管理</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="aPR20101.action">売掛登録</a>
							</li>
							<li>
								<a href="aPR20201.action">代金請求</a>
							</li>
							<li>
								<a href="aPR20301.action">入金登録</a>
							</li>
						</ul>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"
							aria-expanded="false">
							<i class="glyphicon glyphicon-user"></i>
							<span>DHEE</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="alogin.action">退出</a>
							</li>
						</ul>
					</li>
					<li></li>
				</ul>
			</div>
			<!-- Menu End -->

		</div>
	</div>
	<!-- Top End -->

	<!-- Body Begin -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-6" align="left">
										<font style="font-size: 14px; line-height: 29px;">商品別出庫表作成</font>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<table class="table table-bordered" id="mytable">

									<tr>
										<th style="text-align: center;">商品コード</th>
										<th style="text-align: center;">商品名</th>
										<th style="text-align: center;">受注コード</th>
										<th style="text-align: center;">出庫数量</th>
										<th style="text-align: center;">合計出庫数量</th>
									</tr>

									<%-- <c:forEach items="${ m002list}" var="m002"> --%>



									<%
										List<M002PR10201> m002list = (ArrayList<M002PR10201>) request.getAttribute("m002list");
									%>
									<%
										if (m002list != null) {
											for (M002PR10201 m002 : m002list) {
									%>
									<tr>
										<td style="text-align: center;"><%=m002.getM00201()%></td>
										<td style="text-align: left;" class="hebing"><%=m002.getM00202()%></td>
										<td style="text-align: center;"><%=m002.getT00101()%></td>
										<td style="text-align: center;"><%=m002.getT00203()%></td>
										<td style="text-align: right;" class="hebing1"><%=m002.getSum()%></td>
									</tr>
									<%-- </c:forEach> --%>
									<%
										}
										}
									%>
								</table>

								<p id="p1" style="color: red;">${message }</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Body End -->

	<!-- Foot begin -->
	<div class="text-center text-muted"
		style="height: 40px; width: 100%; bottom: 0; position: fixed; line-height: 40px; background-color: #eee">
		<i class="glyphicon glyphicon-copyright-mark"></i>
		DHEE 2017 大連華信計算機新技術培訓中心. すべての知る権利を保留
	</div>

	<!-- Foot End -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/datetimepicker/bootstrap-datetimepicker.js"
		charset="UTF-8"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/datetimepicker/locales/bootstrap-datetimepicker.ja.js"
		charset="UTF-8"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/echarts.min.js"></script>
	<script src="js/jquery.min.js"></script>
	<script type="text/javascript">
		$(function() {

			$('.hebing').each(function(index, element) {

				if (!$(this).hasClass('hide')) {

					var next = $(this).parent('tr').next('tr').children('.hebing');

					$(this).attr('rowspan', 1);
					$(this).attr('style', "vertical-align: middle !important;text-align: center;");
					while ($(this).text() == next.text()) {
						$(this).attr('rowspan', parseInt($(this).attr('rowspan')) + 1);
						next.hide();
						next.addClass('hide');
						next = next.parent('tr').next('tr').children('.hebing');

					}
				}
			});
		});
	</script>
	<script type="text/javascript">
	$(function() {

		$('.hebing1').each(function(index, element) {

			if (!$(this).hasClass('hide')) {

				var next = $(this).parent('tr').next('tr').children('.hebing1');

				$(this).attr('rowspan', 1);
				$(this).attr('style', "vertical-align: middle !important;text-align: center;");
				while ($(this).text() == next.text()) {
					$(this).attr('rowspan', parseInt($(this).attr('rowspan')) + 1);
					next.hide();
					next.addClass('hide');
					next = next.parent('tr').next('tr').children('.hebing1');

				}
			}
		});
	});
	</script>
</body>
</html>