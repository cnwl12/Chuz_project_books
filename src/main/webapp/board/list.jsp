<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.itwillbs2.domain.PageDTO"%>
<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/list.jsp</title>

<link rel="stylesheet" href="fonts/icomoon/style.css" />

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js"></script>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/board.css" />

</head>
<body>

<script type="text/javascript">

$(function() {
  function submitCheck() {
    var keyword = $("#keyWord").val();
    if (keyword.trim() === "") { // 입력없이 검색 누름
      alert("검색어를 입력해주세요");
      return false;
    }
    // 검색 로직 실행
    // ...
  }
  $("form").submit(submitCheck);
})

</script>
 
<jsp:include page="../include/top.jsp"></jsp:include> 

<%
//날짜 포맷 -> 문자열로 변경 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");

							// 형변환
List<BoardDTO> dtoList =(List<BoardDTO>)request.getAttribute("dtoList"); //가져와서 변수에 담기 

PageDTO pageDTO =(PageDTO)request.getAttribute("pageDTO"); // 페이징 처리하는 pageDTO가져와서 담기 

String id =(String)session.getAttribute("id"); %>
<div class="sub_cont">
<div>

<!--  <form  -->
<!--               class="narrow-w form-search d-flex align-items-stretch mb-3" -->
<!--               data-aos="fade-up" -->
<!--               data-aos-delay="200" -->
<!--               id="searchForm" -->
              
<!--             > -->
<!--               <input type="text" -->
<!--                 class="form-control px-4" -->
<!--                 placeholder="검색어를 입력해주세요" -->
<!--                 name = "searchKeyWord" -->
<!--                 id = "searchF"> -->
<!--               <button type="submit" class="btn btn-primary">Search</button> -->
<!--             </form> -->

</div>
   
 
<div class="buttonUtil">
<%
// TODO: 글작성, 갤러리 버튼 아이콘 변경
if(id!=null){%>
<a href="fwrite.bo"><input type="button" value="글작성"></a>
<%} %> 
<a href="gallary.bo"><input type="button" value="갤러리" ></a>
</div>
 
<table border="1" width="100" class="brod_table">
<tr>
<th>No.</th>   
<th>제목</th> 
<th>작성자</th>
<th>조회수</th>   
<th>작성일</th>   

<% //결과 while 접근(rs.next()) -> T -> 열접근 rs.getInt("num") ...

for(int i = 0; i<dtoList.size(); i++){ // 자바 내장객체 배열길이는 size()
	BoardDTO dto = dtoList.get(i); //dtoList큰바구니에서 가져와서 BoardDTO형에 담기  
	// 작은바구니 주소 접근 [dto(10번지)|dto(20번지)|dto|dto|dto] 
	%>
	<tr>
	<td><%=dto.getBoard_num()%></td>
	 <!--글제목 통해서 이동 : 하이퍼링크 연결 // 바뀌는 번호값 들고다니기 -->
	<td><a href="content.bo?board_num=<%=dto.getBoard_num()%>"><%=dto.getBoard_subject()%></a></td>
	<td><%=dto.getBoard_name()%></td>
	<td><%=dto.getBoard_readcount()%></td>
	<td><%=dateFormat.format(dto.getBoard_date())%></td></tr>
<%
} 
%>	
</table>
<!-- 페이지번호  -->
<div class="pageNum">
<%
// 이전 startPage 시작페이지 pageBlock 보여줄 페이지 수 비교 
// startPage 더 크면 [이전] 글자 나타남
if(pageDTO.getStartPage()> pageDTO.getPageBlock()){
	%>
	<a href="list.bo?pageNum=<%=pageDTO.getStartPage()-pageDTO.getPageBlock()%>">[이전]</a>
	<%
}
//for문을 통한 하단 페이지 증가 // </table 하단부터 연결
for(int i = pageDTO.getStartPage(); i<=pageDTO.getEndPage(); i++){
	%>
	<a href="list.bo?pageNum=<%=i%>"><%=i%></a>
	<%
}
// 다음 endPage 끝페이지 -> pageCount 전체페이지 비교 
//	=> 전체페이지가 크면 다음 클릭 했을 때 페이지가 존재  
if(pageDTO.getEndPage() < pageDTO.getPageCount()){ // 1~10 < 11~20, 21~30 ---
%>
	<a href="list.bo?pageNum=<%=pageDTO.getStartPage()+pageDTO.getPageBlock()%>">[다음]</a> 
							<!--currentpage+pageblock해도됨  -->
							<!-- 1~10 -> 11~20으로 넘어가게  -->
<%
}
 %>
</div> 
 
<div class="buttonDiv">
<form action="list.bo">
<input type="text" name="keyWord" id="keyWord"  >
<input type="submit" value="검색" >
</form>
</div>


 </div>
</body>




</html>