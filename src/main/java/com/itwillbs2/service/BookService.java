package com.itwillbs2.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import com.itwillbs2.dao.BookDAO;
import com.itwillbs2.domain.BookDTO;

public class BookService {
	
	// 회원가입 처리(insert)
	public void insertMember(HttpServletRequest request) {
		
		try {
			request.setCharacterEncoding("utf-8");
			// todo : 키 값 받기(hashmap) 등 정리하기 
			String id = request.getParameter("id");
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
	
	
	
	
	
	
} // 클래스
