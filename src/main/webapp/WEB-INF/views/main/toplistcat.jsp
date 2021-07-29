<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>게시물 추천 리스트</title>
        <link rel="stylesheet" href="/resources/css/main_view.css" type="text/css">
        <link rel="stylesheet" href="/resources/css/top_list.css">
    </head>
    <%@ include file="../includes/header2.jsp"%>
    
    <body>
        <header>
            <div class="text-area">
                <h1>${place} BEST 10</h1>
                <p>오늘 ${place} 뭐 먹지?</p><hr>             
            </div>
        </header>
            
       <c:forEach var="restaurant" items="${list}">
       
        <ul class="list" onclick ="location.href='../restaurant?cid=${restaurant.cid }'">
            <li class="itemlist">     
        <div class="box">
          <img src="<c:out value="${restaurant.mainphotourl}"/>"/>
            <div class="name">
            <h1><c:out value="${restaurant.placename}"/> <c:out value="${restaurant.rating}"/> </h1>
             <c:out value="${restaurant.catename} | "/><c:out value="${restaurant.phonenum}"/> <br>
             <c:out value="${restaurant.address}"/>
			 </div>                        
        </div>
            </li>
        </ul>
       
        </c:forEach>
        <script type="text/javascript">
function go(){
	var f = document.logoutform;


	f.submit();
}
</script>
    </body>
</html>
