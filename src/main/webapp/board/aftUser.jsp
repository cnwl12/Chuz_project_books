<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 후 이용</title>
</head>
<body>
<script type="text/javascript">
<%
String message = (String) request.getAttribute("message");
if (message != null) {
%>
        alert("<%= message %>");
        history.back(); // 로그인 페이지로 이동
    </script>
<%
}
%>

</body>
</html>