<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${Restaurant.placename }</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" href="../resources/css/main_view.css" type="text/css">
<link rel="stylesheet" href="../resources/css/register3.css" type="text/css">
<script src="../resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@ include file="includes/header2.jsp"%>
<form method="get" action="/modify">
	<!-- 가게 정보  -->
	<input type="hidden" name="error" id="error" value="${error}">
	<input type="hidden" value="${Restaurant.cid }" name="cid" id="cid">
	<input type="hidden" value="${Restaurant.address} ${Restaurant.placename }" name="placeaddress" id="placeaddress">
	<c:if test="${Restaurant.mainphotourl !=null}">
	<img src="${Restaurant.mainphotourl}" width="700" height="580">
	</c:if>
	<c:if test="${Restaurant.mainphotourl ==null}">
	<img src="/resources/img/food1.jpg" width="700" height="580">
	</c:if>
	<br> ${Restaurant.placename } (${Restaurant.catename })
	(${Restaurant.views }) ${Restaurant.rating }
	<br> ${Restaurant.address}



	<c:if test="${Restaurant.parking eq 'Y' }">
		<h4>주차 가능</h4>

	</c:if>

	<c:if test="${Restaurant.phonenum != null }">
${Restaurant.phonenum}

</c:if>
	<div id="map" style="width:350px;height:350px;" ></div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ddfa64a774c1422fb95b40bd0dc99e12&libraries=services"></script>

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
	<!-- 가게 오픈 타임과 브레이크타임, 라스트오더 -->
	<c:if test="${open != null}">
		<c:forEach var="open" items="${open }">
			<table>
				<tr>
					<td>${open.periodName }
				</tr>
				<c:if test="${open.timeName != null}">
					<tr>
						<td>${open.timeName }</td>
					</tr>
				</c:if>
				<tr>
					<c:if test="${open.timeSE != null}">

						<td>${open.timeSE }&nbsp;</td>

					</c:if>
					<c:if test="${open.dayOfWeek != null}">

						<td>${open.dayOfWeek }</td>

					</c:if>
				</tr>
			</table>
		</c:forEach>
	</c:if>

	<!-- 가게 휴무일 -->


	<c:if test="${off != null }">
		<c:forEach var="off" items="${off}">
			<table>
				<tr>
					<c:if test="${off.holydayName != null }">
						<td>${off.holydayName }</td>
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
	<h3>메뉴</h3>
	<c:if test="${menu != null }">
		<table>
			<c:forEach var="menu" items="${menu }">
				<tr>
					<td>${menu.menu }:${menu.price }
				<tr>
			</c:forEach>

		</table>
	</c:if>
	<br>
	<hr>
	<br>
	<input type="button" onclick="location.href='/restaurantreview/register?cid=${Restaurant.cid}'" value="리뷰 작성">
	<br><br><br>
	
	<!-- 리뷰 -->
	<c:if test="${review !=null }">
		<c:forEach var="review" items="${review }">
		<input type="hidden" name="userid" value="${review.userid }">
		<sec:authorize access="isAuthenticated()">
	  	
	    
		
		</sec:authorize>
			<table>
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
				<td><input type="button" value="리뷰 수정" onclick="location.href='/restaurantreview/modify?rw=${review.rw_no}&cid=${Restaurant.cid}'">
				
				</tr>
				
			</table>
			<br>
			<br>
		</c:forEach>
	</c:if>
	 <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')"> 
	 
	<button type="submit">수정하기</button>
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
</body>
</html>