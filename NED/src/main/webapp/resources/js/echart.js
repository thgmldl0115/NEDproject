// ECharts 인스턴스 생성
var chart = echarts.init(document.getElementById('main'));
var chart2 = echarts.init(document.getElementById('main2'));

// 전역 변수로 selectedSigCd 정의
var selectedSigCd = '30170'; // 초기값은 서구 (30170)

//차트와 테이블을 그리는 함수
function drawChartAndTable(chart, selectedGuName, datasetGu, datasetAll, months, tableId, titleText, yAxisLabel, legendData, usageLabel, type) {
    // 테이블 헤더 수정
    $(tableId + ' thead th:last-child').text(usageLabel);

    // 테이블 초기화
    $(tableId + ' tbody').remove();
    var tbody = $('<tbody></tbody>');

    $.each(months, function(index, month) {
        var yearMonth = month;
        var averageLabel = ($('#dongListEnergy').val()) ? '동 평균' : '구 평균';
        var row1 = $('<tr></tr>');
        row1.append($('<td rowspan="2" style="vertical-align: middle; text-align: center;">' + yearMonth + '</td>'));
        row1.append($('<td style="text-align: center;">' + averageLabel + '</td>'));
        row1.append($('<td style="text-align: center;">' + datasetAll[index].toLocaleString()  + '</td>'));
        tbody.append(row1);

        var row2 = $('<tr></tr>');
        var locationName = selectedGuName;
        if (type === 'energy' && $('#dongListEnergy').val()) {
            locationName = $('#dongListEnergy option:selected').text();
        } else if (type === 'gas' && $('#dongListGas').val()) {
            locationName = $('#dongListGas option:selected').text();
        }
        if (type === 'energy') {
            $('#selectGu').text(locationName + ' 에너지 사용량');
        } else if (type === 'gas') {
            $('#selectGu2').text(locationName + ' 온실가스 배출량');
        }

        row2.append($('<td style="text-align: center;">' + locationName + '</td>'));
        row2.append($('<td style="text-align: center;">' + datasetGu[index].toLocaleString() + '</td>'));
        tbody.append(row2);
    });

    $(tableId).append(tbody);

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
            data: legendData,
            bottom : 0,
            orient : 'horizontal',
            textStyle:{
            	fontSize:12
            }
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            },
            left: '0%',
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
                data: months,
                axisLabel: {
                    formatter: function (value, index) {
                        return index % 2 === 0 ? value : '';
                    }
                }
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: selectedGuName,
                type: 'line',
                stack: null, // stack 설정 제거하여 두 값이 더해지지 않도록 수정
                smooth: true,
                lineStyle: {
                    color: 'rgba(127, 188, 177, 1)'
                },
                areaStyle: {
                    color: 'rgba(127, 188, 177, 0.05)'
                },
                emphasis: {
                    focus: 'series'
                },
                itemStyle: {
                    color: 'rgba(127, 188, 177, 1)'
                },
                data: datasetGu
            },
            {
                name: '대전 전체',
                type: 'line',
                stack: null, // stack 설정 제거하여 두 값이 더해지지 않도록 수정
                smooth: true,
                lineStyle: {
                    color: 'rgba(255, 152, 132, 1)'
                },
                areaStyle: {
                    color: 'rgba(255, 152, 132, 0.05)'
                },
                emphasis: {
                    focus: 'series'
                },
                itemStyle: {
                    color: 'rgba(255, 152, 132, 1)'
                },
                data: datasetAll
            }
        ]
    };

    // 옵션을 사용해 차트를 그립니다
    chart.setOption(option);
    // 반응형 처리를 위한 리사이즈 이벤트 핸들러
    window.addEventListener('resize', function () {
    	chart.resize();
    });
}

