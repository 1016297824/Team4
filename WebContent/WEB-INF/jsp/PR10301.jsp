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
									<form action="aPR10302.action">
										<div class="col-md-6" align="left">
											<font style="font-size: 14px; line-height: 29px;">顧客別受注実績月報印刷プレビュー</font>
										</div>
										<div class="col-md-6" align="right">
											<button type="submit" class="btn btn-primary btn-sm"
												data-toggle="modal" data-target="#goodsModal">印刷プレビュー</button>
										</div>
									</form>
								</div>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-6">
										<div class="input-group date form_date">
											<span class="input-group-addon"> 印刷月次（省略時本月）</span>
											<input type="text" class="form-control" readonly>
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
	</script>

</body>
</html>