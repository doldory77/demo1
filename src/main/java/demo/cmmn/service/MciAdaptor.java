package demo.cmmn.service;

import java.util.List;
import java.util.Map;

public interface MciAdaptor {
	
	/** 호가
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getPrice(Map<String, Object> params) throws Exception;
	
	/** 차트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public String getChart(Map<String, Object> params) throws Exception;
	
}
