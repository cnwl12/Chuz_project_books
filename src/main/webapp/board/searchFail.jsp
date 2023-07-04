<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchFail</title>
<link rel="stylesheet" href="fonts/icomoon/style.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/board.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js"></script>
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
	  }) 
  })
  
  </script>



<jsp:include page="../include/top.jsp"></jsp:include>

<div class="allDiv" style=""> 
		
		<div class="ss_line">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody><tr>
           	<td height="19" style="padding:3px 0;">
            <div class="search_t_g"><span class="result_l">요청하신 검색 결과가 없습니다!</span></div></td>
            </tr>
        	</tbody></table> 
      	</div>
        
        <div class="ss_space_h10"></div>
        <div class="ss_list_wbox">
        	<ul class="formulli">
             	<li>입력한 검색어의 철자 또는 띄어쓰기가 정확한지 다시 한번 확인해 주세요.</li>
                <li>검색어의 단어 수를 줄이거나, 보다 일반적인 검색어를 사용하여 검색해 보세요.</li>
            </ul>
        </div>
    </div> 

<!-- 검색창  -->
   <div class="container">
        <div class="row justify-content-center align-items-center">
          <div class="col-lg-9 text-center">
            
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



</body>
</html>