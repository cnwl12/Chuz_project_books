package com.itwillbs2.domain;

import java.sql.Timestamp;

public class BoardDTO { //boarddto에 담아서 jsp에 전달 
	// 캡슐화 -> 멤버변수 생성 
	private int num;
	private String name;
	private String subject;
	private String content;
	private int readcount;
	private Timestamp date;
	//파일 추가
	private String file;
	
	// get/set 메서드 생성
	public int getNum() { //값 가져오고 
		return num;
	}
	public void setNum(int num) { // 값 저장하고 
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	
	
	
	
}
