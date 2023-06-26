<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookStroes_login</title>

    <link rel="stylesheet" href="fonts/icomoon/style.css" />
    <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

    <link rel="stylesheet" href="css/tiny-slider.css" />
    <link rel="stylesheet" href="css/aos.css" />
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/bs.css"/>

<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js">


</script>
 -->
 

</head>
<body>

 <div>
<jsp:include page="../include/top.jsp"></jsp:include>
</div>

  <div class="site-mobile-menu site-navbar-target">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close">
          <span class="icofont-close js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div>

<br>
<br><br><br><br><br><br><br><br>
<div id ="ySContent">
<div class="loginCont">
<div id="divTabMemberArea" class="yesTab_nor yesTab_blue tab_2col">
<form  action="loginPro.bs" method="post">
<ul  class="formulli" id="ulTabMember">
<li><input type="text" name="id" placeholder="아이디"></li>
<li><input type="password" name="pass" placeholder="비밀번호"> <br>
<input type="submit" value="로그인">
<a href="join.bs"><input type="button" value="회원가입"></a>
</ul>
</form>

</div>



</div>
</div>


</body>
</html>