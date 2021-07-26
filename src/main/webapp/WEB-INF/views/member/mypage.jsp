<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
 <link rel="stylesheet" href="/resources/css/main_view.css" type="text/css">
<link rel="stylesheet" href="/resources/css/Mypage.css">
 <script src="/resources/js/jquery-3.6.0.min.js"></script>


</head>
<body>
<%@ include file="../includes/header2.jsp"%>
	<header>

		</div>
		<div class="thumb-wrapper">
			<img src="/resources/img/user-thumb.png">
			<div class="badge"></div>
		</div>
		<div class="text-area">
			<h1>안녕하세요 ${member.nickname }님</h1>
			<!--닉네임으로 들어가게 데이터 베이스-->
			<input type="hidden" value="">
			<div class="desc">
				Nice to Meet you<br />
			</div>
		</div>
		<div class="mail">${member.email }</div>
		<!--이메일 데이터 베이스-->
	</header>
	<br>
	
	<ul class="list">
		<li class="item mousect-effect">
			<div class="left">
				<img src="/resources/img/icon/bookmark.svg" />
				<div class="name">Bookmark</div>
			</div>
			<div class="right">
				<img src="/resources/img/icon/right_arrow.svg" />
			</div>
		</li>

		<li class="item mouse-effect" onclick="location.href='/member/modify'">

			<div class="left">

				<img src="/resources/img/icon/account.svg" />
				<div class="name">Account Info</div>

			</div>

			<div class="right">
				<img src="/resources/img/icon/right_arrow.svg" />
			</div>

		</li>
	<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')"> 
		<li class="item mouse-effect" onclick="location.href='../register'">
			<div class="left">
				<img src="/resources/img/icon/business.svg" />
				<div class="name">Restaurant register</div>
			</div>
			<div class="right">
				<img src="/resources/img/icon/right_arrow.svg" />
			</div>
		</li>
		</sec:authorize>
		
		
	
		
		

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