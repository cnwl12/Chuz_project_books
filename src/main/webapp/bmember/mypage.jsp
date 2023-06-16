<%@page import="com.itwillbs2.domain.BookDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BS_mypage</title>
</head>
<body>

<%
BookDTO bookDTO =(BookDTO)request.getAttribute("bookDTO"); 
%>

<form action="updatePro.bs" method="post">
<fieldset>
  <p>ID<span>*</span> </p>
 <p>
   <input type="text" name="id" value="<%=bookDTO.getId()%>" readonly="readonly">
 </p>

   <p>PASS<span>*</span></p>
   <input type="password" name="pass" value="<%=bookDTO.getPass()%>" >

    <p>이름<span>*</span></p>
    <input type="text" name="name" value="<%=bookDTO.getName()%>" >

     <p>휴대폰번호(연락처)<span>*</span></p>
     <input type="text" name="phone" value="<%=bookDTO.getPhone()%>">

     <p>주소</p>
     <input type="text" placeholder="도로명주소" name="addressMain" value="<%=bookDTO.getAddressMain()%>">
     <input type="text" placeholder="상세주소" name="addressSub" value="<%=bookDTO.getAddressSub()%>">
   
      <p>E-mail</p>
      <input type="email" name="email" value="<%=bookDTO.getEmail()%>"> <br>
</fieldset>

<!-- 제출/초기화 -->     
    <input type="submit" value="회원 정보 수정">
    <input type="reset" value="회원탈퇴"> <br>
    <input type="button" value="뒤로가기"><a href="insert.bs"></a>
      
</form>


</body>
</html>