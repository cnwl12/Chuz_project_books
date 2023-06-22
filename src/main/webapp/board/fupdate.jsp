<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/fupdate.jsp</title>

<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/aos.css" />
<link rel="stylesheet" href="css/style.css" />

</head>
<body>

<jsp:include page="../include/top.jsp"></jsp:include>
<br><br><br><br><br><br><br>
<%
BoardDTO dto = (BoardDTO)request.getAttribute("dto");

//num, id값 가져와야함 
String id =(String)session.getAttribute("id"); //글쓴이 = 로그인 

%>


<h4>첨부글 수정 : 로그인 (<%=id%>)</h4> <!--get방식 경우)주소값에 입력값이 나타남 -->
<form action="fupdatePro.bo" method="post" 
	  enctype="multipart/form-data"> <!-- 첨부파일 경우 post  -->
<input type="hidden" name="board_num" value="<%=dto.getBoard_num()%>">
<table border="1">	
<tr><td>글쓴이</td>						<!--  ┌글쓴이 id값 가져올거라서 : 글쓴이 알려주는 인증값  -->
	<td><input type="text" name="board_name" value="<%=dto.getBoard_name()%>" readonly="readonly"></td></tr>
<tr><td>글제목</td>
	<td><input type="text" name="board_subject" value="<%=dto.getBoard_subject()%>"></td></tr> <!-- value 사용자가 적을거 -->
<tr><td>첨부파일</td>
	<td>새로운 수정 파일<input type="file" name="board_file"><br>
		기존 파일 이름 : <input type="text" name="oldfile" value="<%=dto.getBoard_file()%>" readonly="readonly"> </td></tr>
		 <!-- 첨부파일은 value 없음 / 기존 첨부파일(oldfile) 들고가야함--> 
<tr><td>글내용</td>
	<td><textarea name="board_content" rows="10" cols="20"><%=dto.getBoard_content()%></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="글수정"></td></tr>
</table>
</form>



</body>
</html>