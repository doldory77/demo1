package demo.cmmn.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

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
	
	
}
