package DJEnergy.proj.kr.addrData.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import DJEnergy.proj.kr.addrData.dao.IaddrDataDAO;
import DJEnergy.proj.kr.addrData.vo.addrDataVO;

/**
 * Class Name  : addrDataService
 * Author      : LeeSoHee
 * Created Date: 2024. 11. 26.
 * Version: 1.0
 * Purpose:   
 * Description: 
 */
@Service
public class addrDataService {
	
	@Autowired
	IaddrDataDAO dao;
	
	// 건물 검색
	public List<addrDataVO> getAddtList(String userAddr){
		return dao.getAddtList(userAddr);
	}
	
	// 건물별 데이터 조회
	public List<addrDataVO> getAddrDetail(addrDataVO vo){
		return dao.getAddrDetail(vo);
	}
	
	// 선택건물의 주요용도 - 평균 데이터값 22.01~22.06
	public List<addrDataVO> getMLRealData(addrDataVO vo){
		return dao.getMLRealData(vo);
	}
	
	public List<addrDataVO> getMLcode(addrDataVO vo){
		return dao.getMLcode(vo);
	}
}
