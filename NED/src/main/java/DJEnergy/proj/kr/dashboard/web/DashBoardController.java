package DJEnergy.proj.kr.dashboard.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import DJEnergy.proj.kr.dashboard.service.DashBoardService;
import DJEnergy.proj.kr.dashboard.vo.AvgDataVO;
import DJEnergy.proj.kr.dashboard.vo.DashBoardVO;

/**
 * Class Name  : DashBoardController
 * Author      : LeeSoHee
 * Created Date: 2024. 11. 22.
 * Version: 1.0
 * Purpose:   
 * Description: 
 */
@Controller
public class DashBoardController {
	
	@Autowired
	DashBoardService service;
	
	@RequestMapping("/")
	public String basicInfo(Model model) {
		// 2022 대전시 전체 그래프
		List<DashBoardVO> basicAllInfo = service.getAllData(2022);
		model.addAttribute("basicAllInfo", basicAllInfo);
		
		// 년도 list
		List<DashBoardVO> yearInfo = service.getYr();
		model.addAttribute("yearInfo", yearInfo);
		
		// 초기 구(서구)의 동 list (stdgNm, stdgCd)
		List<DashBoardVO> dongList = service.getDong("30170");
		model.addAttribute("dongList", dongList);
		
		
		return "home";
	}
	
	
	// 대전시 전체 에너지 사용량
	@ResponseBody
	@PostMapping("/daejeonAll")
	public List<DashBoardVO> dashBoard(@RequestParam("year") String year) {
		int num = Integer.parseInt(year);
		List<DashBoardVO> dashBoardList = service.getAllData(num);
		return dashBoardList;
	}
	
	// 동 리스트
	@ResponseBody
	@PostMapping("/getDong")
	public List<DashBoardVO> getDong(@RequestParam("gu") String gu) {
		List<DashBoardVO> dashBoardList = service.getDong(gu);
		return dashBoardList;
	}
	
	// 구별 에너지 사용량
	@ResponseBody
	@PostMapping("/getGuUsqnt")
	public List<AvgDataVO> getGuUsqnt(
			@RequestParam("year") String year,
			@RequestParam("gu") String gu) {
		DashBoardVO vo = new DashBoardVO();
		vo.setStnddYr(year);
		vo.setSgngCd(gu);
		List<AvgDataVO> avgDataList = service.getGuUsqnt(vo);
		return avgDataList;
	}
	
	// 구별 온실가스 배출량
	@ResponseBody
	@PostMapping("/getGuDsamt")
	public List<AvgDataVO> getGuDsamt(
			@RequestParam("year") String year,
			@RequestParam("gu") String gu) {
		DashBoardVO vo = new DashBoardVO();
		vo.setStnddYr(year);
		vo.setSgngCd(gu);
		List<AvgDataVO> avgDataList = service.getGuDsamt(vo);
		return avgDataList;
	}
	
	// 동별 에너지 사용량
	@ResponseBody
	@PostMapping("/getDongUsqnt")
	public List<AvgDataVO> getDongUsqnt(
			@RequestParam("year") String year,
			@RequestParam("gu") String gu,
			@RequestParam("dong") String dong) {
		DashBoardVO vo = new DashBoardVO();
		vo.setStnddYr(year);
		vo.setSgngCd(gu);
		vo.setStdgCd(dong);
		List<AvgDataVO> avgDataList = service.getDongUsqnt(vo);
		return avgDataList;
	}
	
	// 동별 온실가스 배출량
	@ResponseBody
	@PostMapping("/getDongDsamt")
	public List<AvgDataVO> getDongDsamt(
			@RequestParam("year") String year,
			@RequestParam("gu") String gu,
			@RequestParam("dong") String dong) {
		DashBoardVO vo = new DashBoardVO();
		vo.setStnddYr(year);
		vo.setSgngCd(gu);
		vo.setStdgCd(dong);
		List<AvgDataVO> avgDataList = service.getDongDsamt(vo);
		return avgDataList;
	}	
	
	@RequestMapping("/example")
	public String example() {
		return "example";
	}
	
	@RequestMapping("/lshtest")
	public String lshInfo(Model model) {
		List<DashBoardVO> basicAllInfo = service.getAllData(2022);
		model.addAttribute("basicAllInfo", basicAllInfo);
		
		List<DashBoardVO> yearInfo = service.getYr();
		model.addAttribute("yearInfo", yearInfo);
		
		return "lsh_test";
	}
	
   @RequestMapping("/building")
   public String building_search(Model model) {
      // 년도 list
      List<DashBoardVO> yearInfo = service.getYr();
      model.addAttribute("yearInfo", yearInfo);
      
      return "building_search";
   }
}
