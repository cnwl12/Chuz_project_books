<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookStore_join me!</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

<link rel="stylesheet" href="css/tiny-slider.css" />
<link rel="stylesheet" href="css/aos.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/bs.css"/>
<link rel="stylesheet" href="css/member.css"/>
<script type="text/javascript">

$(function(){
	var regex = /^[a-zA-Z0-9]{4,10}$/ 	// id, pw 검사
	var regexTel = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/		// 휴대폰 검사
	
	var pass = $.trim($("#pass").val());
	var pass2 = $.trim($("#pass2").val());
	
	//trim 쓰기!! 
	
	$("#pass").on("input", function(){
		console.log("#pass : " + $("#pass"));
		console.log("#pass.val() : " + $("#pass").val());
		// console.log($(".checkPassResult").html());
		console.log(regex.test($("#pass").val()));
	})
	
	console.log(pass==pass2);

	$("#pass2").on("input", function(){
		pass = $("#pass").val();
		pass2 = $("#pass2").val();
		
		if(pass == pass2){
			//console.log("일치합니다");
			$(".checkPassResult").html("비밀번호가 일치합니다");	
		}else{
			$(".checkPassResult").html("비밀번호가 불일치합니다");	
			// $("#pass2").focus();
			console.log("불일치"); 
		}
	})
	
	$("#phone").on("input",function(){
		
		tel =$("#phone").val();
		
		if(!(regexTel.tel)){
			
		$(".checkTelResult").html("-을 삽입해주세요");
		}else
			$(".checkTelResult").html("연락처 확인");
		
	})//
	
// 	$("#id").on("input",function(){
// 		var id = $("#id").val()
		
// 		$.ajax({
// 			data : id,
// 			method : "POST",
// 			url : "/checkId.bs"
// 		})
// 		.done(function(result){
// 			if(result.result){
// 				$(".checkIdResult").html("사용 가능한 아이디입니다.");
// 			}else{
// 				$(".checkIdResult").html("중복된 아이디입니다.");
// 			}
// 		})
// // 		$(".checkIdResult").html("");
// 	})
	
// 	$(".checkPassResult")

})

// $(document).ready(function(){})
	


function validate() {
	var id = document.getElementById("id");
	var pass = document.getElementById("pass");
}
 
function fun1() {
	
	// 아이디 작성 
	if(document.checkform.id.value==""){
		alert("*필수 작성 바랍니다");
		document.checkform.id.focus();
		return false;
	} 
	
	//회원 아이디 제어
	if(document.checkform.id.value.length < 4 ||
		document.checkform.id.value.length >10){
		alert("ID는 4~10자 내로 작성바랍니다");
		document.checkform.id.focus();
		return false;
	}
	
	//비밀번호 작성 1)
	if(document.checkform.pass.value==""){
		alert("비밀번호 작성 바랍니다");
		document.checkform.pass.focus();
		return false;
	}
	//비밀번호 작성 제어 
	if(document.checkform.pass.value.length < 4 ||
		document.checkform.pass.value.length > 10){
		alert("비밀번호는 4~10자 내로 작성바랍니다");
		document.cf.pass.focus();
		return false;
	}
	
	//비밀번호 작성 2 확인용)
	if(document.checkform.pass2.value==""){
		alert("비밀번호 동일 작성 바랍니다");
		document.checkform.pass2.focus();
		return false;
	}
	//비밀번호 작성 재확인 
	if(document.checkform.pass2.value !=document.cf.pass.value){
		alert("비밀번호가 일치하지 않습니다");
		document.checkform.pass2.focus();
		return false;
	}
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
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
<div class="ySJoinStep">
	<h1>회원가입</h1>
	<!-- id/pass 설정하기  -->
	<form action="joinPro.bs" method="post" name="checkform" onsubmit="return fun1()"> <!--  -->
	<div class="ySContRow w_600">
	<ul class="formulli">
	<li>id<input type="text" placeholder="id는 최대 4자리 이상으로 작성"
				name="id" id="id"  > <span class="checkIdResult"> #중복확인용</span></li>
	<li>pass<input type="password" placeholder="비밀번호는 8자리 이상으로 작성"
			name="pass" id="pass" >
	</li>
	<li>pass 재확인<input type="password" placeholder="비밀번호 동일" name="pass2" id="pass2" >		
		<div class="checkPassResult">확인용</div>	</li>
	<li>이름<input type="text" name="name" id="name" > </li>
	<li>휴대폰번호(연락처)<input type="text" name="phone" id="phone" ><span class="checkTelResult">연락처유효성</span></li>
	</ul>

		<ul class="formulli">
			<li>E-mail <input type="email" name="email">
			</li> 주소
			<input type="text" id="sample6_postcode" placeholder="우편번호">
			<input type="button" onclick="sample6_execDaumPostcode()"
				value="우편번호 찾기">
			<li><input type="text" id="sample6_address" placeholder="주소"
				name="addressMain"> <input type="text"
				id="sample6_extraAddress" placeholder="참고항목"></li>
			<li><input type="text" id="sample6_detailAddress"
				placeholder="상세주소" name="addressSub"></li>
		</ul>
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




		<!-- 제출/초기화 -->
	
	
			<div>
				<input type="button" value="가입취소" onclick="history.back();">
				<input type="submit" value="회원가입" > 
				<input type="reset" value="초기화">
			</div>
		</div>
	</form>
</div>

		<!-- <p>
			ID<span>*</span> <input type="text" placeholder="id는 최대 4자리 이상으로 작성"
				name="id" id="id"  >
				 <input type="button"
				value="중복확인" width="10" height="3" onclick="idCheck()" > <br>
		</p>

		PASS* <input type="password" placeholder="비밀번호는 8자리 이상으로 작성"
			name="pass" id="pass" ><br> PASS 재확인* <input
			type="password" placeholder="비밀번호 동일" name="pass2" id="pass2" ><br>

		이름* <input type="text" name="name" id="name" ><br> 휴대폰번호(연락처)* <input
			type="text" name="phone" id="phone" ><br> -->

		<!-- 주소- 다음api  -->
		


</body>
</html>