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

int board_num = Integer.parseInt(request.getParameter("board_num"));
int comment_num = Integer.parseInt(request.getParameter("comment_num"));

//DB작업하러가기 
//DAO 객체생성 -기억장소 할당
BoardDAO dao = new BoardDAO();

//메서드 정의 및 호출 
//리턴할 형 없음 deleteBoard(int num) 메서드 정의 
//delete from board where num=?
//deleteBoard(num)메서드 호출 // 게시판 번호 
dao.deleteComment(comment_num);

%>

<script type="text/javascript">

</script>
</body>
</html>