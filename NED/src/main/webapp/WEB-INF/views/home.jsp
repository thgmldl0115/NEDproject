<%
  /* ================================================================= 
   * 작성일     : 2024. 11. 19. 
   * 작성자     : 이소희
   * 상세설명  : 템플릿 최초 적용
   * 화면ID  :
   * ================================================================= 
   * 수정일         작성자             내용      
   * -----------------------------------------------------------------
   * 11/19   최지은          ui 전체 구성
   * 11/22   최지은          ui 수정, 비동기로 전체 조회 표에만 넣기
   * ================================================================= 
   */
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Next Energy Daejeon</title>
    <style>
        .container_table {
          overflow-y: scroll;
          height: 300px;
          width: 100%;
        }
        
        /* 스크롤바의 폭 너비 */
        .container_table::-webkit-scrollbar {
            width: 7px;  
        }
        
        .container_table::-webkit-scrollbar-thumb {
            background: rgb(179, 204, 168); /* 스크롤바 색상 */
            border-radius: 10px; /* 스크롤바 둥근 테두리 */
        }

        .container_table::-webkit-scrollbar-track {
            background: rgb(236, 236, 236);  /*스크롤바 뒷 배경 색상*/
        }

        .other_table {
          overflow-y: scroll;
          height: 600px;
          width: 100%;
        }
        
        /* 스크롤바의 폭 너비 */
        .other_table::-webkit-scrollbar {
            width: 7px;  
        }
        
        .other_table::-webkit-scrollbar-thumb {
            background: rgb(179, 204, 168); /* 스크롤바 색상 */
            border-radius: 10px; /* 스크롤바 둥근 테두리 */
        }

        .other_table::-webkit-scrollbar-track {
            background: rgb(236, 236, 236);  /*스크롤바 뒷 배경 색상*/
        }

        table {
          border-collapse: collapse;
          max-width: 367px;
          min-width: 366px;
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
        
        .caption_div {
        	display: flex; 
        	flex-direction: column; 
        	justify-content: flex-end; 
        	margin-right: 5px;
        }
        
        .form-control:focus {
		    box-shadow: none !important;  /* 그림자 제거 */
		    outline: none !important;     /* 클릭 시 테두리 강조 제거 */
		    border-color: rgb(80, 80, 80);
		}
        
    </style>

</head>

<body class="body_scroll" id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <%@ include file="/WEB-INF/inc/top.jsp"%>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <div class="row mb-4">

						<!-- Pie Chart -->
                        <div class="col-xl-4 col-lg-5">
                            <div class="card shadow mb-4" style="height: 95%;">
                            	<div id="map" style="height: 100%;"></div>
                            </div>
                        </div>

                        <!-- Area Chart -->
                        <div class="col-xl-8 col-lg-7">
                            <div class="card shadow mb-4" style="height: 95%;">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">대전시 전체 에너지 사용량</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
									<div class="d-flex justify-content-between">
									    <div class="d-flex">
									        <select class="form-control" id="all_year" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
												<c:forEach items="${yearInfo}" var="year">
									            	<c:if test="${year.stnddYr == 2022}">
									            		<option value="${year.stnddYr}" selected>${year.stnddYr}</option>
									            	</c:if>
									            	<c:if test="${year.stnddYr != 2022}">
														<option value="${year.stnddYr}">${year.stnddYr}</option>
									            	</c:if>
												</c:forEach>
											</select>
									    </div>
									    <div class="caption_div">
											단위 : MWh
									    </div>
									</div>
									
									<div class="d-flex">
	                                    <div class="chart-area" style="padding-top: 10px;">
	                                        <div id="myAreaChart" style="height: 100%; width: 100%;"></div>
	                                    </div>
	                                    <div>
		                                    <div class="container_table">
		                                    	<table>
		                                    		<thead>
		                                    			<tr>
		                                    				<th>월</th>
		                                    				<th>
		                                    					전력
		                                    				</th>
		                                    				<th>
		                                    					 가스
		                                    				</th>
		                                    				<th>합계</th>
		                                    			</tr>
		                                    		</thead>
		                                    		<tbody id="allBody">
		                                    			<c:forEach items="${basicAllInfo}" var="allInfo">
			                                    			<tr>
				                                    			<td style="text-align: center;">${allInfo.useMm}</td>
				                                    			<td style="text-align: right;"><fmt:formatNumber value="${allInfo.elrwUsqnt}" pattern="#,##0"/></td>
				                                    			<td style="text-align: right;"><fmt:formatNumber value="${allInfo.ctyGasUsqnt}" pattern="#,##0"/></td>
				                                    			<td style="text-align: right;"><fmt:formatNumber value="${allInfo.sumNrgUsqnt}" pattern="#,##0"/></td>
			                                    			</tr>
		                                    			</c:forEach>
		                                    		</tbody>
		                                    	</table>
		                                    </div>
	                                    </div>
									</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Content Row -->
                    <div class="row">
						<div class="col-xl-6 col-lg-6">
							<!-- 에너지 사용량 -->
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary" id="selectGu">OO구 에너지 사용량</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body" style="height: 700px;">
									<div class="d-flex justify-content-between">
										<div class="d-flex">
											<select class="form-control dongListClass" id="dongListEnergy" aria-label="Default select example"
												style="width: 100px; margin-right: 20px;">
												
											</select> 
											<select class="form-control" id="energyType" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
												<option selected>전기</option>
												<option value="1">가스</option>
											</select> 
											
											<select class="form-control" id="year" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
												<c:forEach items="${yearInfo}" var="year">
									            	<c:if test="${year.stnddYr == 2022}">
									            		<option value="${year.stnddYr}" selected>${year.stnddYr}</option>
									            	</c:if>
									            	<c:if test="${year.stnddYr != 2022}">
														<option value="${year.stnddYr}">${year.stnddYr}</option>
									            	</c:if>
												</c:forEach>
											</select> 
										</div>
									    <div class="caption_div">
											단위 : MWh
									    </div>
									</div>
									<div class="d-flex">
										<div class="chart-area" style="padding-top: 20px;">
											<div id="main" style="width: 100%; height: 600px;"></div>
										</div>
										<div>
											<div class="other_table">
												<table class="table" id="energyTb" style="width: 300px">
													<thead style="text-align: center;">
														<tr>
															<th>월</th>
															<th>구분</th>
															<th>전기 사용량</th>
														</tr>
													</thead>
													<tbody>
														
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xl-6 col-lg-6">
							<!-- 온실가스 배출량 -->
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary" id="selectGu2">OO구 온실가스 배출량</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body" style="height: 700px;">
									<div class="d-flex justify-content-between">
										<div class="d-flex">
											<select class="form-control dongListClass" id="dongListGas" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
												
											</select>
											<select class="form-control" id="energyType2" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
												<option selected>전기</option>
												<option value="1">가스</option>
											</select> 
											
											<select class="form-control" id="year2" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
												<c:forEach items="${yearInfo}" var="year">
									            	<c:if test="${year.stnddYr == 2022}">
									            		<option value="${year.stnddYr}" selected>${year.stnddYr}</option>
									            	</c:if>
									            	<c:if test="${year.stnddYr != 2022}">
														<option value="${year.stnddYr}">${year.stnddYr}</option>
									            	</c:if>
												</c:forEach>
											</select>
										</div>
									    <div class="caption_div">
											단위 : tCO2eq
									    </div>
									</div>
	
									<div class="d-flex">
										<div class="chart-area" style="padding-top: 20px;">
											<div id="main2" style="width: 100%; height: 600px;"></div>
										</div>
										<div>
											<div class="other_table">
												<table class="table" id="energyTb2" style="width: 300px">
													<thead style="text-align: center;">
														<tr>
															<th>월</th>
															<th>구분</th>
															<th>전기 사용량</th>
														</tr>
													</thead>
													<tbody>
														
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
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <%@ include file="/WEB-INF/inc/footer.jsp"%>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

</body>

<script>
$(document).ready(function () {
    // 대전시 전체 년도 select
    $("#all_year").on('change', function() {
        let selectedYear = $("#all_year").val();
        
        var elrwUsqntData = [];
        var ctyGasUsqntData = [];

        $.ajax({
            type: 'POST', // 요청 방식
            url: '/daejeonAll', // 요청을 보낼 URL
            data: { year: selectedYear }, // 전송할 데이터 (key-value)
            success: function (res) {
                console.log("응답");
                console.log('Response:', res); // 응답 데이터 콘솔에 출력
                
                let str = "";
                
                res.forEach(function(item) {
                    const elc_data = item.elrwUsqnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    const gas_data = item.ctyGasUsqnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    const sum_data = item.sumNrgUsqnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    
                    str += "<tr>";
                    str += "<td>"+ item.useMm +"</td>";
                    str += "<td style='text-align: right;'>"+ elc_data +"</td>";
                    str += "<td style='text-align: right;'>"+ gas_data +"</td>";
                    str += "<td style='text-align: right;'>"+ sum_data +"</td>";
                    str += "</tr>";
                    
                    elrwUsqntData.push(item.elrwUsqnt); // 전력 사용량 데이터를 추가
                    ctyGasUsqntData.push(item.ctyGasUsqnt); // 가스 사용량 데이터를 추가
                });
                
                $("#allBody").html(str);

                all_info_chart(elrwUsqntData, ctyGasUsqntData);
            },
            error: function (error) {
                console.error('Error:', error); // 오류 콘솔에 출력
            }
        });
    });
    
    // 페이지 로드 시 초기 차트 그리기
    let initialElrwUsqntData = [];
    let initialCtyGasUsqntData = [];
    
    // JSP에서 모델 데이터 가져오기
    // Ensure that the JSP expressions are correctly inserted into the JavaScript array
    <c:forEach items="${basicAllInfo}" var="info">
        initialElrwUsqntData.push(${info.elrwUsqnt}); // Ensure this is correctly outputted as a number
        initialCtyGasUsqntData.push(${info.ctyGasUsqnt}); // Ensure this is correctly outputted as a number
    </c:forEach>
    
    // 초기 차트 그리기
    all_info_chart(initialElrwUsqntData, initialCtyGasUsqntData);
});

function all_info_chart(elc_data, gas_data) {
    // ECharts 차트 설정
    var all_chart =  echarts.init(document.getElementById('myAreaChart')); // 차트를 그릴 DOM 요소 선택

    // 옵션 설정
    var option = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                label: {
                    backgroundColor: '#6a7985'
                }
            }
        },
        legend: {
            data: ['전력', '가스'], // 범례 데이터
            bottom: 0, // 범례를 차트 아래로 이동
            orient: 'horizontal',
            textStyle: {
                fontSize: 12,
            }
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            },
            left: '0%'
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '8%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                boundaryGap: false,
                data: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"], // x축 데이터
                axisLabel: {
                    formatter: function (value, index) {
                        return index % 2 === 0 ? value : ''; // x축 레이블을 2번째마다만 표시
                    }
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
                splitNumber: 4, // y축 값 4개로 제한
                max: 600000, // 데이터 최대값 기준
                min: 0,  // 데이터 최소값 기준
                axisLabel: {
                    formatter: function (value) {
                        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 천 단위 쉼표 추가
                    }
                }
            }
        ],
        series: [
            {
                name: '전력',
                type: 'line',
                smooth: true,
                lineStyle: {
                    color: 'rgba(255, 152, 132, 1)' // 전력 라인의 색상
                },
                areaStyle: {
                    color: 'rgba(255, 152, 132, 0.05)' // 전력 영역 색상
                },
                emphasis: {
                    focus: 'series'
                },
                itemStyle: {
                    color: 'rgba(255, 152, 132, 1)' // 전력 포인트 색상
                },
                data: elc_data // 전력 데이터 (y축 데이터)
            },
            {
                name: '가스',
                type: 'line',
                smooth: true,
                lineStyle: {
                    color: 'rgba(127, 188, 177, 1)' // 가스 라인의 색상
                },
                areaStyle: {
                    color: 'rgba(127, 188, 177, 0.05)' // 가스 영역 색상
                },
                emphasis: {
                    focus: 'series'
                },
                itemStyle: {
                    color: 'rgba(127, 188, 177, 1)' // 가스 포인트 색상
                },
                data: gas_data // 가스 데이터 (y축 데이터)
            }
        ]
    };

    // ECharts에 옵션을 적용하여 차트를 그립니다
    all_chart.setOption(option);
}
	
</script>

</html>