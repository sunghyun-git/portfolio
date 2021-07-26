var Swiper=new Swiper('.swiper-container', {
    dirction: 'vertical',
    loop: true,
    pagination: {
        el: '.swiper-pagination',
    },
    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },
})


	var searchForm = $(".searchForm");
     		$(".searchForm button").on("click", function(e) { 	
     		if (!searchForm.find("input[name='keyword']").val()) {
     		alert("키워드를 입력하세요");
     		return false;
     		}
     		e.preventDefault();
     		searchForm.submit();
     });

