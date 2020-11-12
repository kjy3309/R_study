<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style></style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<p><a href="upload">C:/test/word.txt 업로드</a></p>
	<p><a href="read">/store/test/word.txt 읽기</a></p>
	<p><a href="delete">/store 폴더 삭제</a></p>
	<p>${content}</p>
</body>
<script>
	var msg = "${msg}";
	var link = "${link}"
	if(msg != ""){
		alert(msg);		
	}
	if(link != ""){
		location.href=link;
	}		
</script>
</html>