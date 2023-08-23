/*list 내 검색어*/
$(function() { 
  function submitCheck() {
    var keyword = $("#keyWord").val();
    if (keyword.trim() === "") { // 입력없이 검색 누름
      alert("검색어를 입력해주세요");
      return false;
    }
  }
  $("#keywordForm").submit(submitCheck);
}) 
