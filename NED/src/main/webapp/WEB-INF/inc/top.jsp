<%
  /* ================================================================= 
   * 작성일     : 2024. 11. 19. 
   * 작성자     : 이소희
   * 상세설명  : 템플릿 최초 적용 - top
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
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Custom fonts for this template-->
<link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
    href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet">
<!-- 지도과련 css -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/map.css">
<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
	<img src="img/logo_green.png" style="width: 250px;">
	
	<div class="ml-auto">
        <button type="button" class="btn btn-outline-success btn-user btn-block" id="getMinhoBtn" style="width: 150px;">
            건물 페이지 이동
        </button>
    </div>

</nav>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // DOM이 완전히 로드된 후 버튼 이벤트 등록
        const getMinhoBtn = document.getElementById("getMinhoBtn");
        if (getMinhoBtn) {
            // 현재 URL의 경로를 가져옴
            const currentPath = window.location.pathname;

            // 버튼 텍스트를 동적으로 변경
            if (currentPath === "/") {
            	getMinhoBtn.innerText = "건물 페이지 이동";
            } else if (currentPath === "/building") {
            	getMinhoBtn.innerText = "홈으로";
            }

            // 버튼 클릭 이벤트 등록
            getMinhoBtn.addEventListener("click", function() {
                if (currentPath === "/") {
                    window.location.href = "/building";
                } else if (currentPath === "/building") {
                    window.location.href = "/";
                }
            });
        }
    });
</script>
<!-- End of Topbar -->