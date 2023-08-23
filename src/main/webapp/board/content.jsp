<%@page import="com.itwillbs2.domain.*"%>
<%@page import="com.itwillbs2.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookStores_board</title>

<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/board.css" />

<script type="text/javascript">
function comment_delete(comment_num){
	
	var board_num = ${dto.getBoard_num()};
	// alert(board_num);
	
	if(confirm("삭제하시겠습니까?")){
		location.href="commentDelete.bo?comment_num="+comment_num +"&board_num="+board_num;
	//	location.href="main.bs";
	}
}

</script>

</head>
<body>

<jsp:include page="../include/top.jsp"></jsp:include>
 
<!--로그인 되어있는 아이디 == 세션에 저장된 "id"일치  -->
<!-- string으로 형변환 -->
  
<%
BoardDTO dto=(BoardDTO)request.getAttribute("dto");
String id =(String)session.getAttribute("id");
%>  
 
 
 <!-- ////////////  -->
<div class="sub_cont">
	<form action="fwritePro.bo" method="post" enctype="multipart/form-data">
		<table class="type09">
		  <thead>
		  <tr>
		    <th scope="cols">게시글보기</th> 
		    <th scope="cols"> </th>
		  </tr>
		  </thead>
		  <tbody>
		  <tr>
		    <th scope="row">No.</th>
		    <td><input type="text" name="board_name" value="<%=dto.getBoard_num()%>" disabled="disabled"  style="border : none; background: white;"></td>
		  </tr>
		  <tr>
		    <th scope="row">글쓴이</th>
		    <td><input type="text" name="board_num" value="<%=dto.getBoard_name() %>" disabled="disabled"  style="border : none; background: white;"></td>
		  </tr>
		  <tr>
		    <th scope="row">조회수</th>
		    <td><input type="text" name="board_num" value="<%=dto.getBoard_readcount()%>" disabled="disabled"  style="border : none; background: white;"></td>
		  </tr>
		  <tr> 
		    <th scope="row">글제목</th>
		    <td><input type="text" name="board_subject" value="<%=dto.getBoard_subject()%>" disabled="disabled" style="border : none; width : 1050px; background: white;" ></td>
		  </tr>
		  <tr> 
		    <th scope="row">글내용</th>
		    <td><textarea name="board_content"   disabled="disabled"  rows="10px" cols="150px" style="border : none; background: white;"><%=dto.getBoard_content()%></textarea></td>
		  </tr>
		  
		   <tr> 
		    <th scope="row">첨부파일</th>
		    <td>
		    <a href="upload/<%=dto.getBoard_file()%>" download>
		    	<img src ="upload/<%=dto.getBoard_file()%>" width="500" height="500">
		 	</a>  
			</td>
		  </tr>
		  </tbody>
		</table>
		
		<%
		// 로그인값(세션값), 글쓴이 일치하면 => 글수정, 글삭제 보이기 
		if(id!=null){ //세션값이 있으면 
			if(id.equals(dto.getBoard_name())){ // 로그인한 사람 = 글쓴이 =>수정/삭제버튼 보임 
			%>
				<div style=" align-content:right; text-align: center; margin-top: 15px">
					<input type="button" value="삭제" onclick="location.href='delete.bo?board_num=<%=dto.getBoard_num()%>'">
					<input type="button" value="수정" onclick="location.href='fupdate.bo?board_num=<%=dto.getBoard_num()%>'">
			<%
			}
		}
		%>	
				</div>
			</form>
		</div> 
 
 <!-- 댓글 --> 
<table class="table-striped">
	
	
		<tr>
				<td id="td01">아이디</td>
				<td id="td01">내용</td>
				<td colspan="2" id="td01">작성일</td>
		</tr>	
		
		<c:forEach var="comment" items="${commentList }">
		<tr>
			<td>${comment.comment_id }</td>
			<td>${comment.comment_text }</td>
			<td>${comment.comment_date }</td>
			<td>
			<c:if test="${comment.comment_id eq id }">
			<input type="button" value="삭제" onclick="comment_delete(${comment.comment_num})">
			</c:if>
			</td>
		</tr>
	
		</c:forEach>
	

	</table>

<div style="margin-top : 5px;">
<form method="post" action="comment_insert.bo">
		<input type="hidden" name="board_num" value="<%=dto.getBoard_num()%>">
		<input type="hidden" name="comment_id" value="<%=id%>">
		
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<tr>
			<%
			if(id !=null){
			%>
			<td style="border-bottom:none;" valign="middle"><%=id%></td>
			<td><input type="text" style="height:50px;" class="form-control"  placeholder="상대방을 존중하는 댓글을 남깁시다." name ="comment_text">
			<td><div style="margin-top:15px;"><input type="submit" value="댓글 작성"></div></td>
			<%
			}else{
				%>
				<td>
				<input type="text" style="height:50px;" class="form-control"  disabled  placeholder="로그인 후 작성가능합니다" name ="comment_text">
				</td>
			<%} 
			%>
			</tr>
		</table>
	</form>
</div>
<%-- 
	<form method="post"  action="comment_insert.bo">
		<input type="hidden" name="board_num" value="<%=dto.getBoard_num()%>">
		<input type="hidden" name="comment_id" value="<%=id%>">
		
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<tr>
				<td style="border-bottom:none;" valign="middle"><%=id%></td>
				<td><input type="text" style="height:50px;"
				 class="form-control"  name = "comment_text"
				 <c:choose>
				 	<c:when test="${empty sessionScope.id }">
				 		disabled="disabled" placeholder="로그인 후 이용해주세요."
				 	</c:when>
				 	<c:otherwise>
				 		placeholder="상대방을 존중하는 댓글을 남깁시다."
				 	</c:otherwise>
				 </c:choose>
				 ></td>
				<td><br><input type="submit" value="댓글 작성"></td>
			</tr>
		</table>
	</form> --%>
		
		<!-- 이전, 다음글 없을 때  -->
<div class="buttonPN">
<% if (dto.getPrev_num() != 0) { %>
<input type="button" value="이전 글" onclick="location.href='content.bo?board_num=<%=dto.getPrev_num()%>'">
<% } %>
<!-- <input type="hidden" value="이전 글"> -->

<input type="button" value="글목록" onclick="location.href='list.bo'">

<% if (dto.getNext_num() != 0) { %>
<input type="button" value="다음 글" onclick="location.href='content.bo?board_num=<%=dto.getNext_num()%>'">
<%
}   
%>
</div>
<!-- <input type="hidden" value="다음 글" >  -->

	 
		
</body>
</html>