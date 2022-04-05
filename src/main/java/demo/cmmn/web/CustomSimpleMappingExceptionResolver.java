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
		String errorMsgDetail = "";
		
		logger.debug("exception type : {}", ex.getClass().getName());
		
		if (ex != null && ex instanceof Exception) {
			// 일반 오류
			if (!EgovObjectUtil.isNull(statusCode)) {
				errorCode = EgovStringUtil.integer2string(statusCode);
			}
			errorMsg = ex.getMessage();
		} else if (ex != null && ex instanceof EgovBizException) {
			// 업무단 오류
			EgovBizException egovEx = (EgovBizException) ex;
			errorCode = egovEx.getMessageKey();
			errorMsg = egovEx.getMessage();
			errorMsgDetail = egovEx.getMessage();
		} else if ("cmmn/dataAccessFailure".equals(viewName)) {
			logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			// DB - 키중복 오류
			errorCode = "8000";
			errorMsg = messageSource.getMessage("8000", null, Locale.KOREAN);
			errorMsgDetail = messageSource.getMessage("8000.detail", null, Locale.KOREAN);
		}
		
		request.setAttribute("errorCode", errorCode);
		request.setAttribute("errorMsg", errorMsg);
		request.setAttribute("errorMsgDetail", errorMsgDetail);
		
		if (pack != null) {
			pack.setCode(errorCode);
			pack.setMsg(errorMsg);
			pack.setMsgDetail(errorMsgDetail);
			commonService.insertLog(pack);
			try {
				commonService.selectLogByRange(pack.getTimestamp().substring(0, 14).concat("000"), pack.getTimestamp());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		logger.debug("viewName & packingVO : [{}] & {}", viewName, pack);
		
		return getModelAndView(viewName, ex, request);
		
//		if ("application/json".startsWith(request.getHeader("Content-Type"))) {
//		}
//		return super.doResolveException(request, response, handler, ex);
	}

	
}
