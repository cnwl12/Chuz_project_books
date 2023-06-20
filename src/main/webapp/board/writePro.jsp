<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--pro여기선 전달만할거라 다른 거 지워도 됨  -->
<%
//board/writePro.jsp
//사용자가 입력한 정보를 서버에 전달하면 
//서버 내장객체 request 내장객체에 저장 
//post방식 : 주소창에 안 보임 ㄴ ) request 한글처리 
request.setCharacterEncoding("utf-8");

//request name,subject, content 가져와서 변수에 저장 
String board_name = request.getParameter("board_name");
String board_subject = request.getParameter("board_subject");
String board_content = request.getParameter("board_content");

// 글번호 num => 구해주기 => /*일단 수동으로 1씩 넣어서 작업 */
int board_num = 1; 
// 조회수 readcount => 0 설정(작성전까진 아무도 못보니까)
int board_readcount = 0;
// 작성일 date	=> 현시스템 날짜,시간 가져오기		//시스템 날짜 가져오기 
Timestamp board_date = new Timestamp(System.currentTimeMillis());

// 게시판 글을 하나의 바구니(자바파일)에 저장 
// 패키지 board 파일이름 BoardDTO 파일 생성
// num, name, subject, content, readcount, date 멤버변수
// set/get 메서드 생성 

// BoardDTO 객체생성(기억장소 할당)
BoardDTO dto = new BoardDTO();
// "set메서드" 호출해서 폼에서 가져온 값을 "저장" 
dto.setBoard_num(board_num);
dto.setBoard_name(board_name);
dto.setBoard_subject(board_subject);
dto.setBoard_content(board_content);
dto.setBoard_readcount(board_readcount);
dto.setBoard_date(board_date);

// 게시판 글 작성된 바구니(DTO)주소값 갖고 DB작업 파일에 insertBoard()메서드 호출 = 디비에 게시판 글 저장 
// 패키지 board 파일이름 BoardDAO 파일 생성 
// 리턴할형 없음 insertBoard(바구니 주소 : BoardDTO(형) dto(변수))메서드 정의 
// insertBoard(1~4단계 실행)

//사용 시 
// BoardDAO 객체생성(기억장소 할당)
BoardDAO dao = new BoardDAO();

// max(num) 구하는 메서드 정의 -> num중에 가장 큰 번호 구하기 
// int(-리턴할 형) getMaxNum() 메서드 정의 (전체를 대상으로 --> 값안들고 가도 됨)
// num(위에 선언해뒀음) = getMaxNum()메서드 호출 +1  
board_num = dao.getMaxNum()+1;
		//num중 가장 큰 번호 +1 해서 num에 저장하겠다는 뜻 
dto.setBoard_num(board_num); // 바구니에 저장 		

// insertBoard(바구니 주소)메서드 호출해서 디비에 게시판 글 저장 
dao.insertBoard(dto);


// 게시판 글목록 이동
response.sendRedirect("list.jsp");
%>