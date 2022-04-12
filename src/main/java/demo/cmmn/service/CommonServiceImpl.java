package demo.cmmn.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("commonService")
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService {

	@Resource(name="commonDAO")
	CommonDAO commonDAO;

	@Override
	public String insertLog(PackingVO packingVO) {
		String result = "";
		try {
			result = commonDAO.insertLog(packingVO);
		} catch (Exception e) {
			egovLogger.error("CommonServiceImpl.insertLog : ", e);
		}
		return result;
	}

	@Override
	public PackingVO selectLogById(String id) throws Exception {
		return commonDAO.selectLogById(id);
	}

	@Override
	public List<PackingVO> selectLogByRange(String start, String end) throws Exception {
		EgovMap params = new EgovMap();
		params.put("start", start);
		params.put("end", end);
		return commonDAO.selectLogByRange(params);
	}

	@Override
	public PathVO selectMenuByPath(String path) throws Exception {
		return commonDAO.selectMenuByPath(path);
	}

	@Override
	public PathVO selectApiByPath(String path) throws Exception {
		return commonDAO.selectApiByPath(path);
	}

	@Override
	public List<EgovMap> selectCountryList(EgovMap params) throws Exception {
		return commonDAO.selectCountryList(params);
	}

	@Override
	public int selectCountryListTotCnt(EgovMap params) throws Exception {
		return commonDAO.selectCountryListTotCnt(params);
	}
	
	
}
