package com.itwillbs2.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.itwillbs2.domain.BookDTO;

// DAO DB작업 분리 
public class BookDAO {
	
	// 디비연결 메서드
	public Connection getConnection() throws Exception {
		// 커넥션 풀(Connection pool) : 서버 연결정보 저장 
		// 톰캣에서 DBCP(DataBase ConnectionPool) API 사용
		// 자원의 이름 가져오는 자바 내장객체 InitialContext()
		Context init = new InitialContext();
		DataSource ds =(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
		
	}
	public void insertMember(BookDTO dto) { //회원가입만 처리할거니까 return안해도 됨
		
		try {
			Connection con = getConnection(); //리턴값 con이라서 
			
			//todo : sql 구문 정리하기 (파라미터 줄이기!!! )
			String sql=
					"insert into bmember(id, pass, name, phone, addressMain, addressSub, email, date)"
					+ " values(?,?,?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getPhone());
			pstmt.setString(5, dto.getAddressMain());
			pstmt.setString(6, dto.getAddressSub());
			pstmt.setString(7, dto.getEmail());
			pstmt.setTimestamp(8, dto.getDate());

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
		}
	}//
	
	//로그인 메서드 -사용자 체크	(id pass동일한지)				dto 받아서 해도 괜찮음 
	public BookDTO userCheck(String id, String pass) {
		
		BookDTO dto =null; 
		
		try {
			Connection con = getConnection(); 
			
			String sql = "select * from bmember where id=? and pass=?";
			//db에서 값 넣어서 실행해보면 일치하면 값 출력되고, 불일치 시 empty set으로 출력
			PreparedStatement pstmt = con.prepareStatement(sql);

			pstmt.setString(1,id);
			pstmt.setString(2,pass);

			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) { //DB에 정보있는지 조회 
				dto = new BookDTO(); //dto null이었는데 기억장소생성 
				dto.setId(rs.getString("id")); //db열에서 갖고와서(열 접근) dto에 담기 
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setAddressMain(rs.getString("addressMain"));
				dto.setAddressSub(rs.getString("addressSub"));
				dto.setDate(rs.getTimestamp("date"));
				
			}else	{ // (F)-> 아이디, 비밀번호 불일치
				dto = null; 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
		}
		return dto; //dto의 주소값
	}//
	
	public BookDTO getMember(String id) {
		BookDTO dto = null;
		
		try {
		Connection con	= getConnection();
		
		String sql="select * from bmember where id=?";

		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);

		ResultSet rs= pstmt.executeQuery();
		
		if(rs.next()) {// 아이디 존재
			
			dto = new BookDTO();//기억장소 할당 
			
			dto.setId(rs.getString("id")); 
			dto.setPass(rs.getString("pass"));
			dto.setName(rs.getString("name"));
			dto.setPhone(rs.getString("phone"));
			dto.setAddressMain(rs.getString("addressMain"));
			dto.setAddressSub(rs.getString("addressSub"));
			dto.setDate(rs.getTimestamp("date"));
		}else {
			// 아이디 부재 => null
		}
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
		}
		return dto; 
	} // getMember 메서드 끝
	
	public void updateMember(BookDTO updateDTO) {
		try {
			Connection con = getConnection();
			//todo : sql구문 수정 
			String sql = "update bmember set name=? where id =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1,updateDTO.getName()); //주소값을 통해 값을 가져옴
			pstmt.setString(2,updateDTO.getId());  
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 마무리
		}
	}//updateMember 메서드 끝 
	
	public void deleteMember(String id) {
		
		try {
			Connection con = getConnection(); //DB연결 
			
			String sql = "delete from bmember where id=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();			
		}finally {
			//select제외 return 값 없음 
		}
	}//deleteMember 메서드 끝 
	
	// todo : board 게시판 생성해야함 
	public List<BookDTO> getMemberList(){
		
		List<BookDTO> dtoList = new ArrayList<>();
		
		try {
			Connection con = getConnection(); //DB연결
			
			//sql 구문 실행 
			String sql = "select * from bmember";
			
			PreparedStatement pstmt = con.prepareStatement(sql);
			//4단계, sql구문 실행 , 저장
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BookDTO dto = new BookDTO(); // 작은 바구니에 담기
				dto.setId(rs.getString("id")); //열 접근
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getTimestamp("date"));
				// [ㅇㅁㅁㅁㅁㅁㅁㅁ]  
				dtoList.add(dto); //dto에 배열 저장 
				// 하나씩 저장하고 while 반복 // [ㅇㅇ...ㅁㅁㅁㅁㅁ]  
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
		}
		
		return dtoList;
	}// getMemberList() 메서드 끝 
	
}// 클래스
