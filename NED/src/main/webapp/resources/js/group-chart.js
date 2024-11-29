// ECharts를 이용하여 그룹형 막대 차트를 생성하는 JavaScript 함수
function groupedBarChart(addrList) {
    // 차트 렌더링에 필요한 데이터 추출
	const lastSixMonths = addrList.slice(-6); // 마지막 6개월 데이터 추출
	const categories = lastSixMonths.map(function(item) {
	  // 년-월 형식의 문자열 생성
	  var year = String(item.stnddYr).slice(-2); // 뒤 2자리만 사용
	  var month = String(item.useMm).padStart(2, '0'); // 월을 2자리로 변환
	  return year + "." + month; // 문자열 조합 (백틱 사용 안 함)
	});
    const elrwData = addrList.map(function(item) { return item.elrwUsqntAvg; });
    const gasData = addrList.map(function(item) { return item.ctyGasUsqntAvg; });
    const sumData = addrList.map(function(item) { return item.sumNrgUsqntAvg; });
    

    // 'MLChart2' 아이디를 가진 div를 사용하여 차트 인스턴스 초기화
    const chartDom = document.getElementById('MLChart2');
    const myChart = echarts.init(chartDom);

    // 차트 설정
    const option = {
        title: {
            text: '선택 건물 주요 용도 - 평균 데이터 ',
            left: 'center'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow' // 축 그림자 포인터
            }
        },
        legend: {
            data: ['전력 사용량', '도시가스 사용량', '총 에너지 사용량'],
            bottom: 0
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        xAxis: {
            type: 'category',
            data: categories,
            axisTick: {
                alignWithLabel: true
            }
        },
        yAxis: {
            type: 'value',
            name: '사용량',
            axisLabel: {
                formatter: '{value}'
            }
        },
        series: [
            {
                name: '전력 사용량',
                type: 'bar',
                data: elrwData,
                itemStyle: {
                    color: '#5470C6'
                }
            },
            {
                name: '도시가스 사용량',
                type: 'bar',
                data: gasData,
                itemStyle: {
                    color: '#91CC75'
                }
            },
            {
                name: '총 에너지 사용량',
                type: 'bar',
                data: sumData,
                itemStyle: {
                    color: '#FAC858'
                }
            }
        ]
    };

    // 설정된 옵션으로 차트를 렌더링
    myChart.setOption(option);
    
    window.addEventListener('resize', function () {
        myChart.resize();
    });
}