package demo.user.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.cmmn.service.CommonService;
import demo.cmmn.service.PackingVO;
import demo.cmmn.web.BaseController;
import demo.user.service.UserService;
import demo.user.service.UserVO;

//@CrossOrigin(origins="*", allowCredentials="true")
@Controller
public class UserController extends BaseController {

	@Resource(name="userService")
	UserService userService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	@RequestMapping("/api/joinUser.do")
	@ResponseBody
	public PackingVO joinUser(@RequestBody UserVO vo) throws Exception {
		
		logger.debug("userVO : {}", vo);
		
		PackingVO pack = getPack("0000", "success", vo);
		pack.setId(vo.getId());
		
		userService.insertUser(vo);
		
//		commonService.insertLog(pack);
//		PackingVO other = commonService.selectLogById(vo.getId());
		
		return pack;
		
	}
}
