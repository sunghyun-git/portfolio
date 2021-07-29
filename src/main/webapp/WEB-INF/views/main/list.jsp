<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- swiper 관련 내용 -->
<!-- 링크 : https://m.blog.naver.com/anedthh/222014406404 -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>잇!슐랭</title>
<link rel="stylesheet" href="/resources/css/main_view.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/swiper.css" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com"
	type="text/css">
<link rel="preconnect" href="https://fonts.gstatic.com" type="text/css"
	crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">
<script src="/resources/js/jquery-3.6.0.min.js"></script>

<style>

  .list {
    margin-top: 50px;
    text-align: center;
    background-color: #8295a0;
  }
  .list img{
    border-radius: 50%;
    width: 300px;
    height: 300px;
    border-radius: 50%;
    box-shadow: 0 6px 12px 0 rgba(0, 0, 0, 0.1),
      0 12px 24px 0 rgba(0, 0, 0, 0.24);
    margin-bottom: 2%;
  }
  .name h1{
      margin-bottom: 1%;
  }
  </style>
</head>
<!-- 메인화면 -->
<body>
	<!--상단 바 -->
	<nav class="mainbar">
		<div class="mainbar_title">
			<a href="/main/list"> <img src="/resources/img/eatchelin.png"></a>
		</div>

		<!-- 검색창 -->
		<div class="search">
			<form id='searchForm' action="/main/search" method='get'>
				<input class="search_txt" type="text"
					placeholder="식당 또는 지역,음식을 검색하세요." name='keyword'>
				<button class="search_btn">
					<i class="fas fa-search"></i>
				</button>
			</form>
		</div>

		<ul class="mainbar_join">
			<sec:authorize access="isAnonymous()">
				<!-- 로그인 안했을 때 -->
				<li><a href="/member/login">로그인</a></li>
				<li><a href="/member/join">회원가입</a></li>
			</sec:authorize>

			<sec:authorize access="isAuthenticated()">
				<!-- 로그인 했을 때 -->

				<li><form method="post" name="logoutform"
						action="/member/logout">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" /> <a href="javascript:go();">로그아웃</a>
					</form></li>
				<li><a href="/member/mypage">마이 페이지</a></li>
			</sec:authorize>
		</ul>

	</nav>


	<!-- 추천게시물 (하단에 swiper 기능 추가함)-->
	<section class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<article class="img_set">
					<div class="img_1">
						<a href="/main/toplist?address=노원">
							<div class="img1">
								<h1>무릉 노원</h1>
								<h2>노원 맛집</h2>
							</div>
						</a> <a href="/main/toplist?address=강남">
							<div class="img2">
								<h1>많이 찾는</h1>
								<h2>강남 맛집</h2>
							</div>
						</a> <a href="/main/toplist?address=이태원">
							<div class="img3">
								<h1>분위기 깡패</h1>
								<h2>이태원 맛집</h2>
							</div>
						</a>
					</div>
					<div class="img_2">
						<a href="/main/toplist?address=종로">
							<div class="img4">
								<h1>서울의 중심</h1>
								<h2>종로 맛집</h2>
							</div>
						</a> <a href="/main/toplist?address=마포">
							<div class="img5">
								<h1>20대가 좋아하는</h1>
								<h2>마포 맛집</h2>
							</div>
						</a> <a href="/main/toplist?address=강서">
							<div class="img6">
								<h1>있을 것 다 있는</h1>
								<h2>강서 맛집</h2>
							</div>
						</a>
					</div>
				</article>
			</div>
			<article class="swiper-slide">
				<div class="img_set">
					<div class="img_1">
						<a href="/main/toplistcat?address=퓨전요리">
							<div class="img7">
								<h1>글로벌 시대에 어울리는</h1>
								<h2>퓨전요리 BEST 10</h2>
							</div>
						</a> <a href="/main/toplistcat?address=한식">
							<div class="img8">
								<h1>한국인의 맛</h1>
								<h2>한식 BEST 10</h2>
							</div>
						</a> <a href="/main/toplistcat?address=양식">
							<div class="img9">
								<h1>분위기를 내고 싶을 때</h1>
								<h2>양식 BEST 10</h2>
							</div>
						</a>
					</div>
					<div class="img_2">
						<a href="/main/toplistcat?address=분식">
							<div class="img10">
								<h1>학교 앞 떡볶이가 그리울 때</h1>
								<h2>분식집 BEST 10</h2>
							</div>
						</a> <a href="/main/toplistcat?address=고기">
							<div class="img11">
								<h1>위장에 기름칠 하고 싶을 때</h1>
								<h2>고깃집 BEST10</h2>
							</div>
						</a> <a href="/main/toplistcat?address=중화요리">
							<div class="img12">
								<h1>대륙의 맛</h1>
								<h2>중화요리 BEST 10</h2>
							</div>
						</a>
					</div>
				</div>
			</article>
		</div>
		<!-- paging 처리 -->
		<div class="swiper-pagination"></div>
		<!-- paging btn -->
		<div class="swiper-button-prev"></div>
		<div class="swiper-button-next"></div>
	</section>

	<hr style="margin-top: 80px">

	<!--  평점 순 음식 추천  -->
	<div class="food_recommend">
		평점순 <br>
		<c:forEach var="restaurant" items="${list}">
		<div class="list">
			<a  href="../restaurant?cid=${restaurant.cid }"> <img 
				src="<c:out value="${restaurant.mainphotourl}"/>" height="160px"
				width="360px" />
				<div class="name">
					<h1>
						<c:out value="${restaurant.placename}" />
						<c:out value="${restaurant.rating}" />
					</h1>
					<c:out value="${restaurant.address}" />
					-
					<c:out value="${restaurant.catename}" />
					<br>
					<br>
				</div>
			</a>
			</div>
		</c:forEach>
	</div>
	<hr style="margin-top: 80px">

	<!-- 조회 수 높은 순으로 음식 추천 -->
	조회수 높은 순
	<div class="food_recommend">
		<c:forEach var="restaurant" items="${list1}">
		<div class="list">
			<a  href="../restaurant?cid=${restaurant.cid }"> <img 
				src="<c:out value="${restaurant.mainphotourl}"/>" height="160px"
				width="360px" />
				<div class="name">
					<h1>
						<c:out value="${restaurant.placename}" />
						<c:out value="${restaurant.rating}" />
					</h1>
					<c:out value="${restaurant.address}" />
					-
					<c:out value="${restaurant.catename}" />
				</div>
			</a>
			</div>
		</c:forEach>
	</div>

	<hr style="margin-top: 80px">

	<!-- 댓글 많은 순으로 게시글 추천 -->
	댓글 많은 순
	<div class="food_recommend">
		<c:forEach var="restaurant" items="${list2}">
		<div class="list">
			<a  href="../restaurant?cid=${restaurant.cid }"> <img
				src="<c:out value="${restaurant.mainphotourl}"/>" height="160px"
				width="360px" />
				<div class="name">
					<h1>
						<c:out value="${restaurant.placename}" />
						<c:out value="${restaurant.rating}" />
					</h1>
					<c:out value="${restaurant.address}" />
					-
					<c:out value="${restaurant.catename}" />

				</div>
			</a>
			</div>
		</c:forEach>
	</div>

	<script>
         
function go(){
	var f = document.logoutform;


	f.submit();
}

</script>

	<script src="https://kit.fontawesome.com/43a55c298a.js"
		crossorigin="anonymous"></script>

	<script src="/resources/js/swiper.min.js"></script>
	<script type="text/javascript" src="/resources/js/main_view.js"></script>
	<script>

var searchForm = $("#searchForm");
$(document).ready(function(){
	$("#searchForm button").on("click", function(e) { 	
	if (!searchForm.find("input[name='keyword']").val()) {
	alert("키워드를 입력하세요");
	return false;
	}
	searchForm.find("input[name='pageNum']").val("1");
	e.preventDefault();
	searchForm.submit();
});


$(".paginate_button a").on("click",
function(e) {
e.preventDefault();
console.log('click');
actionForm.find("input[name='pageNum']").val($(this).attr("href"));
actionForm.submit();
});		

var actionForm = $("#actionForm");
$(".paginate_button a").on("click", function(e) {
e.preventDefault();
console.log('click');
actionForm.find("input[name='pageNum']").val($(this).attr("href"));
actionForm.submit();
});

});
</script>
</body>
</html>