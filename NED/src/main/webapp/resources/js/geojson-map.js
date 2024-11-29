document.addEventListener("DOMContentLoaded", function() {
    // 지도 컨테이너가 존재하는지 확인
    var mapContainer = document.getElementById('map');
    if (!mapContainer) {
        // 지도 컨테이너가 없으면 더 이상의 코드를 실행하지 않음
        return;
    }
// Leaflet.js 지도 초기화
fetchDongList('30170'); // 초기 서구의 동 리스트 불러오기
const map = L.map('map', {
    center: [36.34, 127.39], // 대전광역시 중심 좌표
    zoom: 10.5, // 초기 줌 레벨
    zoomControl: false, // 확대/축소 버튼 활성화
    dragging: false, // 드래그 활성화
    scrollWheelZoom: false, // 마우스 휠 확대/축소 활성화
    doubleClickZoom: false, // 더블 클릭 확대/축소 활성화
    touchZoom: false, // 터치 확대/축소 활성화
    keyboard: false, // 키보드 이동 활성화
    attributionControl: false, // OSM 저작권 표시 비활성화
    zoomSnap: 0.5
});

// 지도 타일 추가
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors', // 타일 제공자 표시
    maxZoom: 18,
    minZoom: 10,
    opacity: 0.8,
    tileSize: 256
}).addTo(map);

// 기본 GeoJSON 스타일 정의
const geojsonStyles = {
    "유성구": { color: "#97BA88", fillColor: "#B3CCA8", fillOpacity: 0.7, weight: 2 },
    "동구": { color: "#7DC62C", fillColor: "#B4E380", fillOpacity: 0.7, weight: 2 },
    "서구": { color: "#A9D75F", fillColor: "#DBEEBC", fillOpacity: 0.7, weight: 2 },
    "중구": { color: "#4EA72F", fillColor: "#88D66C", fillOpacity: 0.7, weight: 2 },
    "대덕구": { color: "#64B071", fillColor: "#ABD4B2", fillOpacity: 0.7, weight: 2 }
};

// Hover 시 변경할 스타일 정의
const hoverStyles = {
    "유성구": { color: "#6F9A5C", fillColor: "#9CBC8E", fillOpacity: 0.85, weight: 3 },
    "동구": { color: "#70B327", fillColor: "#93D749", fillOpacity: 0.85, weight: 3 },
    "서구": { color: "#92CB35", fillColor: "#B3DB73", fillOpacity: 0.85, weight: 3 },
    "중구": { color: "#4DA42E", fillColor: "#66CA42", fillOpacity: 0.85, weight: 3 },
    "대덕구": { color: "#57A965", fillColor: "#80BE8A", fillOpacity: 0.85, weight: 3 }
};

// 각 구의 중심 좌표
const predefinedCenters = {
    "유성구": [36.36454, 127.32646],
    "동구": [36.33430, 127.4748],
    "서구": [36.30037, 127.3548],
    "중구": [36.28672, 127.4031],
    "대덕구": [36.42092, 127.44237]
};

// GeoJSON 파일 로드 및 지도에 추가
const geojsonFiles = [
    { file: "/resources/json/30200_yuseong.json", name: "유성구" },
    { file: "/resources/json/30110_dong.json", name: "동구" },
    { file: "/resources/json/30170_seo.json", name: "서구" },
    { file: "/resources/json/30140_jung.json", name: "중구" },
    { file: "/resources/json/30230_daedeok.json", name: "대덕구" }
];

function fetchDongList(sigCd) {
    $.ajax({
        url: '/getDong',
        type: 'POST',
        data: { gu: sigCd },
        success: function(response) {
            // 동 리스트 select box 초기화 (같은 클래스 가진 모든 select box를 초기화)
            $('.dongListClass').empty();

            // 기본 옵션 추가
            $('.dongListClass').append('<option value="">전체</option>');
            
            // 동 리스트 추가
            $.each(response, function(i, data) {
            	 
            	 $('.dongListClass').append('<option value="' + data.stdgCd + '">' + data.stdgNm + '</option>');
            });
        },
        error: function(error) {
            console.error('동 리스트를 가져오는 중 오류 발생:', error);
        }
    });
}

geojsonFiles.forEach(geojson => {
    fetch(geojson.file)
        .then(response => {
            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            return response.json();
        })
        .then(data => {
            // GeoJSON 데이터를 지도에 추가
            L.geoJSON(data, {
                style: geojsonStyles[geojson.name],
                onEachFeature: (feature, layer) => {
                    // Hover 이벤트: 색상과 두께 변경 및 클래스 추가
                    layer.on("mouseover", () => {
                        layer.setStyle(hoverStyles[geojson.name]);
                        layer.bringToFront(); // Hover된 레이어를 최상단으로 이동
                        layer.getElement().classList.add('leaflet-hover'); // Hover 시 그림자 및 크기 확대 효과 추가
                    });

                    // Hover 해제: 원래 스타일로 복구 및 클래스 제거
                    layer.on("mouseout", () => {
                        layer.setStyle(geojsonStyles[geojson.name]);
                        layer.getElement().classList.remove('leaflet-hover'); // Hover 해제 시 효과 제거
                    });

                    // feature.properties에서 SIG_CD 가져오기
                    var sigCd = feature.properties.SIG_CD || "N/A";

                    // 클릭 이벤트: 구의 정보 출력
                    layer.on("click", () => {
                        selectedSigCd = sigCd;
                        var year = $('#year').val();
                        console.log(selectedSigCd);
                        fetchDongList(selectedSigCd); // 구 클릭 시 동 리스트 가져오기
                        fetchChartData(sigCd, year);
                        fetchGasChartData(sigCd, year);
                    });
                }
            }).addTo(map);

            // 구 이름 라벨 표시
            const center = predefinedCenters[geojson.name];
            if (center) {
                L.marker(center, {
                    icon: L.divIcon({
                        className: 'label',
                        html: `<b>${geojson.name}</b>`,
                        iconSize: [150, 40],
                        iconAnchor: [75, 20]
                    })
                }).addTo(map);
            }
        })
        .catch(error => {
            console.error(`Error loading GeoJSON file (${geojson.file}):`, error);
        });
});
});
