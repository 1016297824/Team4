<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<body onload="init();">
	<!-- Hidden -->
	<input type="hidden" id="userId" name="userId" value="${userId }" />
	<input type="hidden" id="hiddenNowProductAmount"
		name="hiddenNowProductAmount" value="" />
	<input type="hidden" id="hiddenProductName" name="hiddenProductName"
		value="" />
	<input type="hidden" id="hiddenUnitPrice" name="hiddenUnitPrice"
		value="" />
	<input type="hidden" id="hiddenCompany" name="hiddenCompany" value="" />
	<table id="hiddenCustomerTable" style="display: none;">
		<thead>
			<tr>
				<th style="text-align: center;">選択</th>
				<th style="text-align: center;">顧客コード</th>
				<th style="text-align: center;">顧客名</th>
				<th style="text-align: center;">信用限度額</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<table id="hiddenProductTable" style="display: none;">
		<thead>
			<tr>
				<th style="text-align: center;">選択</th>
				<th style="text-align: center;">商品コード</th>
				<th style="text-align: center;">商品名</th>
				<th style="text-align: center;">単価</th>
				<th style="text-align: center;">在庫数</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
	<nav id="hiddenNav" style="display: none;">
		<ul>
			<li>
				<a href="#"></a>
			</li>
			<li class="active">
				<a href="#"></a>
			</li>
		</ul>
	</nav>

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
								<a href="aPR10201.action">商品別出庫表作成</a>
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
							<span>${userName }</span>
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
										<font style="font-size: 14px; line-height: 29px;">受注情報</font>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-4">
										<div class="input-group">
											<span class="input-group-addon">顧客コード</span>
											<input type="text" class="form-control" id="customerCode"
												name="customerCode">
											<span class="input-group-addon">
												<a id="aCustomer" href="#" data-toggle="modal"
													data-target="#customerModal">
													<span class="glyphicon glyphicon-search"></span>
												</a>
											</span>
										</div>
										<p id="customerCodeMessage" style="color: red;"></p>
									</div>
									<div class="col-md-6">
										<div class="input-group date form_date">
											<span class="input-group-addon">納入希望日（省略時翌日）</span>
											<input id="date" name="date" type="text" class="form-control"
												readonly>
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-md-10">
										<div class="input-group">
											<span class="input-group-addon">納入先（省略時現住所）</span>
											<input id="locationId" name="locationId" type="text"
												class="form-control">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-6" align="left">
										<font style="font-size: 14px; line-height: 29px;">受注商品明細</font>
									</div>
									<div class="col-md-6" align="right">
										<button id="selectAllProdects" type="button"
											class="btn btn-primary btn-sm" data-toggle="modal"
											data-target="#goodsModal">追加</button>
										<button type="button" class="btn btn-default btn-sm"
											id="clearProducts">クリア</button>
										<button type="submit" class="btn btn-warning btn-sm"
											onclick="issuePR10101();">発行</button>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<table id="injectionTable" class="table table-bordered">
									<thead>
										<tr>
											<th style="text-align: center;">項番</th>
											<th style="text-align: center;">商品コード</th>
											<th style="text-align: center;">商品名</th>
											<th style="text-align: center;">単価</th>
											<th style="text-align: center;">単位</th>
											<th style="text-align: center;">在庫数</th>
											<th style="text-align: center;">売上数量</th>
											<th style="text-align: center;">
												<input type="checkbox" name="checkInjection" id="checkbox0" />
											</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Body End -->

	<!-- Customer Modal -->
	<div class="modal fade" id="customerModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">顧客情報</h4>
				</div>
				<div class="modal-body">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="row">
								<div class="col-md-6" align="left">
									<div class="input-group">
										<span class="input-group-addon">顧客名</span>
										<input id="customerName" name="customerName" type="text"
											class="form-control" autofocus>
										<p id="customerMessage">${customerMessage }</p>
									</div>
								</div>
								<div class="col-md-6" align="right">
									<button id="selectCustomer" type="submit"
										class="btn btn-primary btn-sm">検索</button>
								</div>
							</div>
						</div>
						<div class="panel-body" id="pageCustomer">
							<table class="table table-bordered" id="customerTable">
								<thead>
									<tr>
										<th style="text-align: center;">選択</th>
										<th style="text-align: center;">顧客コード</th>
										<th style="text-align: center;">顧客名</th>
										<th style="text-align: center;">信用限度額</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<nav class="page">
								<ul class="pagination">
									<li>
										<a href="#">«</a>
									</li>
									<li>
										<a href="#">1</a>
									</li>
									<li>
										<a href="#">2</a>
									</li>
									<li>
										<a href="#">3</a>
									</li>
									<li>
										<a href="#">4</a>
									</li>
									<li>
										<a href="#">5</a>
									</li>
									<li>
										<a href="#">» </a>
									</li>
								</ul>
							</nav>
						</div>
						<div class="col-lg-12" align="center">
							<!-- 分页控件，标签必须是<ul> -->
							<ul id="pageButton"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Goods Modal -->
	<div class="modal fade" id="goodsModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">商品追加</h4>
				</div>
				<div class="modal-body">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="row">
								<div class="col-md-6" align="left">
									<div class="input-group">
										<span class="input-group-addon">商品名</span>
										<input type="text" class="form-control" id="productName"
											name="productName">
									</div>
								</div>
								<div class="col-md-6" align="right">
									<button type="button" class="btn btn-primary btn-sm"
										id="selectProducts">検索</button>
								</div>
							</div>
						</div>
						<div class="panel-body" id="pageProduct">
							<table class="table table-bordered" id="productTable">
								<thead>
									<tr>
										<th style="text-align: center;">選択</th>
										<th style="text-align: center;">商品コード</th>
										<th style="text-align: center;">商品名</th>
										<th style="text-align: center;">単価</th>
										<th style="text-align: center;">在庫数</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<nav class="page">
								<ul class="pagination">
									<li>
										<a href="#">«</a>
									</li>
									<li>
										<a href="#">1</a>
									</li>
									<li>
										<a href="#">2</a>
									</li>
									<li>
										<a href="#">3</a>
									</li>
									<li>
										<a href="#">4</a>
									</li>
									<li>
										<a href="#">5</a>
									</li>
									<li>
										<a href="#">»</a>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="row">
						<div class="col-md-4" align="left">
							<div class="input-group">
								<span class="input-group-addon">商品コード</span>
								<input id="productId" name="productId" type="text"
									class="form-control" readonly>
							</div>
						</div>
						<div class="col-md-4" align="left">
							<div class="input-group">
								<span class="input-group-addon">売上数量</span>
								<input type="text" class="form-control" id="productAmount"
									name="productAmount">
							</div>
							<p id="productAmountMessage" style="color: red;"></p>
						</div>
						<div class="col-md-4" align="right">
							<button type="button" class="btn btn-primary btn-sm"
								id="productAdd">確認</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

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
		src="${pageContext.request.contextPath }/js/PR10101.js"
		charset="UTF-8"></script>

</body>
</html>