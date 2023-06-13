package com.itwillbs2.domain;

import java.sql.Timestamp;

public class BookDTO {
	// MemberDTO (데이터묶음) : Member데이터 저장 => 전달 
	// 멤버변수 (계속 추가 가능) -> 데이터 은닉(캡슐화 적용)
	private String id;
	private String pass;
	private String name;
	private Timestamp date;
	
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
	
	
	
}
