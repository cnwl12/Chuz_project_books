package com.itwillbs2.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.itwillbs2.domain.*;

public class BoardDAO { 
	// public 리턴할형 메서드명(){}

	// 1-2단계) DB연결 커넥션 만들기 (con) 			// 예외 중복발생하는거 다 최상위로 예외처리 Exception
	public Connection getConnection() throws Exception{
//		
//		Class.forName("com.mysql.cj.jdbc.Driver");
//		
//		String dbUrl="jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC";
//		String dbUser="root";
//		String dbPass="1234";
//
//		Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
//		
//		return con; // 연결주소값 리턴
		// 서버에서 (context.xml) DB연결 처리해버림 
		
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
		System.out.println("BoardDAO insertBoard()"); //연결되는지 확인
		Connection con = null; //try 밖에서도 쓰게 선언
		PreparedStatement pstmt = null;
		
		try {//1~4단계 sql 구문작성 및 db연결
			
			//선언부 삭제 
			con = getConnection(); // DB연결 +
			// sql실행문						// 생략해도 되지만, 프로그램 가독성 등을 위해 작성이 좋음 
			String sql="insert into board(num,name,subject,content,readcount,date,file) values(?,?,?,?,?,?,?)";
			// 연결된 문자열 통해 들어온(sql) 실행정보 변수에 담기 pstmt(prepareStatement 담을 리턴형 연결 맞추기)
			pstmt = con.prepareStatement(sql);
			
			// ?에 채워넣을 값 가져오기 
			pstmt.setInt(1, dto.getNum()); // 첫번째열에 , 주소값 dto에 저장된 num가져오기 
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getReadcount());
			pstmt.setTimestamp(6, dto.getDate()); // ? 채우기 
			pstmt.setString(7, dto.getFile()); // file 추가 
			
			
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
	
	public int getMaxNum() {
		int num = 0; // 초기화
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {//1~4단계 sql 구문작성 및 db연결
			con = getConnection(); // DB연결
			
			//3 sql구문 
			String sql ="select max(num)from board"; 
			pstmt = con.prepareStatement(sql);
			
			//4 실행 -> 결과 저장
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { //5 결과접근 -> num에 저장 
				num = rs.getInt("max(num)"); //rs.getInt(1) - 1번열로 해도 됨 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs !=null) try {rs.close();} catch(Exception ex){}
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		
			
		}// 마무리
		return num;
	}//getMaxNum 메서드 
	
	// 메서드 정의 getBoardList()
	public List<BoardDTO> getBoardList(int startRow,int pageSize) { //List 배열에 <BoardDTO> 정보를 넘기겠다 
		//BoardDTO 게시판글을 배열에 담아서 리턴(큰틀)  //ArrayList 자식
		List<BoardDTO> dtoList = new ArrayList<>(); //arraylist는 10개 공간 생성 
		//큰바구니
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {//1~4단계 sql 구문작성 및 db연결
			con = getConnection(); // DB연결
			
			//3 sql구문 									//글순서 최신순으로 
		//(전체)String sql = "select * from board order by num desc"; // 모든 게시판 글 가지고 올거니까 
			String sql = "select * from board order by num desc limit ?,?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,startRow-1); //limit문법 : 자르겠다(0<x<=1 : 처음 미포함해야지 1~10 : 10개 들어가게! )
			pstmt.setInt(2, pageSize); // 10개

			//실행 -> 저장 
			rs = pstmt.executeQuery(); 
			
			while(rs.next()){
				// 하나의 글 행 -> 열 -> dto에 담기(하나의 글 저장)
				BoardDTO dto = new BoardDTO(); // 작은바구니에 담기 
				dto.setNum(rs.getInt("num")); // 열접근 
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setDate(rs.getTimestamp("date"));
				dto.setReadcount(rs.getInt("readcount"));
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
		
		return dtoList;
	}//getBoardList()메서드 끝 
	
	public BoardDTO getBoard(int num) { // 글목록 가져오기 
		//try밖에서도 쓸 수 있게 try밖에서 선언
		BoardDTO dto = null; //num있거나 없거나 상관없이 기억장소 공간 만들겠다 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection(); // DB연결
			
			String sql = "select * from board where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1,num); // 메서드명에 num으로 받아왔으니까 
			
			rs= pstmt.executeQuery(); // 실행 
			
			//하나밖에 없어서 if써도 됨(while도 가능)
			if(rs.next()) { //num에 접근해서 가지고 있는정보들 저장해서 dto에 저장 
				dto = new BoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setDate(rs.getTimestamp("date"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				// file 추가 
				dto.setFile(rs.getString("file"));
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
			
			String sql = "update board set subject=?, content=? where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,dto.getSubject());
			pstmt.setString(2,dto.getContent());
			pstmt.setInt(3,dto.getNum());
			
			pstmt.executeUpdate(); // update 실행 
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
	}//updateBoardDTO 메서드 마무리 
	
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection(); // DB연결
			
			//SQL 구문 
			String sql = "delete from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			
			pstmt.executeUpdate(); //delete 실행
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 마무리
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
	} //deleteBoard 메서드 끝
	
	public void updateReadcount(int num) { 
		// 파라미터 dto로 가져와도 되는데, where 조건이 num만 일치하면 readcount 자동으로 증가라 
		// 굳이 dto로 만들어서 가져올 필요없음. 
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "update board set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
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
			String sql = "update board set subject=?, content=?, file=? where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,dto.getSubject());
			pstmt.setString(2,dto.getContent());
			pstmt.setString(3, dto.getFile());
			pstmt.setInt(4,dto.getNum());
			
			pstmt.executeUpdate(); // update 실행 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt !=null) try {pstmt.close();} catch(Exception ex){}
			if(con !=null) try {con.close();} catch(Exception ex){}
		}
		
	}//fupdateBoard 메서드 마무리 
	
}
