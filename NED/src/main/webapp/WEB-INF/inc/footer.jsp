<%
  /* ================================================================= 
   * 작성일     : 2024. 11. 19. 
   * 작성자     : 이소희
   * 상세설명  : 템플릿 최초 적용 - footer
   * 화면ID  :
   * ================================================================= 
   * 수정일         작성자             내용      
   * ----------------------------------------------------------------------- 
   * ================================================================= 
   */
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Footer -->
<footer class="sticky-footer bg-white">
    <div class="container my-auto">
        <div class="copyright text-center my-auto">
            <span>Copyright &copy; Next Energy Daejeon 2024</span>
        </div>
    </div>
</footer>
<!-- End of Footer -->

<!-- Bootstrap core JavaScript-->
<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>

<!-- 지도 관련 script -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script src="${pageContext.request.contextPath}/js/geojson-map.js"></script>

<!-- Page level plugins -->
<!-- <script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script> -->

<!-- Page level custom scripts -->
<%-- <script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath}/js/demo/chart-pie-demo.js"></script>
<script src="${pageContext.request.contextPath}/js/demo/chart-bar-demo.js"></script> --%>

<!-- jheChart -->
<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script src="${pageContext.request.contextPath}/js/echart.js"></script>
<script src="${pageContext.request.contextPath}/js/building-echart.js"></script>
<script src="${pageContext.request.contextPath}/js/building-echart2.js"></script>
<script src="${pageContext.request.contextPath}/js/group-chart.js"></script>
<script src="${pageContext.request.contextPath}/js/group-chart-pred.js"></script>
