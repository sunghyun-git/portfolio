<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<nav class="mainbar">   
        <div class="mainbar_title">
        <a href="/main/list"> <img src="/resources/img/eatchelin.png"></a>
        </div>
        
   <!-- 검색 창 -->  
           
               
     <ul class="mainbar_join">
     <sec:authorize access="isAnonymous()">  <!-- 로그인 안했을 때 -->  
         <li><a href="/member/login">로그인</a></li>
         <li><a href="/member/join">회원가입</a></li>
     </sec:authorize>
     
     <sec:authorize access="isAuthenticated()"> <!-- 로그인 했을 때 -->
     
       	 <li><form method="post" name="logoutform" action="/member/logout">
       	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       	
       	 <a href="javascript:go();">로그아웃</a>
       	 </form></li>
       	 <li><a href="/member/mypage">마이 페이지</a></li>
     </sec:authorize>
         </ul> 
         
    </nav>

     <script type="text/javascript" src="/resources/js/main_view.js"></script>
     <script src="/resources/js/jquery-3.6.0.min.js"></script>
     <script src="https://kit.fontawesome.com/43a55c298a.js" crossorigin="anonymous"></script>