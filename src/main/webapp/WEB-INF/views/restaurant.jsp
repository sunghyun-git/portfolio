<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="includes/header2.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/main_view.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/restaurant.css"
	type="text/css">
<script src="../resources/js/jquery-3.6.0.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<title>${Restaurant.placename}</title>
</head>
<body>
	<form method="get" action="/modify">
		<!-- 가게 정보  -->
		<header>
			<input type="hidden" name="error" id="error" value="${error}">
			<input type="hidden" value="${Restaurant.cid }" name="cid" id="cid">
			<input type="hidden"
				value="${Restaurant.address} ${Restaurant.placename }"
				name="placeaddress" id="placeaddress">
			<c:if test="${Restaurant.mainphotourl !=null}">
				<img src="${Restaurant.mainphotourl}"
					style="margin-top: 50px; float: left; margin-left: 100px; width: 300px; box-shadow: 0 6px 12px 0 rgba(0, 0, 0, 0.1), 0 12px 24px 0 rgba(0, 0, 0, 0.24);"
					width="300" height="380">
			</c:if>
			<c:if test="${Restaurant.mainphotourl ==null}">
				<img src="/resources/img/food1.jpg"
					style="margin-top: 50px; float: left; margin-left: 100px; width: 300px; box-shadow: 0 6px 12px 0 rgba(0, 0, 0, 0.1), 0 12px 24px 0 rgba(0, 0, 0, 0.24);"
					width="500" height="580">
			</c:if>
			<!-- 지도 -->
			<div id="map"
				style="width: 350px; height: 350px; float: right; border-radius: 50%; box-shadow: 0 6px 12px 0 rgba(0, 0, 0, 0.1), 0 12px 24px 0 rgba(0, 0, 0, 0.24); float: right; margin-top: 50px; margin-right: 50px; color: black;"></div>
			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ddfa64a774c1422fb95b40bd0dc99e12&libraries=services">
	</script>
		</header>
		<div class="imf">
			<h2>${Restaurant.placename }(${Restaurant.catename })
				(${Restaurant.views }) ${Restaurant.rating }</h2>
				<br>
<c:if test="${collect == null }">
(${Restaurant.likecount })&nbsp;<a href="../member/likeinsert?cid=${Restaurant.cid }" style="color:black; font-size:30px;" >☆</a>
</c:if>
<c:if test="${collect eq 'Y' }">
(${Restaurant.likecount })&nbsp; <a href="../member/likedelete?cid=${Restaurant.cid }" style="color:black; font-size:30px;">★</a>
</c:if>
<br>
			<br> ${Restaurant.address} <br>
			<c:if test="${Restaurant.parking eq 'Y' }">
				<h5>주차 가능</h5>
			</c:if>

			<c:if test="${Restaurant.phonenum != null }">
${Restaurant.phonenum}<br></c:if>
		</div>
		<br>
		<!-- 가게 오픈 타임과 브레이크타임, 라스트오더 -->
		<c:if test="${open != null}">
			<c:forEach var="open" items="${open }">
				<table class="box1">
					
					<c:if test="${open.timeName != null}">
						<tr>
							<td>${open.timeName }</td>
						</tr>
					</c:if>
					<tr>
						<c:if test="${open.timeSE != null}">

							<td>${open.timeSE }&nbsp;/</td>

						</c:if>
						<c:if test="${open.dayOfWeek != null}">

							<td>${open.dayOfWeek }</td>

						</c:if>
					</tr>
				</table>
				<br>
			</c:forEach>
		</c:if>
		<br>
		<!-- 가게 휴무일 -->
		<c:if test="${off != null }">
			<c:forEach var="off" items="${off}">
				<table class="box2">
					<tr>
						<c:if test="${off.holydayName != null }">
							<td>쉬는날 : </td>
							<td>${off.holydayName }</td>
							<br>
						</c:if>
						<c:if test="${off.offdate != null }">
							
							<td>${off.offdate }</td>
						</c:if>
					</tr>
				</table>
			</c:forEach>
		</c:if>
		<br>
		<br>
		<br>
		<br>
		<hr>
		<br><br><br>
		
		<h3>메뉴</h3>
		<c:if test="${menu != null }">
		<br>
			<table class="box3">
				<c:forEach var="menu" items="${menu }">
					<tr>
						<td>${menu.menu }:${menu.price }
					<tr>
				</c:forEach>

			</table>
		</c:if>

		<br>
		<br>
		<hr>
		<br>
		<h3>리뷰</h3>
		<div class="btn">
			<input type="button"
				onclick="location.href='/restaurantreview/register?cid=${Restaurant.cid}'"
				value="리뷰 작성"> <br> <br> <br>
		</div>

		<!-- 리뷰 -->
		<c:if test="${review !=null }">
			<c:forEach var="review" items="${review }">
				<input type="hidden" name="userid" value="${review.userid }">
				<sec:authorize access="isAuthenticated()">
				</sec:authorize>
				<table class="box4">
					<tr>
						<td>${review.rw_writer }<br> <c:choose>
								<c:when test="${review.rw_rating eq 5 }">
									<td>★★★★★
								</c:when>
								<c:when test="${review.rw_rating eq 4 }">
									<td>★★★★☆
								</c:when>
								<c:when test="${review.rw_rating eq 3 }">
									<td>★★★☆☆
								</c:when>
								<c:when test="${review.rw_rating eq 2 }">
									<td>★★☆☆☆
								</c:when>
								<c:when test="${review.rw_rating eq 1 }">
									<td>★☆☆☆☆
								</c:when>
								<c:when test="${review.rw_rating eq 0 }">
									<td>☆☆☆☆☆
								</c:when>
							</c:choose>
					</tr>
				</table>

				<tr>
					<td>${review.rw_content }<br> <c:if
							test="${review.rw_photo !=null }">
							<td><img src="${review.rw_photo }" width="200"><br>
						</c:if>
				</tr>

				<tr>
					<c:forEach var="reviewa" items="${reviewa }">
						<td>${reviewa }
					</c:forEach>
					<td><input type="button" value="리뷰 수정"
						onclick="location.href='/restaurantreview/modify?rw=${review.rw_no}&cid=${Restaurant.cid}'">
				</tr>


				<br>
				<br>
				<hr width="500px">
			</c:forEach>
		</c:if>
		<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">

			<button type="submit">음식점 수정하기</button>
		</sec:authorize>
	</form>
	<script type="text/javascript">
	function go(){
		var f = document.logoutform;


		f.submit();
	}
	 var replyer = null;
	    <sec:authorize access="isAuthenticated()">
	  	replyer = '<sec:authentication property="principal.username"/>';
	    </sec:authorize>
	    
	    var error = $('#error').val();
	    if(error == 'no'){
	    	alert('작성자만 수정 가능합니다.');
	    }
	    
	    $(document).ready(function(e){
	    document.onkeydown = fkey;
	    document.onkeypress = fkey;
	    document.onkeyup = fkey;
	     
	    var wasPressed = false;
	     
	    var cid = $('#cid').val();
	    function fkey(e){
	        e = e || window.event;
	        if(wasPressed) return;
	     
	        if(e.keyCode == 116){
	            location.href = "/restaurant?cid="+cid;
	        }
	    }
	    });
	</script>
	<script>
var placeaddress = document.getElementById('placeaddress').value;
console.log(placeaddress);
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.5642135, 127.0016985), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch(placeaddress, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		console.log(coords);
        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${Restaurant.placename}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        
        map.setCenter(coords);
    } 
});    
</script>
</body>
</html>