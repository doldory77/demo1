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
}
