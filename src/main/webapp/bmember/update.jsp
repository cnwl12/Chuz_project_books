<%@page import="com.itwillbs2.domain.BookDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookStore_update</title>
<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/aos.css" />
<link rel="stylesheet" href="css/style.css" />
<jsp:include page="../include/top.jsp"></jsp:include>
<br><br><br><br><br><br>
</head>
<body>

<%
BookDTO bookDTO =(BookDTO)request.getAttribute("bookDTO");
%>

<form action="updatePro.bs" method="post">
<label>ID<span>*</span></label>
<input type="text" name="id" value="<%=bookDTO.getId()%>" readonly="readonly"> 
<label>PASS<span>*</span></label>
<input type="password" name="pass" value="<%=bookDTO.getPass()%>" ><br>
<label>이름<span>*</span></label>
<input type="text" name="name" value="<%=bookDTO.getName()%>" ><br>
<label>휴대폰번호(연락처)<span>*</span></label>
<input type="text" name="phone" value="<%=bookDTO.getPhone()%>"><br>
<label>주소</label>
<input type="text" id="sample6_postcode" placeholder="우편번호">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="sample6_address" placeholder="우편번호 찾기 후 주소작성" name="addressMain"><br>
<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="addressSub">
<input type="text" id="sample6_extraAddress" placeholder="참고항목">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {  // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<label>E-mail</label> 
<input type="email" name="email" value="<%=bookDTO.getEmail()%>"> <br>

<!-- 제출/초기화 -->     
    <input type="submit" value="회원 정보 수정">
    <input type="reset" value="회원탈퇴"> <br>
    <input type="button" value="뒤로가기"><a href="main.bs"></a>
      
</form>


</body>
</html>