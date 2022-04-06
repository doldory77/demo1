package demo.cmmn.web;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import demo.cmmn.service.AccessDeniedException;
import demo.cmmn.service.CmmnConst;
import demo.cmmn.service.CommonService;
import demo.cmmn.service.LoginRequireException;
import demo.cmmn.service.PathVO;
import demo.user.service.UserService;
import demo.user.service.UserVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public class AuthApiCheckInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthApiCheckInterceptor.class);
	

	@Autowired(required = true)
	UserService userService;
	
	@Autowired(required = true)
	CommonService commonService;
	
	private Set<String> publicApiURLMap;
	
	public void setPublicApiURLMap(Set<String> publicApiURLMap) {
		this.publicApiURLMap = publicApiURLMap;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("AuthApiCheckInterceptor [{}] 진입", request.getRequestURI());
		
		String apiPath = request.getRequestURI();
		if (publicApiURLMap.contains(apiPath) == false) {
			// 퍼블릭 영역이 아닐때 권한 검사
			PathVO path = commonService.selectApiByPath(apiPath);
			if (path == null || "Y".equals(path.getLoginRequireYn())) {
				UserVO user = (UserVO) request.getSession().getAttribute(CmmnConst.USER_INFO);
				
				if (user == null) {
					throw new LoginRequireException("로그인이 필요 합니다.");
				}
				
				EgovMap params = new EgovMap();
				params.put("id", user.getId());
				params.put("path", apiPath);
				path = userService.selectUserAuthApi(params);
				
				if (path == null) {
					throw new AccessDeniedException("권한이 없습니다.");
				}
				
			}
			
		}
		
		return super.preHandle(request, response, handler);
	}

	
}
