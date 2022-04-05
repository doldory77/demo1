package demo.cmmn.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import demo.cmmn.service.CmmnConst;
import demo.cmmn.service.CmmnUtil;
import demo.cmmn.service.PackingVO;

public class CommonInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(CommonInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.debug("[{}] 진입", request.getRequestURI());
		
		PackingVO pack = new PackingVO();
		pack.setPath(request.getRequestURI());
		pack.setTimestamp(CmmnUtil.yyyyMMddhhmmssSSS());
		request.setAttribute(CmmnConst.PACK, pack);
		return super.preHandle(request, response, handler);
	}
	
	
}
