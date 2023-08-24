<%@page import="com.itwillbs2.domain.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>나의 책장</title>
<script src="https://ssl.nexon.com/s1/p2/ps.min.js" charset="utf-8"
	data-name="PS" data-ngm="true" data-nxlogin="true"></script>
<script src="https://ssl.nexon.com/s1/global/ngb_head.js"></script>
<script src="https://lwres.nexon.com/js/maplestory/jquery-1.12.4.min.js"
	type="text/javascript">
</script>
<script src="https://lwres.nexon.com/js/maplestory/jquery-ui.js"></script>
<script src="https://lwres.nexon.com/js/maplestory/sub_new.js"
	type="text/javascript"></script>
<script
	src="https://lwres.nexon.com/js/maplestory/jquery.mCustomScrollbar.concat.min.js"
	type="text/javascript"></script>
<script src="/Scripts/Common/webboard.js?v=202306250903"></script>
<link rel="stylesheet" href="/Scripts/Common/font_NanumBarunGothic.css" type="text/css" />
	
<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/aos.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/board.css" />

<script type="text/javascript">
function delLike(bookShelf_title){
	
	if(confirm("찜목록에서 삭제하시겠습니까?")){
		location.href="delLike.bs?bookShelf_title="+bookShelf_title;
	}
} 

</script>

</head>
<body>

	<%
	String id =(String)session.getAttribute("id");
	%>

	<jsp:include page="../include/top.jsp"></jsp:include>
	<div class="mnb_blank"></div>
	<div id="container">
		<div class="div_inner">
			<!-- Contents : Str -->
			<div class="contents_wrap2">
				<h1 class="con_title">나의 책장</h1>

				<div class="media_wrap">
					<ul class="media_list">

						<c:forEach var="book" items= "${bookShelves}">
							<li>
								<div class="m_sum">
									<div style="float:right;  margin: 1%;">
									 <input type="button" value="x" onclick="delLike('${book.bookShelf_title}')" id="delLike">
									</div>
									<img src="${book.bookShelf_image}">
								</div> <span class="m_cover"></span>

								<dl class="m_info">
									<dt>
										 ${book.bookShelf_title} 
									</dt>
									<dd>
										등록일 : ${book.bookShelf_date}
									</dd>
								</dl>
							</li>

						</c:forEach>
						</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
