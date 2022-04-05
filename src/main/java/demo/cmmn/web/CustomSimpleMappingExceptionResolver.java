package demo.cmmn.web;

import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import demo.cmmn.service.CmmnConst;
import demo.cmmn.service.CommonService;
import demo.cmmn.service.PackingVO;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.string.EgovObjectUtil;
import egovframework.rte.fdl.string.EgovStringUtil;

public class CustomSimpleMappingExceptionResolver extends SimpleMappingExceptionResolver {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomSimpleMappingExceptionResolver.class);

	@Resource(name = "messageSource")
	private MessageSource messageSource;
	
	@Resource(name = "commonService")
	CommonService commonService;
	
	@Override
	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		
		PackingVO pack = (PackingVO) request.getAttribute(CmmnConst.PACK);
		String viewName = determineViewName(ex, request);
		Integer statusCode = determineStatusCode(request, viewName);
		String errorCode = "";
		String errorMsg = "";
		
		if (ex != null && ex instanceof Exception) {
			if (!EgovObjectUtil.isNull(statusCode)) {
				errorCode = EgovStringUtil.integer2string(statusCode);
			}
			errorMsg = ex.getMessage();
		} else if (ex != null && ex instanceof EgovBizException) {
			EgovBizException egovEx = (EgovBizException) ex;
			errorCode = egovEx.getMessageKey();
			errorMsg = egovEx.getMessage();
		}
		
		request.setAttribute("errorCode", errorCode);
		request.setAttribute("errorMsg", errorMsg);
		
		if (pack != null) {
			pack.setMsgDetail(errorMsg);
			commonService.insertLog(pack);
		}
		
		logger.debug("viewName & packingVO : {} & {}", viewName, pack);
		
		if ("cmmn/dataAccessFailure".equals(viewName)) {
			errorCode = "8000";
			errorMsg = "SQL " + messageSource.getMessage("fail.common.msg", new String[] {}, Locale.KOREAN);
		}
		
		if ("application/json".equals(request.getHeader("Content-Type"))) {
			return getModelAndView("cmmn/jsonErrorView", ex, request);
		}
		
		return super.doResolveException(request, response, handler, ex);
	}

	
}
