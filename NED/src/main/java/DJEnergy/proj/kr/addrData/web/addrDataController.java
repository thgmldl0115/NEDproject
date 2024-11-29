package DJEnergy.proj.kr.addrData.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import DJEnergy.proj.kr.addrData.service.addrDataService;
import DJEnergy.proj.kr.addrData.vo.addrDataVO;

/**
 * Class Name  : addrDataController
 * Author      : LeeSoHee
 * Created Date: 2024. 11. 26.
 * Version: 1.0
 * Purpose:   
 * Description: 
 */
@Controller
public class addrDataController {
	
	@Autowired
	addrDataService service;
	
	// 건물 검색
	@ResponseBody
	@PostMapping("/addrSearch")
	public List<addrDataVO> addrSearch(@RequestParam("userAddr") String userAddr) {
		List<addrDataVO> addrList = service.getAddtList(userAddr);
		return addrList;
	}
	
	// 건물별 데이터 조회
	@ResponseBody
	@PostMapping("/getAddrDetail")
	public List<addrDataVO> getAddrDetail(@RequestParam("year") String year,
			@RequestParam("addr") String addr) {
		
		addrDataVO vo = new addrDataVO();
		vo.setStnddYr(year);
		vo.setLotnoAddr(addr);
		List<addrDataVO> addrList = service.getAddrDetail(vo);
		return addrList;
	}
	
	// 선택건물의 주요용도 - 평균 데이터값 22.01~22.06
	@ResponseBody
	@PostMapping("/getMLRealData")
	public List<addrDataVO> getMLRealData(@RequestParam("year") String year,
			@RequestParam("addr") String addr) {
		
		addrDataVO vo = new addrDataVO();
		vo.setStnddYr(year);
		vo.setLotnoAddr(addr);
		System.out.println("year : "+ year);
		System.out.println("addr : "+ addr);
		List<addrDataVO> addrList = service.getMLRealData(vo);
		System.out.println(addrList);
		return addrList;
	}
	
	@ResponseBody
	@PostMapping("/getMLcode")
	public List<addrDataVO> getMLcode(
			@RequestParam("addr") String addr) {
		
		addrDataVO vo = new addrDataVO();
		vo.setLotnoAddr(addr);
		List<addrDataVO> addrList = service.getMLcode(vo);
		System.out.println(addrList);
		return addrList;
	}
	

}
