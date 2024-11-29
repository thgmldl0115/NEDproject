package DJEnergy.proj.kr.addrData.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import DJEnergy.proj.kr.addrData.vo.addrDataVO;

/**
 * Class Name  : IaddrDataDAO
 * Author      : LeeSoHee
 * Created Date: 2024. 11. 26.
 * Version: 1.0
 * Purpose:   
 * Description: 
 */
@Mapper
public interface IaddrDataDAO {

	// 건물 검색
	public List<addrDataVO> getAddtList(String addr);
	
	// 건물별 데이터 검색
	public List<addrDataVO> getAddrDetail(addrDataVO vo);
	
	// 선택건물의 주요용도 - 평균 데이터값 22.01~22.06
	public List<addrDataVO> getMLRealData(addrDataVO vo);
	
	// ml 필요 코드
	public List<addrDataVO> getMLcode(addrDataVO vo);
}
