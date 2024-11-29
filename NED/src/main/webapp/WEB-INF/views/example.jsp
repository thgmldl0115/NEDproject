<%
  /* ================================================================= 
   * 작성일     : 2024. 11. 19. 
   * 작성자     : 최지은
   * 상세설명  : UI 테스트 파일
   * 화면ID  :
   * ================================================================= 
   * 수정일         작성자             내용      
   * -----------------------------------------------------------------
   * 
   * ================================================================= 
   */
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

</head>

<body id="page-top">

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
                            	<div id="map"></div>
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
									<div class="d-flex" style="margin-bottom: 20px;">
										<select class="form-select" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
											<option selected>전기</option>
											<option value="1">가스</option>
										</select> 

										<select class="form-select" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
											<option selected>2022</option>
											<option value="2021">2021</option>
											<option value="2020">2020</option>
											<option value="2019">2019</option>
										</select> 

									</div>
									
									<div class="d-flex">
	                                    <div class="chart-area">
	                                        <canvas id="myAreaChart"></canvas>
	                                    </div>
	                                    <div>
	                                    	<table class="table" style="width: 300px">
	                                    		<thead style="text-align: center;">
	                                    			<tr>
	                                    				<th>년월</th>
	                                    				<th>구분</th>
	                                    				<th>전기 사용량</th>
	                                    			</tr>
	                                    		</thead>
	                                    		<tbody>
	                                    			<tr>
		                                    			<td>202402</td>
		                                    			<td>서울시 중구</td>
		                                    			<td>153,622</td>
	                                    			</tr>
	                                    			<tr>
		                                    			<td>202402</td>
		                                    			<td>서울시 중구</td>
		                                    			<td>153,622</td>
	                                    			</tr>
	                                    			<tr>
		                                    			<td>202402</td>
		                                    			<td>서울시 중구</td>
		                                    			<td>153,622</td>
	                                    			</tr>
	                                    			<tr>
		                                    			<td>202402</td>
		                                    			<td>서울시 중구</td>
		                                    			<td>153,622</td>
	                                    			</tr>
	                                    			<tr>
		                                    			<td>202402</td>
		                                    			<td>서울시 중구</td>
		                                    			<td>153,622</td>
	                                    			</tr>
	                                    		</tbody>
	                                    	</table>
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
									<h6 class="m-0 font-weight-bold text-primary">OO구 에너지 사용량</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="d-flex" style="margin-bottom: 20px;">
										<select class="form-select" aria-label="Default select example"
											style="width: 100px; margin-right: 20px;">
											<option selected>전체</option>
											<option value="1">OO동</option>
											<option value="2">OO동</option>
											<option value="3">OO동</option>
										</select> 
										<select class="form-select" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
											<option selected>전기</option>
											<option value="1">가스</option>
										</select> 
										
										<select class="form-select" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
											<option selected>2022</option>
											<option value="2021">2021</option>
											<option value="2020">2020</option>
											<option value="2019">2019</option>
										</select> 
									</div>
									<div class="d-flex">
										<div class="chart-bar pt-4 pb-2">
											<canvas id="myAreaChart3"></canvas>
										</div>
										<div>
											<table class="table" style="width: 300px">
												<thead style="text-align: center;">
													<tr>
														<th>년월</th>
														<th>구분</th>
														<th>전기 사용량</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xl-6 col-lg-6">
							<!-- 에너지 사용량 -->
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">OO구 온실가스 배출량</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body">
	
									<div class="d-flex" style="margin-bottom: 20px;">
										<select class="form-select" aria-label="Default select example"
											style="width: 100px; margin-right: 20px;">
											<option selected>전체</option>
											<option value="1">OO동</option>
											<option value="2">OO동</option>
											<option value="3">OO동</option>
										</select> 
										<select class="form-select" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
											<option selected>전기</option>
											<option value="1">가스</option>
										</select> 
										
										<select class="form-select" aria-label="Default select example" style="width: 100px; margin-right: 20px;">
											<option selected>2022</option>
											<option value="2021">2021</option>
											<option value="2020">2020</option>
											<option value="2019">2019</option>
										</select> 
									</div>
	
									<div class="d-flex">
										<div class="chart-pie pt-4 pb-2">
											<canvas id="myAreaChart2"></canvas>
										</div>
										<div>
											<table class="table" style="width: 300px">
												<thead style="text-align: center;">
													<tr>
														<th>년월</th>
														<th>구분</th>
														<th>전기 사용량</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
													<tr>
														<td>202402</td>
														<td>서울시 중구</td>
														<td>153,622</td>
													</tr>
												</tbody>
											</table>
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

</html>