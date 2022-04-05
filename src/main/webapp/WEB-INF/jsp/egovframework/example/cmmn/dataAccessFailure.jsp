<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="demo.cmmn.service.PackingVO" %>
<%@ page import="demo.cmmn.service.CmmnConst" %>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="org.apache.commons.lang3.ObjectUtils" %>
<%@ page isErrorPage="true" %>

<%
	PackingVO pack = (PackingVO) request.getAttribute(CmmnConst.PACK);
	if (pack == null) {
		pack = new PackingVO();
		/*pack.setCode(ObjectUtils.toString(request.getAttribute("errorCode"), ""));
		pack.setMsg(ObjectUtils.toString(request.getAttribute("errorMsg"), ""));*/
	}
	response.setStatus(200);
	out.print(StringUtils.trim(pack.toString()));
	out.flush();
%>