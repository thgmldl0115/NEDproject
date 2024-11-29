package DJEnergy.proj.kr.dashboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import DJEnergy.proj.kr.dashboard.dao.IDashBoardDAO;
import DJEnergy.proj.kr.dashboard.vo.AvgDataVO;
import DJEnergy.proj.kr.dashboard.vo.DashBoardVO;

/**
 * Class Name  : DashBoardService
 * Author      : LeeSoHee
 * Created Date: 2024. 11. 22.
 * Version: 1.0
 * Purpose:   
 * Description: 
 */
@Service
public class DashBoardService {
	
	@Autowired
	IDashBoardDAO dao;
	
	// 대전시 전체 에너지 사용량 조회
	public List<DashBoardVO> getAllData(int year){
		return dao.getAllData(year);
	}
	
	// 년도
	public List<DashBoardVO> getYr(){
		return dao.getYr();
	}
	// 동 리스트
	public List<DashBoardVO> getDong(String sgngCd){
		return dao.getDong(sgngCd);
	}
	
	// 구별 에너지 사용량
	public List<AvgDataVO> getGuUsqnt(DashBoardVO vo){
		return dao.getGuUsqnt(vo);
	};
	
	// 구별 온실가스 배출량
	public List<AvgDataVO> getGuDsamt(DashBoardVO vo){
		return dao.getGuDsamt(vo);
	};

	// 동별 에너지 사용량
	public List<AvgDataVO> getDongUsqnt(DashBoardVO vo){
		return dao.getDongUsqnt(vo);
	};
	
	// 동별 온실가스 배출량
	public List<AvgDataVO> getDongDsamt(DashBoardVO vo){
		return dao.getDongDsamt(vo);
	};
}
