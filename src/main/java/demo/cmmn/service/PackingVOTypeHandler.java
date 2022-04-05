package demo.cmmn.service;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.ibatis.sqlmap.client.extensions.ParameterSetter;
import com.ibatis.sqlmap.client.extensions.ResultGetter;
import com.ibatis.sqlmap.client.extensions.TypeHandlerCallback;

public class PackingVOTypeHandler implements TypeHandlerCallback {
	
	private static final Logger logger = LoggerFactory.getLogger(PackingVOTypeHandler.class);

	@Override
	public void setParameter(ParameterSetter setter, Object parameter) throws SQLException {
		try {
			setter.setString(parameter.getClass().getName() + "@" + parameter.toString());
		} catch (Exception e) {
			logger.error("PackingVOTypeHandler.setParameter : ", e);
		}
	}

	@Override
	public Object getResult(ResultGetter getter) throws SQLException {
		Object obj = null;
		String[] strArr = null;
		try {
			strArr = getter.getString().split("@", 2);
			obj = CmmnUtil.OM.readValue(strArr[1], Class.forName(strArr[0]));
		} catch (JsonProcessingException | ClassNotFoundException e) {
			logger.error("PackingVOTypeHandler.getResult : ", e);
		}
		return obj;
	}

	@Override
	public Object valueOf(String s) {
		// TODO Auto-generated method stub
		return null;
	}

}
