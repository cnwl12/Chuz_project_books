<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// board/fwritePro.jsp

// 파일 업로드 방법2
// 1) 웹서버 upload폴더 생성 후 폴더에 업로드 -> DB 파일이름 저장 
// 2) 데이터베이스 업로드 파일을 바로 저장(대용량 데이터베이스) 

// 파일 업로드 
// 업로드 프로그램 설치 (cos.jar 이용)
// http://www.servlets.com -> cos-22.05.zip 다운로드 -> 압축풀기
// -> C:\Users\ITWILL\Downloads\cos-22.05\lib -> cos.jar
// web-inf -> lib -> cos.jar 넣기 

// cos.jar안에 있는 MultipartRequest.class 객체생성 -> 업로드 
// MultipartRequest multi = new MultipartRequest(request, 업로드 경로, 최대파일크기, 한글처리, 중복이름변경);

// 업로드 경로 (upload폴더 만들기)---(길어서 변수로)
// upload 서버 물리적 경로 (src-main-webapp-upload)
String uploadPath = request.getRealPath("/upload"); // 물리적인경로 (/ : web root에 업로드 폴더 만들것) 
out.println(uploadPath); //upload가상공간(폴더에 올라감 -- > 폴더 ~> 왼쪽파일로 백업가능 )

//최대파일크기(10m)
int maxSize =10*1024*1024;


MultipartRequest multi 												//중복) 업로드 파일 이름 같은 경우 변환
	= new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

// 파라미터 가져오기 (request->multi)
String name = multi.getParameter("name");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
// 파일은 multi로 업로드된 파일 이름을 가져오기 
String file = multi.getFilesystemName("file");

//글번호 num => 구해주기 => /*일단 수동으로 1씩 넣어서 작업 */
int num = 1; 
//조회수 readcount => 0 설정(작성전까진 아무도 못보니까)
int readcount = 0;
//작성일 date	=> 현시스템 날짜,시간 가져오기		//시스템 날짜 가져오기 
Timestamp date = new Timestamp(System.currentTimeMillis());

// BoardDTO에 저장 
BoardDTO dto = new BoardDTO();

// BoardDAO 객체생성 (기억장소 할당)
BoardDAO dao=new BoardDAO();

// set 메서드 호출 ~> 가져온 값 저장 
// 글번호 -> 최대num +1 
dto.setNum(dao.getMaxNum()+1);
dto.setName(name);
dto.setSubject(subject);
dto.setContent(content);
dto.setReadcount(readcount);
dto.setDate(date);
//파일 추가(BoardDTO에 객체 생성 )
dto.setFile(file);

// BoardDAO insertBoard()
dao.insertBoard(dto);

// DB에도 연결 추가해야함 
// DB board테이블에 file열 추가
// ->> alter table board add file varchar(100);
// insert SQL구문 file 추가(cmd) 

%>
<a href="list.jsp">글목록</a> <br>
<script type="text/javascript">
	alert("글목록 이동");	// script는 메시지 전달하면서 많이 사용
	location.href="list.jsp"; 
</script>

<%
// 우선순위 jsp > 스크립트 > html 
response.sendRedirect("list.jsp"); 
%>