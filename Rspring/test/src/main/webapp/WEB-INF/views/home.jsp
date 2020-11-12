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
	<a href="./upload">파일업로드</a><br>
	<button onclick="read()">파일읽기</button><br>
	<a href="./delete">파일삭제</a><br>
	<p>${content }</p>
</body>
<script>
	function read(){
		location.href= "./read";
	}
	
	var page = "${page}";
	if(page != ""){
		location.href = page;
	}
	
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>