<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>

	<a href="upload">저장</a>
	<a href="read">읽기</a>
	<a href="delete">삭제</a>
	<p>${link}</p>



</body>
<script>
	var msg = "${msg}";
	if(msg!=""){
		alert(msg);
	}

</script>
</html>