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
// member 관련 주제로 DB생성 예정
public class BookDAO {
	
	// 디비연결 메서드
	public Connection getConnection() throws Exception {
		// 예외처리 중복되어서 호출한 곳에서 예외처리를 하게 함 throws Exception (함수 호출한 곳으로)
		
//		//1)JDBC 프로그램(Driver.class) 불러오기
//		//(폴더 com.mysql.cj.jdbc 파일이름 Driver.class) 불러오기 
//		Class.forName("com.mysql.cj.jdbc.Driver");  // 외부 파일 연결이라 에러 
//
//		//2)JDBC 이용해서 데이터베이스 연결(DB주소, DB아이디, DB비밀번호) => 연결정보 저장 
//		String dbUrl="jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC";
//		String dbUser="root";
//		String dbPass="1234";
//
//		Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
//		
//		return con;
		
		// 커넥션 풀(Connection pool) : 서버 연결정보 저장 
		// 톰캣에서 DBCP(DataBase ConnectionPool) API 사용 
		// 서버 context.xml 에 DB연결 자원이름 가져와서 사용
		Context init = new InitialContext();
		// 자원의 이름 가져오는 자바 내장객체 InitialContext()
		DataSource ds =(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
		
	}
	
	//String id,String pass,String name,Timestamp date 개별로 넣을 때 
	//	System.out.println("받은 이름 : " + name);
	
	// 디비연결해서 회원가입하는 기능을 만듦 -> 자바파일 안에 메서드 정의
	/* public 리턴할형 메서드명() {	   }*/
	// public void insertMember(MemberDTO를 주소를 저장하는 변수)
							//형			주소	
	public void insertMember(BookDTO dto) { //회원가입만 처리할거니까 return안해도 됨
		System.out.println("BookDAO insertMember()호출");
		System.out.println("받은 BookDTO의 주소" + dto);
		System.out.println("받은 아이디 : " + dto.getId()); //private걸려있어서 get으로 가져오기 
		System.out.println("받은 비밀번호 : " + dto.getPass());
		System.out.println("받은 이름 : " + dto.getName());
		System.out.println("받은 날짜 : " + dto.getDate());
		
		try {
			// 에러 발생 가능성이 높은 코드
			Connection con = getConnection(); //리턴값 con이라서 
			// 메서드 호출 (1,2단계 메서드로 분리되어서 호출만 가능) 

			// 3)연결정보를 이용해서 SQL구문 생성
			String sql="insert into members(id, pass, name, date) values(?,?,?,?)";
			//SQL구문 만드는 내장객체 변수 = con.prepareStatement(sql구문 문자열);
			//java.sql.PreparedStatement 자바내장객체  : SQL 구문 만드는 내장객체 
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			// ?? 채우기
			//4)SQL 구문 실행(Insert, Update, Delete)
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setTimestamp(4, dto.getDate());

			pstmt.executeUpdate();
			 //변수 pstmt 메서드 호출 
		} catch (Exception e) {
			// 에러 메시지
			e.printStackTrace();
		}finally {
			// 마무리
		}
	}//
	
	//로그인 메서드 -사용자 체크	(id pass동일한지)				dto 받아서 해도 괜찮음 
	public BookDTO userCheck(String id, String pass) {
		
		BookDTO dto =null; //Bookdto 선언 (if 문 밖에서도 쓸 수 있게)
		try {
			//1)프로그램 불러오기 
			//자바내장객체 ("mysql제공 내장객체 -- 회사에서 쓰는거 찾아서 써야함 ")
			//2)JDBC 이용해서 데이터베이스 연결(DB주소, DB아이디, DB비밀번호) => 연결정보 저장 
			Connection con = getConnection(); // 1-2단계 생략 
			
			//3)연결정보를 이용해서 SQL구문 생성
//				select * from 테이블 where 조건열=값 and 조건열 = 값
			//  35구문에서 id, pass가 일치하는지 확인 여부는 db에서 실행 후 돌아옴 
			String sql = "select * from members where id=? and pass=?";
			//db에서 값 넣어서 실행해보면 일치하면 값 출력되고, 불일치 시 empty set으로 출력
			PreparedStatement pstmt = con.prepareStatement(sql);

			pstmt.setString(1,id);
			pstmt.setString(2, pass);

			//4) sql 구문실행 (select) .executeQuery() => 결과 저장
			ResultSet rs = pstmt.executeQuery();

			//5) 결과접근 -> if 행 (T)-> 아이디, 비번 일치 -> 출력
//						  else행 (F)-> 아이디, 비밀번호 불일치 -> 출력
			if(rs.next()) {
				// (T)-> 아이디, 비번 일치 => MemberDTO DB에 있는 id,pass,name, date 담아서 전달 
				// (DTO에 담아서 일치한 정보 가져오기) 
				// MemberDTO 객체생성 (기억장소)
				dto = new BookDTO(); //dto null이었는데 기억장소생성 
				dto.setId(rs.getString("id")); //db열에서 갖고와서(열 접근) dto에 담기 
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getTimestamp("date"));
				
			}else	{
				// (F)-> 아이디, 비밀번호 불일치
				// => MemberDTO 비어있는 값 null 전달 
				dto = null; // 초기값 위에서 null로 해서 따로 안해도 됨 (이해위해 작성)
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
			//1,2 디비연결
		Connection con	= getConnection();
		
		//3단계 연결정보 이용해서 sql 구문 제작 (id 일치 여부)
		String sql="select * from members where id=?";

		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);

		//4단계 execute 실행 및 결과 저장 
		ResultSet rs= pstmt.executeQuery();
		
		//5단계 
		if(rs.next()) {
			// 아이디 존재
			dto = new BookDTO();//기억장소 할당 
			dto.setId(rs.getString("id")); //db열에서 갖고와서(열 접근) dto에 담기 
			dto.setPass(rs.getString("pass"));
			dto.setName(rs.getString("name"));
			dto.setDate(rs.getTimestamp("date"));
			
		}else {
			// 아이디 부재 => null
		}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
		}
		return dto; //없으면 null로 return될것 ~ 
	} // getMember 메서드 끝
	
	
			//insert, update, delete --> executeupdate & 리턴없음 (select는 있음)					
	public void updateMember(BookDTO updateDTO) {
		try {
			// 1,2 DB연결
			Connection con = getConnection();
			
			// 3단계 sql 구문 생성(update)
			String sql = "update members set name=? where id =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			//					191받은 변수 updateDTO 통해서 접근 
			pstmt.setString(1,updateDTO.getName()); //주소값을 통해 값을 가져옴
			pstmt.setString(2,updateDTO.getId());  
			// 4단계 실행 executeupdate
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 마무리
		}
		
	}//updateMember 메서드 끝 
	
	/* public 리턴할형 메서드명() {	   }*/
	public void deleteMember(String id) {
			//리턴값 void라 따로 dto null값 초기화할 필요 없음 
		
		try {
			Connection con = getConnection(); //DB연결 
			
			//3단계 sql 구문 -삭제 실행 
			String sql = "delete from members where id=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();			
		}finally {
			//select제외 return 값 없음 
		}
		
	}//deleteMember 메서드 끝 
	
	
	public List<BookDTO> getMemberList(){
		
		List<BookDTO> dtoList = new ArrayList<>();
		
		try {
			Connection con = getConnection(); //DB연결
			
			//sql 구문 실행 
			String sql = "select * from members";
			
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
