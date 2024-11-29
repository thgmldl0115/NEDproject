<%
  /* ================================================================= 
   * 작성일     : 2024. 11. 26. 
   * 작성자     : 최지은
   * 상세설명  : 
   * 화면ID  :
   * ================================================================= 
   * 수정일         작성자             내용      
   * ----------------------------------------------------------------------- 
   * 11/25  이소희      건물별 데이터 조회 테스트 페이지에서 넘어옴
   * ================================================================= 
   */
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<title>Next Energy Daejeon</title>
	<style>
        /* 스크롤바의 폭 너비 */
        .body_scroll::-webkit-scrollbar {
            width: 5px;  
        }

        .body_scroll::-webkit-scrollbar-thumb {
            background: rgb(156, 188, 142); /* 스크롤바 색상 */
            border-radius: 10px; /* 스크롤바 둥근 테두리 */
        }

        .body_scroll::-webkit-scrollbar-track {
            background: rgb(236, 236, 236);  /*스크롤바 뒷 배경 색상*/
        }
	
		.card_body {
			width: 70%;
			margin-top: 20px;
			margin-right: 100px;
			margin-left: 100px;
/* 			margin-bottom: 20px; */
		}
		
        .container_table {
            overflow: auto;
            width: 100%;
            height: 550px;
        }
        
        /* 스크롤바의 폭 너비 */
        .container_table::-webkit-scrollbar {
            width: 7px;
            height: 7px;
        }
        
        .container_table::-webkit-scrollbar-thumb {
            background: rgb(179, 204, 168); /* 스크롤바 색상 */
            border-radius: 10px; /* 스크롤바 둥근 테두리 */
        }

        .container_table::-webkit-scrollbar-track {
            background: rgb(236, 236, 236);  /*스크롤바 뒷 배경 색상*/
        }

        .energy_table {
            overflow: auto;
            width: 100%;
            height: 410px;
        }
        
        /* 스크롤바의 폭 너비 */
        .energy_table::-webkit-scrollbar {
            width: 7px;
            height: 7px;
        }
        
        .energy_table::-webkit-scrollbar-thumb {
            background: rgb(179, 204, 168); /* 스크롤바 색상 */
            border-radius: 10px; /* 스크롤바 둥근 테두리 */
        }

        .energy_table::-webkit-scrollbar-track {
            background: rgb(236, 236, 236);  /*스크롤바 뒷 배경 색상*/
        }
        
        table {
          border-collapse: collapse;
          width: 100%;
        }
	
		caption {
		  caption-side: top !important;
		  text-align: right;
		}
		
        table th,
        table td {
          padding: 8px 16px;
          border: 1px solid #ddd;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
        }

        table thead {
			position: sticky;
			inset-block-start: 0;
			background-color: #EBF5EC;
			text-align: center; 
        }
        
        .form-control:focus {
		    box-shadow: none !important;  /* 그림자 제거 */
		    outline: none !important;     /* 클릭 시 테두리 강조 제거 */
		}
		
		input:focus {
			border-color: #A6A6A6 !important;
		    box-shadow: none !important; /* 그림자 제거 */
		    outline: none !important; /* 기본 테두리 강조 제거 */
		}
		
		input:-webkit-autofill,
		input:-webkit-autofill:hover,
		input:-webkit-autofill:focus {
		    box-shadow: 0 0 0px 1000px white inset !important; /* 배경색 흰색 */
		    border-color: #A6A6A6 !important; /* 테두리 색상 빨간색으로 변경 */
		}
		
		#building_chart {
		    display: none; /* 초기 숨김 */
		}
		
		#machine_chart {
		    display: none; /* 초기 숨김 */
		}
		
        .caption_div {
        	display: flex; 
        	flex-direction: column; 
        	justify-content: flex-end; 
        	margin-right: 5px;
        }
	</style>
