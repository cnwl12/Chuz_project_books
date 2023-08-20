<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookStroes_login</title>

    <link rel="stylesheet" href="fonts/icomoon/style.css" />
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/top2.css"/>

</head>
<body>

 <div class="menu-bg-wrap">
  <a href="main.bs" class="logo m-0 float-start">
  <img src="./image/logo.png" alt="" width="200" height="50" >
  </a>
</div>

<br> 
	<div class="loginF">
		<form action="loginPro.bs" method="post">
			<ul class="formulli">
				<li>
					<input type="text" name="id" placeholder="아이디" class="lP"></li>
				<li style="padding-top: 4px;">
					<input type="password" name="pass" placeholder="비밀번호" class="lP"> <br>
					<div class="FD">
						<input type="submit" value="로그인" style="width: 210px">
					</div>
			</ul>
		</form>
	</div>

</body>
</html>