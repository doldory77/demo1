package demo.cmmn.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import demo.cmmn.service.CmmnConst;
import demo.cmmn.service.CmmnUtil;
import demo.cmmn.service.PackingVO;
import demo.cmmn.service.PagingVO;

public class CommonInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(CommonInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.debug("CommonInterceptor [{}] 진입", request.getRequestURI());
		
		// 통신시 주고받는 전체내용을 감싸는 페킹 오브젝트 생성
		PackingVO pack = new PackingVO();
		pack.setPath(request.getRequestURI());
		pack.setTimestamp(CmmnUtil.yyyyMMddhhmmssSSS());
		
		// 요청(예: /api/countryList.do?page=3) rul에 page 변수에 요청값이  있으면 PagingVO 생성
		if (request.getParameter("page") != null) {
			PagingVO paging = new PagingVO();
			paging.setCurrPageNo(Integer.valueOf(request.getParameter("page")));
			pack.setPagingInfo(paging);
		}
		request.setAttribute(CmmnConst.PACK, pack);
		return super.preHandle(request, response, handler);
	}
	
	
}