</head>
<body class="body_scroll" id="page-top">
	<div id="wrapper">
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content" style="margin-bottom: 40px;">
				<%@ include file="/WEB-INF/inc/top.jsp"%>
				<div class="container-fluid d-flex justify-content-center">
					<div class="card shadow card_body">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">건물별 에너지 사용량</h6>
						</div>
						<div class="card-body px-5" style="height: 700px;">
							<div class="d-flex justify-content-center" style="margin-bottom: 40px;">
								<input type="text" class="form-control" id="userAddr" name="userAddr" placeholder="주소를 입력하세요" style="width: 70%;">
							</div>
							<div class="d-flex justify-content-center">
								<div class="container_table" style="width: 50%;">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>지번 주소</th>
												<th>도로명 주소</th>
											</tr>
										</thead>
										<tbody id="addrList">
										</tbody>
									</table>
								</div>
								<div style="width: 50%;">
									<div style="margin-left: 50px;">
										<div id="addrDetail" style="display: grid;">
										</div>
										<hr>
										<div class="d-flex justify-content-between">
										    <div class="d-flex">
										        <select class="form-control" id="selectYr" style="width: 100px; margin-right: 20px;">
													<c:forEach items="${yearInfo}" var="year">
										            	<c:if test="${year.stnddYr == 2022}">
										            		<option value="${year.stnddYr}" selected>${year.stnddYr}</option>
										            	</c:if>
										            	<c:if test="${year.stnddYr != 2022}">
															<option value="${year.stnddYr}">${year.stnddYr}</option>
										            	</c:if>
													</c:forEach>
												</select>
												<select id="selectData" class="form-control" style="width: 200px;">
													<option value="Usqnt" selected>에너지 사용량</option>
													<option value="Dsamt">온실가스 배출량</option>
												</select>
										    </div>
											<div>
												<button type="button" class="btn btn-outline-success btn-user btn-block" id="getDataBtn" style="width: 70px;">
	                                                	조회
	                                             </button>
											</div>
										</div>
										<div style="margin-top: 13px;">
									    	<div style="width: 100%; text-align: end;">
												에너지 : kWh&nbsp;&nbsp;&nbsp;온실가스 : tCO2eq
									    	</div>
										    <div class="energy_table" style="width: 100%;">
												<table class="table table-hover">
													<thead>
														<tr>
															<th>월</th>
															<th>전력 사용량</th>
															<th>도시가스 사용량</th>
															<th>합계 에너지 사용량</th>
														</tr>
													</thead>
													<tbody id="pickData">
													</tbody>
												</table>
										    </div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="container-fluid d-flex justify-content-center">
				    <div id="building_chart" class="card shadow card_body" style="margin-top: 0;">
				        <div class="card-body d-flex px-5" style=" margin-top: 20px;">
				            <!-- 차트 넣는곳 - 첫 번째 차트 -->
				            <div style="width: 60%; height: 600px; margin-right: 20px;">
					            <div id="buildingChart" style="height: 600px;"></div>
<!-- 							    <div class="caption_div"> -->
<!-- 									막대 : 온실가스  선 : 에너지 -->
<!-- 							    </div> -->
				            </div>
				            <!-- 두 번째 차트 넣는곳 -->
				            <div id="gaugeChart" style="width: 40%; height: 600px;"></div>
							
				        </div>
				    </div>
				</div>
				
				<div class="container-fluid d-flex justify-content-center">
				    <div id="machine_chart" class="card shadow card_body">
				        <div class="card-header py-3">
				            <h6 class="m-0 font-weight-bold text-primary">Machine Learning</h6>
				        </div>
				        <div class="card-body d-flex px-5" style="height: 700px;">
				            <!-- 차트 넣는곳 - 첫 번째 차트 -->
				            <div id="MLChart" style="width: 100%; height: 600px; margin-top:2rem;"></div>
				            <div id="MLChart2" style="display:none;"></div>
							
				        </div>
				    </div>
				</div>
				
			</div>
			<%@ include file="/WEB-INF/inc/footer.jsp"%>
		</div>
	</div>
