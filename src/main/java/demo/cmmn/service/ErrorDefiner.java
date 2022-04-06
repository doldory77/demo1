package demo.cmmn.service;

import java.io.CharConversionException;
import java.io.EOFException;
import java.io.FileNotFoundException;
import java.io.InterruptedIOException;
import java.io.InvalidClassException;
import java.io.InvalidObjectException;
import java.io.NotActiveException;
import java.io.NotSerializableException;
import java.io.OptionalDataException;
import java.io.StreamCorruptedException;
import java.io.SyncFailedException;
import java.io.UTFDataFormatException;
import java.io.UnsupportedEncodingException;
import java.io.WriteAbortedException;
import java.sql.SQLIntegrityConstraintViolationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.CannotAcquireLockException;
import org.springframework.dao.CannotSerializeTransactionException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DeadlockLoserDataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.jdbc.InvalidResultSetAccessException;

public class ErrorDefiner {
	private static final Logger logger = LoggerFactory.getLogger(ErrorDefiner.class);

	
	public static String defineDBErrorCd(Exception e) {
		String errorCode = "9000";
		if (e instanceof BadSqlGrammarException) {
			errorCode = "9001";
		}
		else if (e instanceof InvalidResultSetAccessException) {
			errorCode = "9002";
		}
		else if (e instanceof DuplicateKeyException || e instanceof SQLIntegrityConstraintViolationException) {
			errorCode = "9003";
		}
		else if (e instanceof DataIntegrityViolationException) {
			errorCode = "9004";
		}
		else if (e instanceof DataAccessResourceFailureException) {
			errorCode = "9005";
		}
		else if (e instanceof CannotAcquireLockException) {
			errorCode = "9006";
		}
		else if (e instanceof DeadlockLoserDataAccessException) {
			errorCode = "9007";
		}
		else if (e instanceof CannotSerializeTransactionException) {
			errorCode = "9008";
		}
		logger.debug("##Exception Type : [{}] & mapped ErrorCode : [{}]", e.getClass().getName(), errorCode);
		return errorCode;
	}
	
	public static String defineNormalErrorCd(Exception e) {
		String errorCode = "8000";
		if (e instanceof NullPointerException) {
			errorCode = "8001";
		}
		else if (e instanceof ArrayIndexOutOfBoundsException) {
			errorCode = "8002";
		}
		else if (e instanceof NumberFormatException) {
			errorCode = "8003";
		}
		else if (e instanceof ClassCastException) {
			errorCode = "8004";
		}
		else if (e instanceof ClassNotFoundException) {
			errorCode = "8005";
		}
		else if (e instanceof CloneNotSupportedException) {
			errorCode = "8007";
		}
		else if (e instanceof IllegalAccessException) {
			errorCode = "8008";
		}
		else if (e instanceof InstantiationException) {
			errorCode = "8009";
		}
		else if (e instanceof InterruptedException) {
			errorCode = "8010";
		}
		else if (e instanceof NoSuchFieldException) {
			errorCode = "8011";
		}
		else if (e instanceof NoSuchMethodException) {
			errorCode = "8012";
		}
		else if (e instanceof CharConversionException) {
			errorCode = "8013";
		}
		else if (e instanceof EOFException) {
			errorCode = "8014";
		}
		else if (e instanceof FileNotFoundException) {
			errorCode = "8015";
		}
		else if (e instanceof InterruptedIOException) {
			errorCode = "8016";
		}
		else if (e instanceof InvalidClassException) {
			errorCode = "8017";
		}
		else if (e instanceof InvalidObjectException) {
			errorCode = "8018";
		}
		else if (e instanceof NotActiveException) {
			errorCode = "8019";
		}
		else if (e instanceof NotSerializableException) {
			errorCode = "8020";
		}
		else if (e instanceof OptionalDataException) {
			errorCode = "8021";
		}
		else if (e instanceof StreamCorruptedException) {
			errorCode = "8022";
		}
		else if (e instanceof WriteAbortedException) {
			errorCode = "8023";
		}
		else if (e instanceof SyncFailedException) {
			errorCode = "8024";
		}
		else if (e instanceof UnsupportedEncodingException) {
			errorCode = "8025";
		}
		else if (e instanceof UTFDataFormatException) {
			errorCode = "8026";
		}
		else if (e instanceof ArithmeticException) {
			errorCode = "8027";
		}
		else if (e instanceof ArrayStoreException) {
			errorCode = "8028";
		}
		else if (e instanceof IllegalThreadStateException) {
			errorCode = "8029";
		}
		else if (e instanceof IllegalMonitorStateException) {
			errorCode = "8030";
		}
		else if (e instanceof IllegalStateException) {
			errorCode = "8031";
		}
		else if (e instanceof StringIndexOutOfBoundsException) {
			errorCode = "8032";
		}
		else if (e instanceof NegativeArraySizeException) {
			errorCode = "8033";
		}
		else if (e instanceof SecurityException) {
			errorCode = "8034";
		}
		else if (e instanceof UnsupportedOperationException) {
			errorCode = "8035";
		}
		else if (e instanceof LoginRequireException) {
			errorCode = "8036";
		}
		else if (e instanceof AccessDeniedException) {
			errorCode = "8037";
		}
		
		return errorCode;
	}
}
