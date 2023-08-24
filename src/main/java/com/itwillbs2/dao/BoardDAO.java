package com.itwillbs2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.*;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.itwillbs2.domain.BoardDTO;

public class BoardDAO { 
	// public 리턴할형 메서드명(){}

	// 1-2단계) DB연결 커넥션 만들기 (con) 			// 예외 중복발생하는거 다 최상위로 예외처리 Exception
	public Connection getConnection() throws Exception{
		// 커넥션 풀(Connection pool) : 서버 연결정보 저장 
		// 톰캣에서 DBCP(DataBase ConnectionPool) API 사용 
		// 서버 context.xml 에 DB연결 자원이름 가져와서 사용
		Context init = new InitialContext();
		// 자원의 이름 가져오는 자바 내장객체 InitialContext()
		DataSource ds =(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
	}
	
	// dto 게시판 글 저장 
	public void insertBoard(BoardDTO dto) {
		Connection con = null; //try 밖에서도 쓰게 선언
		PreparedStatement pstmt = null;
		
		try {//1~4단계 sql 구문작성 및 db연결
			con = getConnection(); // DB연결 +
			// sql실행문						// 생략해도 되지만, 프로그램 가독성 등을 위해 작성이 좋음 
			String sql="insert into board(board_num,board_subject,board_content, board_name,board_readcount,board_file,board_date) values(?,?,?,?,?,?,?)";
			// 연결된 문자열 통해 들어온(sql) 실행정보 변수에 담기 pstmt(prepareStatement 담을 리턴형 연결 맞추기)
			pstmt = con.prepareStatement(sql);
			
			// ?에 채워넣을 값 가져오기 
			pstmt.setInt(1, dto.getBoard_num()); // 첫번째열에 , 주소값 dto에 저장된 num가져오기 
			pstmt.setString(2, dto.getBoard_subject());
			pstmt.setString(3, dto.getBoard_content());
			pstmt.setString(4, dto.getBoard_name());
			pstmt.setInt(5, dto.getBoard_readcount());
			pstmt.setString(6, dto.getBoard_file()); 
			pstmt.setTimestamp(7, dto.getBoard_date());  
			
			// 실행
			pstmt.executeUpdate(); 
			
		} catch (Exception e) {
			e.printStackTrace(); 
			
		}finally {
			// 기억장소 누적되면, 과부하 ---> 기억장소 해제 처리 
			//마무리 -> 기억장소 해제 -> 예외처리 (DB랑도 해제해야해서)
			if(pstmt !=null)try{pstmt.close();}catch(Exception ex){}
			if(con !=null)try{con.close();}catch(Exception ex){}
		}
		
	} // insertBoard() 메서드 끝 
	
	public int getMaxNum() { // 글넘버 +
		int board_num = 0; // 초기화
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {//1~4단계 sql 구문작성 및 db연결
			con = getConnection(); // DB연결
			
			//3 sql구문 
			String sql ="select max(board_num)from board"; 
			pstmt = con.prepareStatement(sql);
			
			//4 실행 -> 결과 저장
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { //5 결과접근 -> num에 저장 
				board_num = rs.getInt("max(board_num)"); //rs.getInt(1) - 1번열로 해도 됨 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs !=null) try {rs.close();} catch(Exception ex){}
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		
			
		}// 마무리
		return board_num;
	}//getMaxNum 메서드 
	
	// 메서드 정의 getBoardList()
	public List<BoardDTO> getBoardList(int startRow,int pageSize, String searchKeyword) { //List 배열에 <BoardDTO> 정보를 넘기겠다 
		//BoardDTO 게시판글을 배열에 담아서 리턴(큰틀)  //ArrayList 자식
		List<BoardDTO> dtoList = new ArrayList<>(); //arraylist는 10개 공간 생성 
		//큰바구니
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		
		try {//1~4단계 sql 구문작성 및 db연결
			con = getConnection(); // DB연결
			
			//3 sql구문 									//글순서 최신순으로 
			//(전체)String sql = "select * from board order by num desc"; // 모든 게시판 글 가지고 올거니까 
//			String sql = "select * from board order by board_num desc limit ?,?";
			
			// 제목 검색 키워드 있을 때 
			if(searchKeyword != null) {
			    sql = "select * from board where board_subject LIKE ? order by board_num desc limit ?,?";
			    pstmt = con.prepareStatement(sql);
			    pstmt.setString(1, "%" + searchKeyword + "%");
				pstmt.setInt(2,startRow-1); //limit문법 : 자르겠다(0<x<=1 : 처음 미포함해야지 1~10 : 10개 들어가게! )
				pstmt.setInt(3, pageSize); // 10개
			}else{
				sql = "select * from board order by board_num desc limit ?,?"; 
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,startRow-1); //limit문법 : 자르겠다(0<x<=1 : 처음 미포함해야지 1~10 : 10개 들어가게! )
				pstmt.setInt(2, pageSize); // 10개
			}
			
			System.out.println(searchKeyword);
			
			//실행 -> 저장 
			rs = pstmt.executeQuery(); 
			
			while(rs.next()){
				// 하나의 글 행 -> 열 -> dto에 담기(하나의 글 저장)
				BoardDTO dto = new BoardDTO(); // 작은바구니에 담기 
				dto.setBoard_num(rs.getInt("board_num")); // 열접근 
				dto.setBoard_subject(rs.getString("board_subject"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_name(rs.getString("board_name"));
				dto.setBoard_readcount(rs.getInt("board_readcount"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_date(rs.getTimestamp("board_date"));
				// 큰바구니 배열에 게시판 글 하나 저장 [ㅇㅁㅁㅁㅁㅁㅁㅁ]  
				dtoList.add(dto); //배열 저장 add메서드 사용 
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리	
			if(rs !=null) try {rs.close();} catch(Exception ex){}
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
		
		System.out.println(dtoList);
		return dtoList;
	}//getBoardList()메서드 끝 
	
	public BoardDTO getBoard(int board_num) { // 글목록 가져오기 
		//try밖에서도 쓸 수 있게 try밖에서 선언
		BoardDTO dto = null; //num있거나 없거나 상관없이 기억장소 공간 만들겠다 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection(); // DB연결
			
			// String sql = "select * from board where board_num=?";
			//String sql = "SELECT *,  (SELECT  board_num FROM board WHERE board_num < 1 LIMIT1), (SELECT  board_num FROM board WHERE board_num > 1 LIMIT1)  FROM board_num = ?";
			// String sql = "SELECT *, (SELECT board_num FROM board WHERE board_num < 1 LIMIT 1),  (SELECT board_num FROM board WHERE board_num > 1 LIMIT 1)  FROM board  WHERE board_num = ?";
			String sql = "SELECT *, (SELECT board_num FROM board WHERE board_num < ? ORDER BY board_num DESC LIMIT 1) AS prev_num,  (SELECT board_num FROM board WHERE board_num > ? LIMIT 1) AS next_num FROM board WHERE board_num = ?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1,board_num); // 메서드명에 num으로 받아왔으니까 
			pstmt.setInt(2, board_num);
			pstmt.setInt(3, board_num);
			
			rs= pstmt.executeQuery(); // 실행 
			
			//하나밖에 없어서 if써도 됨(while도 가능)
			if(rs.next()) { //num에 접근해서 가지고 있는정보들 저장해서 dto에 저장 
				dto = new BoardDTO();
				
				dto.setBoard_num(rs.getInt("board_num")); // 열접근 
				dto.setBoard_subject(rs.getString("board_subject"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_name((rs.getString("board_name")));
				dto.setBoard_readcount(rs.getInt("board_readcount"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_date(rs.getTimestamp("board_date"));
				
				// 이전글, 다음글 
				dto.setPrev_num(rs.getInt("prev_num"));
				dto.setNext_num(rs.getInt("next_num"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리 
			if(rs !=null) try {rs.close();} catch(Exception ex){}
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
		
		return dto;
		
		
	} //getBoard 메서드 마무리 
	
	public void updateBoard(BoardDTO dto) { // 리턴할형 없으니까 
	// 기존 파일 업로드 메서드 	
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "update board set board_subject=?, board_content=? where board_num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1,dto.getBoard_subject());
			pstmt.setString(2,dto.getBoard_content());
			pstmt.setInt(3,dto.getBoard_num());
			
			pstmt.executeUpdate(); // update 실행 
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
	}//updateBoardDTO 메서드 마무리 
	
	public void deleteBoard(int board_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection(); // DB연결
			
			//SQL 구문 
			String sql = "delete from board where board_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,board_num);
			
			pstmt.executeUpdate(); //delete 실행
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 마무리
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
	} //deleteBoard 메서드 끝
	
	
	
	public void deleteComment(int comment_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection(); // DB연결
			
			//SQL 구문 
			String sql = "delete from comment where comment_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,comment_num);
			
			pstmt.executeUpdate(); //delete 실행
			System.out.println("행실");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 마무리
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
	}
	
	
	public void updateReadcount(int board_num) { 
		// 파라미터 dto로 가져와도 되는데, where 조건이 num만 일치하면 readcount 자동으로 증가라 
		// 굳이 dto로 만들어서 가져올 필요없음. 
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "update board set board_readcount=board_readcount+1 where board_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 마무리
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
	}//updateReadcount 메서드 끝
	
	public int getBoardCount(){
		int count =0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select count(*) from board";
			pstmt=con.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) {
				count = rs.getInt("count(*)"); // 1 해서 1번열 가져와도 됨 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {//예외처리 
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
			if(rs !=null) try {rs.close();} catch(Exception ex){}
		}
		
		return count;
		
		
	}//getgetBoardCount 끝
	
	public void fupdateBoard(BoardDTO dto) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();	
										//num일치를 찾아서 subject, content, file을 수정할 것임 					
			String sql = "update board set board_subject=?, board_content=?, board_file=? where board_num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,dto.getBoard_subject());
			pstmt.setString(2, dto.getBoard_content());
			pstmt.setString(3, dto.getBoard_file());
			pstmt.setInt(4,dto.getBoard_num());
			
			pstmt.executeUpdate(); // update 실행 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
		
	}//fupdateBoard 메서드 마무리 
	
	
	
	public void insertComment(HashMap<String, String> comment ) {
		
		// comment.get("board_num"); 
		// HashMap<String, String> comment, 
		Connection con = null; 
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection(); 
			// sql실행문						// 생략해도 되지만, 프로그램 가독성 등을 위해 작성이 좋음 
			String sql="insert into comment(board_num,comment_num,comment_id, comment_text) values(?,?,?,?)";
			// 연결된 문자열 통해 들어온(sql) 실행정보 변수에 담기 pstmt(prepareStatement 담을 리턴형 연결 맞추기)
			pstmt = con.prepareStatement(sql);
			
			// ?에 채워넣을 값 가져오기 
			pstmt.setInt(1, Integer.parseInt(comment.get("board_num"))); // 첫번째열에 , 주소값 dto에 저장된 num가져오기 
			pstmt.setInt(2, Integer.parseInt(comment.get("comment_num"))); 
			pstmt.setString(3, comment.get("comment_id"));
			pstmt.setString(4, comment.get("comment_text"));
			
			// 실행
			pstmt.executeUpdate(); 
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			if(pstmt !=null)try{pstmt.close();}catch(Exception ex){}
			if(con !=null)try{con.close();}catch(Exception ex){}
		}
		
	} // insertComment() 
	
	public String getMaxNum_comment() { // 댓글 숫자 +
		int comment_num = 0; // 초기화
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {//1~4단계 sql 구문작성 및 db연결
			con = getConnection(); // DB연결
			
			//3 sql구문 
			String sql ="select max(comment_num)from comment"; 
			pstmt = con.prepareStatement(sql);
			
			//4 실행 -> 결과 저장
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { //5 결과접근 -> num에 저장 
				comment_num = rs.getInt("max(comment_num)"); //rs.getInt(1) - 1번열로 해도 됨 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs !=null) try {rs.close();} catch(Exception ex){}
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		
			
		}// 마무리
		return (comment_num + 1) + "";
	}//getMaxNum 메서드 

	public List<HashMap<String, String>> getCommentList(int board_num) {
		
		List<HashMap<String, String>> commentList = new ArrayList<>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = getConnection();
			
			String sql = "select * from comment where board_num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,board_num);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				
				HashMap<String, String> comment = new HashMap<String, String>(); // 작은바구니 타입
				
//				comment.put("board_num", board_num); // 화면에 보여줄 필요가 없어서 put no
				comment.put("comment_num", rs.getInt("comment_num")+"");
				comment.put("comment_id", rs.getString("comment_id"));
				comment.put("comment_text", rs.getString("comment_text"));
				comment.put("comment_date", rs.getString("comment_date"));
				
				commentList.add(comment);
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		
		}finally {
			if(rs !=null) try {rs.close();} catch(Exception ex){}
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
		
		return commentList;
	}
	
	
	
	
	
}
