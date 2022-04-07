package demo.user.service;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Service;

import demo.cmmn.service.ErrorDefiner;
import demo.cmmn.service.PathVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {

	@Resource(name="userDAO")
	UserDAO userDAO;
	
	@Override
	public String insertUser(UserVO vo) throws Exception {
		vo.setPasswd(DigestUtils.sha256Hex(vo.getPasswd()));
		String result = null;
		try {
			result = userDAO.insertUser(vo);
		} catch (Exception e) {
			String errorCode = ErrorDefiner.defineDBErrorCd(e);
			throw processException(errorCode, e);
		}
		
		return result;
	}

	@Override
	public PathVO selectUserAuthApi(EgovMap params) throws Exception {
		return userDAO.selectUserAuthApi(params);
	}

	@Override
	public UserVO selectUserByIdAndPasswd(EgovMap params) throws Exception {
		params.put("passwd", DigestUtils.sha256Hex(String.valueOf(params.get("passwd"))));
		return userDAO.selectUserByIdAndPasswd(params);
	}

	@Override
	public int updateUserSessionById(EgovMap params) throws Exception {
		return userDAO.updateUserSessionById(params);
	}

}
