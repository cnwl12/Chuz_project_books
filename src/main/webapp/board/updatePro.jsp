<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 처리만할거니까 다 지워도 됨 
// board/updatePro.jsp

// 수정할 내용을 서버에 전달하면 request에 저장 
// request한글설정 
request.setCharacterEncoding("utf-8");

// request에서 파라미터(태그정보)값을 가져오기
int num=(Integer.parseInt(request.getParameter("num"))); // 정수형으로 전환해서 가져오기 
String name = request.getParameter("name");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

//BoardDTO 객체생성-기억장소할당(바구니에서 가져옴) 
BoardDTO dto = new BoardDTO();
//DTO 변수에 private으로 막혀있으니까 우회적으로 set을 통해 값을 저장 
//set메서드 호출 > 파라미터 값을 저장 // 새로 입력값 저장 
dto.setNum(num);
dto.setName(name);
dto.setSubject(subject);
dto.setContent(content);

//DAO객체생성
BoardDAO dao = new BoardDAO();

//update board set subject=?, content=? where num=?
//리턴할 형 없음==>dto따로 설정 필요없이
//메서드호출 updateBoard(dto) 메서드 정의 및 호출
dao.updateBoard(dto);

// list.jsp로 이동
response.sendRedirect("list.jsp");


%>