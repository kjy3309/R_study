<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HDFS DASH BOARD</title>
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<style>
			table, th, td{
				border : 1px solid black;
				border-collapse: collapse;
				padding: 5px 10px;
			}			
			#path{
				margin-bottom : 5px;
				margin-right: 5px;
				width : 300px;
			}
			#layer{
				position:absolute;
				background-color:white;
				top: 5%;
				left: 5%;
				width: 500px;
				height: 50%;
				border: 1px solid black;
				font-size: 12px;
				padding: 10px;
				z-index:2;
				overflow:scroll; 				
			}
			#bg{
				position:absolute;
				top:0px;
				left:0px;
				width:100%;
				height:100%;
				background-color: black;
				opacity:0.5;
			}
			#popup{
				position:absolute;
				top:10%;
				left:10%;
				background-color: white;
			}
			textarea{
	    		width: 300px;
				height: 300px;
    			resize: none;
			}
			input[type="text"]{
				width: 300px;
			}
		</style>
	</head>
	<body>		
	 <input id="path" type="text" name="path" value="${param.path}"/>
 	<button id="go">폴더로 이동</button>
	<button id="mkdir">폴더만들기</button>
	 <p id="pathLink"></p>

	<button id="mkFile">파일생성</button>
	<button id="upload">업로드</button>
	<table>
	 	<tr>
	 		<th>owner</th><th>group</th><th>size</th><th>type</th><th>name</th><th>option</th>
	 	</tr>
		<c:forEach var="info" items="${fileInfo.FileStatuses.FileStatus}">		
	 	<tr>
	 		<td>${info.owner}</td>
	 		<td>${info.group}</td>
	 		<td>${info.length} Byte</td>
	 		<td>${info.type}</td>	 		
	 		<td>
	 			<c:if test="${info.type eq 'DIRECTORY'}">
	 			<a href="list?path=${fileInfo.currPath}/${info.pathSuffix}">${fileInfo.currPath}/${info.pathSuffix}</a>
	 			</c:if>
	 			<c:if test="${info.type eq 'FILE'}">
	 			${info.pathSuffix}	 			
	 			</c:if>	 				 		
	 		</td>
	 		<td>
 			<c:if test="${info.type eq 'FILE'}">
 				<c:if test="${info.length gt 0}">
 		 			<a href="read?path=${fileInfo.currPath}/${info.pathSuffix}">[read]</a>&nbsp;
		 			<a href="download?path=${fileInfo.currPath}/${info.pathSuffix}">[download]</a>&nbsp;	 
		 			<a href="mapReduce?path=${fileInfo.currPath}/${info.pathSuffix}">[map-reduce]</a>&nbsp;	
 				</c:if>			 			
	 		</c:if>
			<a href="delDir?path=${fileInfo.currPath}/${info.pathSuffix}">[delete]</a>
	 		</td>
	 	</tr> 
	 </c:forEach> 
	 </table>
	</body>

	<c:if test="${fn:length(content) gt 0}">
		<div id="layer">${content}</div>
		<div id="bg"></div>	
	</c:if>	
	
	<div id="popup"></div>
	
	<script>		
		var msg = "${msg}"
		var path = "${param.path}";	
		
		if(path != ""){			
			var depth = [""];
			if(path != "/"){
				depth = path.split("/");
			}
			console.log(depth);
			
			var loc="";
			depth.forEach(function(item,idx){
				if(item != ""){
					loc +="/"+item
					$("#pathLink").append("<a href='list?path="+loc+"'>"+item+"</a>");
					console.log(item+" : "+loc);
				}else{
					$("#pathLink").append("<a href='list?path=/'>home</a>");
				}
				console.log(idx,(depth.length-1));
				if(idx < (depth.length-1)){
					$("#pathLink").append(" > ");
				}

			});
			
		}else{
			$("#pathLink").append("<a href='list?path=/'>home</a>");
		}
		
		if(msg.length >= 2){			
			alert(msg);
			prev();
		}		
		
		$("#go").click(function(){//페이지 이동
			location.href="list?path="+$("#path").val();
		});
		
		$("#mkdir").click(function(){//폴더 생성
			location.href="mkdir?path="+$("#path").val();
		});
		
		$("#bg").click(function(){//레이어 닫기
			$("#layer, #bg").hide();
			prev();
		});
		
		//파일 생성 팝업
		$("#mkFile").click(function(){
			$("#popup").empty();
			$("#popup").load("./resources/html/popup.html #inputBox",function(){
				$("#filePath").val("${param.path}");				
			});			
		});
		
		//업로드 파일 생성
		$("#upload").click(function(){
			$("#popup").empty();
			$("#popup").load("./resources/html/popup.html #uploadBox");			
		});
		
		function fileUpload(){
			$("#dstPath").val("${param.path}");		
			$("#uploadForm").submit();
		};
		

		function prev(){
			var movePath = path.substring(0,path.lastIndexOf("/"));		
			console.log("movePath : "+movePath);
			location.href="list?path="+movePath;
		}
		
		
	</script>
</html>
