package com.VIG.mvc.service.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Comment {

	private int commentId;
	private int feedId;
	private String commentText;
	private User user;
	private Date regDate;
	private Date editDate;
	
	public Comment() {
		// TODO Auto-generated constructor stub
	}

}