package demo.cmmn.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.dao.CannotAcquireLockException;
import org.springframework.dao.CannotSerializeTransactionException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DeadlockLoserDataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.jdbc.InvalidResultSetAccessException;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CmmnUtil {

	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmssSSS");
	
	public static final ObjectMapper OM = new ObjectMapper();
	
	public static String yyyyMMddhhmmssSSS() {
		return sdf.format(new Date());
	}
	public static String yyyyMMddhhmmss() {
		return sdf.format(new Date());
	}
	
	public static String subStrBytes(String source, int cutLength) {
		if(!source.isEmpty()) { 
			source = source.trim(); 
			if(source.getBytes().length <= cutLength) { 
				return source; 
			} else { 
				StringBuffer sb = new StringBuffer(cutLength); 
				int cnt = 0; 
				for(char ch : source.toCharArray()) { 
					cnt += String.valueOf(ch).getBytes().length; 
					if(cnt > cutLength) break; 
				} 
				return sb.toString(); 
			} 
		} else { 
			return ""; 
		} 
	}
	
}
