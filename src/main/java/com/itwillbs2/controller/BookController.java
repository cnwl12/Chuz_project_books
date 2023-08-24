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
	protected void doProcess(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String strPath = request.getServletPath(); // 연결된 실제주소 /insert.me

		// 회원가입 매핑
		if (strPath.equals("/join.bs")) {
			RequestDispatcher dis = request.getRequestDispatcher("bmember/join.jsp");
			dis.forward(request, response);
		}
		
		// 회원가입처리 
		if (strPath.equals("/joinPro.bs")) {
			BookService bookService = new BookService(); // 처리작업
			bookService.insertMember(request);

			response.sendRedirect("main.bs"); // web.xml로 가서 가상주소 뽑아옴
		}
		
		// 로그인 페이지
		if (strPath.equals("/login.bs")) { // login.jsp로 넘어감
			RequestDispatcher dis = request.getRequestDispatcher("bmember/login.jsp");
			dis.forward(request, response);
		}
		
		// 나의 책장 
		if (strPath.equals("/bookShelf.bs")) { // 
			
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			
			BookService bookService = new BookService();
			
			List<HashMap<String, String>> bookShelves = bookService.getBookShelves(id);
			request.setAttribute("bookShelves", bookShelves);
			
			RequestDispatcher dis = request.getRequestDispatcher("bmember/bookShelf.jsp");
			dis.forward(request, response);
		}
		
		// 로그인 일치여부 확인
		if (strPath.equals("/loginPro.bs")) { // 뽑아온 값은 / 붙여줘야함
			BookService bookService = new BookService();
			BookDTO bookDTO = bookService.userCheck(request);

			if (bookDTO != null) {
				// DB에서 ID 등 정보 일치하면 => 페이지 상관없이 값 유지하기 위해 세션값 생성(권한부여받은것!)
				HttpSession session = request.getSession();
				session.setAttribute("id", bookDTO.getId());
				
				RequestDispatcher dis = request.getRequestDispatcher("bmember/success.jsp");
				dis.forward(request, response);
				
			} else { // id,pw 불일치 => member/msg.jsp
				RequestDispatcher dis = request.getRequestDispatcher("bmember/msg.jsp");
				request.setAttribute("msg", " 아이디 또는 비밀번호가 불일치합니다.");
				dis.forward(request, response);
			}
		} 

		// 메인으로 이동
		if (strPath.equals("/main.bs")) { // main.me 유지하면서
			
			BoardService boardService = new BoardService();
			RequestDispatcher dis = request.getRequestDispatcher("bmember/main.jsp");
			dis.forward(request, response);
		}

		// 회원정보 수정/삭제 이동
		if (strPath.equals("/update.bs")) { // main.me 유지하면서

			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");

			if (id == null) { // 로그인 안한상태
				RequestDispatcher dis = request.getRequestDispatcher("bmember/msg.jsp");
				request.setAttribute("msg", "로그인 이후 이용 가능합니다");
				dis.forward(request, response);
			} else {

				BookService bookService = new BookService();
				BookDTO bookDTO = bookService.getMember(id);

				request.setAttribute("bookDTO", bookDTO);

				RequestDispatcher dis = request.getRequestDispatcher("bmember/update.jsp");
				dis.forward(request, response);
			}
		}
		
		// 회원정보 수정 처리 페이지 
		if (strPath.equals("/updatePro.bs")) { // main.me 유지하면서

			BookService bookService = new BookService();
			BookDTO bookDTO = bookService.userCheck(request);

			if (bookDTO != null) {

				bookService.updateMember(request);

				response.sendRedirect("main.bs");

			} else {	//회원정보 수정시 비밀번호 틀렸을 때 
				RequestDispatcher dis = request.getRequestDispatcher("bmember/msg.jsp");
				request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
				dis.forward(request, response);
			}
		}

		// logout페이지 매핑
		if (strPath.equals("/logout.bs")) {
			HttpSession session = request.getSession();
			session.invalidate();

			response.sendRedirect("main.bs");
		} 
		
		// 회원탈퇴 페이지 
		if (strPath.equals("/delete.bs")) {

			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");
			
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
		
		// 책 찜하기
		if (strPath.equals("/checkBook.bs")) {		
			
			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");
			
			request.setAttribute("msg", "로그인 후 이용가능합니다.");
			
			if(id != null) {
				BookService bookService = new BookService();
				if(bookService.insertYn(request)) {
					bookService.insertCheckBook(request);
					request.setAttribute("msg", "나의 책장에 추가되었습니다.");
				} else {
					request.setAttribute("msg", "이미 책장에 추가되어 있습니다.");
				}
			}
			
			RequestDispatcher dis = request.getRequestDispatcher("bmember/msg.jsp");
			dis.forward(request, response);
			
		} //
		
		if (strPath.equals("/delLike.bs")) {	
		
			BookService bookService = new BookService();
			bookService.delLike(request);
			
			response.sendRedirect("bookShelf.bs");
		}
		
	}// doProcess()
} // 클래스
