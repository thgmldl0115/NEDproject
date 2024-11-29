package DJEnergy.proj.kr.dashboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import DJEnergy.proj.kr.dashboard.vo.AvgDataVO;
import DJEnergy.proj.kr.dashboard.vo.DashBoardVO;

/**
 * Class Name  : IDashBoardDAO
 * Author      : LeeSoHee
 * Created Date: 2024. 11. 22.
 * Version: 1.0
 * Purpose:   DAO 생성
 * Description: 
 */
@Mapper
public interface IDashBoardDAO {
	
	// 대전시 전체 에너지 사용량 조회
	public List<DashBoardVO> getAllData(int year);
	
	// 년도
	public List<DashBoardVO> getYr();
	// 동 리스트
	public List<DashBoardVO> getDong(String sgngCd);
	
	// 구별 에너지 사용량
	public List<AvgDataVO> getGuUsqnt(DashBoardVO vo);
	// 구별 온실가스 배출량
	public List<AvgDataVO> getGuDsamt(DashBoardVO vo);
	
	// 동별 에너지 사용량
	public List<AvgDataVO> getDongUsqnt(DashBoardVO vo);
	// 동별 온실가스 배출량
	public List<AvgDataVO> getDongDsamt(DashBoardVO vo);
	
}
