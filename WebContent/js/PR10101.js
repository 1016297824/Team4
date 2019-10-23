function init() {
	var date = new Date();
	date.setDate(date.getDate() + 1);
	$("#date").val(dateFormat("YYYY-mm-dd", date));
}

function dateFormat(fmt, date) {
	var ret;
	var opt = {
		"Y+" : date.getFullYear().toString(),
		"m+" : (date.getMonth() + 1).toString(),
		"d+" : date.getDate().toString(),
		"H+" : date.getHours().toString(),
		"M+" : date.getMinutes().toString(),
		"S+" : date.getSeconds().toString()
	}
	for ( var k in opt) {
		ret = new RegExp("(" + k + ")").exec(fmt);
		if (ret) {
			fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
		}
	}
	return fmt;
}

// init datetimepicker
$(".form_date").datetimepicker({
	language : 'ja',// i18N
	autoclose : true,// autoclose
	todayHighlight : true,// todayHighlight
	todayBtn : true,// todayBtn
	minView : "month",// minView
	format : "yyyy-mm-dd",// format
	pickerPosition : "bottom-left"// pickerPosition:bottom-left
});

// 入力する文字の個数を制限します
$("#customerCode").bind("input propertychange", function() {
	// alert("bind");
	var text = $("#customerCode").val();
	var textlen = $("#customerCode").val().length;
	if (textlen > 5) {
		// alert("weishu");
		$("#customerCodeMessage").html("顧客コード欄に5桁を入力してください");
		var lenText = text.substring(0, 5);
		$("#customerCode").val(lenText);
	} else {
		$("#customerCodeMessage").html("");
	}
});

$("#customerCode").keyup(function() {
	// alert("keyup");
	// 強制入力タイプは半角文字です
	var str = $(this).val();
	// alert(str + "2");
	var result = "";
	for (var i = 0; i < str.length; i++) {
		if (str.charCodeAt(i) == 12288) {
			// alert("?");
			result += String.fromCharCode(str.charCodeAt(i) - 12256);
			continue;
		}
		if (str.charCodeAt(i) > 65280 && str.charCodeAt(i) < 65375) {
			// alert("?");
			$("#customerCodeMessage").html("顧客コード欄に半角数字を入力してください");
			// result += String.fromCharCode(str.charCodeAt(i) - 65248);
			result += "";
		} else {
			// alert("?");
			// $("#userMessage").html("担当者コード欄に半角数字を入力してください");
			result += String.fromCharCode(str.charCodeAt(i));
		}
	}
	$(this).val(result);

	// 強制入力タイプは数字です
	var c = $(this);
	// alert(c.val() + "1");
	if (/[^\d]/.test(c.val())) {
		$("#customerCodeMessage").html("顧客コード欄に半角数字を入力してください");
		var temp = c.val().replace(/[^\d]/g, '');
		$(this).val(temp);
	}
});

