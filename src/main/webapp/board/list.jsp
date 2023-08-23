<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.itwillbs2.domain.PageDTO"%>
<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>    
<head>   
<meta charset="UTF-8">  
<title>board/list.jsp</title>   
 
<link rel="stylesheet" href="fonts/icomoon/style.css" /> 
  
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js"></script>
<script type="text/javascript" src="js/searchBook.js"></script>
<script type="text/javascript" src="js/keyword.js"></script>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/board.css" /> 
 
</head>
<body>
	<jsp:include page="../include/top.jsp"></jsp:include>

	<%
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");

List<BoardDTO> dtoList =(List<BoardDTO>)request.getAttribute("dtoList"); 

PageDTO pageDTO =(PageDTO)request.getAttribute("pageDTO"); 

String id =(String)session.getAttribute("id"); %>

	<div class="sub_cont">
		<div class="container">
			<div class="row justify-content-center align-items-center">
				<div class="col-lg-9 text-center" style="width: 100%">
					<form class="narrow-w form-search d-flex align-items-stretch mb-3"
						data-aos="fade-up" data-aos-delay="200" id="searchForm">

						<input type="text" class="form-control px-4"
							placeholder="검색어를 입력해주세요" name="searchKeyWord" id="searchF">
						<button type="submit" class="btn btn-primary">Search</button>
					</form>
				</div>
			</div>
		</div> 

		<div class="buttonUtil">
			<%
			if (id != null) {
			%>
			<a href="fwrite.bo"><input type="button" value="글쓰기" id="listBtn"></a>
			<%
			}
			%>
			<a href="gallary.bo"><input type="button" value="갤러리" id="listBtn"></a>
		</div>

		<table border="1" width="100" class="brod_table">
			<tr>
				<th id="td01">No.</th>
				<th id="td01">제목</th>
				<th id="td01">작성자</th>
				<th id="td01">조회수</th>
				<th id="td01">작성일</th>

				<%

for(int i = 0; i<dtoList.size(); i++){ // 자바 내장객체 배열길이는 size()
	BoardDTO dto = dtoList.get(i); 
	%>
			<tr>
				<td><%=dto.getBoard_num()%></td>
				<td><a href="content.bo?board_num=<%=dto.getBoard_num()%>"><%=dto.getBoard_subject()%></a></td>
				<td><%=dto.getBoard_name()%></td>
				<td><%=dto.getBoard_readcount()%></td>
				<td><%=dateFormat.format(dto.getBoard_date())%></td>
			</tr>
			<%
} 
%>
		</table>
		
		
		<div class="pageNum">
			<%
if(pageDTO.getStartPage()> pageDTO.getPageBlock()){ // startPage 더 크면 [이전]
	%>
			<a href="list.bo?pageNum=<%=pageDTO.getStartPage()-pageDTO.getPageBlock()%>">[이전]</a> 
				
			<%
}
for(int i = pageDTO.getStartPage(); i<=pageDTO.getEndPage(); i++){
	%>
			<a href="list.bo?pageNum=<%=i%>"><%=i%></a>
			<%
}
// 다음 endPage 끝페이지 -> pageCount 전체페이지 비교 
//	=> 전체페이지가 크면 다음 클릭 했을 때 페이지가 존재  
if(pageDTO.getEndPage() < pageDTO.getPageCount()){ // 1~10 < 11~20, 21~30 ---
%>
			<a href="list.bo?pageNum=<%=pageDTO.getStartPage()+pageDTO.getPageBlock()%>">[다음]</a>
				
			<%
}
 %>
		</div>

		<div class="buttonDiv">
			<form action="list.bo" id="keywordForm">
				<input type="text" name="keyWord" id="keyWord" placeholder="제목 키워드">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
</body>
</html>