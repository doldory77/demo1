package demo.user.web;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.cmmn.service.CmmnConst;
import demo.cmmn.service.CmmnUtil;
import demo.cmmn.service.CommonService;
import demo.cmmn.service.NotExistUserException;
import demo.cmmn.service.PackingVO;
import demo.cmmn.web.BaseController;
import demo.user.service.UserService;
import demo.user.service.UserVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

//@CrossOrigin(origins="*", allowCredentials="true")
@Controller
public class UserController extends BaseController {

	@Resource(name="userService")
	UserService userService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	@RequestMapping("/api/user/joinUser.do")
	@ResponseBody
	public PackingVO joinUser(@RequestBody UserVO vo) throws Exception {
		
		logger.debug("userVO : {}", vo);
		
		PackingVO pack = getPack("0000", "success", vo);
		pack.setId(vo.getId());
		
		userService.insertUser(vo);
		
//		commonService.insertLog(pack);
//		PackingVO other = commonService.selectLogById(vo.getId());
		
		return pack;
		
	}
	
	@RequestMapping("/api/user/login.do")
	@ResponseBody
	public PackingVO login(@RequestBody EgovMap params) throws Exception {
		UserVO user = userService.selectUserByIdAndPasswd(params);
		if (user == null) {
			throw new NotExistUserException("회원 정보가 없습니다.");
		}
		// 세션에 사용자정보 등록
		HttpSession session = request.getSession();
		logger.debug("session ID : [{}]", session.getId());
		session.setAttribute(CmmnConst.USER_INFO, user);
		String autoExtendYn = (String) params.get("isAutoExtend");
		if (autoExtendYn != null && "Y".equalsIgnoreCase(autoExtendYn)) {
			// 로그인시 자동 세션 연장 요청이면 쿠키에 세션키 저장
			Cookie cookie = new Cookie("sessionKey", session.getId());
			cookie.setPath("/");
			cookie.setMaxAge(CmmnConst.AUTO_EXTEND_SESSION_LIMIT_TIME);
			response.addCookie(cookie);
			
			// user 테이블에 세션키와 연자시간 업데이트
			params.put("sessionKey", session.getId());
			params.put("sessionLimit", CmmnUtil.yyyyMMddhhmmss(new Date().getTime() + CmmnConst.AUTO_EXTEND_SESSION_LIMIT_TIME_MILI));
			userService.updateUserSessionById(params);
		}
		PackingVO pack = getPack("0000", "success", params, user);
		
		return pack;
	}
	
}
