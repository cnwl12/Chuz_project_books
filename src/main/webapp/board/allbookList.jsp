<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

  <link rel="stylesheet" href="fonts/icomoon/style.css" />
    <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

    <link rel="stylesheet" href="css/tiny-slider.css" />
    <link rel="stylesheet" href="css/aos.css" />
    <link rel="stylesheet" href="css/style.css" />


<head>
<div>
<jsp:include page="../include/top.jsp"></jsp:include> <br><br><br><br><br><br><br>
</div>
</head>
<body>
<div>
<table border="2" id="" >
<th>이미지</th>
<td id="bookTitle">책 제목 메인</td>
<td><img alt="" id="bookImg" src="bmg/books-007.jpg" width="200" height="300"></td>
<td id="bookDiscount">가격</td>
<td>

</td> 
</table>
<br>

<!--  ////////////////  -->
<table border="2" >
<th>for문</th>
<td>책 제목 메인</td>
<td><img alt="" src="bmg/books-007.jpg" width="200" height="300"></td>
<td>가격</td>
<td>

<script type="text/javascript">
window.onload = function (){
	var bookJson = <%=request.getAttribute("bookList")%>;
	var arr = bookJson.items;
	var book = arr[0];
	document.getElementById('bookTitle').textContent = book.title;
	document.getElementById('bookDiscount').textContent = book.discount;
	document.getElementById('bookImg').src = book.image;
	
	// bookImg
	// bookPrice
	
// 	arr.forEach(function(book, index){
// 	    debugger;
// 	})
}

</script>


</td>
</table>



</div>
</body>