<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/delete.jsp</title>
</head>
<body>
<%
//session : 연결정보를 페이지 상관없이 값 유지(+연결정보 저장)
//로그인 정보를 session.setAttribute("id", id); 세션에 "저장"
//session에서 저장한 "id" 값을 "가져오기" session.getAttribute("id") -> String id변수에 저장 
String id =(String)session.getAttribute("id");
%>

<form action="deletePro.bs" method="post">
아이디 : <input type="text" name="id" 
		value="<%=id%>" readonly><br>
비밀번호 : <input type="password"	name="pass"><br>
<input type="submit" value="회원정보삭제">
</form>


</body>
</html>