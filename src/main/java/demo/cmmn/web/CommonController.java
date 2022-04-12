package demo.cmmn.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.cmmn.service.CmmnConst;
import demo.cmmn.service.CommonService;
import demo.cmmn.service.PackingVO;
import demo.cmmn.service.ValidatorHelper;
import demo.user.service.UserVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

//@CrossOrigin(origins="*", allowCredentials="true")
@Controller
public class CommonController extends BaseController {
	
	@Resource(name="commonService")
	CommonService commonService;
	
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
	public PackingVO test03(@RequestBody UserVO userVO, BindingResult bindingResult, Model model) throws Exception {
		PackingVO pack = getPack("0000", "success", userVO);
		
		logger.debug("{}", userVO.getId());
		logger.debug("{}", userVO.getPasswd());
		logger.debug("{}", userVO.getName());
		logger.debug("{}", userVO.getBirthday());
		logger.debug("{}", userVO.getCellPhoneNo());
		
		if (!ValidatorHelper.validate(messageSource, beanValidator, userVO, bindingResult, pack)) {
			return pack;
		}
		return pack;
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
		PackingVO pack = getPack("", "", params);
		
		
		return pack;
	}
	
	@RequestMapping("/api/countryList.do")
	@ResponseBody
	public PackingVO countryList() throws Exception {
		PackingVO pack = getPack("", "", null);
		EgovMap resultMap = new EgovMap();
		int pageNo = 1;
		if (request.getParameter("page") != null) {
			pageNo = Integer.valueOf(request.getParameter("page"));
		}
		int firstIndex = pageNo * CmmnConst.RECORD_COUNT_PER_PAGE - CmmnConst.RECORD_COUNT_PER_PAGE + 1;  
		EgovMap params = new EgovMap();
//		params.put("countryNm", "");
		params.put("page", pageNo);
		params.put("recordCountPerPage", CmmnConst.RECORD_COUNT_PER_PAGE);
		params.put("firstIndex", firstIndex);
		List<EgovMap> list = commonService.selectCountryList(params);
		int total = commonService.selectCountryListTotCnt(params);
		int lastPage = (int) Math.ceil((double)total/(double)CmmnConst.RECORD_COUNT_PER_PAGE);
		int blockNo = (int) Math.ceil((double)pageNo/(double)CmmnConst.BLOCK_COUNT_PER_PAGE);
		logger.debug("blockNo: {}, pageNo: {}", blockNo, pageNo);
		int blockStartPage = blockNo * CmmnConst.BLOCK_COUNT_PER_PAGE - CmmnConst.BLOCK_COUNT_PER_PAGE + 1;
		int blockEndPage = blockNo * CmmnConst.BLOCK_COUNT_PER_PAGE;
		blockEndPage = lastPage <= blockEndPage ? lastPage : blockEndPage;
		int prevPage = (blockStartPage - 1 > 0 ? blockStartPage - 1 : 0);
		int nextPage = (blockEndPage + 1 < lastPage ? blockEndPage + 1 : 0);
		
//		resultMap.put("list", list);
		resultMap.put("prevPage", prevPage);
		resultMap.put("blockStartPage", blockStartPage);
		resultMap.put("blockEndPage", blockEndPage);
		resultMap.put("nextPage", nextPage);
		pack.setInput(params);
		pack.setOutput(resultMap);
		return pack;
	}
}
