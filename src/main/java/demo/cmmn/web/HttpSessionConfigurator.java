package demo.cmmn.web;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

public class HttpSessionConfigurator extends Configurator {

	public static final String SESSION = "session";
	public static final String CONTEXT = "context";
	
	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		HttpSession session = (HttpSession) request.getHttpSession();
		if (session != null) {
			ServletContext context = session.getServletContext();
			sec.getUserProperties().put(HttpSessionConfigurator.SESSION, session);
			sec.getUserProperties().put(HttpSessionConfigurator.CONTEXT, context);
		}
	}
	
}
