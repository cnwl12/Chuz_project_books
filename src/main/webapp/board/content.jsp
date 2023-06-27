<%@page import="com.itwillbs2.domain.*"%>
<%@page import="com.itwillbs2.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookStores_board</title>

<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/aos.css" />
<link rel="stylesheet" href="css/style.css" />


</head>
<body>

<jsp:include page="../include/top.jsp"></jsp:include>

<br><br><br><br><br><br><br><br>

<!--로그인 되어있는 아이디 == 세션에 저장된 "id"일치  -->
<!-- string으로 형변환 -->
<%
BoardDTO dto=(BoardDTO)request.getAttribute("dto");

String id =(String)session.getAttribute("id"); %>
<h1>글내용 : 로그인(<%=id%>)</h1>
<table border="2">
<tr><td>No.</td><td><%=dto.getBoard_num()%></td></tr>


<tr><td>글쓴이</td><td><%=dto.getBoard_name() %></td></tr>
<tr><td>조회수</td><td><%=dto.getBoard_readcount()%></td></tr>
<tr><td>작성일</td><td><%=dto.getBoard_date()%></td></tr>
<tr><td>제목</td><td><%=dto.getBoard_subject() %></td></tr>
<tr><td>첨부파일</td>

<td>


<img src ="upload/<%=dto.getBoard_file()%>" width="400" height="400"><br>

<a href="upload/<%=dto.getBoard_file()%>" download> 
<!-- 링크를 연결해야 이미지가 나타남(연결된 파일 이름) -->
<!--download로 되어있으면 하이퍼링크 통해 다운로드 되어짐  -->
<%=dto.getBoard_file()%></a>
</td></tr> 
<tr><td>글내용</td><td><%=dto.getBoard_content() %></td></tr>
<tr>
<td colspan="2">													<!--몇번글을 갖고 넘어갈건지 num으로 가져가야함  -->
<%
// 세션값이 있으면 
// 로그인값(세션값), 글쓴이 일치하면 => 글수정, 글삭제 보이기 
if(id!=null){ //세션값이 있으면 
	if(id.equals(dto.getBoard_name())){ // 로그인한 사람 = 글쓴이 =>수정/삭제버튼 보임 
%>
<input type="button" value="삭제" onclick="location.href='delete.bo?board_num=<%=dto.getBoard_num()%>'">
<input type="button" value="수정" onclick="location.href='fupdate.bo?board_num=<%=dto.getBoard_num()%>'">
<input type="submit" value="추천">
<%	
		
	}
}

%>

</table>

<form method="post"  action="comment_insert.bo">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<tr>
					<td style="border-bottom:none;" valign="middle"><%=id%></td>
					<td><input type="text" style="height:50px;" class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다." name = "comment_text"></td>
					<td><br><input type="submit" value="댓글 작성"></td>
				</tr>
			</table>
		</form>
		
		<!-- 이전, 다음글 없을 때  -->

<% if (dto.getPrev_num() != 0) { %>
<input type="button" value="이전 글" onclick="location.href='content.bo?board_num=<%=dto.getPrev_num()%>'">
<% } %>
<!-- <input type="hidden" value="이전 글"> -->

<input type="button" value="글목록" onclick="location.href='list.bo'">

<% if (dto.getNext_num() != 0) { %>
<input type="button" value="다음 글" onclick="location.href='content.bo?board_num=<%=dto.getNext_num()%>'">
<% } %>
<!-- <input type="hidden" value="다음 글" >  -->

	 
		
</body>
</html>