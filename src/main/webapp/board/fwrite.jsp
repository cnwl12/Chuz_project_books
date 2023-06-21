<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/fwrite.jsp</title>

<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/aos.css" />
<link rel="stylesheet" href="css/style.css" />

</head>
<body>

<jsp:include page="../include/top.jsp"></jsp:include> 
<br><br><br><br><br><br><br><br>

<%
// main에서 session값을 가져옴
// 연결정보를 저장해서 유지되는 기억장소 session내장객체에서 저장값을 가져오기 
// 페이지 상관없이 로그인정보 저장-유지 
	String id = (String)session.getAttribute("id");
// 파일을 업로드 할 때 전송방식 : post 방식 (주소줄에 파일 가져갈 수 없어서)

// enctype="multipart/form-data" //form에서 넘길 때 멀티파트~형식으로 넘기겠다 

%>

<h4>첨부파일 글쓰기</h4> <!--get방식 경우)주소값에 입력값이 나타남 -->
<form action="fwritePro.bo" method="post" enctype="multipart/form-data">
<table border="1">	
<tr><td>글쓴이</td>						<!--  ┌글쓴이 id값 가져올거라서 : 글쓴이 알려주는 인증값  -->
	<td><input type="text" name="board_name" value="<%=id%>" readonly="readonly"></td></tr>
<tr><td>글제목</td>
	<td><input type="text" name="board_subject"></td></tr> <!-- value 사용자가 적을거 -->
<tr><td>첨부파일</td>
	<td><input type="file" name="board_file"></td></tr>
<tr><td>글내용</td>
	<td><textarea name="board_content" rows="10" cols="20"></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="글쓰기"></td></tr>
</table>


</form>


</body>
</html>