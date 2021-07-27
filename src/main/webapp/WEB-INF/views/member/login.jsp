<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<link rel="stylesheet" href="/resources/css/main_view.css" type="text/css">
	<link rel="stylesheet" href="/resources/css/login.css">
	 
</head>


 <body> 

        <!--header-->
        <section class="login-form"><br><br><br><br>
            <h1>잇! 슐랭</h1> 
            <!--아이디-->
            <h3 style="color:red;">${error }</h3>
            <h3 style="color:red;">${logout }</h3>
        <form method="post" action="/login">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="int-area"> 
                <input id="username" type="text" name="username" placeholder="아이디" value="${result }"> 
                <label for="username">아이디</label> 
            </div>
            <!--비밀번호-->
            <div class="int-area"> 
                    <input id="password" type="password" name="password" placeholder="비밀번호"> 
                    <label for="password">비밀번호</label> 
                </div>
                <!--아이디 비밀번호 찾기 캡션-->
                <div class="caption">
                	<a href="/member/findid">아이디 찾기 </a> /
                    <a href="/member/findpw"> 비밀번호 찾기</a>
                    
                </div>
                <!--로그인 회원가입 버튼-->
                    <input type="submit" value="로그인">  
                    <input type="button" value="회원가입" onclick="location.href='/member/join'" > 
                </form>
            </section> 
            </body> 
            </html>

    