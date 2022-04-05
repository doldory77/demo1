package demo.cmmn.service;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibatis.sqlmap.client.extensions.ParameterSetter;
import com.ibatis.sqlmap.client.extensions.ResultGetter;
import com.ibatis.sqlmap.client.extensions.TypeHandlerCallback;

public class MsgTrunkTypeHandler implements TypeHandlerCallback {
	
	private static final Logger logger = LoggerFactory.getLogger(MsgTrunkTypeHandler.class);

	@Override
	public void setParameter(ParameterSetter setter, Object parameter) throws SQLException {
		try {
			setter.setString(CmmnUtil.subStrBytes(parameter.toString(), 2000));
		} catch (Exception e) {
			logger.error("MsgTrunkTypeHandler.setParameter : ", e);
		}
	}

	@Override
	public Object getResult(ResultGetter getter) throws SQLException {
		if (getter != null) return getter.getString();
		return null;
	}

	@Override
	public Object valueOf(String s) {
		// TODO Auto-generated method stub
		return null;
	}

}
