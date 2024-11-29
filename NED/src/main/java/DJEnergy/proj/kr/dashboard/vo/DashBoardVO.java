package DJEnergy.proj.kr.dashboard.vo;

/**
 * Class Name  : DashBoardVO
 * Author      : LeeSoHee
 * Created Date: 2024. 11. 22.
 * Version: 1.0
 * Purpose:   VO 생성
 * Description: 
 */

public class DashBoardVO {
	private String lotnoAddr;
	private String roadNmAddr;
	private String sgngCd;
	private String sgngNm;
	private String stdgCd;
	private String stdgNm;
	private String lotnoMno;
	private String lotnoSno;
	private String gpsLot;
	private String gpsLat;
	private String stnddYr;
	private String useMm;
	private int elrwUsqnt;
	private int ctyGasUsqnt;
	private int sumNrgUsqnt;
	private int elrwToeUsqnt;
	private int ctyGasToeUsqnt;
	private int sumNrgToeUsqnt;
	private int elrwGrgsDsamt;
	private int ctyGasGrgsDsamt;
	private int sumGrgsDsamt;
	public String getLotnoAddr() {
		return lotnoAddr;
	}
	public void setLotnoAddr(String lotnoAddr) {
		this.lotnoAddr = lotnoAddr;
	}
	public String getRoadNmAddr() {
		return roadNmAddr;
	}
	public void setRoadNmAddr(String roadNmAddr) {
		this.roadNmAddr = roadNmAddr;
	}
	public String getSgngCd() {
		return sgngCd;
	}
	public void setSgngCd(String sgngCd) {
		this.sgngCd = sgngCd;
	}
	public String getSgngNm() {
		return sgngNm;
	}
	public void setSgngNm(String sgngNm) {
		this.sgngNm = sgngNm;
	}
	public String getStdgCd() {
		return stdgCd;
	}
	public void setStdgCd(String stdgCd) {
		this.stdgCd = stdgCd;
	}
	public String getStdgNm() {
		return stdgNm;
	}
	public void setStdgNm(String stdgNm) {
		this.stdgNm = stdgNm;
	}
	public String getLotnoMno() {
		return lotnoMno;
	}
	public void setLotnoMno(String lotnoMno) {
		this.lotnoMno = lotnoMno;
	}
	public String getLotnoSno() {
		return lotnoSno;
	}
	public void setLotnoSno(String lotnoSno) {
		this.lotnoSno = lotnoSno;
	}
	public String getGpsLot() {
		return gpsLot;
	}
	public void setGpsLot(String gpsLot) {
		this.gpsLot = gpsLot;
	}
	public String getGpsLat() {
		return gpsLat;
	}
	public void setGpsLat(String gpsLat) {
		this.gpsLat = gpsLat;
	}
	public String getStnddYr() {
		return stnddYr;
	}
	public void setStnddYr(String stnddYr) {
		this.stnddYr = stnddYr;
	}
	public String getUseMm() {
		return useMm;
	}
	public void setUseMm(String useMm) {
		this.useMm = useMm;
	}
	public int getElrwUsqnt() {
		return elrwUsqnt;
	}
	public void setElrwUsqnt(int elrwUsqnt) {
		this.elrwUsqnt = elrwUsqnt;
	}
	public int getCtyGasUsqnt() {
		return ctyGasUsqnt;
	}
	public void setCtyGasUsqnt(int ctyGasUsqnt) {
		this.ctyGasUsqnt = ctyGasUsqnt;
	}
	public int getSumNrgUsqnt() {
		return sumNrgUsqnt;
	}
	public void setSumNrgUsqnt(int sumNrgUsqnt) {
		this.sumNrgUsqnt = sumNrgUsqnt;
	}
	public int getElrwToeUsqnt() {
		return elrwToeUsqnt;
	}
	public void setElrwToeUsqnt(int elrwToeUsqnt) {
		this.elrwToeUsqnt = elrwToeUsqnt;
	}
	public int getCtyGasToeUsqnt() {
		return ctyGasToeUsqnt;
	}
	public void setCtyGasToeUsqnt(int ctyGasToeUsqnt) {
		this.ctyGasToeUsqnt = ctyGasToeUsqnt;
	}
	public int getSumNrgToeUsqnt() {
		return sumNrgToeUsqnt;
	}
	public void setSumNrgToeUsqnt(int sumNrgToeUsqnt) {
		this.sumNrgToeUsqnt = sumNrgToeUsqnt;
	}
	public int getElrwGrgsDsamt() {
		return elrwGrgsDsamt;
	}
	public void setElrwGrgsDsamt(int elrwGrgsDsamt) {
		this.elrwGrgsDsamt = elrwGrgsDsamt;
	}
	public int getCtyGasGrgsDsamt() {
		return ctyGasGrgsDsamt;
	}
	public void setCtyGasGrgsDsamt(int ctyGasGrgsDsamt) {
		this.ctyGasGrgsDsamt = ctyGasGrgsDsamt;
	}
	public int getSumGrgsDsamt() {
		return sumGrgsDsamt;
	}
	public void setSumGrgsDsamt(int sumGrgsDsamt) {
		this.sumGrgsDsamt = sumGrgsDsamt;
	}
	
