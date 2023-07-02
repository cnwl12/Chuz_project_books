<%@page import="com.itwillbs2.domain.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>갤러리</title>
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
<link rel="stylesheet" href="/Scripts/Common/font_NanumBarunGothic.css"
	type="text/css" />


<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />
    
<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/aos.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/board.css" />
</head>
<body>

	<%
	List<BoardDTO> dtoList = (List<BoardDTO>) request.getAttribute("dtoList");
	PageDTO pageDTO = (PageDTO) request.getAttribute("pageDTO"); // 페이징 처리하는 pageDTO가져와서 담기
	String id =(String)session.getAttribute("id");
	%>

	<jsp:include page="../include/top.jsp"></jsp:include>
	<div class="mnb_blank"></div>
	<!-- container str -->
	<div id="container">
		<div class="div_inner">
			<!-- Contents : Str -->
			<div class="contents_wrap2">
				<h1 class="con_title">갤러리_자료실</h1>
				<div class="buttonUtil">
					<%
					// TODO: 글작성, 갤러리 버튼 아이콘 변경
					if(id!=null){%>
					<a href="fwrite.bo"><input type="button" value="글작성"></a>
					<%} %> 
					<a href="list.bo"><input type="button" value="갤러리" ></a>
				</div>
				<div class="media_wrap">
					<ul class="media_list">
						<%
						for (int i = 0; i < dtoList.size(); i++) {
							BoardDTO dto = dtoList.get(i);
						%>

						<li>
							<div class="m_sum">
								<img src="upload/<%=dto.getBoard_file()%>">
							</div> <span class="m_cover"><a
								href="content.bo?board_num=<%=dto.getBoard_num()%>"></a></span>
							<dl class="m_info">
								<dt>
									<a href="content.bo?board_num=<%=dto.getBoard_num()%>"> <%=dto.getBoard_subject()%>
									</a>
								</dt>
								<dd>
									<span class="eye_cnt"><%=dto.getBoard_readcount()%></span>
								</dd>
							</dl>
						</li>
						<%
						}
						%>
					</ul>
				</div>
			</div>
		</div>
		<!-- container end -->
	</div>
	<!-- 페이지번호  -->  
	<div class="pageNum">
	<%
	// 이전 startPage 시작페이지 pageBlock 보여줄 페이지 수 비교 
	// startPage 더 크면 [이전] 글자 나타남
	if (pageDTO.getStartPage() > pageDTO.getPageBlock()) {
	%>
	<a
		href="gallary.bo?pageNum=<%=pageDTO.getStartPage() - pageDTO.getPageBlock()%>">[이전]</a>
	<%
	}
	//for문을 통한 하단 페이지 증가 // </table 하단부터 연결
	for (int i = pageDTO.getStartPage(); i <= pageDTO.getEndPage(); i++) {
	%>
	<a href="gallary.bo?pageNum=<%=i%>"><%=i%></a>
	<%
	}
	// 다음 endPage 끝페이지 -> pageCount 전체페이지 비교 
	//	=> 전체페이지가 크면 다음 클릭 했을 때 페이지가 존재  
	if (pageDTO.getEndPage() < pageDTO.getPageCount()) { // 1~10 < 11~20, 21~30 ---
	%>
	<a
		href="gallary.bo?pageNum=<%=pageDTO.getStartPage() + pageDTO.getPageBlock()%>">[다음]</a>
	<!--currentpage+pageblock해도됨  -->
	<!-- 1~10 -> 11~20으로 넘어가게  -->
	<%
	}
	%>
	</div>
</body>
</html>