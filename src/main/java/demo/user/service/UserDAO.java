package demo.user.service;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("userDAO")
public class UserDAO extends EgovAbstractDAO {

	public String insertUser(UserVO vo) throws Exception {
		return (String) insert("userDAO.insertUser", vo);
	}
}
