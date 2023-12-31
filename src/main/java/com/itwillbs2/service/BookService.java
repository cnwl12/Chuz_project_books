package com.itwillbs2.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.itwillbs2.dao.BoardDAO;
import com.itwillbs2.dao.BookDAO;
import com.itwillbs2.domain.BookDTO;

public class BookService {
	
	
	// 회원가입 처리(insert)
	public void insertMember(HttpServletRequest request) {
		
		try {
			request.setCharacterEncoding("utf-8");
			// todo : 키 값 받기(hashmap) 등 정리하기 
			String id = request.getParameter("id");
			System.out.println(id);
			String pass = request.getParameter("pass");
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String addressMain =request.getParameter("addressMain"); // 도로명 주소
			String addressSub =request.getParameter("addressSub");
			Timestamp date = new Timestamp(System.currentTimeMillis());
			
			// MemberDTO 객체생성 (기억장소 할당)
			//(dto :주소)  (new : 객체-id,pass,name 등 담겨 있음)
			BookDTO dto = new BookDTO();
			
			dto.setId(id);
			dto.setPass(pass);
			dto.setName(name);
			dto.setPhone(phone);
			dto.setEmail(email);
			dto.setAddressMain(addressMain);
			dto.setAddressSub(addressSub);
			dto.setDate(date);

			// MemberDAO 객체를 생성해야 호출 가능(기억장소 할당)
			BookDAO dao = new BookDAO();
			// insertMember() 메서드 호출  // 회원가입 -> DB로 전달 
			dao.insertMember(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
	} //insertMember()

	// 회원 정보 조회(id, pass 있는지 조회 )
	public BookDTO userCheck(HttpServletRequest request) { //request 저장할 변수 Http ...  
		
		BookDTO bookDTO = null; 
		
		try {
			request.setCharacterEncoding("utf-8");
			
			String id = request.getParameter("id");
			String pass = request.getParameter("pass");

			BookDAO dao = new BookDAO();
			bookDTO = dao.userCheck(id, pass); // id,pass값 있으면 dto에 저장 | 없으면 null
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally { //생략해도 됨 
			
		}
		return bookDTO;
	} // userCheck 메서드 끝 
	
	
	public BookDTO getMember(String id) { //id 가져와서 회원정보 가져오기 
		
		BookDTO bookDTO = null;
		
		try { 
			BookDAO dao = new BookDAO();
			bookDTO = dao.getMember(id); 
			// 아이디 정보 가져오기 있다면 memberDTO에 담아서 가져옴, 없으면 null로 리턴
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
		}
		return bookDTO; //없으면 null로 return될것 ~ 
	} // getMember 메서드 끝
	
	
	// 회원정보 수정 
	public void updateMember(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");

			// request "id", "pass", "name" => 가져와서 => 변수에 저장 
			String id = request.getParameter("id");
			String pass = request.getParameter("pass");
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String addressMain = request.getParameter("addressMain");
			String addressSub = request.getParameter("addressSub");
			String email = request.getParameter("email");
			
			// 수정할 데이터를 하나의 바구니 저장 
			//set 메서드 호출 후 값 저장
			BookDTO bookDTO = new BookDTO();
			
			bookDTO.setId(id);
			bookDTO.setPass(pass);
			bookDTO.setName(name);
			//todo : DB에 주소, phone 컬럼 설정
			bookDTO.setPhone(phone);
			bookDTO.setAddressMain(addressMain);
			bookDTO.setAddressSub(addressSub);
			bookDTO.setEmail(email);
			
			BookDAO dao = new BookDAO();
			dao.updateMember(bookDTO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		
	} // updateMember 메서드 끝
	
	public void deleteMember(String id) {
		
		try {
			BookDAO dao = new BookDAO();

			dao.deleteMember(id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		
	}// deleteMember 회원정보 삭제 

	public List<HashMap<String, String>> getBookShelves(String id) {
		
		List<HashMap<String, String>> bookShelves = null;
		
		try {
			BookDAO bookDAO = new BookDAO();
			bookShelves = bookDAO.getBookShelves(id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
		
		}
		
		return bookShelves;
	}

	public boolean insertYn(HttpServletRequest request) {
		String id = (String) request.getSession().getAttribute("id");
		String isbn = request.getParameter("isbn");
		
		// MemberDAO 객체를 생성해야 호출 가능(기억장소 할당)
		BookDAO dao = new BookDAO();
		// insertMember() 메서드 호출  // 회원가입 -> DB로 전달 
		return dao.insertYN(id, isbn);
	}
	
	public void insertCheckBook(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String id = (String) request.getSession().getAttribute("id");
			String title = request.getParameter("title");
			String image = request.getParameter("image");
			String isbn = request.getParameter("isbn");
			//Timestamp date = new Timestamp(System.currentTimeMillis());	dao에서 해줄거에요
			
			HashMap<String, String> book = new HashMap<>();
			book.put("title", title);
			book.put("image", image);
			book.put("isbn", isbn);
			book.put("id", id);
			//book.put("date", date);
			
			
			// MemberDAO 객체를 생성해야 호출 가능(기억장소 할당)
			BookDAO dao = new BookDAO();
			// insertMember() 메서드 호출  // 회원가입 -> DB로 전달 
			dao.insertCheckBook(book);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
	}

	public void delLike(HttpServletRequest request) {
		try {
			String book_title = request.getParameter("bookShelf_title");
			
			BookDAO dao = new BookDAO();

			dao.delLike(book_title);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
} // 클래스
