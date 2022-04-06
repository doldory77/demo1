package demo.cmmn.service;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class PathVO {

	private String path;
	private String name;
	private String loginRequireYn;
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginRequireYn() {
		return loginRequireYn;
	}
	public void setLoginRequireYn(String loginRequireYn) {
		this.loginRequireYn = loginRequireYn;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}
