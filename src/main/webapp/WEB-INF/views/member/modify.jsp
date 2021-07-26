<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="/resources/css/modify.css">
<script src="/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<header>
		<div class="text-area">
			<h1>나의 정보 수정</h1>
		</div>
	</header>
	<form method="post" action="/member/modify">
		<section class="modify-form">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<!--비밀번호-->
			<div class="int-pass">
				*비밀번호<br> <input id="pwd" type="password" name="pwd" label
					for="pw"> </label>
			</div>
			<div class="int-pass">
				* 비밀번호 재확인<br> <input type="password" id="pwd2" name="pwd2">
			</div>
			<!--닉네임 수정-->
			<div class="int-username">
				* 닉네임<br> <input type="text" name="nickname" id ="nickname"
					value="${member.nickname }">
			</div>
			<br>
			<!--생년월일 select를 사용해서 구현-->
			<div class="fieldlabel">
				<div class="formfield">
					* 생년월일<br>
					<br> <input id="year" name="year" list="yearlist"
						value="${year }">
					<datalist id="yearlist">
						<option value="1990">
						<option value="1991">
						<option value="1992">
						<option value="1993">
						<option value="1994">
						<option value="1995">
						<option value="1996">
						<option value="1997">
						<option value="1998">
						<option value="1999">
						<option value="2000">
					</datalist>
					<input id="month" name="month" list="monthlist" value="${month }">
					<datalist id="monthlist">

						<option value="01">
						<option value="02">
						<option value="03">
						<option value="04">
						<option value="05">
						<option value="06">
						<option value="07">
						<option value="08">
						<option value="09">
						<option value="10">
						<option value="11">
						<option value="12">
					</datalist>

					<label for="day"></label> <input id="day" name="day" list="daylist"
						value="${day}">
					<datalist id="daylist">
						<option value="01">
						<option value="02">
						<option value="03">
						<option value="04">
						<option value="05">
						<option value="06">
						<option value="07">
						<option value="08">
						<option value="09">
						<option value="10">
						<option value="11">
						<option value="12">
						<option value="13">
						<option value="14">
						<option value="15">
						<option value="16">
						<option value="17">
						<option value="18">
						<option value="19">
						<option value="20">
						<option value="21">
						<option value="22">
						<option value="23">
						<option value="24">
						<option value="25">
						<option value="26">
						<option value="27">
						<option value="28">
						<option value="29">
						<option value="30">
						<option value="31">
					</datalist>
				</div>
			</div>
			<br>
			<br>
			<!--이메일-->
			* 이메일
			<div class="fieldlabel">
				<label for="email01"></label>
				<div class="formfield">
					<input type="text" id="email1" name="email1" size="20"
						maxlength="20" value="${email1 }" autocomplete="off"><span>@</span>
					<input id="email2" name="email2" list="domains" value="${email2 }">
					<datalist id="domains">
						<option value="naver.com">
						<option value="daum.net">
						<option value="gmail.com">
						<option value="yahoo.co.kr">
					</datalist>
					<br>

				</div>
				<%--      <select id="domains" >
            	<option value="${email2 }">${email2 }</option>
               <option value="naver.com">naver.com</option>
               <option value="daum.net">daum.net</option>
               <option value="gmail.com">gmail.net</option>
               <option value="yahoo.co.kr">yahoo.co.kr</option>
           </select> --%>

			</div>
			<input name="agree" type="checkbox"> 이벤트, 혜택정보 수신동의(선택) <br>
		</section>
		<!--로그인 회원가입 버튼-->
		<button type="submit">정보수정</button>
		<input type="button" value="취소 " onClick="history.go(-1)">
	</form>
	<script>
	var pwJ = /^[A-Za-z0-9]{4,12}$/;
            
            $(document).ready(function(e){
            $("button[type='submit']").on("click", function(e){  
            	if($('#pwd').val()==''){
            		alert('비밀번호를 입력하세요');
            		return false;
            	}	
            	if($('#pwd').val() != ($('#pwd2').val())){
            		alert('비밀번호가 다릅니다.');
            		return false;
            	}
            	if($('#nickname').val()==''){
            		alert('닉네임을 입력하세요');
            		return false;
            	}
            	if(($('#year').val()=='')&&($('#month').val()=='')&&($('#day').val()=='')){
            		alert('생년월일을 입력하세요');
            		return false;
            	}
            	if(($('#email1').val()=='')&&($('#email2').val()=='')){
            		alert('이메일을 입력하세요');
            		return false;
            	}
            	return true;
            });
            });
            
            </script>
</body>
</html>
