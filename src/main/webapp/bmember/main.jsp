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
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="favicon.png" />

    <meta name="description" content="" />
    <meta name="keywords" content="bootstrap, bootstrap5" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>

    <link rel="stylesheet" href="fonts/icomoon/style.css" />
    <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />

    <link rel="stylesheet" href="css/tiny-slider.css"   />
    <link rel="stylesheet" href="css/aos.css" />
    <link rel="stylesheet" href="css/style.css" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js"></script>
    <title>
     main
    </title>
  </head>
  <body>
  
  <script type="text/javascript">
  
  $(function(){
	  
	  $("#searchForm").on("submit",function(e){
		
		  e.preventDefault(); 
		  // 페이지 이동없이 접근 제한
		  // 맨처음에 와야함 
		  alert("검색어를 입력해주세요!");
		  
		  if(trim(searchKeyword)="") {// 공백제겋
			  alert("검색어를 입력해주세요")} // if문안에 뭐쓰징
		  else{location.href="list.bo?searchKeyword"+searchKeyword}
		  })
		  if(trim(searchKeyword)="") {
		  alert("검색어를 입력해주세요");
		  $("#searchF).focus();
		  }else{location.href="list.bo?searchKeyword"+searchKeyword}
		  })
		  
	  })
  })
  
  
   $(document).ready(function() {
 	 $("#searchF").focus();
	});
  
  
  </script>
  
  
  <!-- 여기 -->
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
  </script>
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
              action="allbookList.bo"
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

    <div class="section">
      <div class="container">
        <div class="row mb-5 align-items-center">
          <div class="col-lg-6">
            <h2 class="font-weight-bold text-primary heading">
            	추천리스트
            </h2>
          </div>
        </div>
        
        <div class="row">
          <div class="col-12">
            <div class="property-slider-wrap">
              <div class="property-slider">
               
<!--                 .item -->
              </div>

              <div
                id="property-nav"
                class="controls"
                tabindex="0"
                aria-label="Carousel Navigation"
              >
                <span
                  class="prev"
                  data-controls="prev"
                  aria-controls="property"
                  tabindex="-1"
                  >Prev</span
                >
                <span
                  class="next"
                  data-controls="next"
                  aria-controls="property"
                  tabindex="-1"
                  >Next</span
                >
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

<!-- /////하단/////   -->

    <div class="section sec-testimonials">
      <div class="container">
        <div class="row mb-5 align-items-center">
          <div class="col-md-6">
            <h2 class="font-weight-bold heading text-primary mb-4 mb-md-0">
              Customer Says
            </h2>
          </div>
          <div class="col-md-6 text-md-end">
            <div id="testimonial-nav">
              <span class="prev" data-controls="prev">Prev</span>

              <span class="next" data-controls="next">Next</span>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-lg-4"></div>
        </div>
        <div class="testimonial-slider-wrap">
          <div class="testimonial-slider">
            <div class="item">
              <div class="testimonial">
                <img
                  src="images/person_1-min.jpg"
                  alt="Image"
                  class="img-fluid rounded-circle w-25 mb-4"
                />
                <div class="rate">
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                </div>
                <h3 class="h5 text-primary mb-4">James Smith</h3>
                <blockquote>
                  <p>
                    &ldquo;Far far away, behind the word mountains, far from the
                    countries Vokalia and Consonantia, there live the blind
                    texts. Separated they live in Bookmarksgrove right at the
                    coast of the Semantics, a large language ocean.&rdquo;
                  </p>
                </blockquote>
                <p class="text-black-50">Designer, Co-founder</p>
              </div>
            </div>

            <div class="item">
              <div class="testimonial">
                <img
                  src="images/person_2-min.jpg"
                  alt="Image"
                  class="img-fluid rounded-circle w-25 mb-4"
                />
                <div class="rate">
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                </div>
                <h3 class="h5 text-primary mb-4">Mike Houston</h3>
                <blockquote>
                  <p>
                    &ldquo;Far far away, behind the word mountains, far from the
                    countries Vokalia and Consonantia, there live the blind
                    texts. Separated they live in Bookmarksgrove right at the
                    coast of the Semantics, a large language ocean.&rdquo;
                  </p>
                </blockquote>
                <p class="text-black-50">Designer, Co-founder</p>
              </div>
            </div>

            <div class="item">
              <div class="testimonial">
                <img
                  src="images/person_3-min.jpg"
                  alt="Image"
                  class="img-fluid rounded-circle w-25 mb-4"
                />
                <div class="rate">
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                </div>
                <h3 class="h5 text-primary mb-4">Cameron Webster</h3>
                <blockquote>
                  <p>
                    &ldquo;Far far away, behind the word mountains, far from the
                    countries Vokalia and Consonantia, there live the blind
                    texts. Separated they live in Bookmarksgrove right at the
                    coast of the Semantics, a large language ocean.&rdquo;
                  </p>
                </blockquote>
                <p class="text-black-50">Designer, Co-founder</p>
              </div>
            </div>

            <div class="item">
              <div class="testimonial">
                <img
                  src="images/person_4-min.jpg"
                  alt="Image"
                  class="img-fluid rounded-circle w-25 mb-4"
                />
                <div class="rate">
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                  <span class="icon-star text-warning"></span>
                </div>
                <h3 class="h5 text-primary mb-4">Dave Smith</h3>
                <blockquote>
                  <p>
                    &ldquo;Far far away, behind the word mountains, far from the
                    countries Vokalia and Consonantia, there live the blind
                    texts. Separated they live in Bookmarksgrove right at the
                    coast of the Semantics, a large language ocean.&rdquo;
                  </p>
                </blockquote>
                <p class="text-black-50">Designer, Co-founder</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


  <%-- <jsp:include page="../include/bottom.jsp"></jsp:include> --%>

    <!-- Preloader -->
    <div id="overlayer"></div>
    <div class="loader">
      <div class="spinner-border" role="status">
        <span class="visually-hidden">Loading...</span>
      </div>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/tiny-slider.js"></script>
    <script src="js/aos.js"></script>
    <script src="js/navbar.js"></script>
    <script src="js/counter.js"></script>
    <script src="js/custom.js"></script>
  </body>
</html>
