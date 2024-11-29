// 게이지 차트 초기화 함수 (상대적인 변화 수준을 단계로 표시)
function initGaugeChart(sumGrgsDsamt, sumGrgsDsamtAvg) {
    var chartDom = document.getElementById('gaugeChart');
    var myChart = echarts.init(chartDom);
    
    // 1년 총 배출량 차이 계산
    var difference = sumGrgsDsamt - sumGrgsDsamtAvg;
    
    // 상대적인 변화 수준을 7단계로 나누기
    var maxDifference = Math.max(Math.abs(difference), 120); // 최대 3으로 설정, 차이에 따라 동적으로 계산
    var normalizedDifference = (difference / maxDifference) * 120; // -3에서 3까지 정규화

    // 게이지 차트 설정
    var option = {
        series: [
            {
                type: 'gauge',
                startAngle: 180,
                endAngle: 0,
                center: ['50%', '60%'],
                radius: '80%',
                min: -120,
                max: 120,
                splitNumber: 6,
                axisLine: {
                    lineStyle: {
                        width: 20,
                        color: [
                            [0.14, '#A9ED83'],   // 차이값이 -3 ~ -2 사이일 때
                            [0.28, '#9CF6B4'],   // 차이값이 -2 ~ -1 사이일 때
                            [0.42, '#81D5FF'],   // 차이값이 -1 ~ 0 사이일 때
                            [0.57, '#FFE575'],   // 차이값이 0 ~ 1 사이일 때
                            [0.71, '#FFB89B'],   // 차이값이 1 ~ 2 사이일 때
                            [0.85, '#E68E8E'],   // 차이값이 2 ~ 3 사이일 때
                            [1, '#DE6C6C']       // 차이값이 3 이상일 때
                        ]
                    }
                },
                pointer: {
                    icon: 'path://M12.8,0.7l12,40.1H0.7L12.8,0.7z',
                    length: '15%',
                    width: 24,
                    offsetCenter: [0, '-60%'],
                    itemStyle: {
                        color: 'auto'
                    }
                },
                axisTick: {
                    length: 15,
                    lineStyle: {
                        color: 'auto',
                        width: 3
                    }
                },
                splitLine: {
                    length: 25,
                    lineStyle: {
                        color: 'auto',
                        width: 6
                    }
                },
                axisLabel: {
                    color: '#464646',
                    fontSize: 18,
                    distance: -60,
                    rotate: 'tangential',
                    formatter: function (value) {
                        if (value === -120) {
                            return '매우 낮음';
                        } else if (value === -80) {
                            return '낮음';
                        } else if (value === -40) {
                            return '약간 낮음';
                        } else if (value === 0) {
                            return '보통';
                        } else if (value === 40) {
                            return '약간 높음';
                        } else if (value === 80) {
                            return '높음';
                        } else if (value === 120) {
                            return '매우 높음';
                        }
                        return '';
                    }
                    
                },
                title: {
                    offsetCenter: [0, '-10%'],
                    fontSize: 20
                },
                detail: {
                	fontSize: 18,
                	offsetCenter: [0, '70%'], // 텍스트를 차트 아래쪽으로 배치
                    valueAnimation: true,
                    formatter: function (value) {
                    	var diffValue = difference || 0; // null 또는 undefined인 경우 0으로 설정
                        return '건물 온실가스 배출량이 동 평균 대비 \n' + Math.abs(diffValue).toFixed(2) + '톤 ' + (diffValue > 0 ? '높습니다' : '낮습니다');
                    },
                    color: '#686868'
                },
                data: [
                    {
                        value: normalizedDifference, // 동적 차이 값 설정
                        name: '건물 온실가스배출량'
                    }
                ]
            }
        ]
    };
    myChart.setOption(option);
    window.addEventListener('resize', function () {
  	  myChart.resize();
    });
}
