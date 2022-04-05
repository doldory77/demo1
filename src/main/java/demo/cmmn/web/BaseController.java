package demo.cmmn.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;

import demo.cmmn.service.CmmnConst;
import demo.cmmn.service.PackingVO;

public class BaseController {

	protected static final Logger logger = LoggerFactory.getLogger(BaseController.class);
	
	@Autowired(required = true)
	protected HttpServletRequest request;
	
	@Resource(name = "messageSource")
	protected MessageSource messageSource;
	
	private PackingVO getPack(String id, String code, String msg, String msgDetail, Object input, Object output) {
		PackingVO tmp = null;
		try {
			tmp = (PackingVO) request.getAttribute(CmmnConst.PACK);
		} catch (Exception e) {
			return null;
		}
		
		tmp.setId(id);
		tmp.setCode(code);
		tmp.setMsg(msg);
		tmp.setMsgDetail(msgDetail);
		tmp.setInput(input);
		tmp.setOutput(output);
		
		return tmp;
	}
	
	protected PackingVO getPack() {
		return getPack("", "", "", "", null, null);
	}
	
	protected PackingVO getPack(String code, String msg, Object in) {
		return getPack("", code, msg, "", in, null);
	}
	
}
