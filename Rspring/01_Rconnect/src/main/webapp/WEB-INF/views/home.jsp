<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>R MAIN</title>
<style></style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<h3>R-SPRING 연동 페이지 홈</h3>
	<p>${msg}</p>
	<ul>
		<li><a href='ver'>R 버전 확인</a></li>
		<li><a href='reqPage'>다양한 요청</a></li>
		<li><a href='graph'>그래프</a></li>
		<li><a href='textMining'>텍스트 마이닝</a></li>		
		<li><a href='map?file=cycle_map.R'>따릉이 정류소 분포</a></li>
		<li><a href='map?file=wc_map.R'>공용 화장실 분포</a></li>
	</ul>	
	<c:if test="${fileName ne null and fileName ne ''}">
		<iframe src="/viz/${fileName}" width="70%" height="800px" style="border:none"></iframe>
	</c:if>
	
	
</body>
</html>