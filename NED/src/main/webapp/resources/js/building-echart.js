// 데이터 포매터 함수
function dataFormatter(data) {
  const monthList = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
  return data.map(function (item, index) {
    return item !== undefined ? {
      name: monthList[index],
      value: item
    } : null;
  }).filter(function (item) {
    return item !== null;
  });
}

// 차트 옵션 설정 함수
function setChartOption(ctyGasGrgsDsamtData, elrwGrgsDsamtData, ctyGasUsqntData, elrwUsqntData) {
  return {
    title: {
      text: '건물의 월별 온실가스 배출량 및 에너지 사용량',
      subtext: '데이터 출처: 사용자 제공',
      left: 'center'
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'shadow'
      }
    },
    legend: {
      data: ['도시가스 배출량', '전력 배출량', '도시가스 사용량', '전력 사용량'],
      top: '10%'
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '10%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: true,
      data: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
    },
    yAxis: [
      {
        type: 'value',
        name: '사용량 (kWh)',
        position: 'left',
        max: function (value) { return Math.ceil(value.max * 1.2); },
        axisLine: {
          lineStyle: {
            color: '#539F91'
          }
        },
        splitLine: {
          show: false
        },
        axisLabel: {
          formatter: '{value}'
        }
      },
      {
        type: 'value',
        name: '배출량 (톤)',
        position: 'right',
        max: function (value) { return Math.ceil(value.max * 1.2); },
        axisLine: {
          lineStyle: {
            color: '#DE6C6C'
          }
        },
        axisLabel: {
          formatter: '{value}'
        }
      }
    ],
    series: [
      {
        name: '도시가스 배출량',
        type: 'bar',
        yAxisIndex: 1,
        data: ctyGasGrgsDsamtData,
        itemStyle: {
          color: 'rgb(127, 188, 177)'
        },
        animationDelay: function (idx) {
          return idx * 100;
        },
        animationDurationUpdate: 1500,
        animationEasingUpdate: 'cubicOut'
      },
      {
        name: '전력 배출량',
        type: 'bar',
        yAxisIndex: 1,
        data: elrwGrgsDsamtData,
        itemStyle: {
          color: 'rgb(255, 152, 132)'
        },
        animationDelay: function (idx) {
          return idx * 100 + 50;
        },
        animationDurationUpdate: 1500,
        animationEasingUpdate: 'cubicOut'
      },
      {
        name: '도시가스 사용량',
        type: 'line',
        data: ctyGasUsqntData,
        itemStyle: {
          color: 'rgb(127, 188, 177)'
        },
        lineStyle: {
          width: 3,
          type: 'dotted'
        },
        animationDelay: function (idx) {
          return idx * 100;
        },
        animationDurationUpdate: 1500,
        animationEasingUpdate: 'cubicOut'
      },
      {
        name: '전력 사용량',
        type: 'line',
        data: elrwUsqntData,
        itemStyle: {
          color: 'rgb(255, 152, 132)'
        },
        lineStyle: {
          width: 3,
          type: 'dotted'
        },
        animationDelay: function (idx) {
          return idx * 100 + 50;
        },
        animationDurationUpdate: 1500,
        animationEasingUpdate: 'cubicOut'
      }
    ],
    animationEasing: 'elasticOut',
    animationDuration: 1000,
    animationDelayUpdate: function (idx) {
      return idx * 100;
    }
  };
}

// 차트 초기화 함수
function initBuildingChart(res) {
  const ctyGasGrgsDsamtData = dataFormatter(res.map(function (item) { return item.ctyGasGrgsDsamt; }));
  const elrwGrgsDsamtData = dataFormatter(res.map(function (item) { return item.elrwGrgsDsamt; }));
  const ctyGasUsqntData = dataFormatter(res.map(function (item) { return item.ctyGasUsqnt; }));
  const elrwUsqntData = dataFormatter(res.map(function (item) { return item.elrwUsqnt; }));

  var myChart = echarts.init(document.getElementById('buildingChart'));
  var option = setChartOption(ctyGasGrgsDsamtData, elrwGrgsDsamtData, ctyGasUsqntData, elrwUsqntData);
  myChart.setOption(option);

  window.addEventListener('resize', function () {
    myChart.resize();
  });
}