	@Override
	public String toString() {
		return "DashBoardVO [lotnoAddr=" + lotnoAddr + ", roadNmAddr=" + roadNmAddr + ", sgngCd=" + sgngCd + ", sgngNm="
				+ sgngNm + ", stdgCd=" + stdgCd + ", stdgNm=" + stdgNm + ", lotnoMno=" + lotnoMno + ", lotnoSno="
				+ lotnoSno + ", gpsLot=" + gpsLot + ", gpsLat=" + gpsLat + ", stnddYr=" + stnddYr + ", useMm=" + useMm
				+ ", elrwUsqnt=" + elrwUsqnt + ", ctyGasUsqnt=" + ctyGasUsqnt + ", sumNrgUsqnt=" + sumNrgUsqnt
				+ ", elrwToeUsqnt=" + elrwToeUsqnt + ", ctyGasToeUsqnt=" + ctyGasToeUsqnt + ", sumNrgToeUsqnt="
				+ sumNrgToeUsqnt + ", elrwGrgsDsamt=" + elrwGrgsDsamt + ", ctyGasGrgsDsamt=" + ctyGasGrgsDsamt
				+ ", sumGrgsDsamt=" + sumGrgsDsamt + "]";
	}
	public DashBoardVO(String lotnoAddr, String roadNmAddr, String sgngCd, String sgngNm, String stdgCd, String stdgNm,
			String lotnoMno, String lotnoSno, String gpsLot, String gpsLat, String stnddYr, String useMm, int elrwUsqnt,
			int ctyGasUsqnt, int sumNrgUsqnt, int elrwToeUsqnt, int ctyGasToeUsqnt, int sumNrgToeUsqnt,
			int elrwGrgsDsamt, int ctyGasGrgsDsamt, int sumGrgsDsamt) {
		super();
		this.lotnoAddr = lotnoAddr;
		this.roadNmAddr = roadNmAddr;
		this.sgngCd = sgngCd;
		this.sgngNm = sgngNm;
		this.stdgCd = stdgCd;
		this.stdgNm = stdgNm;
		this.lotnoMno = lotnoMno;
		this.lotnoSno = lotnoSno;
		this.gpsLot = gpsLot;
		this.gpsLat = gpsLat;
		this.stnddYr = stnddYr;
		this.useMm = useMm;
		this.elrwUsqnt = elrwUsqnt;
		this.ctyGasUsqnt = ctyGasUsqnt;
		this.sumNrgUsqnt = sumNrgUsqnt;
		this.elrwToeUsqnt = elrwToeUsqnt;
		this.ctyGasToeUsqnt = ctyGasToeUsqnt;
		this.sumNrgToeUsqnt = sumNrgToeUsqnt;
		this.elrwGrgsDsamt = elrwGrgsDsamt;
		this.ctyGasGrgsDsamt = ctyGasGrgsDsamt;
		this.sumGrgsDsamt = sumGrgsDsamt;
	}
	public DashBoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
