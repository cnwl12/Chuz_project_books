package com.itwillbs2.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itwillbs2.domain.BookDTO;
import com.itwillbs2.service.BoardService;
import com.itwillbs2.service.BookService;

public class BookController extends HttpServlet {
	// 가상주소 -> 실제주소 연결 (주소매핑) => 서블릿(처리하는역할|처리담당자) 상속
	// => 오버라이딩doGet/doPost/service()자동으로 호출 => 자동으로 웹애플리케이션 서버(톰캣) 자동으로 메서드 호출

	// 메서드 호출
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	// 주소매핑 메서드
	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String strPath = request.getServletPath(); // 연결된 실제주소 /insert.me

		// 게시판 매핑
		if (strPath.equals("/board.bs")) {
			// "/insert.bs" 주소가 변경되지 않고(가상주소 유지) 이동
			// RequestDispatcher 자바파일 forward 메서드 호출 // jsp주소 화면에 안보이게 주소변경없이 유지
			RequestDispatcher dis = request.getRequestDispatcher("bmember/board.jsp");
			dis.forward(request, response);
		}

		// 회원가입 매핑
		if (strPath.equals("/join.bs")) {
			// "/insert.bs" 주소가 변경되지 않고(가상주소 유지) 이동
			// RequestDispatcher 자바파일 forward 메서드 호출 // jsp주소 화면에 안보이게 주소변경없이 유지
			RequestDispatcher dis = request.getRequestDispatcher("bmember/join.jsp");
			dis.forward(request, response);
		}

		if (strPath.equals("/joinPro.bs")) {
			// insertMember()메서드 호출
			BookService bookService = new BookService(); // 처리작업
			bookService.insertMember(request);

			// 로그인 페이지(login.me)로 이동 (주소변경 insertpro에서 login.me로 )
			response.sendRedirect("login.bs"); // web.xml로 가서 가상주소 뽑아옴
		}

		if (strPath.equals("/login.bs")) { // login.jsp로 넘어감
			// member/login.jsp로 이동 (주소 변경 없이 이동- jsp주소가 안보이면서 이동해야해서)
			// RequestDispatcher 자바파일 forward 메서드 호출 - jsp 이동방식
			RequestDispatcher dis = request.getRequestDispatcher("bmember/login.jsp");
			dis.forward(request, response);
		}
		
		if (strPath.equals("/bookShelf.bs")) { // 
			
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			System.out.println(id);
			BookService bookService = new BookService();
			// bookService.getBookShelves(id);
			
			List<HashMap<String, String>> bookShelves = bookService.getBookShelves(id);
			request.setAttribute("bookShelves", bookShelves);
			
			//System.out.println("bookShelves  컨: "+ bookShelves);
			
			RequestDispatcher dis = request.getRequestDispatcher("bmember/bookShelf.jsp");
			dis.forward(request, response);
		}
		
		
		
		// 로그인 일치여부 확인
		if (strPath.equals("/loginPro.bs")) { // 뽑아온 값은 / 붙여줘야함
			BookService bookService = new BookService();
			// 리턴값MemberDTO = userCheck(request) 메서드 호출
			BookDTO bookDTO = bookService.userCheck(request);

			if (bookDTO != null) {
				// DB에서 ID 등 정보 일치하면 => 페이지 상관없이 값 유지하기 위해 세션값 생성(권한부여받은것!)
				HttpSession session = request.getSession();
				session.setAttribute("id", bookDTO.getId());
				// main.me로 이동
				 response.sendRedirect("main.bs"); // 주소값 바뀌면서 이동 (jsp경우엔 dispatch..)
				
			} else { // id,pw 불일치 => member/msg.jsp
				RequestDispatcher dis = request.getRequestDispatcher("bmember/msg.jsp");
				dis.forward(request, response);
			}
		} //

		// 메인으로 이동
		if (strPath.equals("/main.bs")) { // main.me 유지하면서
			// member/main.jsp로 이동
			
			BoardService boardService = new BoardService();
			request.setAttribute("bookList", boardService.searchBook("자바"));
//			이거 딴데서도 쓰면되깅
//			System.out.println("bookList");
			
			
			RequestDispatcher dis = request.getRequestDispatcher("bmember/main.jsp");
			dis.forward(request, response);
		}

		// 회원정보 수정/삭제 이동
		if (strPath.equals("/update.bs")) { // main.me 유지하면서
			// member/main.jsp로 이동

			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");

			if (id == null) { // 로그인 안한상태
				RequestDispatcher dis = request.getRequestDispatcher("bmember/msg2.jsp");
				dis.forward(request, response);
				// response.sendRedirect("main.bs");
			} else {

				BookService bookService = new BookService();
				BookDTO bookDTO = bookService.getMember(id);

				request.setAttribute("bookDTO", bookDTO);

				RequestDispatcher dis = request.getRequestDispatcher("bmember/update.jsp");
				dis.forward(request, response);
			}
		}

		if (strPath.equals("/updatePro.bs")) { // main.me 유지하면서

			BookService bookService = new BookService();

			BookDTO bookDTO = bookService.userCheck(request);

			if (bookDTO != null) {

				bookService.updateMember(request);

				response.sendRedirect("main.bs");

			} else {
				RequestDispatcher dis = request.getRequestDispatcher("bmember/msg.jsp");
				dis.forward(request, response);
			}
		}

		// logout페이지 매핑
		if (strPath.equals("/logout.bs")) {
			HttpSession session = request.getSession();
			session.invalidate();

			response.sendRedirect("main.bs");
		} //

		if (strPath.equals("/delete.bs")) {

			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");
			// System.out.println(id + "북서비스 리퀘스트");
			
			BookService bookService = new BookService();
			bookService.deleteMember(id);
			
			session.invalidate();
			  
			response.sendRedirect("main.bs");
			
			/*
			 * 실제로는 y/n 등으로 update만 진행해서 
			 * 물리적 데이터 남기고 로그인 시 where 조건 따져서 로그인 진행
			 *  
			 * */
			
		} // 세션 삭제

		
		
//		if (strPath.equals("/checkId.bs")) {
//			 System.out.println("체크 아이디");
//			    String id = (String) request.getAttribute("id");
//			    MemberService memberService = new MemberService();
//			    boolean checkResult = memberService.checkId(id);
//			    response.setContentType("application/json");
//			    response.setCharacterEncoding("UTF-8");
//			    PrintWriter out = response.getWriter();
//			    out.print("{\"result\": " + checkResult + "}");
//			    out.flush();
//		}
	}// doProcess()
} // 클래스
