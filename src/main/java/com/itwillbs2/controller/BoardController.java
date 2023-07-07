package com.itwillbs2.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.ha.backend.Sender;

import com.google.gson.JsonObject;
import com.itwillbs2.dao.ApiExamSearchBook;
import com.itwillbs2.domain.BoardDTO;
import com.itwillbs2.service.BoardService;
import com.itwillbs2.service.BookService;
import com.mysql.cj.Session;
import com.itwillbs2.domain.PageDTO;

public class BoardController extends HttpServlet { //상속받아서 오버라이딩 

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글 깨짐 방지) doProcess 과정 거칠 때 if 만나기 전에 위에서 아예 선언
		request.setCharacterEncoding("UTF-8");
		// 가상주소 뽑아오기 getServletPath(); 
		String strPath = request.getServletPath(); 
		
		// 첨부파일 포함 글쓰기
		if(strPath.equals("/fwrite.bo")) { // 뽑아온 주소는 앞에 / 
			RequestDispatcher dis = request.getRequestDispatcher("board/fwrite.jsp");
			dis.forward(request, response);
		}
		
		// 등록 실행할 페이지 
		if(strPath.equals("/fwritePro.bo")) {
			// pro 실행할 BoardService 객체생성 
			BoardService boardService = new BoardService();
			boardService.insertBoard(request);
			
			response.sendRedirect("list.bo");
		}
		
		// 수정 페이지 
		if(strPath.equals("/fupdate.bo")) {

			BoardService boardService = new BoardService(); //  가져와서

			BoardDTO dto = boardService.getBoard(request);
			
			request.setAttribute("dto", dto);
			
			RequestDispatcher dis = request.getRequestDispatcher("board/fupdate.jsp");
			dis.forward(request, response);
		}	
		
		// 수정 처리 페이지 
		if(strPath.equals("/fupdatePro.bo")){

			BoardService boardService = new BoardService();
			boardService.fupdatePro(request);

			response.sendRedirect("list.bo");
		}
		
		// 글목록 페이지 
		if(strPath.equals("/list.bo")) { 
			PageDTO pageDTO = new PageDTO();
			
			// 한 페이지에 보여줄 글 개수 설정 
			int pageSize = 10;
			String pageNum =request.getParameter("pageNum"); //get방식으로 설정해서 가져오기 
			
			// 페이지 번호 가져오기 
			if(pageNum == null){
				pageNum="1"; // (페이지 번호가 없으면 무조건 1page 설정) [보통 창 켰을 때 첫번째 페이지]  
			}
			// pageNum 정수형으로 변경(currentPage)
			int currentPage = Integer.parseInt(pageNum);
			
			// 페이징 처리할게 너무 많아서 DTO 따로 생성해서 담아옴 
			// request를 -> pageDTO에 저장 
			pageDTO.setPageSize(pageSize);
			pageDTO.setPageNum(pageNum);
			pageDTO.setCurrentPage(currentPage);
			// DB에서 가져올 행번호 구하기(구한 행(시작행)부터 ~ pageSize10개 ) 
			
			//DB에서 글목록 가져오기 -> 게시판 내 조회
			BoardService boardService = new BoardService();
			String searchKeyword = request.getParameter("keyWord");
			
			List<BoardDTO> dtoList = boardService.getBoardList(pageDTO,searchKeyword);
			
			int count = boardService.getBoardCount();
			
			// 한 화면에 보여줄 페이지 개수
			int pageBlock=3; //(1~10 / 11~20 / 21~30)

			// 시작하는 페이지번호 구하기
			//			   	currentPage		 pageBlock => startPage
			//			 	1~10 (0~9)			10	   =>  	(0*10)+1-> 	 1
			//				11~20(10~19)		10	   => 	(1*10)+1->  11	
			//				21~30(20~29)		10	   => 	(2*10)+1->  21	
			int startPage = (currentPage-1)/pageBlock * pageBlock +1;
								// 0~9		/ 10 

			// 끝나는 페이지번호 구하기 
			// 끝행 endRow 식 구하기 
			//	 			startPage 	pageBlock 	 => endPage
			//				1(11)(21)	  10		 =>  10 (20) (30)	
			int endPage = startPage + pageBlock -1;
			// 계산으로 끝나는 페이지번호 => 실제 있는 전체 페이지 번호 비교 
			// 끝나는 페이지번호 구한값(10) => 2(실제 있는 전체 페이지) 와 비교
			// 계산으로 끝나는 페이지번호 구한값(10)이 더 크면 => 실제 페이지(2)로 변경

			// 실제 있는 전체 페이지 번호 구하기 
			// 50개 글, 10개씩 조회 -> 5페이지 + =>5
			// 55개 글, 10개씩 조회 -> 5페이지 + 5개 글 => 6 (페이지+1)
			int pageCount =count/pageSize +(count%pageSize==0?0:1); // 전체글 개수 DB에서 가져옴 
							//나머지가 없는 경우  //+남은 경우 삼항연산자로 값 저장 
			if(endPage > pageCount){//endPage > 전체 페이지번호
				endPage = pageCount; //endPage = 전체 페이지번호;
			}
			
			//가져온 목록 request 저장 
			pageDTO.setCnt(count);
			pageDTO.setPageBlock(pageBlock);
			pageDTO.setStartPage(startPage);
			pageDTO.setEndPage(endPage);
			pageDTO.setPageCount(pageCount);
			
			request.setAttribute("dtoList", dtoList);
			request.setAttribute("pageDTO", pageDTO);
			
			//board/list.jsp로 이동 (주소변경 없이 이동)
			RequestDispatcher dis = request.getRequestDispatcher("board/list.jsp");
			dis.forward(request, response);
		}
		
		// 게시글 페이지 (글목록안 작성됨 게시글)
		if(strPath.equals("/content.bo")) {
			BoardService boardService = new BoardService();
			
			BoardDTO dto = boardService.getBoard(request); // 메서드 호출
			request.setAttribute("dto", dto); //request에 저장 
			
			// 댓글 
			List<HashMap<String, String>> commentList = boardService.getComment(request);
			request.setAttribute("commentList", commentList);
			
			RequestDispatcher dis = request.getRequestDispatcher("board/content.jsp");
			dis.forward(request, response);
		}
		
		// 게시글 삭제 
		if(strPath.equals("/delete.bo")) {

			BoardService boardService = new BoardService();
			boardService.deleteBoard(request);
			response.sendRedirect("list.bo");
		}
		
		// 댓글 페이지
		if (strPath.equals("/comment_insert.bo")) {

			request.setCharacterEncoding("UTF-8");
			
			BoardService boardService = new BoardService();
			String board_num = request.getParameter("board_num");
			
			System.out.println(request.getParameter("comment_text"));
			boardService.insertComment(request);
			
			response.sendRedirect("content.bo?board_num=" + board_num);
			
		}
		
		// 댓글 삭제 페이지 
		if(strPath.equals("/commentDelete.bo")) {
			
			BoardService boardService = new BoardService();
			String board_num = request.getParameter("board_num");
			boardService.deleteComment(request);

			response.sendRedirect("content.bo?board_num=" + board_num);
		}
		
		// api -> 검색된 책 정보 페이지 
		if(strPath.equals("/allbookList.bo")) {
			
			HttpSession session = request.getSession();
			
			BoardService boardService = new BoardService();
			BookService bookService = new BookService();
			PageDTO pageDTO = new PageDTO();
			
			// 한 페이지에 보여줄 글 개수 설정 
			int pageSize = 10;
			// 페이지 번호 가져오기 (페이지 번호가 없으면 무조건 1page 설정) [보통 창 켰을 때 첫번째 페이지]
			String pageNum =request.getParameter("pageNum"); //get방식으로 설정해서 가져오기 
			
			String keyWord = request.getParameter("searchKeyWord");
			JsonObject bookList = boardService.searchBook(request);		
			
			// 검색된 책 총 권수 
			int count = Integer.parseInt(bookList.asMap().get("total").toString());		
			
			// 검색 키워드가 없을 때
			if(count ==0) {
				RequestDispatcher dis = request.getRequestDispatcher("board/searchFail.jsp");
				dis.forward(request, response);
			}
			// ----------찜 기능--------------------------------
			List<String> isbns = new ArrayList<>();
			
			if(session != null) { // 로그인했을 때
				String id = (String)session.getAttribute("id");
				
				 if (id != null) {
					 List<HashMap<String, String>> bookShelves = bookService.getBookShelves(id);
				
					for(Map<String, String> book : bookShelves) {
						isbns.add(book.get("bookShelf_isbn")); 
					}
				}
			}		 

			// ------------------ 이하 paging -----------------------
			// pageNum 정수형으로 변경(currentPage)
			int currentPage = Integer.parseInt(pageNum);
			
			pageDTO.setPageSize(pageSize);
			pageDTO.setPageNum(pageNum);
			pageDTO.setCurrentPage(currentPage);
			
			// 한 화면에 보여줄 페이지 개수
			int pageBlock=10; //(1~10 / 11~20 / 21~30)

			// 시작하는 페이지번호 구하기
			int startPage = (currentPage-1)/pageBlock * pageBlock +1;
								// 0~9		/ 10 

			// 끝나는 페이지번호 구하기 
			int endPage = startPage + pageBlock -1;
			
			int pageCount =count/pageSize +(count%pageSize==0?0:1); // 전체s글 개수 DB에서 가져옴 
							//나머지가 없는 경우  //+남은 경우 삼항연산자로 값 저장 
			if(endPage > pageCount){//endPage > 전체 페이지번호
				endPage = pageCount; //endPage = 전체 페이지번호;
			}
			
			//가져온 목록 request 저장 
			pageDTO.setCnt(count);
			pageDTO.setPageBlock(pageBlock);
			pageDTO.setStartPage(startPage);
			pageDTO.setEndPage(endPage);
			pageDTO.setPageCount(pageCount);
			
			request.setAttribute("pageDTO", pageDTO);
			request.setAttribute("bookList", bookList );
			request.setAttribute("isbns", isbns);
			
			RequestDispatcher dis = request.getRequestDispatcher("board/allbookList.jsp");
			dis.forward(request, response);
		}
		
		// 검색 조회 후 책이 없을 때 
		if(strPath.equals("/searchFail.bo")) {
			
			RequestDispatcher dis = request.getRequestDispatcher("board/searchFail.jsp");
			dis.forward(request, response);
		}
		
		// 갤러리 이미지 
		if(strPath.equals("/gallary.bo")) { 

			PageDTO pageDTO = new PageDTO();
			int pageSize = 10;
			// 페이지 번호 가져오기 (페이지 번호가 없으면 무조건 1page 설정) [보통 창 켰을 때 첫번째 페이지]
			String pageNum =request.getParameter("pageNum"); //get방식으로 설정해서 가져오기 
			
			if(pageNum == null){
				pageNum="1"; //페이지 번호 없으면 무조건 1페이지로 하겠다 
			}
			// pageNum 정수형으로 변경(currentPage)
			int currentPage = Integer.parseInt(pageNum);
			
			// 페이징 처리할게 너무 많아서 DTO 따로 생성해서 담아옴 
			// request를 -> pageDTO에 저장 
			pageDTO.setPageSize(pageSize);
			pageDTO.setPageNum(pageNum);
			pageDTO.setCurrentPage(currentPage);
			
			BoardService boardService = new BoardService();
			String searchKeyword = request.getParameter("keyWord");
			
			List<BoardDTO> dtoList = boardService.getBoardList(pageDTO,searchKeyword);
			
			// getBoardCount() 메서드 호출
			int count = boardService.getBoardCount();
			
			// 한 화면에 보여줄 페이지 개수
			int pageBlock=3; //(1~10 / 11~20 / 21~30)
			int startPage = (currentPage-1)/pageBlock * pageBlock +1;
								// 0~9		/ 10 
			int endPage = startPage + pageBlock -1;

			int pageCount =count/pageSize +(count%pageSize==0?0:1); // 전체글 개수 DB에서 가져옴 
							//나머지가 없는 경우  //+남은 경우 삼항연산자로 값 저장 
			if(endPage > pageCount){//endPage > 전체 페이지번호
				endPage = pageCount; //endPage = 전체 페이지번호;
			}
			
			//가져온 목록 request 저장 
			pageDTO.setCnt(count);
			pageDTO.setPageBlock(pageBlock);
			pageDTO.setStartPage(startPage);
			pageDTO.setEndPage(endPage);
			pageDTO.setPageCount(pageCount);
			
			request.setAttribute("dtoList", dtoList);
			request.setAttribute("pageDTO", pageDTO);
			
			RequestDispatcher dis = request.getRequestDispatcher("board/gallary.jsp");
			dis.forward(request, response);
		}
	}// doProcess

}
