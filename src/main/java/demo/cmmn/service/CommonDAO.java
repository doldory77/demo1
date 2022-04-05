package demo.cmmn.service;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("commonDAO")
public class CommonDAO extends EgovAbstractDAO {

	public String insertLog(PackingVO packingVO) throws Exception {
		return (String) insert("commonDAO.insertLog", packingVO);
	}
	
	public PackingVO selectLogById(String id) throws Exception {
		return (PackingVO) select("commonDAO.selectLogById", id);
	}
	
}
