package demo.user.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import demo.cmmn.service.ErrorDefiner;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.cryptography.EgovDigestService;
import egovframework.rte.fdl.idgnr.impl.Base64;

@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {

	@Resource(name="digestService")
	EgovDigestService digestService;
	
	@Resource(name="userDAO")
	UserDAO userDAO;
	
	@Override
	public String insertUser(UserVO vo) throws Exception {
		vo.setPasswd(Base64.encode(digestService.digest(vo.getPasswd().getBytes("UTF-8"))));
		String result = null;
		try {
			result = userDAO.insertUser(vo);
		} catch (Exception e) {
			String errorCode = ErrorDefiner.defineDBErrorCd(e);
			throw processException(errorCode, e);
		}
		
		return result;
	}

}
