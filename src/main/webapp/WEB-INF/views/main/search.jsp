<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${place} 맛집  검색 결과</title>
 <script src="/resources/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="/resources/css/main_view.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/swiper.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com" type="text/css">
	<link rel="preconnect" href="https://fonts.gstatic.com" type="text/css" crossorigin>
	 <link rel="stylesheet" href="/resources/css/top_list.css">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet"> 
</head>
<body>
  <nav class="mainbar">   
        <div class="mainbar_title">
        <a href="/main/list"> <img src="/resources/img/eatchelin.png"></a>
        </div>
        
   <!-- 검색 창 
        <div class="search">
       	<form class='searchForm' action="/main/search" method='get'> 
            <input type="text" name='keyword'> 
            <button><i class="fas fa-search"></i></button>
            </form>	
        </div>    -->    
        
        
        
               
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
    	   <div class="search">
                <form id='searchForm' action="/main/search" method='get'> 
                    <input class="search_txt" type="text" placeholder="식당 또는 지역,음식을 검색하세요." name='keyword' value="${place }"> 
                    <button class="search_btn"><i class="fas fa-search"></i></button>
                </form>   
            </div>     
              <div class="text-area">
                <h1>${place} 검색결과</h1>
            </div>
            <c:if test="${count == 0 }">
            <h1>검색 내용 없음</h1>
            </c:if>
            <c:if test="${count != 0 }">
            
            <center><div id="map" align="right" style="width:600px;height:500px; position:relative; overflow:hidden;  align-content:center;"></div></center>
            </c:if>
             <c:forEach var="restaurant" items="${list}">
        <ul class="list" onclick="location.href='../restaurant?cid=${restaurant.cid }'">
            <li class="itemlist">     
        <div class="box">
     
    

    <!--  이미지가 있으면 불러오고 없으면 설정된 이미지를 불러온다 -->
       <c:choose>
    	 <c:when test="${restaurant.mainphotourl != null}">
          <img src="<c:out value="${restaurant.mainphotourl}"/>"/>
    	</c:when>
    	<c:otherwise>
    		<img src="/resources/img/eatchelin.png">
    	</c:otherwise>
       </c:choose> 
      
            <div class="name">
            <input type="hidden" name="placeadd" value="${restaurant.address }">
            <input type="hidden" name="placecid" value="${restaurant.cid }">
            <input type="hidden" name="placena" value="${restaurant.placename}">
            <input type="hidden" name="photo" value="${restaurant.mainphotourl}">
            <input type="hidden" name="views" value="${restaurant.views}">
            <input type="hidden" name="rating" value="${restaurant.rating }">
            <input type="hidden" name="catename" value="${restaurant.catename }">
            <h1><c:out value="${restaurant.placename}"/> <c:out value="${restaurant.rating}"/> </h1>
             <c:out value="${restaurant.catename} | "/><c:out value="${restaurant.phonenum}"/> <br>
             <c:out value="${restaurant.address}"/><br>
             <h6><c:out value="${restaurant.reviewcount}"/>/<c:out value="${restaurant.views}"/></h6>
			 </div>                        
        </div>
            </li>
        </ul>
        </c:forEach>
          
        <!-- 페이징 삭제 할듯 -->
	<div class='pull-right'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous"><a
								href="${pageMaker.startPage -1}">Previous</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} ">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a
								href="${pageMaker.endPage +1}">Next</a></li>
						</c:if>
					</ul>
				</div>
				<!--  end Pagination -->
				<form id='actionForm' action="/main/search" method='get'>
					<input type='hidden' name='pageNum'
						value='${pageMaker.cri.pageNum}'> 
					<input type='hidden'name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
				</form>


</body>
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
     <script>

function go(){
	var f = document.logoutform;


	f.submit();
}

</script>
 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ddfa64a774c1422fb95b40bd0dc99e12&libraries=services,clusterer,drawing"></script>
 
 <script>
 
	 
	 var grpl = $("input[name=placeadd]").length;
		//배열 생성
		var placeaddress = new Array(grpl);
		//배열에 값 주입
		for(var i=0; i<grpl; i++){                          
			placeaddress[i] = $("input[name=placeadd]").eq(i).val();
	        console.log(placeaddress[i]);
	    }
		
		 var grpl1 = $("input[name=placena]").length;
			//배열 생성
		var placena = new Array(grpl1);
			//배열에 값 주입
			for(var i=0; i<grpl; i++){                          
				placena[i] = $("input[name=placena]").eq(i).val();
		        console.log(placena[i]);
		    }
		var grpl2 = $("input[name=placecid]").length;	
		var placecid = new Array(grpl2);
		for(var i=0; i<grpl2;i++){
			placecid[i] = $("input[name=placecid]").eq(i).val();
			console.log(placecid[i]);
		}
		
		var grpl3 = $("input[name=photo]").length;
 		var photo = new Array(grpl3);
 		for(var i=0; i<grpl3 ; i++){
 			photo[i] = $("input[name=photo]").eq(i).val();
 			
 		}
 		
 		var grpl4 = $("input[name=rating]").length;
 		var rating = new Array(grpl4);
 		for(var i=0; i<grpl4 ; i++){
 			rating[i] = $("input[name=rating]").eq(i).val();
 		}
 		var grpl5 = $("input[name=catename]").length;
 		var catename = new Array(grpl5);
 		for(var i=0; i<grpl5; i++){
 			catename[i] = $("input[name=catename]").eq(i).val();
 			console.log(catename[i]);
 		}
 		
 		
 
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var infowindow = new kakao.maps.InfoWindow({zIndex:1});
//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();


//주소로 좌표를 검색합니다	 
placeaddress.forEach(function(addr,index){
	

geocoder.addressSearch(addr, function(result, status) {
	
    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {
    	 
     var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
     var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        
        
        	 // 마커 이미지의 이미지 크기 입니다	
        	 var imageSize = new kakao.maps.Size(24, 35); 

        	 // 마커 이미지를 생성합니다    
        	 var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
        	 
        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords,
            
        });
        
        kakao.maps.event.addListener(marker, 'click', function() {
            // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
            if(photo[index] == ""){
                infowindow.setContent('<a href="../restaurant?cid='+placecid[index]+'"><div style="width:auto;height:auto;padding:5px;font-size:15px; color:black;">' +placena[index] +' '+rating[index] + '<br>'+catename[index]+'</div><br> <img src="/resources/img/eatchelin.png" height="150" width="150"> <a>');
            }
            else{
                infowindow.setContent('<a href="../restaurant?cid='+placecid[index]+'"><div style="width:auto;height:auto;padding:5px;font-size:15px; color:black;">' +placena[index] +' '+rating[index] +'<br>'+catename[index]+'</div> <br><img src="'+photo[index]+'" height="150" width="150"> <a>');

            }
            infowindow.open(map, marker);
            map.setCenter(coords);
        });
        
      
        
        
       

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    	
     }
  });
});
geocoder.addressSearch(placeaddress[0], function(result, status) {
	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	map.setCenter(coords);
});



</script>
</body>

</html>