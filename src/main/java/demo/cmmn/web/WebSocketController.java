package demo.cmmn.web;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

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
import demo.user.service.UserVO;

@Controller
@ServerEndpoint(value="/live", configurator=HttpSessionConfigurator.class)
public class WebSocketController {

	private static final Logger logger = LoggerFactory.getLogger(WebSocketController.class);
	
	private Map<Session, EndpointConfig> configs = Collections.synchronizedMap(new HashMap<>());
	
	@OnOpen
	public void onOpen(Session session, EndpointConfig config) {
		if (!configs.containsKey(session)) configs.put(session, config);
		logger.debug("onOpen");
		
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				int cnt = 0;
				for (int i=0; i<3; i++) {
					if (session == null) break;
					try {
						session.getBasicRemote().sendText(++cnt + "");
						Thread.sleep(1000);
					} catch (IOException e) {
						e.printStackTrace();
						break;
					} catch (InterruptedException e) {
						e.printStackTrace();
						break;
					}
				}
				
			}
		}).start();
	}
	
	@OnClose
	public void onClose(Session session) {
		if (configs.containsKey(session)) configs.remove(session);
		logger.debug("onClose");
	}
	
	@OnMessage
	public void onMessage(String msg, Session session) throws IOException {
		logger.debug("onMessage {}", msg);
		if (configs.containsKey(session)) {
			EndpointConfig config = configs.get(session);
			HttpSession httpSession = (HttpSession) config.getUserProperties().get(HttpSessionConfigurator.SESSION);
			UserVO user = (UserVO) httpSession.getAttribute(CmmnConst.USER_INFO);
			if (user != null) logger.debug(user.getName());
		}
		session.getBasicRemote().sendText("hello " + msg + " !!");
	}
	
	@OnError
	public void onError(Session session, Throwable e) {
		logger.error(e.toString());
	}
}
