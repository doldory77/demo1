package demo.cmmn.service;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;

public class WSPackingVO {

	public String cmd;
	public Map<String, String> header;
	public Map<String, String> body;
	
	public WSPackingVO() {
		this.cmd = "";
		this.header = new HashMap<>();
		this.body = new HashMap<>();
	}

	public String getCmd() {
		return cmd;
	}

	public void setCmd(String cmd) {
		this.cmd = cmd;
	}

	public Map<String, String> getHeader() {
		return header;
	}

	public void setHeader(Map<String, String> header) {
		this.header = header;
	}

	public Map<String, String> getBody() {
		return body;
	}

	public void setBody(Map<String, String> body) {
		this.body = body;
	}

	@Override
	public String toString() {
		try {
			return CmmnUtil.OM.writeValueAsString(this);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
			return null;
		}
	}
}
