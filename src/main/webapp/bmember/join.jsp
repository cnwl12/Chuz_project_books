<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookStore_join me!</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>


<link rel="stylesheet" href="fonts/icomoon/style.css" />

<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/bs.css"/>
<link rel="stylesheet" href="css/member.css"/>

<script type="text/javascript">

$(function(){
	var regex = /^[a-zA-Z0-9]{4,10}$/ 	// id, pw 검사
	var regexTel = /^[010][0-9]{4}[0-9]{4}$/		// 휴대폰 검사
	
	var pass = $.trim($("#pass").val());
	var pass2 = $.trim($("#pass2").val());
	
	console.log(pass);
	
	$("#id").on("input", function() {
		id = $("#id").val().length;
		
		if(id < 4 ){
			$(".checkIdResult").html("4자리 이상 작성").css("color","red");
		}else{
			// 요건 충족했을 때 삭제
			$(".checkIdResult").html("");
		}
		
	})
	
	// 콘솔 확인용
	/* 
	$("#pass").on("input", function(){
		console.log("#pass : " + $("#pass"));
		console.log("#pass.val() : " + $("#pass").val());
		// console.log($(".checkPassResult").html());
		console.log(regex.test($("#pass").val()));
	})
	
	console.log(pass==pass2);
	*/
	
	// 비밀번호 자리 수 
	$("#pass").on("input", function() {
		pass = $("#pass").val().length;
		
		if(pass < 8){
			$(".checkPass1Result").html("8자리 이상 작성 바랍니다").css("color","red");	
		}else{
			$(".checkPass1Result").html(" ");	
		}
	})
	
	// 비밀번호 재확인 일치여부 
	$("#pass2").on("input", function(){
		pass = $("#pass").val();
		pass2 = $("#pass2").val();
		
		if(pass == pass2){
			//console.log("일치합니다");
			$(".checkPassResult").html("비밀번호가 일치합니다");	
			$(".checkPassResult").html("");
		}else{
			$(".checkPassResult").html("비밀번호가 불일치합니다").css("color","red");	
			// $("#pass2").focus();
			console.log("불일치"); 
		}
	})
	
	// 핸드폰 자리 수 
	$("#phone").on("input",function(){
		
		tel =$("#phone").val().length;
		
 		/* if(tel > 11){
 			tel.replace(/\D/g, '').slice(0, 11);
		}
 		 */
 		
 		if(tel > 11 || tel < 11){
 			$(".checkTelResult").html("연락처 자리수 확인").css("color","red");
 		}else{
			$(".checkTelResult").html(" ")
		}
		
	})//
	
})


// - 제거 
function removeHyphen(event) {
  var input = event.target;
  var phoneNumber = input.value;
  var cleanedPhoneNumber = phoneNumber.replace(/-/g, '');
  input.value = cleanedPhoneNumber;
}

function fun1() {
	
	// 아이디 작성 
	if(document.checkform.id.value==""){
		alert("*필수 작성 바랍니다");
		document.checkform.id.focus();
		return false;
	} 
	
	//비밀번호 작성 1)
	if(document.checkform.pass.value==""){
		alert("비밀번호 작성 바랍니다");
		document.checkform.pass.focus();
		return false;
	}
	
	//비밀번호 작성 2)
	if(document.checkform.pass2.value==""){
		alert("비밀번호 작성 바랍니다");
		document.checkform.pass2.focus();
		return false;
	}
	
	if(document.checkform.name.value==""){
		alert("이름 작성 바랍니다");
		document.checkform.name.focus();
		return false;
	}
	
	// 연락처 작성 
	if(document.checkform.phone.value==""){
		alert("연락처 작성 바랍니다");
		document.checkform.phone.focus();
		return false;
	}
	
	
	
	
}//fun1 끝  
	
	// 중복확인 완료 안내
	function idCheck() {
		alert("중복확인완료");
	}	
	
</script>


</head>
<body>

	<jsp:include page="../include/top.jsp"></jsp:include>
	
	<!-- id/pass 설정하기  -->
	<form action="joinPro.bs" method="post" name="checkform" onsubmit="return fun1()"> <!--  -->
	<div  class="joinTable">
	
	<table id="table_JN">
	<tbody >
	<tr><td style="color: maroon; font-size: 20px" > 회원가입 :) </td> </tr>
	
	<tr>
	<td>아이디<span style="color: red">*</span> </td>
	<td><input type="text" name="id" id="id" ></td>	
	<td><span class="checkIdResult"></span></td>
	</tr>
	
	<tr>
	<td>비밀번호<span style="color: red">*</span> </td>
	<td><input type="password" name="pass" id="pass" ></td>
	<td><span class="checkPass1Result"></span></td>
	</tr>
	
	<tr>
	<td>비밀번호 재입력<span style="color: red">*</span> </td>
	<td><input type="password" name="pass2" id="pass2"></td>	
	<td><span class="checkPassResult"></span></td>
	</tr>
	
	<tr><td>이름<span style="color: red">*</span> </td>
		<td><input type="text" name="name" id="name" ></td></tr>
	<tr><td>휴대전화<span style="color: red">*</span> </td>
		<td><input type="text" name="phone" id="phone" oninput="removeHyphen(event)" ></td>
		<td><span class="checkTelResult"></span></td></tr>
	<tr><td>E-mail</td>
		<td><input type="email" name="email"></td></tr>
	<tr>
	<td vertical-align:top>주소</td>
	<td>
			<input type="text" id="sample6_postcode" placeholder="우편번호"></td>
			<td id="notd">
			<input type="button" onclick="sample6_execDaumPostcode()"
				value="우편번호 찾기"></td></tr>
				<tr>
				<td></td>
			<td><input type="text" id="sample6_address" placeholder="주소"
				name="addressMain"></td></tr>
				<tr>
				<td></td>
				<td><input type="text" id="sample6_detailAddress"
				placeholder="상세주소" name="addressSub"></td>
				<td > <input type="text"
				id="sample6_extraAddress" placeholder="참고항목"></td></tr>
			
		<script
			src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

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
                
                }  else {
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
</tbody>
</table>
</div>

<div style=" margin:0 auto; padding:30px 0 0 0; border-bottom:4px solid #505050; width:930px"></div>

<div>
		<!-- 제출/초기화 --> 
	<div  class= "buttonJN">
	
				<input type="button" value="가입취소" onclick="history.back();">
				<input type="submit" value="회원가입" > 
				<input type="reset" value="초기화">
	</div>
</div>
	</form>

</body>
</html>