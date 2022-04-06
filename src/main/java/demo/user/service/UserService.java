package demo.user.service;

import demo.cmmn.service.PathVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface UserService {

	public String insertUser(UserVO vo) throws Exception;
	public PathVO selectUserAuthApi(EgovMap params) throws Exception;
	
}
