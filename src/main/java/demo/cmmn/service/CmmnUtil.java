package demo.cmmn.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CmmnUtil {

	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmssSSS");
	
	public static final ObjectMapper OM = new ObjectMapper();
	
	public static String yyyyMMddhhmmssSSS() {
		return sdf.format(new Date());
	}
	
}
