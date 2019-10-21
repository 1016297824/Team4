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

		</div>
	</div>
	<!-- Top End -->

	<!-- Body Begin -->
	<div class="container">
		<div class="row">
			<div class="col-md-12 text-right">
				<div class="row">
					<div class="col-md-6 text-left">
						<br />
						<br />
						<img alt=""
							src="${pageContext.request.contextPath }/images/login.jpg">
					</div>
					<div class="col-md-6 ">
						<h3>&nbsp;</h3>
						<div
							class="panel panel-default panel-body col-md-8 col-md-offset-2">
							<form action="login.action" method="post" name="form1">
								<div class="form-group text-left">
									<label>部門</label>
									<select class="form-control" name="M00304" id="department">
										<option></option>
										<c:forEach items="${lm005 }" var="m005">
											<option value="${m005.m00501 }">${m005.m00502 }</option>
										</c:forEach>
									</select>
									<p id="departmentMessage" style="color: red;">${departmentMessage }</p>
								</div>
								<div class="form-group text-left">
									<label>担当者コード</label>
									<input type="text" class="form-control" name="M00301" id="user" />
									<!-- <br> -->
									<p id="userMessage" style="color: red;">${userMessage }</p>
								</div>
								<div class="form-group text-left">
									<label>パスワード</label>
									<input type="password" class="form-control" name="M00303"
										id="password" />
									<p id="passwordMessage" style="color: red;">${passwordMessage }</p>
								</div>
								<div class="col-md-12">
									<button id="" type="button"
										class="btn btn-primary col-md-4 col-md-offset-1"
										onclick="loginCheck();">登録</button>
									<span class="col-md-2"></span>
									<button type="reset" class="btn btn-default col-md-4">キャンセル</button>
								</div>
							</form>
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
		//入力する文字の個数を制限します
		$("#user").bind("input propertychange", function() {
			var text = $("#user").val();
			var textlen = $("#user").val().length;
			if (textlen > 3) {
				//alert("weishu");
				$("#userMessage").html("担当者コード欄に3桁を入力してください");
				var lenText = text.substring(0, 3);
				$("#user").val(lenText);
			}
		});

		$("#user").keyup(function() {
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
					$("#userMessage").html("担当者コード欄に半角数字を入力してください");
					//result += String.fromCharCode(str.charCodeAt(i) - 65248);
					result += "";
				} else {
					//alert("?");
					//$("#userMessage").html("担当者コード欄に半角数字を入力してください");
					result += String.fromCharCode(str.charCodeAt(i));
				}
			}
			$(this).val(result);

			//強制入力タイプは数字です
			var c = $(this);
			//alert(c.val() + "1");
			if (/[^\d]/.test(c.val())) {
				$("#userMessage").html("担当者コード欄に半角数字を入力してください");
				var temp = c.val().replace(/[^\d]/g, '');
				$(this).val(temp);
			}
		});

		function loginCheck() {
			//alert("zk");
			var user = $("#user").val();
			var password = $("#password").val();
			var department = $("#department").val();
			//alert(user + password + department);
			if (user == "" || password == "" || department == "") {
				if (department == "") {
					alert("部門名称を選択してください");
				}
				if (user == "") {
					alert("担当者コードを入力してください");
				}
				if (password == "") {
					alert("パスワードを入力してください");
				}
			} else {
				//alert("submit");
				document.form1.submit();
			}
		}
	</script>

</body>
</html>