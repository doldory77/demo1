package demo.user.service;

import org.springframework.stereotype.Repository;

import demo.cmmn.service.PathVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("userDAO")
public class UserDAO extends EgovAbstractDAO {

	public String insertUser(UserVO vo) throws Exception {
		return (String) insert("userDAO.insertUser", vo);
	}
	
	public PathVO selectUserAuthApi(EgovMap params) throws Exception {
		return (PathVO) select("userDAO.selectUserAuthApi", params);
	}
	
	public UserVO selectUserByIdAndPasswd(EgovMap params) throws Exception {
		return (UserVO) select("userDAO.selectUserByIdAndPasswd", params);
	}
	
	public UserVO selectUserBySessionKey(String sessionKey) throws Exception {
		return (UserVO) select("userDAO.selectUserBySessionKey", sessionKey);
	}
	
	public int updateUserSessionById(EgovMap params) throws Exception {
		return update("userDAO.updateUserSessionById", params);
	}
}
