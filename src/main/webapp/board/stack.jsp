<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실</title>

<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/board.css" />

</head>
<body>

<jsp:include page="../include/top.jsp"></jsp:include> 

<%
// main에서 session값을 가져옴
// 연결정보를 저장해서 유지되는 기억장소 session내장객체에서 저장값을 가져오기 
// 페이지 상관없이 로그인정보 저장-유지 
	String id = (String)session.getAttribute("id");
// 파일을 업로드 할 때 전송방식 : post 방식 (주소줄에 파일 가져갈 수 없어서)

// enctype="multipart/form-data" //form에서 넘길 때 멀티파트~형식으로 넘기겠다  
  
%> 

<!-- ////////////  -->
<div class="sub_cont">
	<form action="stackPro.bo" method="post" enctype="multipart/form-data">
		<table class="type09">
		  <thead>
		  <tr>
		    <th scope="cols">글쓰기</th> 
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
		    <td><input type="text" name="board_subject" style="border : none; width : 1050px" ></td>
		  </tr>
		<!--   <tr> 
		    <th scope="row">글내용</th>
		    <td><textarea name="board_content" rows="10px" cols="150px" style="border : none;"></textarea></td>
		  </tr> -->
		   <tr> 
		    <th scope="row">첨부파일</th>
		    <td><input type="file" name="board_file"></td>
		  </tr>
		  </tbody>
		</table>
		<div style=" align-content: center; text-align: center; margin-top: 15px">
			<input type="submit" value="자료실 글쓰기"  >
		</div>
	</form>
</div>

</body>
</html>