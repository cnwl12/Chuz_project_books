<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/delet.jsp</title>
</head>
<body>
<%
// 삭제작업 바로 
// delete.jsp?num=1
// num=1 서버에 전달 => 서버 request 저장
int board_num = Integer.parseInt(request.getParameter("board_num"));

// DB작업하러가기 
// DAO 객체생성 -기억장소 할당
BoardDAO dao = new BoardDAO();

// 메서드 정의 및 호출 
// 리턴할 형 없음 deleteBoard(int num) 메서드 정의 
// delete from board where num=?
// deleteBoard(num)메서드 호출 // 게시판 번호 
dao.deleteBoard(board_num);

// 글목으로 이동
response.sendRedirect("list.jsp");
%>
</body>
</html>