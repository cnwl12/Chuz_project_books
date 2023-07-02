<!-- /*
* Template Name: Property
* Template Author: Untree.co
* Template URI: https://untree.co/
* License: https://creativecommons.org/licenses/by/3.0/
*/ -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="fonts/icomoon/style.css" />
    <link rel="stylesheet" href="css/tiny-slider.css"   />
    <link rel="stylesheet" href="css/style.css" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js"></script>
	<style>
	.site-nav{position: absolute;}
	</style>
    <title>
     main
    </title>
  </head>
  <body>
  
  <script type="text/javascript">
  
  $(function(){
	  
	  $("#searchForm").on("submit",function(e){
		  e.preventDefault();
		  var searchKeyWord = $.trim($("#searchF").val());
		  if(searchKeyWord==""){
			  alert("검색어를 입력해주세요.");
			  return false;
		  }
		  
		  location.href="allbookList.bo?pageNum=1&searchKeyWord="+searchKeyWord;
		  // 페이지 이동없이 접근 제한
		  // 맨처음에 와야함 
		//  alert("검색어를 입력하세요");
		  
		  
		  /* if((searchKeyword)=="") {// 공백제거
			  alert(searchKeyword)
			  	
		  
		  }else{ //이동 
			  location.href="list.bo?searchKeyword"+searchKeyword
		  } */
		  
		  /* if(trim(searchKeyword)="") {
		  	alert("검색어를 입력해주세요");
		  	$("#searchF").focus();
		  }else{
			  location.href="list.bo?searchKeyword"+searchKeyword
		  } */
	  }) 
  })
  
  </script>
  
<!--   
  여기
  <script>
  $(document).ready(function(){
  		console.log(${bookList});
	// 스크립트에서는 : 안되고 for - of  
  			
  		 for(var book of ${bookList.get("items")}){ 
  			console.log(book);
  			var str = "";
  			// book.title
  		
  			
  			str += "<div class='property-item'> ";
            str += 		"<a href='property-single.html' class='img'> ";
            str += 			"<img src= '"+book.image+"' alt='Image' class='img-fluid' />"
            str += 		"</a>"
            str += "<div class='property-content'>"
             str += 		"<div class='price mb-2'>"
            str +=			"<span>"+book.discount+"</span>"
            str +=		"</div>"
            str += 		"<div>"
            str += 			"<span class='d-block mb-2 text-black-50'>"+book.author+"</span>"
            str += 			"<span class='city d-block mb-3'>"+book.title+"</span>"
            str +="<a href='"+book.link+"' class='btn btn-primary py-2 px-3'> 상세보기 </a>"
            str += 		"</div>"
            str +=	"</div>"
            str +="</div>"
  			
         $(".property-slider").append(str);
  			
  			
  		}
  		
  		/*  var bookList = ${bookList.get("items")};
  		 
  		console.log(bookList.get("items")[0]); */
	  		
  	})
  </script> -->
  <!--   -->
    <div class="site-mobile-menu site-navbar-target">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close">
          <span class="icofont-close js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div>
    
    <!-- header 부분 - top  -->
<jsp:include page="../include/top.jsp"></jsp:include>
                  
    	<!-- 드롭다운메뉴      
      	<li class="has-children">
                 <a href="#">Dropdown</a>
                 <ul class="dropdown">
                      <li><a href="#"></a></li>
                      <li><a href="#">Sub Menu Two</a></li>
                      <li><a href="#">Sub Menu Three</a></li>
                   </ul> 
              	</li> --> 

<!-- 메인 슬라이드 : 검색창 -->
    <div class="hero">
      <div class="hero-slide">
        <div
          class="img overlay"
          style="background-image: url('bmg/books-016.jpg')"
        ></div>
        <div
          class="img overlay"
          style="background-image: url('bmg/books-012.jpg')"
        ></div>
        <div
          class="img overlay"
          style="background-image: url('bmg/books-001.jpg')"
        ></div>
      </div>

      <div class="container">
        <div class="row justify-content-center align-items-center">
          <div class="col-lg-9 text-center">
            <h1 class="heading" data-aos="fade-up">
              쉽고 빠르게 검색해보세요
            </h1>
            <form 
              class="narrow-w form-search d-flex align-items-stretch mb-3"
              data-aos="fade-up"
              data-aos-delay="200"
              id="searchForm"
              
            >
              <input type="text"
                class="form-control px-4"
                placeholder="검색어를 입력해주세요"
                name = "searchKeyWord"
                id = "searchF">
              <button type="submit" class="btn btn-primary">Search</button>
            </form>
          </div>
        </div>
      </div>
    </div>

<!--     <div class="section"> -->
<!--       <div class="container"> -->
<!--         <div class="row mb-5 align-items-center"> -->
<!--           <div class="col-lg-6"> -->
<!--             <h2 class="font-weight-bold text-primary heading"> -->
<!--             	추천리스트 -->
<!--             </h2> -->
<!--           </div> -->
<!--         </div>  -->
        
<!--         <div class="row"> -->
<!--           <div class="col-12"> -->
<!--             <div class="property-slider-wrap"> -->
<!--               <div class="property-slider"> -->
               
<!-- 			 item  -->
<!--               </div> -->

<!--               <div -->
<!--                 id="property-nav" -->
<!--                 class="controls" -->
<!--                 tabindex="0" -->
<!--                 aria-label="Carousel Navigation" -->
<!--               > -->
<!--                 <span -->
<!--                   class="prev" -->
<!--                   data-controls="prev" -->
<!--                   aria-controls="property" -->
<!--                   tabindex="-1" -->
<!--                   >Prev</span -->
<!--                 > -->
<!--                 <span -->
<!--                   class="next" -->
<!--                   data-controls="next" -->
<!--                   aria-controls="property" -->
<!--                   tabindex="-1" -->
<!--                   >Next</span -->
<!--                 > -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
<!--         </div> -->
<!--       </div> -->
<!--     </div> -->

  <%-- <jsp:include page="../include/bottom.jsp"></jsp:include> --%>
  
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/tiny-slider.js"></script>
    <script src="js/aos.js"></script>
    <script src="js/navbar.js"></script>
<!--     <script src="js/counter.js"></script> -->
    <script src="js/custom.js"></script>
  </body>
</html>
