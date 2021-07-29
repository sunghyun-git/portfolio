<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식점 수정 </title>
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
</style>

<script src="/resources/js/jquery-3.6.0.min.js"></script>
 <link rel="stylesheet" href="/resources/css/main_view.css" type="text/css">
 <link rel="stylesheet" href="/resources/css/register2.css" type="text/css">
<script>
var arrInput = new Array(0);
  var arrInputValue = new Array(0);
 
function addInput() {
  arrInput.push(arrInput.length);
  arrInputValue.push("");
  display();
}
 
function display() {
  document.getElementById('parah').innerHTML="";
  for (intI=0;intI<arrInput.length;intI++) {
    document.getElementById('parah').innerHTML+=createInput(arrInput[intI], arrInputValue[intI]);
  }
}
 
function saveValue(intId,strValue) {
  arrInputValue[intId]=strValue;
}  
 
function createInput(id,value) {
	  return "<input type='text' name='menu' id='test "+ id +"' onChange='javascript:saveValue("+ id +",this.value)' placeholder='메뉴' style='background:transparent; border:none; border-bottom: solid 1px #ccc; padding: -10px 5px 10px; font-size:14pt; width: 200px; height: 1%; margin-top: 10px; margin-bottom: 10px;'>"
	  +"&nbsp;<input type='text' name='price' id='test "+ id +"' onChange='javascript:saveValue("+ id +",this.value)' placeholder='가격'style='background:transparent; border:none; border-bottom: solid 1px #ccc; padding: -10px 5px 10px; font-size:14pt; width: 200px; height: 1%; margin-top: 10px; margin-bottom: 10px;'> <br>";
	}
 
function deleteInput() {
  if (arrInput.length > 0) { 
     arrInput.pop(); 
     arrInputValue.pop();
  }
  display(); 
}
</script>

<script type="text/javascript">
// 오픈시간, 브레이크타임, 라스트오더 추가 
var arrInput1 = new Array(0);
var arrInputValue1 = new Array(0);

function addInput1() {
arrInput1.push(arrInput.length);
arrInputValue1.push("");
display1();
}

function display1() {
document.getElementById('parah1').innerHTML="";
for (intI=0;intI<arrInput1.length;intI++) {
  document.getElementById('parah1').innerHTML+=createInput1(arrInput1[intI], arrInputValue1[intI]);
}
}

function saveValue1(intId,strValue) {
arrInputValue1[intId]=strValue;
}  

function createInput1(id,value) {
	return "<input type='text' name='periodName' id='test1 "+ id +"' onChange='javascript:saveValue("+ id +",this.value)' placeholder='영업 기간 이름(ex ○월~○일)' style='background:transparent; border:none; border-bottom: solid 1px #ccc; padding: -10px 5px 10px; font-size:14pt; width: 325px; height: 1%; margin-top: 10px; margin-bottom: 10px;'><br>" 
	+"<input type='text' name='timeName' id='test1 "+ id +"' onChange='javascript:saveValue("+ id +",this.value)' placeholder='영업시간,브레이크타임,라스토오더타임' style='background:transparent; border:none; border-bottom: solid 1px #ccc; padding: -10px 5px 10px; font-size:14pt; width: 325px; height: 1%; margin-top: 10px; margin-bottom: 10px;'><br>"
	+"<input type='text' name='timeSE' id='test1 "+ id +"' onChange='javascript:saveValue("+ id +",this.value)' placeholder='영업시간 (ex 11:00 ~ 22:00)' style='background:transparent; border:none; border-bottom: solid 1px #ccc; padding: -10px 5px 10px; font-size:14pt; width: 325px; height: 1%; margin-top: 10px; margin-bottom: 10px;'><br>"
	+"<input type='text' name='dayOfWeek' id='test1 "+ id +"' onChange='javascript:saveValue("+ id +",this.value)' placeholder='영업일자(ex 매일,월~금)' style='background:transparent; border:none; border-bottom: solid 1px #ccc; padding: -10px 5px 10px; font-size:14pt; width: 325px; height: 1%; margin-top: 10px; margin-bottom: 10px;'><br>"

	;
	}

