package demo.cmmn.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service("mciAdaptor")
public class MciAdaptorImpl implements MciAdaptor {

	@Override
	public List<Map<String, Object>> getPrice(Map<String, Object> params) throws Exception {
		List<Map<String, Object>> list = new ArrayList<>();
		
		// 매도가 시뮬레이션
		for (int i=0; i<6; i++) {			
			Map<String, Object> map = new HashMap<>();
			map.put("type", 1);
			map.put("index", i+1);
			map.put("remain_amount", CmmnUtil.randomRange(100, 1000));
			map.put("remain_percent", CmmnUtil.randomRange(20, 100));
			map.put("price", CmmnUtil.randomRange(5500, 6000));
			map.put("rate_of_change", CmmnUtil.randomRange(1,9) + "." + CmmnUtil.randomRange(10,50));
			map.put("rate_type", 1);
			list.add(map);
		}
		
		return list;
	}

	@Override
	public String getChart(Map<String, Object> params) throws Exception {
		StringBuilder sb = new StringBuilder();
		String leadLine = null;
		BufferedReader br = null;
		FileReader fr = null;
		String fileName = "data" + (CmmnUtil.randomRange(1, 6) % 6) + ".json";
		fr = new FileReader(new File(params.get("filePath").toString() + fileName));
		br = new BufferedReader(fr);
		
		while ((leadLine = br.readLine()) != null) {
			sb.append(leadLine);
		}
		if (br != null) br.close();
		return sb.toString();
	}

}
