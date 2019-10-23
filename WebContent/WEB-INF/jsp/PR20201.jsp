<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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

<body>
	<!-- Hidden -->
	<table id="hiddenCustomerTable" style="display: none;">
		<thead>
			<tr>
				<th style="text-align: center;">選択</th>
				<th style="text-align: center;">顧客コード</th>
				<th style="text-align: center;">顧客名</th>
				<th style="text-align: center;">信用限度額</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

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
	<form action="PR20202_1.action" method="post">
		<div class="container">
			<div class="row">
				<div class="col-md-12">

					<div class="row">
						<div class="col-md-12">
							<div class="panel panel-default">
								<div class="panel-heading">
									<div class="row">
										<div class="col-md-6" align="left">
											<font style="font-size: 14px; line-height: 29px;">代金請求</font>
										</div>
										<div class="col-md-6" align="right">
											<button type="submit" class="btn btn-primary btn-sm"
												data-toggle="modal" data-target="#goodsModal"
												id="MakeRequestView" name="MakeRequestView">作成</button>
											<button type="reset" class="btn btn-default btn-sm">クリア</button>

										</div>
									</div>
								</div>
								<div class="panel-body">
									<div class="row">
										<div class="col-md-4">
											<div class="input-group">
												<span class="input-group-addon">顧客コード</span>
												<input type="text" class="form-control" id="CustomerID"
													name="CustomerID">
												<span class="input-group-addon">
													<a href="#" data-toggle="modal"
														data-target="#customerModal" id="AllCustomer">
														<span class="glyphicon glyphicon-search"></span>
													</a>
												</span>
											</div>
										</div>
										<div class="col-md-4">
											<div class="input-group date form_date">
												<span class="input-group-addon">請求日付</span>
												<input type="text" class="form-control" id="RequestDate"
													name="RequestDate"
													value="<%=new SimpleDateFormat(" yyyy-MM-dd ").format(Calendar.getInstance().getTime())%>">
												<span class="input-group-addon">
													<span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>

			</div>
			<span style="color: red;">${PR20201message}</span>
		</div>

	</form>
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
										<input type="text" class="form-control" id="CustomerName"
											name="CustomerName">
									</div>
								</div>
								<div class="col-md-6" align="right">
									<button type="submit" class="btn btn-primary btn-sm"
										id="OneCustomer" name="OneCustomer">検索</button>
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
										<a href="#">« </a>
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
		src="${pageContext.request.contextPath }/js/echarts.min.js"></script>

	<script type="text/javascript">
		//init datetimepicker
		$(".form_date").datetimepicker({
			language : 'ja', //i18N
			autoclose : true, //autoclose
			todayHighlight : true, //todayHighlight
			todayBtn : true, //todayBtn
			minView : "month", //minView
			format : "yyyy-mm-dd", //format
			pickerPosition : "bottom-left" //pickerPosition:bottom-left
		});

		$("#AllCustomer").click(
				function() {
					$.ajax({
						type : "post",
						url : "PR20201Customers.action",
						dataType : "json",
						data : {},
						async : true,
						success : function(data) {
							//console.log(data);
							$("#hiddenCustomerTable tbody").empty();
							$.each(data.cusList, function(key, val) {
								$("#hiddenCustomerTable tbody").append(
										'<tr>' + '<td style="text-align: center;">' + '<a href="#" data-dismiss="modal" onclick="customerClick(' + val.id + ');">'
												+ '<span class="glyphicon glyphicon-check"></span>' + '</a>' + '</td>' + '<td style="text-align: center;">' + val.id + '</td>'
												+ '<td style="text-align: left;">' + val.name + '</td>' + '<td style="text-align: right;">' + val.quota + '</td>' + '</tr>');
							});

							var ina = $(this).html();
							var htr = $("#hiddenCustomerTable tbody tr");
							var len = Number(htr.length);
							var page = Math.ceil(len / 5);
							var li = $("#pageCustomer ul li");
							var a = $("#pageCustomer ul a");
							a.css('display', 'block');
							if (page <= 5) {
								var n = 1;
								var end = 5 * n;
								var start = end - 5;
								$("#customerTable tbody").empty();
								for (var i = start; i < end; i++) {
									var tr = htr.eq(i).clone();
									$("#customerTable tbody").append(tr);
								}
								a.css('display', 'none');
								for (var i = 0; i < page + 2; i++) {
									li.eq(i).removeClass("active");
									if (i == 0) {
										a.eq(i).html("«");
										a.eq(i).css('display', 'block');
									} else if (i == page + 1) {
										a.eq(i).html("»");
										a.eq(i).css('display', 'block');
									} else if (i == n) {
										li.eq(i).attr("class", "active");
										a.eq(i).html(i);
										a.eq(i).css('display', 'block');
									} else {
										if (i <= page) {
											a.eq(i).html(i);
											a.eq(i).css('display', 'block');
										}
									}
								}
							} else {
								var n = 1;
								var end = 5 * n;
								var start = end - 5;
								$("#customerTable tbody").empty();
								for (var i = start; i < end; i++) {
									var tr = htr.eq(i).clone();
									$("#customerTable tbody").append(tr);
								}
								for (var i = 0; i < 7; i++) {
									li.eq(i).removeClass("active");
									if (i == 0) {
										a.eq(i).html("«");
									} else if (i == 6) {
										a.eq(i).html("»");
									} else if (i == 1) {
										li.eq(i).attr("class", "active");
										a.eq(i).html(i);
									} else {
										a.eq(i).html(i);
									}
								}
							}
						}
					});
				});

		$("#OneCustomer").click(
				function() {
					$.ajax({
						type : "post",
						url : "PR20201Customers2.action",
						dataType : "json",
						data : "CustomerName=" + $("#CustomerName").val(),
						async : true,
						success : function(data) {
							//console.log(data);
							$("#hiddenCustomerTable tbody").empty();
							$.each(data.cusList2, function(key, val) {
								$("#hiddenCustomerTable tbody").append(
										'<tr>' + '<td style="text-align: center;">' + '<a href="#" data-dismiss="modal" onclick="customerClick(' + val.id + ');">'
												+ '<span class="glyphicon glyphicon-check"></span>' + '</a>' + '</td>' + '<td style="text-align: center;">' + val.id + '</td>'
												+ '<td style="text-align: left;">' + val.name + '</td>' + '<td style="text-align: right;">' + val.quota + '</td>' + '</tr>');
							});

							var ina = $(this).html();
							var htr = $("#hiddenCustomerTable tbody tr");
							var len = Number(htr.length);
							var page = Math.ceil(len / 5);
							var li = $("#pageCustomer ul li");
							var a = $("#pageCustomer ul a");
							a.css('display', 'block');
							if (page <= 5) {
								var n = 1;
								var end = 5 * n;
								var start = end - 5;
								$("#customerTable tbody").empty();
								for (var i = start; i < end; i++) {
									var tr = htr.eq(i).clone();
									$("#customerTable tbody").append(tr);
								}
								a.css('display', 'none');
								for (var i = 0; i < page + 2; i++) {
									li.eq(i).removeClass("active");
									if (i == 0) {
										a.eq(i).html("«");
										a.eq(i).css('display', 'block');
									} else if (i == page + 1) {
										a.eq(i).html("»");
										a.eq(i).css('display', 'block');
									} else if (i == n) {
										li.eq(i).attr("class", "active");
										a.eq(i).html(i);
										a.eq(i).css('display', 'block');
									} else {
										if (i <= page) {
											a.eq(i).html(i);
											a.eq(i).css('display', 'block');
										}
									}
								}
							} else {
								var n = 1;
								var end = 5 * n;
								var start = end - 5;
								$("#customerTable tbody").empty();
								for (var i = start; i < end; i++) {
									var tr = htr.eq(i).clone();
									$("#customerTable tbody").append(tr);
								}
								for (var i = 0; i < 7; i++) {
									li.eq(i).removeClass("active");
									if (i == 0) {
										a.eq(i).html("«");
									} else if (i == 6) {
										a.eq(i).html("»");
									} else if (i == 1) {
										li.eq(i).attr("class", "active");
										a.eq(i).html(i);
									} else {
										a.eq(i).html(i);
									}
								}
							}
						}
					});
				});

		function customerClick(id) {
			$("#CustomerID").val(id);
		}

		$("#pageCustomer ul a").click(function() {
			var ina = $(this).html();
			var htr = $("#hiddenCustomerTable tbody tr");
			var len = Number(htr.length);
			var page = Math.ceil(len / 5);
			var li = $("#pageCustomer ul li");
			var a = $("#pageCustomer ul a");
			if (ina == "«") {
				if (page <= 5) {
					var n = 1;
					var end = 5 * n;
					var start = end - 5;
					$("#customerTable tbody").empty();
					for (var i = start; i < end; i++) {
						var tr = htr.eq(i).clone();
						$("#customerTable tbody").append(tr);
					}
					a.css('display', 'none');
					for (var i = 0; i < page + 2; i++) {
						li.eq(i).removeClass("active");
						if (i == 0) {
							a.eq(i).html("«");
							a.eq(i).css('display', 'block');
						} else if (i == page + 1) {
							a.eq(i).html("»");
							a.eq(i).css('display', 'block');
						} else if (i == n) {
							li.eq(i).attr("class", "active");
							a.eq(i).html(i);
							a.eq(i).css('display', 'block');
						} else {
							if (i <= page) {
								a.eq(i).html(i);
								a.eq(i).css('display', 'block');
							}
						}
					}
				} else {
					var n = 1;
					var end = 5 * n;
					var start = end - 5;
					$("#customerTable tbody").empty();
					for (var i = start; i < end; i++) {
						var tr = htr.eq(i).clone();
						$("#customerTable tbody").append(tr);
					}
					for (var i = 0; i < 7; i++) {
						li.eq(i).removeClass("active");
						if (i == 0) {
							a.eq(i).html("«");
						} else if (i == 6) {
							a.eq(i).html("»");
						} else if (i == 1) {
							li.eq(i).attr("class", "active");
							a.eq(i).html(i);
						} else {
							a.eq(i).html(i);
						}
					}
				}
			} else if (ina == "»") {
				if (page <= 5) {
					var n = page;
					var end = 5 * n;
					var start = end - 5;
					$("#customerTable tbody").empty();
					for (var i = start; i < end; i++) {
						var tr = htr.eq(i).clone();
						$("#customerTable tbody").append(tr);
					}
					a.css('display', 'none');
					for (var i = 0; i < page + 2; i++) {
						li.eq(i).removeClass("active");
						if (i == 0) {
							a.eq(i).html("«");
							a.eq(i).css('display', 'block');
						} else if (i == page + 1) {
							a.eq(i).html("»");
							a.eq(i).css('display', 'block');
						} else if (i == n) {
							li.eq(i).attr("class", "active");
							a.eq(i).html(i);
							a.eq(i).css('display', 'block');
						} else {
							if (i <= page) {
								a.eq(i).html(i);
								a.eq(i).css('display', 'block');
							}
						}
					}
				} else {
					var n = page;
					var end = 5 * n;
					var start = end - 5;
					$("#customerTable tbody").empty();
					for (var i = start; i < end; i++) {
						var tr = htr.eq(i).clone();
						$("#customerTable tbody").append(tr);
					}
					for (var i = 0; i < 7; i++) {
						li.eq(i).removeClass("active");
						if (i == 0) {
							a.eq(i).html("«");
						} else if (i == 6) {
							a.eq(i).html("»");
						} else {
							a.eq(i).html(page - 5 + i);
						}
					}
					li.eq(5).attr("class", "active");
				}
			} else {
				var n = Number(ina);
				if (page <= 5) {
					var end = 5 * n;
					var start = end - 5;
					$("#customerTable tbody").empty();
					for (var i = start; i < end; i++) {
						var tr = htr.eq(i).clone();
						$("#customerTable tbody").append(tr);
					}
					a.css('display', 'none');
					for (var i = 0; i < page + 2; i++) {
						li.eq(i).removeClass("active");
						if (i == 0) {
							a.eq(i).html("«");
							a.eq(i).css('display', 'block');
						} else if (i == page + 1) {
							a.eq(i).html("»");
							a.eq(i).css('display', 'block');
						} else if (i == n) {
							li.eq(i).attr("class", "active");
							a.eq(i).html(i);
							a.eq(i).css('display', 'block');
						} else {
							if (i <= page) {
								a.eq(i).html(i);
								a.eq(i).css('display', 'block');
							}
						}
					}
				} else {
					if (n <= 2) {
						var end = 5 * n;
						var start = end - 5;
						$("#customerTable tbody").empty();
						for (var i = start; i < end; i++) {
							var tr = htr.eq(i).clone();
							$("#customerTable tbody").append(tr);
						}
						for (var i = 0; i < 7; i++) {
							li.eq(i).removeClass("active");
							if (i == 0) {
								a.eq(i).html("«");
							} else if (i == 6) {
								a.eq(i).html("»");
							} else if (i == n) {
								li.eq(i).attr("class", "active");
								a.eq(i).html(i);
							} else {
							}
						}
					} else if (n >= page - 2) {
						var end = 5 * n;
						var start = end - 5;
						$("#customerTable tbody").empty();
						for (var i = start; i < end; i++) {
							var tr = htr.eq(i).clone();
							$("#customerTable tbody").append(tr);
						}
						for (var i = 0; i < 7; i++) {
							li.eq(i).removeClass("active");
							if (i == 0) {
								a.eq(i).html("«");
							} else if (i == 6) {
								a.eq(i).html("»");
							} else {
								a.eq(i).html(page - 5 + i);
								if (Number(a.eq(i).html()) == n) {
									li.eq(i).attr("class", "active");
								}
							}
						}
					} else {
						var end = 5 * n;
						var start = end - 5;
						$("#customerTable tbody").empty();
						for (var i = start; i < end; i++) {
							var tr = htr.eq(i).clone();
							$("#customerTable tbody").append(tr);
						}
						for (var i = 0; i < 7; i++) {
							li.eq(i).removeClass("active");
							if (i == 0) {
								a.eq(i).html("«");
							} else if (i == 6) {
								a.eq(i).html("»");
							} else if (i == 3) {
								li.eq(i).attr("class", "active");
								a.eq(i).html(n);
							} else {
								a.eq(i).html(n - 3 + i);
							}
						}
					}
				}
			}
		});
	</script>
</body>

</html>