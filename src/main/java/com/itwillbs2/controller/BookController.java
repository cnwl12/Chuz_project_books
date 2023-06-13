package com.itwillbs2.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itwillbs2.domain.BookDTO;
import com.itwillbs2.service.BookService;
import com.mysql.cj.Session;

public class BookController extends HttpServlet{
	// 가상주소 -> 실제주소 연결 (주소매핑) => 서블릿(처리하는역할|처리담당자) 상속 
		//=> 오버라이딩doGet/doPost/service()자동으로 호출 => 자동으로 웹애플리케이션 서버(톰캣) 자동으로 메서드 호출 
	
	// 메서드 호출 
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("BookController doGet()");
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("BookController doPost()");
		doProcess(request, response);
	}
	
	//주소매핑 메서드 
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("BookController doProcess()");
		// 가상주소 뽑아오기 /insert.me
		String strPath = request.getServletPath(); // 연결된 실제주소 /insert.me
		System.out.println(strPath);
		// 가상주소 비교해서 실제 파일연결 -> 이동
		// 뽑아온 가상주소와 원하는 가상주소 비교 -> 일치하면 
		if(strPath.equals("/insert.me")) {
			// 실제 파일연결 -> 이동 
			// response.sendRedirect("member/insert.jsp"); // member폴더 파일 복사해서 가져왔음(연결)
			// 기존방식은 주소 바뀌면서 실행되었음 
			
			// "/insert.me" 주소가 변경되지 않고(가상주소 유지) 이동
			// RequestDispatcher 자바파일 forward 메서드 호출		// jsp주소 화면에 안보이게 주소변경없이 유지
			RequestDispatcher dis = request.getRequestDispatcher("member/insert.jsp");
			dis.forward(request, response);
			//insert.jsp에서도 이동페이지 .me로 변경 
		}
		
		//위랑 연결해서  else해도 됨 
		if(strPath.equals("/insertPro.me")) {
			System.out.println("주소비교 insertPro.me");
			//System.out.println(request.getParameter("id")); // id 값 넘어오는지 확인 
			//55먼저 하면 한글처리가 안되어서 주석처리 
			
			//MemberService 객체생성
			//insertMember()메서드 호출
			BookService bookService = new BookService(); //처리작업
			bookService.insertMember(request);
			
			//로그인 페이지(login.me)로 이동 (주소변경 insertpro에서 login.me로 ) 
			response.sendRedirect("login.me"); // web.xml로 가서 가상주소 뽑아옴
		}
		if(strPath.equals("/login.me")) { //login.jsp로 넘어감 
			// member/login.jsp로 이동 (주소 변경 없이 이동- jsp주소가 안보이면서 이동해야해서)
			// "/login.me" 주소가 변경되지 않고(가상주소 유지) 이동 
			// RequestDispatcher 자바파일 forward 메서드 호출 - jsp 이동방식 
			RequestDispatcher dis = request.getRequestDispatcher("member/login.jsp");
			dis.forward(request, response);
		}
		
		// 로그인 일치여부 확인 
		if(strPath.equals("/loginPro.me")) { // 뽑아온 값은 / 붙여줘야함 
			System.out.println("주소비교 /loginPro.me ");
			// 처리 
			// MemberService 객체생성 
			BookService bookService = new BookService();
			
			// 리턴값MemberDTO = userCheck(request) 메서드 호출 
			BookDTO bookDTO = bookService.userCheck(request);
			 
			if(BookDTO !=null) { 
			//DB에서 ID 등 정보 일치하면 => 페이지 상관없이 값 유지하기 위해 세션값 생성(권한부여받은것!) 
				// 자바에서는 자바에 맞는 세션불러야함! (바로 session.set 못함)
				HttpSession session = request.getSession();
				
				session.setAttribute("id",BookDTO.getId());
			 
			// main.me로 이동 
			response.sendRedirect("main.me"); //주소값 바뀌면서 이동 (jsp경우엔 dispatch..)
			}else { //id,pw 불일치 => member/msg.jsp
				RequestDispatcher dis = request.getRequestDispatcher("member/msg.jsp");
				dis.forward(request, response);
			//<script type="text/javascript"> -- 자바 msg.jsp로 따로 분리했음 
//				alert("아이디 비밀번호 불일치");
//				history.back();
//			</script>
			}
			
			
			
		}//
		
		//메인으로 이동
		if(strPath.equals("/main.me")) { // main.me 유지하면서 
			//member/main.jsp로 이동
			RequestDispatcher dis =request.getRequestDispatcher("member/main.jsp");
			dis.forward(request, response);
		}		
		
		
		
		
		
	}//doProcess()
} // 클래스 
