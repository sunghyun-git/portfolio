<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/css/login.css">
</head>
<body>
<section class="login-form"><br><br><br><br>
<h1>비밀번호 찾기</h1> 
<form method="post" action="/member/findpw">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="int-area"> 
                <input id="userid" type="text" name="userid" placeholder="아이디" value="${result }"> 
                <label for="userid">아이디</label> 
            </div>
            <!--비밀번호-->
            <div class="int-area"> 
                    <input id="email" type="text" name="email" placeholder="이메일"> 
                    <label for="email">이메일</label> 
                </div>
                <!--아이디 비밀번호 찾기 캡션-->
                
                <!--로그인 회원가입 버튼-->
                    <input type="submit" value="비밀번호 찾기">  
                    <input type="button" value="로그인으로" onclick="location.href='/member/login'" > 
                </form>
</section>
</body>
</html>