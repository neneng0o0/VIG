package com.VIG.mvc.service.follow.Impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.follow.FollowDao;


@Repository("followDaoImpl")
public class FollowDaoImpl implements FollowDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public FollowDaoImpl() {
		
	}

	@Override
	public void addFollow(Map<String, Object> follow) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.insert("FollowMapper.addFollow", follow);
		
	}

	@Override
	public void deleteFollow(Map<String, Object> follow) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.delete("FollowMapper.deleteFollow", follow);
		
	}

	@Override
	public List<User> getFollowList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getFollowingList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}