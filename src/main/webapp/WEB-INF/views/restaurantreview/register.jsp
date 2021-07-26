<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 추가하기</title>
<link rel="stylesheet" href="../resources/css/main_view.css" type="text/css">
<link rel="stylesheet" href="../resources/css/register2.css" type="text/css">
<script src="../resources/js/jquery-3.6.0.min.js"></script>
<style>

.uploadResult {
	width: 100%;
	background-color: gray;
}
.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li {
	list-style: none;
	padding: 10px;
}
.uploadResult ul li img {
	width: 20px;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.rating .rate_radio {
    position: relative;
    display: inline-block;
    z-index: 20;
    opacity: 0.001;
    width: 60px;
    height: 60px;
    background-color: #fff;
    cursor: pointer;
    vertical-align: top;
    display: none;
}
.rating .rate_radio + label {
    position: relative;
    display: inline-block;
    margin-left: -4px;
    z-index: 10;
    width: 60px;
    height: 60px;
    background-image: url('../resources/img/starrate.png');
    background-repeat: no-repeat;
    background-size: 60px 60px;
    cursor: pointer;
    background-color: #f0f0f0;
}
.rating .rate_radio:checked + label {
    background-color: #ff8;
}
</style>
</head>
<body>
<%@ include file="../includes/header2.jsp"%>
<form method="post" action="/restaurantreview/register" role="form">
<input type="hidden" name="${_csrf.parameterName}" id="token" data-token-name="${_csrf.headerName}"
				value="${_csrf.token}" />
<h1>리뷰 작성하기</h1>
<section class="modify-form">
<div class="int-pass">

<input type="hidden" name="cid" value="${restaurant.cid }">
<h5 style="color:black">음식점이름</h5>
<input type="text" name="restaurant" value="${restaurant.placename }" readonly="readonly"><br>
<h5 style="color:black">아이디</h5>
<input type="text" name="userid" value="${member.userid }" readonly="readonly"><br>
<h5 style="color:black">별명</h5>
<input type="text" name="rw_writer" value="${member.nickname }" readonly="readonly"><br>
<h5 style="color:black">리뷰 내용</h5>
<textarea name="rw_content" placeholder="리뷰 내용" style="width:300px;height:200px">${review.rw_content }</textarea><br>


</div>
</section>
<div class="review_rating">
            <h1>평점을 선택해 주세요</h1>
            <div class="rating">
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="rating1" id="rating1" value="1" class="rate_radio" title="1점">
                <label for="rating1"></label>
                <input type="checkbox" name="rating2" id="rating2" value="2" class="rate_radio" title="2점">
                <label for="rating2"></label>
                <input type="checkbox" name="rating3" id="rating3" value="3" class="rate_radio" title="3점" >
                <label for="rating3"></label>
                <input type="checkbox" name="rating4" id="rating4" value="4" class="rate_radio" title="4점">
                <label for="rating4"></label>
                <input type="checkbox" name="rating5" id="rating5" value="5" class="rate_radio" title="5점">
                <label for="rating5"></label>
               
            </div>
        </div>
<h1>리뷰 사진</h1>
<input type="file" accept="image/*" onchange='chk_file_type(this)' name='uploadFile' multiple>
<div class='uploadResult'>
		<ul><!-- 첨부 파일의 이름을 목록으로 출력 -->
		</ul>
	</div>
	<br>
	<button type="submit">음식점 리뷰 추가하기</button>
</form>
<script type="text/javascript">
// 이미지 사진만 업로드 
function chk_file_type(obj) {

	var file_kind = obj.value.lastIndexOf('.');

	var file_name = obj.value.substring(file_kind+1,obj.length);

	var file_type = file_name.toLowerCase();

	var check_file_type=new Array();

	check_file_type=['jpg','gif','png','jpeg','bmp','tif'];



	if(check_file_type.indexOf(file_type)==-1) {

		alert('이미지 사진만 업로드 해주세요.');

		var parent_Obj=obj.parentNode;

		var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);



		document.getElementById("wfb-field-219958876").value = "";    //초기화를 위한 추가 코드

		document.getElementById("wfb-field-219958876").select();        //초기화를 위한 추가 코드

		document.selection.clear();                                                //일부 브라우저 미지원

		return false;

	}

}
$(document).ready(function(e){
	  var formObj = $("form[role='form']");
	  $("button[type='submit']").on("click", function(e){    
	    e.preventDefault();
	    console.log("submit clicked");
	    var str = "";
	    $(".uploadResult ul li").each(function(i, obj){
	      var jobj = $(obj);
	      console.dir(jobj);
	      console.log("-------------------------");
	      console.log(jobj.data("filename"));
	      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
	    });
	    console.log(str);
	    formObj.append(str).submit();
	  });
	  
	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	  var maxSize = 5242880; //5MB
	  
	  function checkExtension(fileName, fileSize){
	    if(fileSize >= maxSize){
	      alert("파일 사이즈 초과");
	      return false;
	    }
	    
	    if(regex.test(fileName)){
	      alert("해당 종류의 파일은 업로드할 수 없습니다.");
	      return false;
	    }
	    return true;
	  }
	  
	  var cloneObj = $(".uploadDiv").clone(); 
	  $("input[type='file']").change(function(e){
	    var formData = new FormData();
	    var inputFile = $("input[name='uploadFile']");
	    var files = inputFile[0].files;
	    
	    for(var i = 0; i < files.length; i++){
	      if(!checkExtension(files[i].name, files[i].size) ){
	        return false;
	      }
	      formData.append("uploadFile", files[i]);
	    }
	    
	    $.ajax({
	      url: '/uploadAjaxAction',
	      processData: false, 
	      contentType: false,
	      data: formData,
	      type: 'POST',
	      dataType:'json',
	      beforeSend : function(xhr){
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
	      success: function(result){
	        console.log(result); 
			showUploadResult(result); //업로드 결과 처리 함수 
			$(".uploadDiv").html(cloneObj.html());
	      }
	    }); //$.ajax
	  });
	  
	  function showUploadResult(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0){ return; }
		var uploadUL = $(".uploadResult ul");
		var str ="";
			    
		$(uploadResultArr).each(function(i, obj){
			/*
			//image type
			if(obj.image){
			    var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
			    str += "<li><div>";
			    str += "<span> "+ obj.fileName+"</span>";
			    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			    str += "<img src='/display?fileName="+fileCallPath+"'>";
			    str += "</div>";
			    str +"</li>";
			}else{
			    var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);            
			    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			              
			    str += "<li><div>";
			    str += "<span> "+ obj.fileName+"</span>";
			    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			    str += "<img src='/resources/img/attach.png'></a>";
			    str += "</div>";
			    str +"</li>";
			}
			*/
			//image type
			if(obj.image){
				var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"'";
				str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
				str += " ><div>";
				str += "<span> "+ obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' "
				str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
			}
		});    
		uploadUL.append(str);
	  }
	  
	  $(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		$.ajax({
		  url: '/deleteFile',
		  data: {fileName: targetFile, type:type},
		  dataType:'text',
		  type: 'POST',
		  beforeSend : function(xhr){
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
		  success: function(result){
			alert(result);
		    targetLi.remove();
		  }
		}); //$.ajax
	  });
	});
function go(){
	var f = document.logoutform;


	f.submit();
}
//평점
function Rating(){};
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(newrate){
    //평점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
    let items = document.querySelectorAll('.rate_radio');
    items.forEach(function(item, idx){
        if(idx < newrate){
            item.checked = true;
        }else{
            item.checked = false;
        }
    });
}
let rating = new Rating();//평점 인스턴스 생성
document.addEventListener('DOMContentLoaded', function(){
    //평점선택 이벤트 리스너
    document.querySelector('.rating').addEventListener('click',function(e){
        let elem = e.target;
        if(elem.classList.contains('rate_radio')){
            rating.setRate(parseInt(elem.value));
        }
    })
});
</script>
</body>
</html>