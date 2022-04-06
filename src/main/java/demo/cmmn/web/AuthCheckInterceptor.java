package demo.cmmn.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import demo.cmmn.service.CommonService;
import demo.cmmn.service.LoginRequireException;
import demo.user.service.UserService;

public class AuthCheckInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthCheckInterceptor.class);

	@Autowired(required = true)
	UserService userService;
	
	@Autowired(required = true)
	CommonService commonService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("AuthCheckInterceptor [{}] 진입", request.getRequestURI());
		
//		commonService.selectLogById("xx");
		boolean test = true;
		if (test) {
			throw new LoginRequireException("로그인이 필요합니다.");
		}
		
		return super.preHandle(request, response, handler);
	}

	
}
