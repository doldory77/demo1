package demo.cmmn.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import demo.cmmn.service.PackingVO;
import demo.user.service.UserVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@CrossOrigin(origins="*", allowCredentials="true")
@Controller
public class CommonController extends BaseController {

	@Autowired
	private DefaultBeanValidator beanValidator;
	
	@RequestMapping("/api/test01.do")
	@ResponseBody
	public EgovMap test01() throws Exception {
		EgovMap map = new EgovMap();
		map.put("name", "돌도리");
		map.put("birthday", "19770303");
		map.put("cellPhone", "01062597052");
		
		logger.debug("map : {}", map);
		
		return map;
	}
	
	@RequestMapping("/api/test02.do")
	@ResponseBody
	public EgovMap test02(@RequestBody SampleVO sampleVO, BindingResult bindingResult, Model model) throws Exception {
		EgovMap map = new EgovMap();
		map.put("error", "");
		logger.debug("{}", sampleVO.getName());
		logger.debug("{}", sampleVO.getDescription());
		logger.debug("{}", sampleVO.getRegUser());
		beanValidator.validate(sampleVO, bindingResult);
		if (bindingResult.hasErrors()) {
			map.put("error", "require error");
		}
		
		return map;
	}
	
	@RequestMapping("/api/test03.do")
	@ResponseBody
	public EgovMap test03(@RequestBody UserVO userVO, BindingResult bindingResult, Model model) throws Exception {
		EgovMap map = new EgovMap();
		map.put("error", "");
		logger.debug("{}", userVO.getName());
		logger.debug("{}", userVO.getCellPhoneNo());
		logger.debug("{}", userVO.getId());
		beanValidator.validate(userVO, bindingResult);
		if (bindingResult.hasErrors()) {
			map.put("error", "require error");
		}
		
		return map;
	}
	
	@RequestMapping("/api/test04.do")
	@ResponseBody
	public PackingVO test04(@RequestBody EgovMap params) throws Exception {
		PackingVO pack = getPack("", "", params);
		@SuppressWarnings("unused")
		int tmp = 100 / 0;
		return pack;
	}
	
	@RequestMapping("/api/menuCheck.do")
	@ResponseBody
	public PackingVO menuCheck(@RequestBody EgovMap params) throws Exception {
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		PackingVO pack = getPack("", "", params);
		
		
		return pack;
	}
}
