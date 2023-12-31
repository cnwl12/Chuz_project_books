package com.itwillbs2.domain;

import java.sql.Timestamp;

public class BoardDTO { //boarddto에 담아서 jsp에 전달 
	// 캡슐화 -> 멤버변수 생성 
	private int board_num;
	private String board_subject;
	private String board_content;
	private String board_name;
	private int board_readcount;
	private int board_recommend;
	private String board_file;
	private Timestamp board_date;
	
	// 넘길페이지 
	private int prev_num; 
	private int next_num;
	
	// get/set 메서드 생성
	
	
	public int getBoard_num() {
		return board_num;
	}
	
	public int getPrev_num() {
		return prev_num;
	}

	public void setPrev_num(int prev_num) {
		this.prev_num = prev_num;
	}

	public int getNext_num() {
		return next_num;
	}

	public void setNext_num(int next_num) {
		this.next_num = next_num;
	}

	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_subject() {
		return board_subject;
	}
	public void setBoard_subject(String board_subject) {
		this.board_subject = board_subject;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public int getBoard_readcount() {
		return board_readcount;
	}
	public void setBoard_readcount(int board_readcount) {
		this.board_readcount = board_readcount;
	}
	public int getBoard_recommend() {
		return board_recommend;
	}
	public void setBoard_recommend(int board_recommend) {
		this.board_recommend = board_recommend;
	}
	public String getBoard_file() {
		return board_file;
	}
	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}
	public Timestamp getBoard_date() {
		return board_date;
	}
	public void setBoard_date(Timestamp board_date) {
		this.board_date = board_date;
	}
	
	
}
