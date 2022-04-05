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
	
	public static String defineDBErrorMsg(Exception e) {
		String errorMsg = "";
		if (e instanceof BadSqlGrammarException) {
			errorMsg = "SQL 문장 오류";
		}
		else if (e instanceof InvalidResultSetAccessException) {
			errorMsg = "유효하지 않은 결과 접근 오류";
		}
		else if (e instanceof DuplicateKeyException) {
			errorMsg = "중복 키 오류";
		}
		else if (e instanceof DataIntegrityViolationException) {
			errorMsg = "오류";
		}
		else if (e instanceof DataAccessResourceFailureException) {
			errorMsg = "오류";
		}
		else if (e instanceof CannotAcquireLockException) {
			errorMsg = "오류";
		}
		else if (e instanceof DeadlockLoserDataAccessException) {
			errorMsg = "오류";
		}
		else if (e instanceof CannotSerializeTransactionException) {
			errorMsg = "오류";
		}
		return errorMsg;
	}
	
}
