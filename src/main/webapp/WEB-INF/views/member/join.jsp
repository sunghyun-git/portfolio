<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="/resources/css/join.css">
<script src="/resources/js/jquery-3.6.0.min.js"></script>
<title>회원가입</title>
</head>
<body>
	<!--header-->
	<section class="join-form">
		<br>
		<h1>회원가입</h1>
		<h5>잇! 슐랭에 방문해주셔서 감사합니다</h5>
		<br>
		<form name="login" action="/member/join" method="post">
			<!--아이디 div class int-area로 잡아서 만듦-->
			<input type="hidden" name="${_csrf.parameterName}" id="token" data-token-name="${_csrf.headerName}"
				value="${_csrf.token}" />
			<div class="int-area">
				* 아이디<br> <input type="text" name="userid" id="userid">
			</div>
			<!--아이디 체크 버튼 -->
			<input type="button" name="user_IDcheck" value="아이디 중복 확인"
				id="idCheck" value="N" onclick="fn_idCheck();"> <br>
			<!--비밀번호-->
			<div class="int-area">
				* 비밀번호<br> <input type="password" name="pwd" id="pwd">
			</div>
			<!--비밀번호 재확인-->
			<div class="int-area">
				* 비밀번호 재확인<br> <input type="password" name="pwd2" id="pwd2">
			</div>
			<!--비밀번호 재확인 체크 버튼-->

			<br>
			<!-- 이름 -->
			<div class="int-area">
				* 이름<br> <input type="text" name="username" value=""
					id="username">
			</div>
			<!--닉네임-->
			<div class="int-area">
				* 닉네임<br> <input type="text" name="nickname" value=""
					id="nickname">
			</div>
			<!--생년월일 select를 사용해서 구현-->
			* 생년월일<br>
			<div class="fieldlabel">
				<br>
				<div class="formfield">
					<input id="year" name="year" list="yearlist" value="">
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
					<input id="month" name="month" list="monthlist" value="">
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
						value="">
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
              <br><br>
            <!--이메일-->
              * 이메일<div class="fieldlabel">
				<label for="email01"></label>
				<div class="formfield">
					<input type="text" id="email1" name="email1" size="20"
						maxlength="20" value="" autocomplete="off"><span>@</span>
					<input id="email2" name="email2" list="domains" value="">
					<datalist id="domains">
						<option value="naver.com">
						
						<option value="daum.net">
						
						<option value="gmail.com">
						
						<option value="yahoo.co.kr">
					
					</datalist>
                </div>
                </div>
            <!--이용약관동의-->
            <fieldset>
                <legend>모두 동의합니다</legend>
                <input type="checkbox" id="checkbox1" name="checkbox"
					value="1">이용약관 동의(필수)<br>
                <input type="checkbox" id="checkbox2" name="checkbox"
					value="2">개인정보 수집, 이용 동의(필수)<br>
               
                <input type="checkbox" id="checkbox4" name="agree"
					value="3">이벤트, 혜택정보 수신동의(선택)<br>
                <input type="checkbox" name="checkbox" value="5"
					onclick='selectAll(this)'>모두 동의(필수 약관)<br>
            </fieldset>
            <!--회원 가입 버튼-->
            <button type="submit">회원가입 </button>
            </form>
            </section>

          </body>
          
          <script type="text/javascript">
          function fn_idCheck(){
        	  var userid = $('#userid').val();
        	  var checkid = /^[a-zA-Z0-9]{4,12}$/;
        	  if(!checkid.test(userid)){
        		  alert("아이디는 영어 숫자 포함 4~12글자입니다.");
        		  document.getElementById('userid').focus();
        	  }
        	  if(checkid.test(userid)){
        		          	  
        	  $.ajax({
        		  	url : "/member/idCheck",
        			type : "post",
        			
        			data : { 
        				userid : $("#userid").val()
        				},
      				beforeSend : function(xhr){
      					var $token = $("#token");
      					xhr.setRequestHeader($token.data("token-name"), $token.val());
      				},
      				success : function(data){
      					var a =new XMLSerializer().serializeToString(data.documentElement);
      					
      					
      					if(a == '<Integer>1</Integer>'){
      						console.log("중복된 아이디");
      						alert("중복된 아이디입니다.");
      					}else if(a == '<Integer>0</Integer>'){	
      						console.log("사용가능한 아이디");
      						alert("사용가능한 아이디입니다.");
      					}
      				},
      				error:function(){
      					alert("Error 관리자에게 문의하세요");
      				} 
        	  });
        	  }
        	  
          }
          function selectAll(selectAll)  {
        	  const checkboxes 
        	       = document.getElementsByName('checkbox');
        	  
        	  checkboxes.forEach((checkbox) => {
        	    checkbox.checked = selectAll.checked;
        	  })
        	}
          
          $(document).ready(function(e){
        	  var checkid = /^[a-zA-Z0-9]{4,12}$/;
              $("button[type='submit']").on("click", function(e){
            	  if(!checkid.test($('#userid').val())){
            		  alert("아이디는 영어 숫자 포함 4~12글자입니다.");
            		  document.getElementById('userid').focus();
            		  return false;
            	  }
            	  if($('#userid').val()==''){
            		  alert('아이디를 입력하세요');
            		  document.getElementById('userid').focus();
            		  return false;
            	  }
            	 
              	if($('#pwd').val()==''){
              		alert('비밀번호를 입력하세요');
              		document.getElementById('pwd').focus();
              		return false;
              	}	
              	if($('#pwd').val() != ($('#pwd2').val())){
              		alert('비밀번호가 다릅니다.');
              		document.getElementById('pwd2').focus();
              		return false;
              	}
              	if($('#username').val()==''){
              		alert('이름을 입력하세요');
              		document.getElementById('username').focus();
              		return false;
              	}
              	if($('#nickname').val()==''){
              		alert('닉네임을 입력하세요');
              		document.getElementById('nickname').focus();
              		return false;
              	}
              	if($('#year').val()==''){
              		alert('생년월일을 입력하세요');
              		document.getElementById('year').focus();
              		return false;
              	}
              	if($('#month').val()==''){
              		alert('생년월일을 입력하세요');
              		document.getElementById('month').focus();
              		return false;
              	}
              	if($('#day').val()==''){
              		alert('생년월일을 입력하세요');
              		document.getElementById('day').focus();
              		return false;
              	}
              	if($('#email1').val()==''){
              		alert('이메일을 입력하세요');
              		document.getElementById('email1').focus();
              		return false;
              	}
              	if($('#email2').val()==''){
              		alert('이메일을 입력하세요');
              		document.getElementById('email2').focus();
              		return false;
              	}
              	if($('#checkbox1').is(":checked")==false ){
              		alert('이용약관에 동의해주세요');
              		return false;
              	}
              	if($('#checkbox2').is(":checked")==false){
              		alert('개인정보 수집,이용에 동의해주세요');
              		return false;
              	}
              	
              	return true;
              });
              });
          
</script>
</html>
