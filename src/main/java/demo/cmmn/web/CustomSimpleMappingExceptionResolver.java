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
import demo.cmmn.service.ErrorDefiner;
import demo.cmmn.service.PackingVO;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

public class CustomSimpleMappingExceptionResolver extends SimpleMappingExceptionResolver {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomSimpleMappingExceptionResolver.class);

	@Resource(name = "messageSource")
	private MessageSource messageSource;
	
	@Resource(name = "commonService")
	CommonService commonService;
	
	@Override
	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		
		String viewName = determineViewName(ex, request);
		Integer statusCode = determineStatusCode(request, viewName);
		// 기본코드
		String errorCode = "8000";
		// 기본메시지
		String errorMsg = messageSource.getMessage("8000", null, Locale.getDefault());
		String errorMsgDetail = "";
		String errorExportMsg = "";
		
		logger.debug("Exception Type : [{}], Http Status Code : [{}]", ex.getClass().getName(), statusCode);
		
		if (ex != null && ex instanceof EgovBizException) {
			// 업무단 오류
			EgovBizException egovEx = (EgovBizException) ex;
			errorCode = egovEx.getMessageKey();
			errorMsg = egovEx.getMessage();
			errorMsgDetail = messageSource.getMessage(errorCode.concat(".detail"), null, Locale.getDefault());
			errorExportMsg = egovEx.getWrappedException().getMessage();
		} else if (ex != null && ex instanceof Exception) {
			// 일반 오류
			errorCode = ErrorDefiner.defineNormalErrorCd(ex);
			errorMsg = messageSource.getMessage(errorCode, null, Locale.getDefault());
			errorMsgDetail = ex.getMessage();
			errorExportMsg = ex.getMessage();
		}
		
		request.setAttribute("errorCode", errorCode);
		request.setAttribute("errorMsg", errorMsg);
		request.setAttribute("errorMsgDetail", errorMsgDetail);
		
		PackingVO pack = (PackingVO) request.getAttribute(CmmnConst.PACK);
		if (pack != null) {
			pack.setCode(errorCode);
			pack.setMsg(errorMsg);
			pack.setMsgDetail(errorExportMsg);
			// 에러 로그정보를 DB에 저장(부하가 클경우 파일로 저장 후 스케쥴 배치로 처리)
			commonService.insertLog(pack);
			pack.setMsgDetail(errorMsgDetail);
			
			// 테스트 확인 코드
			try {
				commonService.selectLogByRange(pack.getTimestamp().substring(0, 10).concat("0000000"), pack.getTimestamp());
			} catch (Exception e) {
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