function deleteInput1() {
if (arrInput1.length > 0) { 
   arrInput1.pop(); 
   arrInputValue1.pop();
}
display1(); 
}


</script>

</head>
<body>
<%@ include file="includes/header2.jsp"%>
<form method="post" action="/modify" role="form">
<input type="hidden" name="cid" value="${cid }">
<h1>음식점 정보</h1>
<section class="modify-form">
<div class="int-pass">
<input type="text" name="placename" value="${Restaurant.placename }" placeholder="음식점 이름"><br>
<input type="text" name="address" value="${Restaurant.address}" placeholder="음식점  주소"><br>
<input type="text" name="catename" value="${Restaurant.catename }" placeholder="카테고리(ex : 한식, 양식, 고기 등)"><br>
<input type="text" name="parking" value="${Restaurant.parking}" placeholder="주차 여부 (Y or N)"><br>
<input type="text" name="phonenum" value="${Restaurant.phonenum}" placeholder="음식점  번호"><br>
<input type="hidden" name="${_csrf.parameterName}" id="token" data-token-name="${_csrf.headerName}"
				value="${_csrf.token}" />
</div>
</section>
<hr>
<h1>음식점 메인 사진</h1>
<br>
<input type="file" accept="image/*" onchange='chk_file_type(this)' name='uploadFile' multiple>
<c:if test="${ Restaurant.mainphotourl!=null}">
<h1>이미 쓰고있는 사진</h1>
<br>
<img src="${ Restaurant.mainphotourl}" width="100" height="100">
</c:if>
<br><br>


<div class='uploadResult'>
		<ul><!-- 첨부 파일의 이름을 목록으로 출력 -->
		</ul>
	</div>

<br><br>
<hr>
<h1>음식점 오픈 시간, 브레이크, 라스트오더 타임</h1>
<section class="modify-form">
<div class="int-pass">
<c:if test="${open != null}">
<c:forEach var="open" items="${open }">
<input type="text" name="periodName" value="${open.periodName }" placeholder="영업 기간 이름(ex ○월~○일)"><br>
<input type="text" name="timeName" value="${open.timeName }" placeholder="영업시간,브레이크타임,라스토오더타임"><br>
<input type="text" name="timeSE" value="${open.timeSE }" placeholder="영업시간 (ex 11:00 ~ 22:00)"><br>
<input type="text" name="dayOfWeek" value="${open.dayOfWeek }" placeholder="영업일자(ex 매일,월~금)"><br>
</c:forEach>
</c:if>
<div id="parah1"></div>
<br><br>
<input type="button" value="추가" onclick="addInput1();" />
<input type="button" value="삭제" onclick="deleteInput1();"/><br>
</div>
</section>
<hr>
<h1>음식점 휴무일</h1>
<section class="modify-form">
<div class="int-pass">
<c:if test="${off != null }">
<c:forEach var="off" items="${off}">
<input type="text" name="holydayName" value="${off.holydayName }" placeholder="휴무일 이름 ex(휴무일,공휴일,설당일 등)"><br>

<input type="text" name="offdate" value="${off.offdate }" placeholder="휴무 요일"><br>
</c:forEach>
</c:if>
</div>
</section>
<hr>

<h1>메뉴 </h1>
<section class="modify-form">
<div class="int-pass">
<c:if test="${menu !=null}">
<c:forEach var="menu" items="${menu }">
				<input type="text" name="menu" value="${menu.menu }">&nbsp;<input type="text" name="price" value="${menu.price }"><br>
</c:forEach>
</c:if>
<div id="parah"></div>
<br><br>
<input type="button" value="추가" onclick="addInput();" />
<input type="button" value="삭제" onclick="deleteInput();"/><br>
<hr>
</div>
</section>
<br>
<button type="submit">음식점 정보 수정하기</button>
<input type="button" value="음식점 삭제하기" onclick="location.href = '/delete?cid=${cid}'"/>
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
	
</script>
</body>
</html>