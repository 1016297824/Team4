<%@page import="java.util.ArrayList"%>
<%@page import="comm.dhee.dto.PR20101"%>
<%@page import="java.util.List"%>
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
							<span>${userName}</span>
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
							<form action="pr20101search.action" method="post">
								<div class="panel-heading">
									<div class="row">
										<div class="col-md-6" align="left">
											<font style="font-size: 14px; line-height: 29px;">売掛検索</font>
										</div>
										<div class="col-md-6" align="right">
											<button type="submit" id="seachpr20101"
												class="btn btn-primary btn-sm" data-toggle="modal"
												data-target="#goodsModal">検索</button>
											<button type="button" class="btn btn-default btn-sm"
												onclick="window.location.href = 'aPR20101.action'">クリア</button>
										</div>
									</div>
								</div>
								<div class="panel-body">
									<div class="row">
										<div class="col-md-4">
											<div class="input-group">
												<span class="input-group-addon">受注コード</span>
												<input type="text" class="form-control" name="t00101"
													id="t00101" value="${t00101}">
											</div>
											<br>
											<p id="t00101Message" style="color: red;">${t00101Message }</p>
										</div>
									</div>
									<hr>
									<br>
									<table id="pr20101table">

										<c:forEach var="a" items="${pr20101list}">

											<tr>
												<td style="text-align: left; padding-left: 5PX;">
													顧客コード：</td>
												<td style="text-align: left; padding-left: 5PX;">${a.m00101}</td>
											</tr>
											<tr>
												<td style="text-align: left; padding-left: 5PX;">
													<br>
													顧客名 ：
												</td>
												<td style="text-align: left; padding-left: 5PX;">
													<br>
													${a.m00103}
												</td>
											</tr>
											<tr>
												<td style="text-align: left; padding-left: 5PX;">
													<br>
													売掛残高 ：
												</td>
												<td style="text-align: left; padding-left: 5PX;">
													<br>
													${a.m00112}
												</td>
											</tr>
											<tr>
												<td style="text-align: left; padding-left: 5PX;">
													<br>
													売掛金 ：
												</td>
												<td style="text-align: left; padding-left: 5PX;">
													<br>
													${a.summoney}
												</td>
											</tr>
										</c:forEach>
									</table>
									<table id="pr20101table1">
									</table>
								</div>
							</form>
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
								<font style="font-size: 14px; line-height: 29px;">売掛登録</font>
							</div>
							<div class="col-md-6" align="right">
								<button type="submit" class="btn btn-warning btn-sm" onclick=""
									id="login">登録</button>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-4">
								<div class="input-group date form_date">
									<span class="input-group-addon">納入日付（省略時今日）</span>
									<input type="text" class="form-control" name="pr20101date"
										id="pr20101date"
										value="<%=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime())%>"
										readonly>
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>

								</div>
								<br>
								<p id="dateMessage" style="color: red;"></p>
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
		DHEE 2019 大連華信計算機新技術培訓中心. すべての知る権利を保留
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

		//登録後売掛残高 
		$("#login").click(
				function() {

					//判断日期是否大于系统日期
					var nowDate = new Date();
					var textDate = $("#pr20101date").val();
					var issueDate = new Date(textDate.replace(/-/g, '/'));
					if (issueDate > nowDate) {
						$("#dateMessage").html("受注納入日付が不正です。");
					} else {

						//执行登录按钮
						var t00101 = $("#t00101").val();
						var pr20101date = $("#pr20101date").val();

						$.ajax({
							type : "post",
							url : "pr20101login.action",
							dataType : "json",
							data : "t00101=" + t00101 + "&pr20101date=" + pr20101date,
							async : true,
							success : function(data) {
								$.each(data.pr20101list1, function(key, val) {
									$("#pr20101table1").empty();
									$("#pr20101table1").append(
											'<tr>' + '<td style="text-align: left; padding-left: 5PX;">' + '<br>' + "登録後売掛残高 ：" + '</td>'
													+ '<td style="text-align: left; padding-left: 5PX;">' + '<br>' + val.m00112 + '</td>' + '</tr>');
								});
							}

						});
						alert("売掛登録成功。");
					}
				});

		//入力する文字の個数を制限します
		$("#t00101").bind("input propertychange", function() {
			var text = $("#t00101").val();
			var textlen = $("#t00101").val().length;
			if (textlen > 5) {
				//alert("weishu");
				$("#t00101Message").html("受注コード欄に5桁を入力してください");
				var lenText = text.substring(0, 5);
				$("#t00101").val(lenText);
			}
		});

		$("#t00101").keyup(function() {
			//強制入力タイプは半角文字です
			var str = $(this).val();
			//alert(str + "2");
			var result = "";
			for (var i = 0; i < str.length; i++) {
				if (str.charCodeAt(i) == 12288) {
					//alert("?");
					result += String.fromCharCode(str.charCodeAt(i) - 12256);
					continue;
				}
				if (str.charCodeAt(i) > 65280 && str.charCodeAt(i) < 65375) {
					//alert("?");
					$("#t00101Message").html("受注コード欄に半角数字を入力してください");
					//result += String.fromCharCode(str.charCodeAt(i) - 65248);
					result += "";
				} else {
					//alert("?");
					//$("#t00101Message").html("受注コード欄に半角数字を入力してください");
					result += String.fromCharCode(str.charCodeAt(i));
				}
			}
			$(this).val(result);

			//強制入力タイプは数字です
			var c = $(this);
			//alert(c.val() + "1");
			if (/[^\d]/.test(c.val())) {
				$("#t00101Message").html("受注コード欄に半角数字を入力してください");
				var temp = c.val().replace(/[^\d]/g, '');
				$(this).val(temp);
			}
		});
	</script>

</body>
</html>