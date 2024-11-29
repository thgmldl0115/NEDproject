// ECharts를 이용하여 그룹형 막대 차트를 생성하는 JavaScript 함수
function predGroupedBarChart(code, addrList) {
    // 차트 렌더링에 필요한 데이터 추출
	
    const categories = ['22.01', '22.02', '22.03', '22.04', '22.05', '22.06'];
    const predElrwData = code.map(function(item) { return item.predicted_usage ? Math.floor(item.predicted_usage) : 0; });
    const realElrwData = addrList.map(function(item) { return item.elrwUsqntAvg; });
    //const gasData = code.map(function(item) { return item.ctyGasUsqntAvg ? Math.floor(item.ctyGasUsqntAvg) : 0; });
    //const sumData = code.map(function(item) { return item.sumNrgUsqntAvg ? Math.floor(item.sumNrgUsqntAvg) : 0; });

    // 'MLChart2' 아이디를 가진 div를 사용하여 차트 인스턴스 초기화
    const chartDom = document.getElementById('MLChart');
    const myChart = echarts.init(chartDom);

    // 차트 설정
    const option = {
        title: {
            text: '예측 데이터  (22.01~22.06)',
            left: 'center'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow' // 축 그림자 포인터
            }
        },
        legend: {
            data: ['예측 전력 사용량', '실제 전력 사용량'],
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
            name: '사용량(kWh)',
            axisLabel: {
                formatter: '{value}'
            }
        },
        series: [
            {
                name: '예측 전력 사용량',
                type: 'bar',
                data: predElrwData,
                itemStyle: {
                    color: '#FCD98C'
                }
            },
            {
                name: '실제 전력 사용량',
                type: 'bar',
                data: realElrwData,
                itemStyle: {
                    color: '#B2DB9D'
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