package demo.cmmn.service;

public interface CommonService {

	public String insertLog(PackingVO packingVO);
	public PackingVO selectLogById(String id) throws Exception;
	
}
