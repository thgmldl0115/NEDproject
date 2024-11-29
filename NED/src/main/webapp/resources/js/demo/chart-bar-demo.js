// Set new default font family and font color to mimic Bootstrap's default styling
// Nunito 폰트 적용됨
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';  // 차트에 적용되는 텍스트 색상

function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}

// Area Chart Example
var ctx = document.getElementById("myAreaChart3");
var myLineChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
    datasets: [
    {
      label: "Earnings",							  // 데이터셋 이름 (툴팁에 표시됨)
      lineTension: 0.3,								  // 곡선의 부드러움 정도 (0.3은 중간 부드러움)
      backgroundColor: "rgba(78, 115, 223, 0.05)",    // 선 아래 배경색
      borderColor: "rgba(78, 115, 223, 1)",			  // 선 색상
      pointRadius: 3,								  // 포인트 반지름 크기
      pointBackgroundColor: "rgba(78, 115, 223, 1)",  // 포인트 배경 색상
//      pointBorderColor: "rgba(78, 115, 223, 1)",    // 포인트 테두리 색상
      pointHoverRadius: 6,							  // 포인트에 마우스 호버 됐을때 반지름 크기 
      pointHoverBackgroundColor: "rgba(78, 115, 223, 0.05)",  // 호버시 포인트 배경색
      pointHoverBorderColor: "rgba(78, 115, 223, 1)",		  // 호버시 포인트 테두리 색
      pointHoverBorderWidth: 2,						  // 호버시 테두리 두께
      pointHitRadius: 1,							  // 포인트에서 n픽셀 떨어진 영역까지 마우스 이벤트(호버, 클릭)가 감지된다.
      pointBorderWidth: 2,							  // 호인트 테두리 두께
      data: [0, 10000, 5000, 15000, 10000, 20000, 15000, 25000, 20000, 30000, 25000, 40000],  // y축 데이터 값
    },

    {
    	label: "test",
    	lineTension: 0.3,
    	backgroundColor: "rgba(255, 161, 61, 0.05)",    // 선 아래 배경색
    	borderColor: "rgba(255, 161, 61, 1)",			  // 선 색상
    	pointRadius: 3,								  // 포인트 반지름 크기
    	pointBackgroundColor: "rgba(255, 161, 61, 1)",  // 포인트 배경 색상
//      pointBorderColor: "rgba(78, 115, 223, 1)",    // 포인트 테두리 색상
    	pointHoverRadius: 6,							  // 포인트에 마우스 호버 됐을때 반지름 크기 
    	pointHoverBackgroundColor: "rgba(255, 161, 61, 0.05)",  // 호버시 포인트 배경색
    	pointHoverBorderColor: "rgba(255, 161, 61, 1)",		  // 호버시 포인트 테두리 색
    	pointHoverBorderWidth: 2,						  // 호버시 테두리 두께
    	pointHitRadius: 1,							  // 포인트에서 n픽셀 떨어진 영역까지 마우스 이벤트(호버, 클릭)가 감지된다.
    	pointBorderWidth: 2,							  // 호인트 테두리 두께
    	data: [10000, 20000, 15000, 25000, 20000, 30000, 25000, 35000, 30000, 40000, 35000, 50000],  // y축 데이터 값
    }
    
    ],
  },
  options: {
    maintainAspectRatio: false,  // 화면 크기에 따라 비율 유지 여부
    layout: {
      padding: {
        left: 10,
        right: 25,
        top: 25,
        bottom: 0
      }
    },
    scales: {
      xAxes: [{  // x축 설정
        time: {  // 데이터 단위를 date로 설정(시간 데이터 처리용)
          unit: 'date'
        },
        gridLines: {  // 그리드 라인 표시 여부
          display: false,  // 세로줄
          drawBorder: false  // 축을 그릴지 여부를 결정한다는데 차이가 없음
        },
        ticks: {
          maxTicksLimit: 7  // 축의 눈금 개수를 제한하는 설정
        }
      }],
      yAxes: [{  // y축 설정
        ticks: {
          maxTicksLimit: 5,
          padding: 10,
          // 축 값 앞에 달러 기호 붙이기
          callback: function(value, index, values) {
            return '$' + number_format(value);
          }
        },
        gridLines: {
          color: "rgb(234, 236, 244)",
          zeroLineColor: "rgb(234, 236, 244)",
          drawBorder: false,
          borderDash: [2],
          zeroLineBorderDash: [2]
        }
      }],
    },
    legend: {  // 범례
      display: false
    },
    tooltips: {  // 포인터 호버될때 표시되는 정보창
      backgroundColor: "rgb(255,255,255)",  // 배경색
      bodyFontColor: "#858796",				// 글자 색
      titleMarginBottom: 10,				// 제목과 본문 사이 여백
      titleFontColor: '#6e707e',			// 제목 글자 색
      titleFontSize: 14,					// 제목 글자 크기
      borderColor: '#dddfeb',				// 테두리 색상
      borderWidth: 1,						// 테두리 두께
      xPadding: 15,							// 툴팁 내부 텍스트와 테두리 좌우(x), 상하(y) 여백 설정
      yPadding: 15,
      displayColors: true,					// 틀팁 내용에 데이터 색상 표시 할지 말지
      intersect: true,						// 마우스가 포인터를 정확히 호버했을때 툴팁을 띄울건지 말건지
      mode: 'nearest',
      caretPadding: 10,						// 툴팁의 꼭지점과 데이터 포인트 사이의 간격 설정
      callbacks: {						 	// 툴팁의 내용과 형식을 커스터마이징하는 함수
        label: function(tooltipItem, chart) {
          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';  // 데이터셋 이름 가져오기
          return datasetLabel + ': $' + number_format(tooltipItem.yLabel);  // 숫자 값 포맷하고 앞에 달러 기호 붙이기
        }
      }
    }
  }
});
