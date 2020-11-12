<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	input[type='text']{
		width:250px;
	}
	table{
		width:500px;
		margin: 5px;
	}
	
	table, th, td{
		border : 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	}
	
	
	
	
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<h3>${msg}</h3>
	<form action="insert">
		<input type='text' id='arr' name='params' value='' placeholder='값들 사이에 콤마(,) 를 넣어 주세요.'/>
		<button>전송</button>
	</form>
	
	<table id="table">
		<tr>
			<th>이름</th>
			<th>반</th>
			<th>과목</th>
			<th>점수</th>
		</tr>
	</table>
	<input type="text" id="name" placeholder="이름"/><br/>
	<input type="text" id="class" placeholder="반"/><br/>
	<input type="text" id="lecture" placeholder="과목"/><br/>
	<input type="text" id="score" placeholder="점수"/><br/><br/>
	<button onclick="add()">추가</button>
	<button onclick="save()">저장</button>	
</body>
<script>
var arry = [];
var obj = {};

function add(){
	obj["name"] = $("#name").val();
	obj["class"] = $("#class").val();
	obj["lecture"] = $("#lecture").val();
	obj["score"] = $("#score").val();
	
	var content = "<tr><td>"+obj["name"]+"</td><td>"+obj["class"]+"</td>"
		+"<td>"+obj["lecture"]+"</td><td>"+obj["score"]+"</td></tr>";
	$("#table").append(content);
	
	arry.push(obj);
	obj = {};
	console.log(arry);
}

function save(){
	//복잡한 JSON 전송
	var params = {"values":arry};
	console.log(params);
	$.ajax({
		type:'POST',		//파라메터가 복잡해 진다는 것은 길이가 길어 진다는 것을 의미 하므로...
		url:'dataFrame',
		data:JSON.stringify(params),//문자열로 변경해서 전달 해야 한다.
		async:false,//비동기 비활성화
		dataType:'JSON',
		contentType:'application/json; charset=UTF-8',//전송 content type이 json 이라는 것을 명시
		success:function(res){
			console.log(res);
		},error:function(e){
			console.log(e);
		}
	});
}




</script>
</html>



