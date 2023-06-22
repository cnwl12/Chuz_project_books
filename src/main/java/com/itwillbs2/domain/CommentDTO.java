package com.itwillbs2.domain;

import java.sql.Timestamp;

public class CommentDTO {

	private Timestamp comment_date;
	private String comment_text;
	private int comment_like;
	private String comment_file;
	
	// G + S
	public Timestamp getComment_date() {
		return comment_date;
	}
	public void setComment_date(Timestamp comment_date) {
		this.comment_date = comment_date;
	}
	public String getComment_text() {
		return comment_text;
	}
	public void setComment_text(String comment_text) {
		this.comment_text = comment_text;
	}
	public int getComment_like() {
		return comment_like;
	}
	public void setComment_like(int comment_like) {
		this.comment_like = comment_like;
	}
	public String getComment_file() {
		return comment_file;
	}
	public void setComment_file(String comment_file) {
		this.comment_file = comment_file;
	}
	
	
	
}
