<%@page import="com.itwillbs2.domain.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>북세브</title>
<link rel="stylesheet"
	href="https://lwres.nexon.com/css/maplestory/sub_new.css"
	type="text/css" />
<link rel="stylesheet"
	href="https://lwres.nexon.com/css/maplestory/jquery.mCustomScrollbar.css"
	type="text/css" />
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


<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/aos.css" />
<link rel="stylesheet" href="css/style.css" />

</head>
<body>

	<%
	String id =(String)session.getAttribute("id");
	%>

	<jsp:include page="../include/top.jsp"></jsp:include>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div class="mnb_blank"></div>
	<!-- container str -->
	<div id="container">
		<div class="div_inner">
			<!-- Contents : Str -->
			<div class="contents_wrap2">
				<h1 class="con_title">읽은 책 목록</h1>
				
				<div class="media_wrap">
					<ul class="media_list">
						
						<c:forEach var="book" items="${bookShelves}">
							<%-- <td>${book.bookShelf_id }</td>--%>
							<%-- <td>${book.bookShelf_isbn }</td>  --%>
						
						<li>
							<div class="m_sum">
								<img src="${book.bookShelf_image }">
							</div> <span class="m_cover"><a
								href="#"></a></span>


							<dl class="m_info">
								<dt>
									<a href="#"> ${book.bookShelf_title }
									</a>
								</dt>
								<dd>
									<span class="eye_cnt">${book.bookShelf_date}</span>
								</dd>
							</dl>
						</li>
						
						</c:forEach>


						<!-- 원본 <li>
                                 <div class="m_sum"><img src="https://img.youtube.com/vi/1w877aJxtn8/mqdefault.jpg" alt="[메이플스토리 IGNITION] 출진(出陣) - YouTube"></div>
                                 <span class="m_cover"><a href="javascript:MEDIABOARD.getArticleView(378276, 1);"><img src="https://lwi.nexon.com/maplestory/common/m_cover.png" alt=""></a></span>
                                 <dl class="m_info">
                                     <dt>
                                         <a href="javascript:MEDIABOARD.getArticleView(378276, 1);">
                                             [메이플스토리 IGNITION] 출진(出陣) - YouTube
                                         </a>
                                     </dt>
                                     <dd><span class="eye_cnt">429</span></dd>
                                 </dl>
                             </li> -->

					</ul>
				</div>
			</div>
		</div>
		<!-- container end -->
	</div>
</body>
</html>