package demo.cmmn.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CmmnUtil {

	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmssSSS");
	private static SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddhhmmss");
	
	public static final ObjectMapper OM = new ObjectMapper();
	
	public static String yyyyMMddhhmmssSSS() {
		return sdf.format(new Date());
	}
	public static String yyyyMMddhhmmss() {
		return sdf2.format(new Date());
	}
	public static String yyyyMMddhhmmss(Date date) {
		return sdf2.format(date);
	}
	
	public static String yyyyMMddhhmmss(long time) {
		Date date = new Date();
		date.setTime(time);
		return sdf2.format(date);
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
	
	public static int randomRange(int n1, int n2) {
		return (int) (Math.random() * (n2 - n1 + 1)) + n1;
	}
	
}
