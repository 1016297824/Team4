<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	href="${pageContext.request.contextPath }/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/datetimepicker/bootstrap-datetimepicker.min.css"
	media="screen" />
</head>
<body>
	<!-- 用来保存请求额的合计n -->
	<input type="hidden" id="hiddensum" name="hiddensum" value="" />

	<!-- Top Begin -->
	<div class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container">
			<!-- Title Begin -->
			<div class="navbar-header">
				<a class="navbar-brand" href="#"> <b>華信商会(株) 販売管理業務システム</b>
				</a>
			</div>
			<!-- Title End -->

			<!-- Menu Begin -->
			<div>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="aPR10101.action">首頁</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" aria-expanded="false"> <span>受注管理</span>
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="aPR10101.action">受注入力</a></li>
							<li><a href="aPR10201.action">商品別出庫表作成</a></li>
							<li><a href="aPR10301.action">顧客別受注実績月報作成</a></li>
							<li><a href="aPR10401.action">商品別受注実績月報作成</a></li>
							<li><a href="aPR10501.action">在庫情報確認</a></li>
						</ul></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" aria-expanded="false"> <span>売掛管理</span>
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="aPR20101.action">売掛登録</a></li>
							<li><a href="aPR20201.action">代金請求</a></li>
							<li><a href="aPR20301.action">入金登録</a></li>
						</ul></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" aria-expanded="false"> <i
							class="glyphicon glyphicon-user"></i> <span>${userName}</span> <span
							class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="alogin.action">退出</a></li>
						</ul></li>
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
										<font style="font-size: 14px; line-height: 29px;">入金検索</font>
									</div>

									<div class="col-md-6" align="right">
										<button type="submit" class="btn btn-primary btn-sm"
											data-toggle="modal" data-target="#goodsModal"
											id="selcustomer">検索</button>
										<button type="submit" class="btn btn-default btn-sm"
											onclick="window.location.href = 'aPR20301.action'">クリア</button>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-4">
										<div class="input-group">
											<span class="input-group-addon">顧客コード</span> <input
												type="text" class="form-control" name="m00101" id="m00101"
												autofocus> <span class="input-group-addon"> <a
												href="#" data-toggle="modal" data-target="#customerModal"
												id="selall"> <span class="glyphicon glyphicon-search"></span>
											</a>
											</span>
										</div>
										<br>
										<p id="m00101Message" style="color: red;"></p>
									</div>
								</div>
								<hr>
								<table id="table1">

								</table>

								<table id="table3">

								</table>
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
								<font style="font-size: 14px; line-height: 29px;">入金明細登録</font>
							</div>
							<div class="col-md-6" align="right">
								<button type="submit" class="btn btn-warning btn-sm" id="login">登録</button>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-4">
								<div class="input-group date form_date">
									<span class="input-group-addon">入金日付（省略時今日）</span> <input
										type="text" class="form-control"
										value="<%=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime())%>"
										name="pr20301date" id="pr20301date" readonly> <span
										class="input-group-addon"> <span
										class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
								<br>
								<p id="dateMessage" style="color: red;"></p>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<table class="table table-bordered" id="table2">
							<thead>
								<tr>
									<th style="text-align: center;">項番</th>
									<th style="text-align: center;">請求書コード</th>
									<th style="text-align: center;">請求書日付</th>
									<th style="text-align: center;">請求額</th>
									<th style="text-align: center;"><input type="checkbox"
										name="checkbox" id="checkbox" /></th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
						<br>
						<p id="tableMessage" style="color: red;"></p>
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
										<span class="input-group-addon">顧客名</span> <input type="text"
											class="form-control" name="m00103" id="m00103" autofocus>
									</div>
									<br>
									<p id="m00103Message" style="color: red;"></p>
								</div>
								<div class="col-md-6" align="right">
									<button type="submit" class="btn btn-primary btn-sm"
										id="selone">検索</button>
								</div>
							</div>
						</div>
						<div class="panel-body">
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
									<li class="disabled"><a href="#" aria-label="Previous">
											<span aria-hidden="true">«</span>
									</a></li>
									<li class="active"><a href="#">1</a></li>
									<li><a href="#">2</a></li>
									<li><a href="#">3</a></li>
									<li><a href="#">4</a></li>
									<li><a href="#">5</a></li>
									<li><a href="#" aria-label="Next"> <span
											aria-hidden="true">»</span>
									</a></li>
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
		<i class="glyphicon glyphicon-copyright-mark"></i> DHEE 2019
		大連華信計算機新技術培訓中心. すべての知る権利を保留
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
			language : 'ja',//i18N
			autoclose : true,//autoclose
			todayHighlight : true,//todayHighlight
			todayBtn : true,//todayBtn
			minView : "month",//minView
			format : "yyyy-mm-dd",//format
			pickerPosition : "bottom-left"//pickerPosition:bottom-left
		});

		//检索按钮（外）
		$("#selcustomer").click(
				function() {

					var m00101 = $("#m00101").val();

					$.ajax({
						type : "post",
						url : "pr20301search.action",
						dataType : "json",
						data : "m00101=" + m00101,
						async : true,
						success : function(data) {

							$("#m00101Message").empty();
							$("#tableMessage").empty();

							//table1显示
							$.each(data.selpr20301list, function(key, val) {
								$("#table1").empty();
								$("#table1").append(
										'<tr>' + '<td style="text-align: left; padding-left: 5PX;">' + '<br>' + '顧客名 ：' + '</td>'
												+ '<td style="text-align: left; padding-left: 5PX;">' + '<br>' + val.m00103 + '</td>' + '</tr>' + '<tr>'
												+ '<td style="text-align: left; padding-left: 5PX;">' + '<br>' + '売掛残高 ：' + '</td>'
												+ '<td style="text-align: left; padding-left: 5PX;">' + '<br>' + val.m00112 + '</td>' + '</tr>');

							});

							//table2显示
							$.each(data.selpr20301list, function(key, val) {
								$("#table2 tbody").empty();
								$("#table2 tbody").append(
										'<tr>' + '<td style="text-align: center;">' + 1 + '</td>' + '<td style="text-align: center;">' + val.t00301 + '</td>'
												+ '<td style="text-align: left;">' + val.t00302 + '</td>' + '<td style="text-align: right;">' + val.sumtm + '</td>'
												+ '<td style="text-align: center;">' + '<input type="checkbox" name="checkbox1name" id="checkbox1" onclick="ck()"/>' + '</tr>');
							});
							if (data.m00101Message != null) {
								$("#table1").empty();
								$("#m00101Message").html(data.m00101Message);
							}
							if (data.tableMessage != null) {
								$("#table2 tbody").empty();
								$("#tableMessage").html(data.tableMessage);
							}
						}
					});
				});

		//搜索按钮
		$("#selall").click(
				function() {

					$.ajax({
						type : "post",
						url : "pr20301selall.action",
						dataType : "json",
						data : {},
						async : true,
						success : function(data) {
							$("#customerTable").empty();
							$.each(data.selalllist, function(key, val) {

								$("#customerTable").append(
										'<tr>' + '<td style="text-align: center;">' + '<a href="#" data-dismiss="modal" onclick="customerClick(' + val.m00101 + ')">'
												+ '<span class="glyphicon glyphicon-check"></span>' + '</a>' + '</td>' + '<td style="text-align: center;">' + val.m00101 + '</td>'
												+ '<td style="text-align: left;">' + val.m00103 + '</td>' + '<td style="text-align: right;">' + val.m00110 + '</td>' + '</tr>');
							});
						}

					});
				});

		//检索按钮（内）
		$("#selone").click(
				function() {
					var m00103 = $("#m00103").val();
					$.ajax({
						type : "post",
						url : "pr20301selone.action",
						dataType : "json",
						data : "m00103=" + m00103,
						async : true,
						success : function(data) {
							$("#customerTable tbody").empty();
							$.each(data.selonelist, function(key, val) {
								$("#customerTable tbody").append(
										'<tr>' + '<td style="text-align: center;">' + '<a href="#" data-dismiss="modal" onclick="customerClick(' + val.m00101 + ')">'
												+ '<span class="glyphicon glyphicon-check"></span>' + '</a>' + '</td>' + '<td style="text-align: center;">' + val.m00101 + '</td>'
												+ '<td style="text-align: left;">' + val.m00103 + '</td>' + '<td style="text-align: right;">' + val.m00110 + '</td>' + '</tr>');
							});
							if (data.m00103Message != null) {
								$("#m00103Message").html(data.m00103Message);
							}
						}
					});
				});
		//选择按钮
		function customerClick(m00101) {
			$("#m00101").val(m00101);
		}

		//CheckBox选择请求额合计

		function ck() {
			var n = 0;
			var tr = $("#table2 tbody tr");
			var check = document.getElementsByName("checkbox1name");

			for (var i = 0; i < tr.length; i++) {
				if (check[i].checked) {
					n = n + Number(tr[i].cells[3].innerHTML);
				}
			}
			//alert(n);
			$("#hiddensum").val(n);
			//alert($("#hiddensum").val())
		}

		//登録按钮 
		$("#login").click(
				function() {

					//判断是否选择
					var m = 0;
					var tr = $("#table2 tbody tr");
					var check = document.getElementsByName("checkbox1name");

					for (var i = 0; i < tr.length; i++) {
						if (check[i].checked) {
							m++;
						}
					}
					if (m == 0) {
						$("#dateMessage").html("入金明細に少なくとも一つレコードを選択してください。");
					} else {
						$("#dateMessage").empty();
						//判断日期是否大于系统日期
						var nowDate = new Date();
						var textDate = $("#pr20301date").val();
						var issueDate = new Date(textDate.replace(/-/g, '/'));
						if (issueDate > nowDate) {
							$("#dateMessage").html("入金日付が不正です。");
						} else {

							//执行登录按钮
							var m00101 = $("#m00101").val();
							var pr20301date = $("#pr20301date").val();
							var summoney = $("#hiddensum").val()

							$.ajax({
								type : "post",
								url : "pr20301login.action",
								dataType : "json",
								data : "m00101=" + m00101 + "&pr20301date=" + pr20301date + "&summoney=" + summoney,
								async : true,
								success : function(data) {
									$.each(data.pr20301loginlist, function(key, val) {
										$("#table3").empty();
										$("#table3").append(
												'<tr>' + '<td style="text-align: left; padding-left: 5PX;">' + '<br>' + "登録後売掛残高 ：" + '</td>'
														+ '<td style="text-align: left; padding-left: 5PX;">' + '<br>' + val.m00112 + '</td>' + '</tr>');
									});
								alert("入金額をすでに登録しました。");
								}
							});
						}
					}
				});
	</script>

</body>
</html>
