package demo.cmmn.web;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import demo.cmmn.service.CmmnConst;
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
			if (path == null || "Y".equals(path.getLoginRequireYn())) {
				UserVO user = (UserVO) request.getSession().getAttribute(CmmnConst.USER_INFO);
				if (user == null) {
					
					throw new LoginRequireException("로그인이 필요 합니다.");
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

	
}
