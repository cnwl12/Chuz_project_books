package com.itwillbs2.domain;

import java.sql.Timestamp;

public class BookDTO {
	// MemberDTO (데이터묶음) : Member데이터 저장 => 전달 
	// 멤버변수 (계속 추가 가능) -> 데이터 은닉(캡슐화 적용)
	private String id;
	private String pass;
	private String name;
	private String phone;
	private String email;
	private String addressMain; // 도로명 주소
	private String addressSub;	// 상세주소 
	private Timestamp date; 	// 가입일
	
	//todo: 회원번호 autoincrement 부여 설정하기 -> db
	
	// 메서드() set(저장)/get(가져오기) 메서드 생성(alt shift s -> R)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddressMain() {
		return addressMain;
	}
	public void setAddressMain(String addressMain) {
		this.addressMain = addressMain;
	}
	public String getAddressSub() {
		return addressSub;
	}
	public void setAddressSub(String addressSub) {
		this.addressSub = addressSub;
	}
	
	
	
}
