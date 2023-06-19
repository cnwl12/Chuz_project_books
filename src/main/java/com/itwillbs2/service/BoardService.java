package com.itwillbs2.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import com.itwillbs2.dao.*;
import com.itwillbs2.domain.*;

public class BoardService {

	public void insertBoard(HttpServletRequest request) {
		
		try {
			request.setCharacterEncoding("utf-8");
			
			String name = request.getParameter("name");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");

			// 글번호 num => 구해주기 => /*일단 수동으로 1씩 넣어서 작업 */
			int num = 1; 
			// 조회수 readcount => 0 설정(작성전까진 아무도 못보니까)
			int readcount = 0;
			// 작성일 date	=> 현시스템 날짜,시간 가져오기		//시스템 날짜 가져오기 
			Timestamp date = new Timestamp(System.currentTimeMillis());
			
			// BoardDTO 객체생성(기억장소 할당)
			BoardDTO dto = new BoardDTO();
			// "set메서드" 호출해서 폼에서 가져온 값을 "저장" 
			dto.setNum(num);
			dto.setName(name);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setReadcount(readcount);
			dto.setDate(date);
			
			//사용 시 
			// BoardDAO 객체생성(기억장소 할당)
			BoardDAO dao = new BoardDAO();
			
			num = dao.getMaxNum()+1;
			//num중 가장 큰 번호 +1 해서 num에 저장하겠다는 뜻 
			dto.setNum(num); // 바구니에 저장 		

			// insertBoard(바구니 주소)메서드 호출해서 디비에 게시판 글 저장 
			dao.insertBoard(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
	} //insertBoard
	
	public List<BoardDTO> getBoardList(PageDTO pageDTO) {
		
		List<BoardDTO> dtoList = null;
		
		try {
			// BoardDAO 객체생성			//BoardDTO는 1개만 가져오겠다는 것 
			BoardDAO dao = new BoardDAO();
			int currentPage = pageDTO.getCurrentPage();
			int pageSize = pageDTO.getPageSize();
			
			// int startRow = 식 구하기;
			// pageNum(currentPage) pageSize => startRow
//			 			1(2)(3)			10	 =>  0+1=>1(10+1=>11)(20+1=>21)	
			int startRow =(currentPage-1) * pageSize +1;
							//get으로 안져오고 위에서 변수로 저장해서 가지고 와도 됨  
			
			// (시작행부터 ~ 끝행까지)
			// 끝행 endRow 식 구하기 
//			 			startRow 	pageSize => endRow
//			 			1(11)(21)	 10		 =>  10 (20) (30)	
			int endRow = (startRow + pageSize -1);

			// 리턴할형 메서드명() 메서드 정의 : List<BoardDTO> getBoardList() 
										// 자바 배열 내장객체 인터페이스 List 클래스 ArrayList
										// cf) 기존배열 -> 처음 기억장소 할당 시 처음 크기 그대로 사용 
			// => ArrayList 자바내장객체 : 기억장소 할당 10개 기억장소 할당 + *"추가 10개씩 증가"* 
			// List<BoardDTO> dtoList = getBoardList()메서드 호출 
			//List<BoardDTO> dtoList =dao.getBoardList();
							// 배열 -> for문 사용  
							//(게시판 목록-- 페이지 자르지않아서 전체목록 전부 나타나서 서버 과부하)

			// select * from board order by num desc limt 시작행-1, 10개
			dtoList =dao.getBoardList(startRow,pageSize);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
		}
		return dtoList;
	}//getBoardList

	public int getBoardCount(){
		int count = 0;
		try {
			// BoardDAO 객체생성  -> 호출 
			BoardDAO dao = new BoardDAO();
			count = dao.getBoardCount();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		
		return count;
	} //getBoardCount()
	
	public BoardDTO getBoard(HttpServletRequest request) {
		
		BoardDTO dto = null;
		
		try {
			  // 사용자가 가져온 num = 1 값을 서버에 전달 -> request 내장객체 저장(글 바뀌니까 / 세션에 저장 안해도됨 )
			  // request(String 형)에서 num파라미터 이름에 해당하는 값을 가져오기 
			  // 정수형으로 <- 문자열을 
			  int num = Integer.parseInt(request.getParameter("num")); // BoardDAO 객체생성
			  BoardDAO dao = new BoardDAO();
			 
			  // 글 내용보기 -> 게시판 글 조회수 1 증가 (조회수 1증가해서 수정) // 리턴할 형 없음(조회만하고 끝나서)
			  // updateReadcount(int num) 메서드 정의 
			  // update board set readcount=? where num=?
			  // readcount를 수정할건데 조건은 num=? // update board set readcount=readcount+1 where  num=?
			  // 기존값에 +1 증가
			  dao.updateReadcount(num);
			  
			  // 리턴할 형 BoardDTO 메서드형 getBoard(int num)메서드 정의 BoardDTO dto =
			  dto = dao.getBoard(num); // select * from board where num=? (num에대한 전부) 
			  // BoardDTO  dto = getBoard(num)메서드호출 
			  // 글목록 전체가져올건데 따로 하나씩 말고, dto 바구니에 담아서 가져오기
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		
		return dto;
		
	} // getBoard



}