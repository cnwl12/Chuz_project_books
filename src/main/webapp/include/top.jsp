<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            
<script type="text/javascript">
	function fun1() {
		window.open("login.bs","","width=450,height=450, top=250,left=150");
	}	
	
	/* // 부모 창에서 메시지 수신 및 처리
    window.addEventListener("message", function(event) {
        var data = event.data;
        if (data.isLoggedIn) {
            // 로그인 성공한 경우 세션값을 이용하여 로그인 상태로 처리
            var userId = data.userId;
            // 세션값을 이용한 로그인 상태 처리 로직을 구현합니다.
            // 예시로 콘솔에 로그인 상태 메시지를 출력하는 것으로 대체하였습니다.
            console.log("로그인 상태로 변경됨. 사용자 아이디: " + userId);
            
            location.reload();
        }
    }); */
		
</script>            
             
    <nav class="site-nav">
      <div class="container">
        <div class="menu-bg-wrap">
          <div class="site-navigation">
            <a href="main.bs" class="logo m-0 float-start">BookStore</a>
            
            <ul class="js-clone-nav d-none d-lg-inline-block text-start site-menu float-end">
              
              <li class="active"><a href="main.bs">Home</a></li>
              <li class="active"><a href="list.bo">게시판</a></li>
              
              <li class="has-children">  
              <%
              String id =(String)session.getAttribute("id"); 
              
              if(id==null){ // 로그인 안한 상태 
              %>
               <a href="#" onclick="fun1()">login</a>
                <%
              }else{ // 세션값 있음 -> 로그인 성공
            	  %>
            	  <%=id%>님
            	  <% 
               }
                %>
                <ul class="dropdown">
                  
                  <%
                  if(id==null){
                  %>
                    <li><a href="join.bs">회원가입</a></li>
                  <%
                  }
                  %>
                  
                  <%
                  if(id!=null){
                	 %>
                  <li><a href="update.bs">회원정보 수정 | 삭제</a></li>
             	  <li><a href="logout.bs">로그아웃</a></li>
                  <li><a href="bookShelf.bs">읽은책장</a></li>
                	<%
                  }
                  %>
                  
                  <%-- <%
              if(id!=null){ // 로그인 안한 상태 
              %>
               <%
               } 
               %> --%>
               
                  
                </ul>
              </li>
            </ul>  
<!-- 
            <a
              href="#"
              class="burger light me-auto float-end mt-1 site-menu-toggle js-menu-toggle d-inline-block d-lg-none"
              data-toggle="collapse"
              data-target="#main-navbar"
            > -->
              <span></span>
            </a>
          </div>
        </div>
      </div>

  		  </nav>
  		   
  		  
  		  