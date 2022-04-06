package demo.cmmn.service;

import java.util.List;

public interface CommonService {

	public String insertLog(PackingVO packingVO);
	public PackingVO selectLogById(String id) throws Exception;
	public List<PackingVO> selectLogByRange(String start, String end) throws Exception;
	public PathVO selectMenuByPath(String path) throws Exception;
	public PathVO selectApiByPath(String path) throws Exception;
	
}
