<%@page import="com.itwillbs2.domain.BoardDTO"%>
<%@page import="com.itwillbs2.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정하기</title>

<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/board.css" />

</head>
<body>

<jsp:include page="../include/top.jsp"></jsp:include>
<%
BoardDTO dto = (BoardDTO)request.getAttribute("dto");
String id =(String)session.getAttribute("id"); //글쓴이 = 로그인 

%>
<!-- ////////////  -->
<div class="sub_cont"> 
	<form action="fupdatePro.bo" method="post" enctype="multipart/form-data">
		<input type="hidden" name="board_num" value="<%=dto.getBoard_num()%>">	
			<table class="type09">
			  <thead>
			  <tr>
			    <th scope="cols">글수정하기</th> 
			    <th scope="cols"> </th>
			  </tr> 
			  </thead>
			  <tbody>
			  <tr>
			    <th scope="row">글쓴이</th>
			    <td><input type="text" name="board_name" value="<%=id%>" readonly="readonly"  style="border : none;"></td>
			  </tr>
			  <tr> 
			    <th scope="row">글제목</th>
			    	<td>
			    		<input type="text" name="board_subject" value="<%=dto.getBoard_subject()%>" style="border : none; width : 1050px">
			    	</td>
		  	  </tr>
			  <tr> 
			    <th scope="row">글내용</th>
			    	<td><textarea name="board_content" rows="10px" cols="150px" style="border : none;"><%=dto.getBoard_content()%></textarea></td>
				</tr>
			   <tr> 
			    <th scope="row">첨부파일</th>
			    <td>새로운 수정 파일<input type="file" name="board_file"><br>
					기존 파일 : <input type="text"  style="border : none;" name="oldfile" value="<%=dto.getBoard_file()%>" readonly="readonly"> </td>
			  </tr>
			  </tbody>
			</table>
			<div style=" align-content: center; text-align: center; margin-top: 15px">
				<input type="submit" value="글수정"  >
			</div>
	</form>
</div>

<!-- ////////// -->
<%-- 
<h4>첨부글 수정 : 로그인 (<%=id%>)</h4> <!--get방식 경우)주소값에 입력값이 나타남 -->
<form action="fupdatePro.bo" method="post" 
	  enctype="multipart/form-data"> <!-- 첨부파일 경우 post  -->
<input type="hidden" name="board_num" value="<%=dto.getBoard_num()%>">
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
 --%>


</body>
</html>