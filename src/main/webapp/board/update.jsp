<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/update.jsp</title>
</head>
<body>

<%
//num, id값 가져와야함 
int board_num = Integer.parseInt(request.getParameter("board_num")); // 글번호 
String id =(String)session.getAttribute("id"); //글쓴이 = 로그인 

// DB에서 수정할 내용 가져오기 (dao의 객체를 생성해서 dto에 접근 )
// BoardDAO 객체생성 
BoardDAO dao = new BoardDAO(); 
// 메서드 호출 (getboard) 
BoardDTO dto = dao.getBoard(board_num); 
%>


<h1>글수정 : 로그인 (<%=id%>)</h1> <!--get방식 경우)주소값에 입력값이 나타남 -->
<form action="updatePro.jsp" method="get">
<input type="hidden" name="board_num" value="<%=dto.getBoard_num()%>">
<table border="1">	
<tr><td>글쓴이</td>						<!--  ┌글쓴이 id값 가져올거라서 : 글쓴이 알려주는 인증값  -->
	<td><input type="text" name="board_name" value="<%=dto.getBoard_name()%>" readonly="readonly"></td></tr>
<tr><td>글제목</td>
	<td><input type="text" name="board_subject" value="<%=dto.getBoard_subject()%>"></td></tr> <!-- value 사용자가 적을거 -->
<tr><td>글내용</td>
	<td><textarea name="board_content" rows="10" cols="20"><%=dto.getBoard_content()%></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="글수정"></td></tr>
</table>
</form>


</body>
</html>