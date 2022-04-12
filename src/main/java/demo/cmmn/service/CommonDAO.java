package demo.cmmn.service;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("commonDAO")
public class CommonDAO extends EgovAbstractDAO {

	public String insertLog(PackingVO packingVO) throws Exception {
		return (String) insert("commonDAO.insertLog", packingVO);
	}
	
	public PackingVO selectLogById(String id) throws Exception {
		return (PackingVO) select("commonDAO.selectLogById", id);
	}
	
	@SuppressWarnings("unchecked")
	public List<PackingVO> selectLogByRange(EgovMap params) throws Exception {
		return (List<PackingVO>) list("commonDAO.selectLogByRange", params);
	}
	
	public PathVO selectMenuByPath(String path) throws Exception {
		return (PathVO) select("commonDAO.selectMenuByPath", path);
	}
	
	public PathVO selectApiByPath(String path) throws Exception {
		return (PathVO) select("commonDAO.selectApiByPath", path);
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCountryList(EgovMap params) throws Exception {
		return (List<EgovMap>) list("commonDAO.selectCountryList", params);
	}
	
	public int selectCountryListTotCnt(EgovMap params) throws Exception {
		return (Integer) select("commonDAO.selectCountryListTotCnt", params);
	}
	
}