$("#aCustomer").click(
		function() {
			$.ajax({
				type : "post",
				url : "getAllCustomer.action",
				dataType : "json",
				data : {},
				async : true,
				success : function(data) {
					// console.log(data);
					$("#hiddenCustomerTable tbody").empty();
					$.each(data.lm001, function(key, val) {
						$("#hiddenCustomerTable tbody").append(
								'<tr>' + '<td style="text-align: center;">' + '<a href="#" data-dismiss="modal" onclick="customerClick(' + val.m00101 + ',&apos;' + val.m00105
										+ '&apos;);">' + '<span class="glyphicon glyphicon-check"></span>' + '</a>' + '</td>' + '<td style="text-align: center;">' + val.m00101
										+ '</td>' + '<td style="text-align: left;">' + val.m00103 + '</td>' + '<td style="text-align: right;">' + val.m00110 + '</td>' + '</tr>');
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

$('#selectCustomer').click(
		function() {
			// alert("searchCustomer");
			var cname = $('#customerName').val();
			// var productName = $('#productName').val();
			// console.log(productName.val());
			$.ajax({
				type : "post",
				url : "selectCustomers.action",
				dataType : "json",
				data : "cname=" + cname + "&productName=" + productName,
				async : true,
				success : function(data) {
					$("#hiddenCustomerTable tbody").empty();
					$.each(data.lm001, function(key, val) {
						$("#hiddenCustomerTable tbody").append(
								'<tr>' + '<td style="text-align: center;">' + '<a href="#" data-dismiss="modal" onclick="customerClick(' + val.m00101 + ',&apos;' + val.m00105
										+ '&apos;);">' + '<span class="glyphicon glyphicon-check"></span>' + '</a>' + '</td>' + '<td style="text-align: center;">' + val.m00101
										+ '</td>' + '<td style="text-align: left;">' + val.m00103 + '</td>' + '<td style="text-align: right;">' + val.m00110 + '</td>' + '</tr>');
					});

					if (data.customerMessage != null) {
						alert(data.customerMessage);
					}

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

function customerClick(id, location) {
	$("#customerCode").val(id);
	$("#locationId").val(location);
}

$("#selectAllProdects").click(
		function() {
			$.ajax({
				type : "post",
				url : "selectAllProdects.action",
				dataType : "json",
				data : {},
				async : true,
				success : function(data) {
					// console.log(data);
					$("#hiddenProductTable tbody").empty();
					$.each(data.lm002, function(key, val) {
						$("#hiddenProductTable tbody").append(
								'<tr>' + '<td style="text-align: center;">' + '<a href="#" onclick="productClick(' + val.m00201 + ',&apos;' + val.m00207 + '&apos;,&apos;'
										+ val.m00202 + '&apos;,' + val.m00203 + ',&apos;' + val.m00204 + '&apos;);">' + '<span class="glyphicon glyphicon-check"></span>' + '</a>'
										+ '</td>' + '<td style="text-align: center;">' + val.m00201 + '</td>' + '<td style="text-align: left;">' + val.m00202 + '</td>'
										+ '<td style="text-align: right;">' + val.m00203 + '</td>' + '<td style="text-align: right;">' + val.m00207 + '</td>' + '</tr>');
					});

					var ina = $(this).html();
					var htr = $("#hiddenProductTable tbody tr");
					var len = Number(htr.length);
					var page = Math.ceil(len / 5);
					var li = $("#pageProduct ul li");
					var a = $("#pageProduct ul a");
					a.css('display', 'block');
					if (page <= 5) {
						var n = 1;
						var end = 5 * n;
						var start = end - 5;
						$("#productTable tbody").empty();
						for (var i = start; i < end; i++) {
							var tr = htr.eq(i).clone();
							$("#productTable tbody").append(tr);
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
						$("#productTable tbody").empty();
						for (var i = start; i < end; i++) {
							var tr = htr.eq(i).clone();
							$("#productTable tbody").append(tr);
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
		})

function productClick(id, nowProductAmount, productName, unitPrice, company) {
	$("#productId").val(id);
	$("#hiddenNowProductAmount").val(nowProductAmount);
	$("#hiddenProductName").val(productName);
	$("#hiddenUnitPrice").val(unitPrice);
	$("#hiddenCompany").val(company);
}

$("#selectProducts").click(
		function() {
			var productName = $("#productName").val();
			// alert(productName);
			$.ajax({
				type : "post",
				url : "selectProducts.action",
				dataType : "json",
				data : "productName=" + productName,
				async : true,
				success : function(data) {
					$("#hiddenProductTable tbody").empty();
					$.each(data.lm002, function(key, val) {
						$("#hiddenProductTable tbody").append(
								'<tr>' + '<td style="text-align: center;">' + '<a href="#" onclick="productClick(' + val.m00201 + ',&apos;' + val.m00207 + '&apos;,&apos;'
										+ val.m00202 + '&apos;,' + val.m00203 + ',&apos;' + val.m00204 + '&apos;);">' + '<span class="glyphicon glyphicon-check"></span>' + '</a>'
										+ '</td>' + '<td style="text-align: center;">' + val.m00201 + '</td>' + '<td style="text-align: left;">' + val.m00202 + '</td>'
										+ '<td style="text-align: right;">' + val.m00203 + '</td>' + '<td style="text-align: right;">' + val.m00207 + '</td>' + '</tr>');
					});

					if (data.productMessage != null) {
						alert(data.productMessage);
					}

					var ina = $(this).html();
					var htr = $("#hiddenProductTable tbody tr");
					var len = Number(htr.length);
					var page = Math.ceil(len / 5);
					var li = $("#pageProduct ul li");
					var a = $("#pageProduct ul a");
					a.css('display', 'block');
					if (page <= 5) {
						var n = 1;
						var end = 5 * n;
						var start = end - 5;
						$("#productTable tbody").empty();
						for (var i = start; i < end; i++) {
							var tr = htr.eq(i).clone();
							$("#productTable tbody").append(tr);
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
						$("#productTable tbody").empty();
						for (var i = start; i < end; i++) {
							var tr = htr.eq(i).clone();
							$("#productTable tbody").append(tr);
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

$("#productAmount").keyup(function() {
	// 強制入力タイプは半角文字です
	var str = $(this).val();
	// alert(str + "2");
	var result = "";
	for (var i = 0; i < str.length; i++) {
		if (str.charCodeAt(i) == 12288) {
			// alert("?");
			result += String.fromCharCode(str.charCodeAt(i) - 12256);
			continue;
		}
		if (str.charCodeAt(i) > 65280 && str.charCodeAt(i) < 65375) {
			// alert("?");
			$("#productAmountMessage").html("売上数量欄に半角数字を入力してください");
			// result += String.fromCharCode(str.charCodeAt(i) - 65248);
			result += "";
		} else {
			result += String.fromCharCode(str.charCodeAt(i));
		}
	}
	$(this).val(result);

	// 強制入力タイプは数字です
	var c = $(this);
	// alert(c.val() + "1");
	if (/[^\d]/.test(c.val())) {
		$("#productAmountMessage").html("売上数量欄に半角数字を入力してください");
		var temp = c.val().replace(/[^\d]/g, '');
		$(this).val(temp);
	}

	var amount = Number($("#productAmount").val());
	// alert(amount);
	if (amount != null) {
		$("#productAmountMessage").html("");
		if (amount > 9999) {
			$("#productAmountMessage").html("売上数量 値を取る範囲は1から9999まで");
			$("#productAmount").val(9999);
		}
		if (amount < 1) {
			$("#productAmountMessage").html("売上数量 値を取る範囲は1から9999まで");
			$("#productAmount").val("");
		}
	}
});

$("#productAdd").click(
		function() {
			var hiddenNowProductAmount = Number($("#hiddenNowProductAmount").val());
			var productAmount = Number($("#productAmount").val());
			var productId = $("#productId").val();
			// alert(productAmount);
			var ok = 1;
			if (productId == "") {
				ok = 0;
				alert("商品を選んでください");
			}

			if (productAmount == 0) {
				ok = 0;
				alert("売上数量を入力してください");
			}

			if (hiddenNowProductAmount < productAmount) {
				ok = 0;
				alert("商品は在庫量不足です");
			}

			var len = Number($("#injectionTable>tbody>tr").length);
			if (len > 11) {
				ok = 0;
				alert("受注商品明細に最多12行レコードのみが追加できる");
			}

			var productId = $("#productId").val();
			var tr = $("#injectionTable tbody tr");
			for (var i = 0; i < tr.length; i++) {
				var haveProductId = tr[i].cells[1].innerHTML;
				if (haveProductId == productId) {
					ok = 0;
					alert("商品コードは同じではいけません");
				}
			}

			if (ok == 1) {
				var no = len + 1;
				var productId = $("#productId").val();
				var productAmount = $("#productAmount").val();
				var hiddenNowProductAmount = $("#hiddenNowProductAmount").val();
				var hiddenProductName = $("#hiddenProductName").val();
				var hiddenUnitPrice = $("#hiddenUnitPrice").val();
				var hiddenCompany = $("#hiddenCompany").val();
				$("#injectionTable tbody").append(
						'<tr>' + '<td style="text-align: center;">' + no + '</td>' + '<td style="text-align: center;">' + productId + '</td>' + '<td style="text-align: left;">'
								+ hiddenProductName + '</td>' + '<td style="text-align: right;">' + hiddenUnitPrice + '</td>' + '<td style="text-align: center;">' + hiddenCompany
								+ '</td>' + '<td style="text-align: right;">' + hiddenNowProductAmount + '</td>' + '<td style="text-align: right;">' + productAmount + '</td>'
								+ '<td style="text-align: center;">' + '<input type="checkbox" name="checkInjection" onchange="checkChange2()"/>' + '</td>' + '</tr>');
				$("#goodsModal").modal('hide');
				checkChange2();
			}

			$("#productName").val("");
			$("#productId").val("");
			$("#productAmount").val("");
		});

$("#checkbox0").change(function() {
	if ($("#checkbox0").get(0).checked) {
		$("input[name='checkInjection']").prop("checked", true);
	} else {
		$("input[name='checkInjection']").prop("checked", false);
	}
});

function checkChange2() {
	var check = document.getElementsByName("checkInjection");
	var n = 0;
	for (var i = 1; i < check.length; i++) {
		if (check[i].checked) {
			n++;
		}
	}

	if (n == check.length - 1) {
		check[0].checked = true;
	} else {
		check[0].checked = false;
	}
}

$("#clearProducts").click(function() {
	$("#injectionTable tbody").empty();
});

function issuePR10101() {
	var check = document.getElementsByName("checkInjection");
	var len = 0;
	for (var i = 1; i < check.length; i++) {
		// console.log(check[i]);
		if (check[i].checked) {
			len++;
		}
	}
	var ok = 1;
	if (len < 1) {
		var ok = 0;
		alert("受注商品明細に少なくとも1本のレコードを選択してください");
	}

	var nowDate = new Date();
	var textDate = $("#date").val();
	var issueDate = new Date(textDate.replace(/-/g, '/'));
	if (issueDate < nowDate) {
		var ok = 0;
		alert("納入希望日はもう過ごしました");
	}

	var customerCode = $("#customerCode").val();
	if (customerCode == "") {
		var ok = 0;
		alert("顧客コードを入力してください");
	}

	var tr = $("#injectionTable tbody tr");
	for (var i = 0; i < tr.length; i++) {
		if (tr[i].cells[7].firstChild.checked) {
			// alert("zk");
			if (Number(tr[i].cells[5].innerHTML) < Number(tr[i].cells[6].innerHTML)) {
				ok = 0;
				alert("商品は在庫量不足です");
			}
		}
	}

	if (ok == 1) {

		var textDate = $("#date").val();
		var t001 = {};
		t001.t00102 = new Date();
		t001.t00103 = new Date(textDate.replace(/-/g, '/'));
		t001.t00105 = $("#customerCode").val();
		t001.t00106 = $("#locationId").val();
		t001.t00107 = $("#userId").val();
		// t001 = JSON.stringify(t001);
		// alert(t001);
		var lt002 = [];
		var tr = $("#injectionTable tbody tr");
		for (var i = 0; i < tr.length; i++) {
			if (tr[i].cells[7].firstChild.checked) {
				// alert("zk");
				var t002 = {};
				t002.t00202 = tr[i].cells[1].innerHTML;
				t002.t00203 = tr[i].cells[6].innerHTML;
				t002.t00204 = tr[i].cells[3].innerHTML;
				lt002.push(t002);
			}
		}
		// lt002 = JSON.stringify(lt002);
		// console.log(lt002);
		var resultBean = {};
		resultBean.t001 = t001;
		resultBean.lt002 = lt002;
		resultBean = JSON.stringify(resultBean);
		// alert(resultBean);
		$.ajax({
			type : "post",
			dataType : "json",
			contentType : "application/json",
			url : "issuePR10101.action",
			data : resultBean,
			async : true,
			success : function(data) {
				if (data.message != "") {
					alert(data.message);
				}
				if (data.result) {
					var tr = $("#injectionTable tbody tr");
					for (var i = 0; i < tr.length; i++) {
						if (tr[i].cells[7].firstChild.checked) {
							var last = Number(tr[i].cells[5].innerHTML) - Number(tr[i].cells[6].innerHTML);
							tr[i].cells[5].innerHTML = last;
						}
					}

					let con = confirm('Excelテーブルを生成しますか');
					if (con == true) {
						window.location.href = "issueExcel.action";
					}
				}
			}
		});
	}
}

$("#pageProduct ul a").click(function() {
	var ina = $(this).html();
	var htr = $("#hiddenProductTable tbody tr");
	var len = Number(htr.length);
	var page = Math.ceil(len / 5);
	var li = $("#pageProduct ul li");
	var a = $("#pageProduct ul a");
	if (ina == "«") {
		if (page <= 5) {
			var n = 1;
			var end = 5 * n;
			var start = end - 5;
			$("#productTable tbody").empty();
			for (var i = start; i < end; i++) {
				var tr = htr.eq(i).clone();
				$("#productTable tbody").append(tr);
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
			$("#productTable tbody").empty();
			for (var i = start; i < end; i++) {
				var tr = htr.eq(i).clone();
				$("#productTable tbody").append(tr);
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
			$("#productTable tbody").empty();
			for (var i = start; i < end; i++) {
				var tr = htr.eq(i).clone();
				$("#productTable tbody").append(tr);
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
			$("#productTable tbody").empty();
			for (var i = start; i < end; i++) {
				var tr = htr.eq(i).clone();
				$("#productTable tbody").append(tr);
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
			$("#productTable tbody").empty();
			for (var i = start; i < end; i++) {
				var tr = htr.eq(i).clone();
				$("#productTable tbody").append(tr);
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
				$("#productTable tbody").empty();
				for (var i = start; i < end; i++) {
					var tr = htr.eq(i).clone();
					$("#productTable tbody").append(tr);
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
				$("#productTable tbody").empty();
				for (var i = start; i < end; i++) {
					var tr = htr.eq(i).clone();
					$("#productTable tbody").append(tr);
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
				$("#productTable tbody").empty();
				for (var i = start; i < end; i++) {
					var tr = htr.eq(i).clone();
					$("#productTable tbody").append(tr);
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