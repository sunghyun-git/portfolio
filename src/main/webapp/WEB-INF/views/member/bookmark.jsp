<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookmark</title>
 <link rel="stylesheet" href="/resources/css/main_view.css" type="text/css">
<link rel="stylesheet" href="/resources/css/Mypage.css">
 <script src="/resources/js/jquery-3.6.0.min.js"></script>


</head>
<body>
<%@ include file="../includes/header2.jsp"%>
	<header>

		
		<div class="text-area">
			<h1>북 마크</h1>
			<!--닉네임으로 들어가게 데이터 베이스-->
			<input type="hidden" value="">
			<div class="desc">
				${member.nickname }<br />
			</div>
		</div>
		<div class="mail">${member.email }</div>
		<!--이메일 데이터 베이스-->
	</header>
	<br>
	
	<ul class="list">
	<c:forEach var="restaurant" items="${RList}">
		<li class="item mousect-effect" >
			<div class="left" onclick="location.href='../restaurant?cid=${restaurant.cid }'">
				<img src="${restaurant.mainphotourl}" height="150" width="150" />
				<div class="name"><h3>${restaurant.placename } (${restaurant.rating })</h3>${restaurant.catename }</div>
			</div>
			<div class="right">
				<a href="../member/likedelete?cid=${restaurant.cid }">좋아요 취소<img src="/resources/img/icon/right_arrow.svg" /></a>
			</div>
		</li>
	</c:forEach>
		
		
		
	
		
		

	</ul>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	

<script type="text/javascript">
function go(){
	var f = document.logoutform;


	f.submit();
}
</script>
</body>
</html>