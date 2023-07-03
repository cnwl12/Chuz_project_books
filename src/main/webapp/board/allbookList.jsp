<%@page import="com.itwillbs2.domain.PageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/board.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js"></script>

<head>
<div>
	<jsp:include page="../include/top.jsp"></jsp:include>
</div>
</head>

<body>

<%
PageDTO pageDTO =(PageDTO)request.getAttribute("pageDTO");
%>

	<!--  ////출력하기 - 하나용 //////  -->
	<script type="text/javascript">
		window.onload = function() {
			var bookJson = <%=request.getAttribute("bookList")%>;
	
		
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
			
				//output += '<div>Total : '+ book.total +' (권)</div>';
			
			arr.forEach(function(book, index) {
				output += '<table width="1300" border="1" class="showBook">';
				output += 	'<tbody>'  
				output += 		'<tr>'
				output += 			'<td width="'+ 250 +'" height="'+ 200+'">';
				output += 				'<img src='+ book.image +' class="imgLi" alt=+'+  +'"></td>';
				output += 		'</tr>'
				output += 		'<td>'
				output += 			'<ul class="printLi" data-isbn="'+book.isbn+'">';
				output += 				'<li class="title">' + book.title + '</li>'; 
				output += 				'<li class="price">' + book.discount + '</sli>'; 
				output += 				'<li class="author">' + book.author + '</li>';
				output += 				'<li class="publisher">' + book.publisher + '</li>';
				output += 				'<li class="description">' + book.description + '</li>';
				output += 				'<li class="link"><a href="' + book.link + '">구매하기</a></li>';
				output += 			'</ul>';  
				output += 		'</td>' 
				output += 		'<td>'
				output += 			'<div class="chex" style="background-image: url(\'image/unChecked.png\'); background-size: cover; background-repeat: no-repeat; background-position: center; width: 50px; height: 25px;">'
				output += 				'<a href="#" onclick="checkBook(this)"> 조아요 </a>' 
				output += 			'</div>'
				output += 		'</td>'
				output += 	'</tbody>'  
				output += '</table>';
				output += '<br>';
			});
			 
			document.getElementById("outputDiv").innerHTML = output;
		}
		
		function checkBook(e){
			var isbn = $(e).closest('.showBook').find('.printLi').attr('data-isbn');
			var title = $(e).closest('.showBook').find('.title').text();	//제목 이미지 isbn date id는 나중에 
			var author = $(e).closest('.showBook').find('.author').text();
			var image = $(e).closest('.showBook').find('.imgLi').attr('src');
		    console.log(isbn);
		    console.log(image);
		    console.log(author);
		    console.log(image);
		    location.href="checkBook.bs?isbn="+isbn+"&title="+title+"&image="+image;
		}
	</script>
	 
	<!-- 페이지번호  -->
	<div class="pageNum" style="font-size : 20px">
<%
// 이전 startPage 시작페이지 pageBlock 보여줄 페이지 수 비교 
// startPage 더 크면 [이전] 글자 나타남
if(pageDTO.getStartPage()> pageDTO.getPageBlock()){
	%>
	<a href="allbookList.bo?pageNum=<%=pageDTO.getStartPage()-pageDTO.getPageBlock()%>&searchKeyWord=<%=request.getParameter("searchKeyWord")%>">[이전]</a>
	<%
}

//for문을 통한 하단 페이지 증가 // </table 하단부터 연결
for(int i = pageDTO.getStartPage(); i <= pageDTO.getEndPage(); i++){
	
	// TODO: total로 더 이상 출력될 내용이 없을 때 , 하단 숫자 사라지게  
	%>
	
	<%-- 
	<%
	if((i*10+1) < pageDTO.getEndPage()){ // 페이지 하단 숫자가 토탈 수보다 작을 때 멈추고(안나오고) 끝남
		break;
	}
	%>
	 --%>
	 
	<a href="allbookList.bo?pageNum=<%=i%>&searchKeyWord=<%=request.getParameter("searchKeyWord")%>"><%=i%></a>
	<%
}


// 다음 endPage 끝페이지 -> pageCount 전체페이지 비교 
//	=> 전체페이지가 크면 다음 클릭 했을 때 페이지가 존재  
if(pageDTO.getEndPage() < pageDTO.getPageCount()){ // 1~10 < 11~20, 21~30 ---
%>
<a href="allbookList.bo?pageNum=<%=pageDTO.getStartPage()+pageDTO.getPageBlock()%>&searchKeyWord=<%=request.getParameter("searchKeyWord")%>">[다음]</a>
	<%-- <a href="allbookList.bo?pageNum=<%=pageDTO.getStartPage()+pageDTO.getPageBlock()%>">[다음]</a>  --%>
							<!--currentpage+pageblock해도됨  -->
							<!-- 1~10 -> 11~20으로 넘어가게  -->
<%
}
 %>
 
 </div>
	
</body>