</body>
<script>
	$(document).ready(function() {
		
		$("#userAddr").on('keydown', function(event) {
			if (event.key === 'Enter') {
				var addrList = [];
				
		        const userAddr = $('#userAddr').val(); 
		        
		        $.ajax({
		            type: 'POST', // 요청 방식
		            url: '/addrSearch', // 요청을 보낼 URL
		            data: { userAddr: userAddr }, // 전송할 데이터 (key-value)
		            success: function (res) {
		            	
		                console.log('Response:', res); // 응답 데이터 콘솔에 출력
		                
		                let str = "";
		                
					
		                res.forEach(function(item) {
		                	
		                	str += "<tr>";
		                	str += "<td>"+ item.lotnoAddr +"</td>";
		                	str += "<td>"+ item.roadNmAddr +"</td>";
		                	str += "</tr>";
		                	
		                });
		                
		                
		                $("#addrList").html(str);
		                
		                $("#addrList tr").click(function(){ 	

		        			var str = ""
		        			var tdArr = new Array();	// 배열 선언
		        			
		        			// 현재 클릭된 Row(<tr>)
		        			var tr = $(this);
		        			var td = tr.children();
		        			
		  
		        			// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
		        			td.each(function(i){
		        				tdArr.push(td.eq(i).text());
		        			});
		        			
		        			
		        			// td.eq(index)를 통해 값을 가져올 수도 있다.
		        			var lotnoAddr = td.eq(0).text();
		        			var roadNmAddr = td.eq(1).text();
		        			var sgngCd = td.eq(2).text();
		        			var stdgCd = td.eq(3).text();
		        			
		        			str += "<span style='font-size: 20px; color: #3D3D3D;'>"+ lotnoAddr +"</span>";
		        			str += "<span>"+ roadNmAddr +"</span>";
		        			
		        			$("#addrDetail").html(str);
		        			
		        			var year = $('#selectYr').val();
	        				getAddrDetail(year, lotnoAddr);
	        				
	        			    $("#building_chart").show();
	        			    $("#machine_chart").show();
		        			
		        			$("#getDataBtn").on("click", function(event){
		        				var year = $('#selectYr').val();
		        				getAddrDetail(year, lotnoAddr);
		        			});
		        		});

		            },
		            error: function (error) {
		                console.error('Error:', error); // 오류 콘솔에 출력
		            }
		        });
			}
		});
	});

	// 1~ 6월간의 데이터 그룹막대차트그릴 데이터 가져오기
	function fetchMLRealData(year, addr) {
	    $.ajax({
	        type: 'POST',
	        url: '/getMLRealData',
	        data: {
	            year: year, // 연도 파라미터
	            addr: addr // 주소 파라미터
	        },
	        success: function (addrList) {
	            
	        	groupedBarChart(addrList);
	        	var code = addrList[0]['mjrPrpsCd'];
	        	
	        	$.ajax({
	                type: 'POST', // 요청 방식
	                url: ' /getMLcode', // 요청을 보낼 URL
	                data: { addr:addr }, // 전송할 데이터 (key-value)
	                success: function (res) {
	                	
	                    console.log('Response:', res); // 응답 데이터 콘솔에 출력
	                    var bldg_arch_area = res[0]['bldgArchArea'];
	                    var code = addrList[0]['mjrPrpsCd'];
	                    getMLdata(code, bldg_arch_area, addrList); // code : 예측데이터/ addrList : 실제데이터
	                    
	                    
	                },
	                error: function (error) {
	                    console.error('Error:', error); // 오류 콘솔에 출력
	                }
	            });
	        	
	        	
	            
	        },
	        error: function (error) {
	            console.error('데이터 가져오기 오류:', error);
	        }
	    });
	}
	
	// 머신러닝 데이터
	function getMLdata(code, bldg_arch_area, addrList){
		$.ajax({
            type: 'GET', // 요청 방식
            url: ' http://192.168.0.42:5500/predict', // 요청을 보낼 URL
            data: { code: code,  bldg_arch_area:bldg_arch_area, year:2022, month:1}, // 전송할 데이터 (key-value)
            success: function (res) {
            	console.log("응답");
                console.log('Response:', res); // 응답 데이터 콘솔에 출력
       			
                predGroupedBarChart(res, addrList);
            },
            error: function (error) {
                console.error('Error:', error); // 오류 콘솔에 출력
            }
        });
		
	}
	
	
	
	function getAddrDetail(year, addr){
		$.ajax({
            type: 'POST', // 요청 방식
            url: '/getAddrDetail', // 요청을 보낼 URL
            data: { year: year,  addr:addr}, // 전송할 데이터 (key-value)
            success: function (res) {
            	console.log("응답");
                console.log('Response:', res); // 응답 데이터 콘솔에 출력
             	// 총 합 계산
                var sumGrgsDsamt = 0;
                var sumGrgsDsamtAvg = 0;
                for (var i = 0; i < res.length; i++) {
                    sumGrgsDsamt += res[i].sumGrgsDsamt ? res[i].sumGrgsDsamt : 0;
                    sumGrgsDsamtAvg += res[i].sumGrgsDsamtAvg ? res[i].sumGrgsDsamtAvg : 0;
                }
                sumGrgsDsamtAvg = sumGrgsDsamtAvg / res.length;
                
                if ($("#selectData").val()== "Usqnt"){
                	
                	let str = "";
    				
                    res.forEach(function(item) {
                    	
                    	str += "<tr>";
                    	str += "<td style='text-align: center;'>"+ item.useMm +"</td>";
                    	str += "<td style='text-align: right;'>"+ item.elrwUsqnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                    	str += "<td style='text-align: right;'>"+ item.ctyGasUsqnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                    	str += "<td style='text-align: right;'>"+ item.sumNrgUsqnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                    	str += "</tr>";
                    	
                    });
                    
                    $("#pickData").html(str);
                	
                } else {
                	
                	let str = "";
                	
                    res.forEach(function(item) {
                    	
                    	str += "<tr>";
                    	str += "<td style='text-align: center;'>"+ item.useMm +"</td>";
                    	str += "<td style='text-align: right;'>"+ item.elrwGrgsDsamt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                    	str += "<td style='text-align: right;'>"+ item.ctyGasGrgsDsamt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                    	str += "<td style='text-align: right;'>"+ item.sumGrgsDsamt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                    	str += "</tr>";
                    	
                    });
                    
                    $("#pickData").html(str);
                	
                }
                
                // 왼쪽 차트 생성
                initBuildingChart(res);
                //오른쪽 게이지차트
                initGaugeChart(sumGrgsDsamt, sumGrgsDsamtAvg);
             	// 밑에 그룹 막대 그래프 출력 예시
                fetchMLRealData(year,addr);

            },
            error: function (error) {
                console.error('Error:', error); // 오류 콘솔에 출력
            }
        });
	}
</script>
</html>