 $(function(){
	  
	  $("#searchForm").on("submit",function(e){
		  e.preventDefault();
		  
		  var searchKeyWord = $.trim($("#searchF").val());
	
		  if(searchKeyWord === ""){
			  alert("제목 키워드를 입력해주세요");
			  return false;
		  }
		  
		  location.href="allbookList.bo?pageNum=1&searchKeyWord="+searchKeyWord;
	  }) 
  })