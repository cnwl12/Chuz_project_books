<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// board/fupdate.jsp

// 경로설정
String uploadPath = request.getRealPath("/upload");

// 파일 사이즈 
int maxSize =10*1024*1024;

// 변수에 담기 												//물리적경로  //파일크기	//한글	 //중복) 업로드 파일 이름 같은 경우 변환
MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

int board_num = Integer.parseInt(multi.getParameter("board_num")); //fwrite 에서 hidden으로 가져왔음 
//파라미터 가져오기 (request->multi)
String board_name = multi.getParameter("board_name");
String board_subject = multi.getParameter("board_subject");
String board_content = multi.getParameter("board_content");
//파일은 multi로 업로드된 파일 이름을 가져오기 
String board_file = multi.getFilesystemName("board_file");

// 새롭게 업로드 된 파일이 없으면 
if(board_file==null){
	board_file = multi.getParameter("oldfile"); // 기존 파일 
}

//BoardDTO에 저장 (바구니)
BoardDTO dto = new BoardDTO();

dto.setBoard_num(board_num); // 수정할 번호를 위에서 가져왔으니까 
dto.setBoard_name(board_name);
dto.setBoard_subject(board_subject);
dto.setBoard_content(board_content);
dto.setBoard_file(board_file);

//BoardDAO 객체생성 (기억장소 할당)
BoardDAO dao=new BoardDAO();

dao.fupdateBoard(dto); //첨부파일 수정 메서드 

//글목록으로 이동 
response.sendRedirect("list.jsp");

%>