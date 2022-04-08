package demo.cmmn.web;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import demo.cmmn.service.CmmnConst;
import demo.cmmn.service.CmmnUtil;
import demo.cmmn.service.CommonService;
import demo.cmmn.service.LoginRequireException;
import demo.cmmn.service.PackingVO;
import demo.cmmn.service.PathVO;
import demo.user.service.UserService;
import demo.user.service.UserVO;

public class AuthMenuCheckInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthMenuCheckInterceptor.class);

	@Autowired(required = true)
	UserService userService;
	
	@Autowired(required = true)
	CommonService commonService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("AuthMenuCheckInterceptor [{}] 진입", request.getRequestURI());
		
		if (CmmnConst.MENU_PAGE_CHECK_URL.equals(request.getRequestURI())) {
			String menuPath = request.getParameter("menu");
			logger.debug("menuPath : [{}]", menuPath);
			
			PathVO path = commonService.selectMenuByPath(menuPath);
			if (path == null) {
				throw new LoginRequireException("존재하지 않는 메뉴 접근");
			}
			
			if ("Y".equals(path.getLoginRequireYn())) {
				HttpSession session = request.getSession();
//				logger.debug("AuthMenuCheckInterceptor session ID : [{}]", session.getId());
				UserVO user = (UserVO) session.getAttribute(CmmnConst.USER_INFO);
				if (user == null) {
					
					// 세션연장여부 체크
					if (AuthMenuCheckInterceptor.CookieChecker.sessionExtendCheck(request, userService)) {
						session.setAttribute(CmmnConst.USER_INFO, user);
					} else {
						throw new LoginRequireException("로그인이 필요 합니다.");
					}
				}
			}
			
			PackingVO pack = (PackingVO) request.getAttribute(CmmnConst.PACK);
			pack.setCode("0000");
			pack.setMsg("인증됨");
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(pack.toString());
			out.flush();
			
			return false;
		} 
		
		return super.preHandle(request, response, handler);
	}
	
	public static class CookieChecker {
		public static String autoExtendSessionKey(HttpServletRequest request) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie c : cookies) {
					if (CmmnConst.SESSION_KEY.equals(c.getName())) {
						return c.getValue();
					}
				}
			}
			return null;
		}
		
		public static boolean isSessionLimitAvailable(UserVO user) {
			if (user == null) return false;
			return Long.valueOf(user.getSessionLimit()) >= Long.valueOf(CmmnUtil.yyyyMMddhhmmss());
		}
		
		public static boolean sessionExtendCheck(HttpServletRequest request, UserService userService) {
			boolean result = false;
			String sessionKey = CookieChecker.autoExtendSessionKey(request);
			if (sessionKey == null) return result;
			UserVO user;
			try {
				user = userService.selectUserBySessionKey(sessionKey);
			} catch (Exception e) {
				logger.error("sessionExtendCheck Error : {}", e);
				return false;
			}
			result = CookieChecker.isSessionLimitAvailable(user);
			
			return result;
		}
	}

	
}