// 에너지 데이터 가져오는 함수
function fetchChartData(sigCd, year, dong) {
    var energyType = $('#energyType').val();
    var isElectricity = (energyType === '전기');
    var url = dong ? '/getDongUsqnt' : '/getGuUsqnt';
    var requestData = dong ? { gu: sigCd, year: year, dong: dong } : { gu: sigCd, year: year };

    $.ajax({
        url: url,
        type: 'POST',
        data: requestData
    }).done(function(response) {
        var months = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
        var datasetGu = new Array(12).fill(0);
        var datasetAll = new Array(12).fill(0);
        var selectedGuName = dong ? $('#dongListEnergy option:selected').text() : getGuNameBySigCd(sigCd);
        var usageLabel = isElectricity ? '전기 사용량' : '가스 사용량';

        $.each(response, function(index, data) {
            var monthIndex = data.useMm - 1;
            if (isElectricity) {
                datasetGu[monthIndex] = parseFloat(data.elrwUsqnt) || 0;
                datasetAll[monthIndex] = parseFloat(data.elrwUsqntAvg) || 0;
            } else {
                datasetGu[monthIndex] = parseFloat(data.ctyGasUsqnt) || 0;
                datasetAll[monthIndex] = parseFloat(data.ctyGasUsqntAvg) || 0;
            }
        });

        drawChartAndTable(chart, selectedGuName, datasetGu, datasetAll, months, '#energyTb', '에너지 사용량 비교', '사용량', [selectedGuName, '대전 전체'], usageLabel, 'energy');
    }).fail(function(error) {
        console.error('Error fetching chart data:', error);
    });
}

// 온실가스 데이터 가져오는 함수
function fetchGasChartData(sigCd, year, dong) {
    var energyType = $('#energyType2').val();
    var isElectricity = (energyType === '전기');
    var url = dong ? '/getDongDsamt' : '/getGuDsamt';
    var requestData = dong ? { gu: sigCd, year: year, dong: dong } : { gu: sigCd, year: year };

    $.ajax({
        url: url,
        type: 'POST',
        data: requestData
    }).done(function(response) {
        var months = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
        var datasetGu = new Array(12).fill(0);
        var datasetAll = new Array(12).fill(0);
        var selectedGuName = dong ? $('#dongListGas option:selected').text() : getGuNameBySigCd(sigCd);
        var usageLabel = isElectricity ? '전력 온실가스 배출량' : '가스 온실가스 배출량';

        $.each(response, function(index, data) {
            var monthIndex = data.useMm - 1;
            if (isElectricity) {
                datasetGu[monthIndex] = parseFloat(data.elrwGrgsDsamt) || 0;
                datasetAll[monthIndex] = parseFloat(data.elrwGrgsDsamtAvg) || 0;
            } else {
                datasetGu[monthIndex] = parseFloat(data.ctyGasGrgsDsamt) || 0;
                datasetAll[monthIndex] = parseFloat(data.ctyGasGrgsDsamtAvg) || 0;
            }
        });

        drawChartAndTable(chart2, selectedGuName, datasetGu, datasetAll, months, '#energyTb2', '온실가스 배출량 비교', '배출량', [selectedGuName, '대전 전체'], usageLabel, 'gas');
    }).fail(function(error) {
        console.error('Error fetching chart data:', error);
    });
}


// 지도에서 구 클릭 시 호출하는 함수
window.onRegionClick = function(sigCd) {
    selectedSigCd = sigCd;
    var year = $('#year').val();
    fetchChartData(sigCd, year);
    fetchGasChartData(sigCd, year); // 온실가스 데이터도 초기화
};

$('#dongListEnergy').on('change', function() {
    var dong = $(this).val();
    var year = $('#year').val();
    if (dong && selectedSigCd) {
        fetchChartData(selectedSigCd, year, dong);
    } else {
        fetchChartData(selectedSigCd, year);
    }
});

$('#dongListGas').on('change', function() {
    var dong = $(this).val();
    var year = $('#year2').val();
    if (dong && selectedSigCd) {
        fetchGasChartData(selectedSigCd, year, dong);
    } else {
        fetchGasChartData(selectedSigCd, year);
    }
});

// 초기 차트 데이터를 설정하기 위해 서구(코드값: 30170)와 년도 2022 전달
fetchChartData('30170', '2022');
fetchGasChartData('30170', '2022');

// 에너지 데이터 select 박스 변경 시 차트 업데이트
$('#year, #energyType').on('change', function () {
    if (selectedSigCd) {
        var year = $('#year').val();
        fetchChartData(selectedSigCd, year);
    }
});

// 온실가스 데이터 select 박스 변경 시 차트 업데이트
$('#year2, #energyType2').on('change', function () {
    if (selectedSigCd) {
        var year = $('#year2').val();
        fetchGasChartData(selectedSigCd, year);
    }
});

// 구 코드에 따른 구 이름 반환 함수
function getGuNameBySigCd(sigCd) {
    switch(sigCd) {
        case '30200': return '유성구';
        case '30110': return '동구';
        case '30170': return '서구';
        case '30140': return '중구';
        case '30230': return '대덕구';
        default: return '알 수 없음';
    }
}


