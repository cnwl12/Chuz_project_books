package com.itwillbs2.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import com.itwillbs2.dao.BookDAO;
import com.itwillbs2.domain.BookDTO;

public class BookService {
	
	// 메서드 정의
	
	// 회원가입 처리 insertMember 메서드 정의 
	public void insertMember(HttpServletRequest request) {
		
		try {
			//폼에서 입력한 내용이 서버에 전달되면 request내장객체 저장
			//post방식 request 한글처리 
			request.setCharacterEncoding("utf-8");
			//request에 저장된 id, pass, name 가져와서 변수에 저장
			String id = request.getParameter("id");
			String pass = request.getParameter("pass");
			String name = request.getParameter("name");
			//날짜 시스템 날짜 가져오기 (java.sql- import="java.sql.Timestamp)
			Timestamp date = new Timestamp(System.currentTimeMillis());
			
			// MemberDTO 객체생성 (기억장소 할당)
//			(dto :주소)  (new : 객체-id,pass,name 등 담겨 있음)
			BookDTO dto = new BookDTO();
			System.out.println("BookDTO 기억장소 주소 : " + dto);
			// MemberDTO 안에 있는 멤버변수 id,pass,name,date에 데이터 저장 
			// dto.id = id; (멤버변수 private으로 막혀있어서 접근 불가!) => set()통해서 값 전달 
			dto.setId(id);
			dto.setPass(pass);
			dto.setName(name);
			dto.setDate(date);
			
			// MemberDAO 객체를 생성해야 호출 가능(기억장소 할당)
			BookDAO dao = new BookDAO();
			System.out.println("BookDAO 기억장소 주소 : " + dao);
			// insertMember() 메서드 호출 

			// dao.insertMember(id,pass,name,date); // 주소통해 메서드 호출 후 리턴 
			dao.insertMember(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
	} //insertMember()

	public BookDTO userCheck(HttpServletRequest request) { //request 저장할 변수 Http ...  
		
		BookDTO memberDTO = null; //dto null 설정 
		
		try {
			// loginPro에서 가지고 옴 
			// 폼에서 입력한 내용을 서버에 전달 => request 내장객체 생성 및 요청 정보 저장 
			// request에서 id, pass값을 가져와서 => 변수에 저장 
			String id = request.getParameter("id");
			String pass = request.getParameter("pass");

			// MemberDAO 객체생성(기억장소 할당)
			MemberDAO dao = new MemberDAO();
			// 메서드 호출 (재사용)
			memberDTO = dao.userCheck(id, pass); // id,pass값 있으면 dto에 저장 | 없으면 null
//				일치 시 id,pw 주소값		 ㄴ dto : 리턴값
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally { //생략해도 됨 
			
		}
		return memberDTO;
		
	} // userCheck
	
	
} // 클래스
