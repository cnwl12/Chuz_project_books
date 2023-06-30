<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/aos.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/listcomment.css" />


<head>
<div>
	<jsp:include page="../include/top.jsp"></jsp:include>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
</div>
</head>

<body>
	<!--  ////출력하기 - 하나용 //////  -->
	<script type="text/javascript">
		window.onload = function() {
			var bookJson =
	<%=request.getAttribute("bookList")%>;
		
			var arr = bookJson.items;
			//	한개씩 접근 	
			//	var book = arr[0];
			//	document.getElementById('bookTitle').textContent = book.title;
			//	document.getElementById('bookDiscount').textContent = book.discount;
			//	document.getElementById('bookImg').src = book.image;

			arr.forEach(function(book, index) { // forEach (함수(이름, 인덱스))
				/* 콘솔확인용  	*/
				
				console.log(document.getElementById('bookTitle').textContent = book.title);
				console.log(document.getElementById('bookDiscount').textContent = book.discount);
				console.log(document.getElementById('bookImg').src = book.image);
			})
		}
	</script>

	<!-- 출력하기!  -->
	<div id="outputDiv"></div>

	<script type="text/javascript">
		window.onload = function() {
			var bookJson =	<%=request.getAttribute("bookList")%>;
			var arr = bookJson.items;
			var output = '';

		/* 	arr.forEach(function(book, index) {
				output += '<table border="2">';
				output += '<tr>'
				output += ' <th>이미지</th>';
				output += '<td><img src='+ book.image +' alt=+'+  +' width="'+ 200 +'" height="'+ 300+'"></td>';
				output += '  </tr>';
				output += '  <tr>';
				output += '  <th>책 제목</th>';
				output += '    <td>' + book.title + '</td>';
				output += '   </tr>';
				output += '  <tr>';
				output += '   <th>가격</th>';
				output += '    <td>' + book.discount + '</td>';
				output += ' </tr>';
				output += ' </table>';
				output += '<br>';
			});
 */ 
			arr.forEach(function(book, index) {
				output += '<table width="1300" border="1" class="showBook">';
				output += '<tbody>'
				output += '<tr>'
				output += '<td><img src='+ book.image +' alt=+'+  +' width="'+ 200 +'" height="'+ 300+'"></td>';
				output += '<td>'
				output += '  <ul>';
				output += '    <li>' + book.title + '</li>';
				output += '    <li>' + book.discount + '</li>';
				output += '  </ul>';
				output += '</td>'
				output += '</tr>'
				output += '</tbody>'
				output += ' </table>';
				output += '<br>';
			});
			
			document.getElementById("outputDiv").innerHTML = output;
		}
	</script>
</body>