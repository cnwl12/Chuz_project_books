package com.itwillbs2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itwillbs2.domain.*;
import com.itwillbs2.service.*;

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
		// 가상주소 뽑아오기 getServletPath(); 
		String strPath = request.getServletPath(); 
		
		if(strPath.equals("/write.bo")) { // 뽑아온 주소는 앞에 / 
			// 글쓰기 화면 - board/write.jsp
			RequestDispatcher dis = request.getRequestDispatcher("board/write.jsp");
			dis.forward(request, response);
		}
		
		if(strPath.equals("/writePro.bo")) {
			// pro 실행할 BoardService 객체생성 
			BoardService boardService = new BoardService();
			boardService.insertBoard(request);
			
			// 글목록 이동
			response.sendRedirect("list.bo");
		}
		
		if(strPath.equals("/list.bo")) { //list.jsp과정 하나씩 줄여감
			// pageDTO 객체생성  
			PageDTO pageDTO = new PageDTO();
			
			// 한 페이지에 보여줄 글 개수 설정 
			int pageSize = 2;
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
			// DB에서 가져올 행번호 구하기(구한 행(시작행)부터 ~ pageSize10개 ) 
			// mysql 이렇게 해도 됨-> limit문법: limit 시작행-1, 10개
			
			//DB에서 글목록 가져오기 
			//BoardService 객체생성 
			BoardService boardService = new BoardService();
			List<BoardDTO> dtoList = boardService.getBoardList(pageDTO);
			
			// getBoardCount() 메서드 정의
			// getBoardCount() 메서드 호출
			int count = boardService.getBoardCount();
			
			// 한 화면에 보여줄 페이지 개수
			int pageBlock=3; //(1~10 / 11~20 / 21~30)

			// 시작하는 페이지번호 구하기
//			   currentPage		 pageBlock => startPage
//			 	1~10 (0~9)			10	   =>  	(0*10)+1-> 	 1
//				11~20(10~19)		10	   => 	(1*10)+1->  11	
//				21~30(20~29)		10	   => 	(2*10)+1->  21	
			int startPage = (currentPage-1)/pageBlock * pageBlock +1;
								// 0~9		/ 10 

			// 끝나는 페이지번호 구하기 
			// 끝행 endRow 식 구하기 
//			 			startPage 	pageBlock 	 => endPage
//			 			1(11)(21)	  10		 =>  10 (20) (30)	
			int endPage = startPage + pageBlock -1;
			// 계산으로 끝나는 페이지번호 => 실제 있는 전체 페이지 번호 비교 
			// 끝나는 페이지번호 구한값(10) => 2(실제 있는 전체 페이지) 와 비교
			// 계산으로 끝나는 페이지번호 구한값(10)이 더 크면 => 실제 페이지(2)로 변경

			// 실제 있는 전체 페이지 번호 구하기 
			// 50개 글, 10개씩 조회 -> 5페이지 + =>5
			// 55개 글, 10개씩 조회 -> 5페이지 + 5개 글 => 6 (페이지+1)

			// 전체 글개수 구하기 select count(*)from board;
			// public int getgetBoardCount(){} //전체니까 값 받지 않을거임 


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
		
		if(strPath.equals("/content.bo")) {
			// BoardService 객체생성
			BoardService boardService = new BoardService();
			BoardDTO dto = boardService.getBoard(request); // 메서드 호출
			
			request.setAttribute("dto", dto); //request에 저장 
			
			// content.jsp로 이동 (주소변동 없이) 
			RequestDispatcher dis = request.getRequestDispatcher("board/content.jsp");
			dis.forward(request, response);
			
		}// getBoard()
		
		
	}// doProcess
	

}
