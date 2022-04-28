package demo.cmmn.web;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import demo.cmmn.service.CmmnConst;
import demo.cmmn.service.CmmnUtil;
import demo.cmmn.service.MciAdaptor;
import demo.cmmn.service.MciAdaptorImpl;
import demo.cmmn.service.WSPackingVO;
import demo.user.service.UserVO;

@Controller
@ServerEndpoint(value="/live", configurator=HttpSessionConfigurator.class)
public class WebSocketController {

	private static final Logger logger = LoggerFactory.getLogger(WebSocketController.class);
	
	private Map<Session, EndpointConfig> configs = Collections.synchronizedMap(new HashMap<>());
	
//	@Resource(name="mciAdaptor")
	private MciAdaptor mciAdaptor = new MciAdaptorImpl();
	
	@OnOpen
	public void onOpen(Session session, EndpointConfig config) {
		if (!configs.containsKey(session)) configs.put(session, config);
		logger.debug("onOpen");
		
//		new Thread(new Runnable() {
//			
//			@Override
//			public void run() {
//				int cnt = 0;
//				for (int i=0; i<3; i++) {
//					if (session == null) break;
//					try {
//						session.getBasicRemote().sendText(++cnt + "");
//						Thread.sleep(1000);
//					} catch (IOException e) {
//						e.printStackTrace();
//						break;
//					} catch (InterruptedException e) {
//						e.printStackTrace();
//						break;
//					}
//				}
//				
//			}
//		}).start();
	}
	
	@OnClose
	public void onClose(Session session) {
		if (configs.containsKey(session)) configs.remove(session);
		logger.debug("onClose");
	}
	
	@OnMessage
	public void onMessage(String msg, Session session) throws IOException {
		logger.debug("onMessage {}", msg);
		WSPackingVO pack = (WSPackingVO)CmmnUtil.OM.readValue(msg, WSPackingVO.class);
		pack.header.put("code", "0000");
		pack.header.put("msg", "");
		pack.header.put("msgDetail", "");
		
		HttpSession httpSession = null;
		ServletContext context = null;
		UserVO user = null;
//		logger.debug(pack.getCmd());
		
		if (configs.containsKey(session)) {
			EndpointConfig config = configs.get(session);
			if (config != null) {				
				httpSession = (HttpSession) config.getUserProperties().get(HttpSessionConfigurator.SESSION);
				context = (ServletContext) config.getUserProperties().get(HttpSessionConfigurator.CONTEXT);
				if (httpSession != null) {
					user = (UserVO) httpSession.getAttribute(CmmnConst.USER_INFO);
					if (user != null) logger.debug(user.getName());
				}
			}
		}
		
		if (user == null) {
			pack.header.put("code", "4444");
			pack.header.put("msg", "인증정보없음");
			pack.header.put("msgDetail", "로그인이 필요합니다.");
			session.getBasicRemote().sendText(pack.toString());
			
			// 종료
			return;
		}
		
		if ("PRICE".equals(pack.getCmd())) {
			List<Map<String, Object>> priceList = null;
			try {
				priceList = mciAdaptor.getPrice(null);
			} catch (Exception e) {
				e.printStackTrace();
			}
			pack.body.put("data", priceList);
			session.getBasicRemote().sendText(CmmnUtil.OM.writeValueAsString(pack));
		} else if ("CHART".equals(pack.getCmd())) {
			if (context != null) {
				String filePath = context.getRealPath("/")+"WEB-INF\\classes\\sample\\";
				Map<String, Object> params = new HashMap<>();
				params.put("filePath", filePath);
				logger.debug(filePath);
				String result = null;
				try {
					result = mciAdaptor.getChart(params);
				} catch (Exception e) {
					e.printStackTrace();
				}
				logger.debug(result); 
				session.getBasicRemote().sendText(result);
			}
		} else {
			session.getBasicRemote().sendText(msg);
		}
		
	}
	
	@OnError
	public void onError(Session session, Throwable e) {
		logger.error(e.toString());
	}
}
