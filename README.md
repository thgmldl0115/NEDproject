<h1> NEDproject </h1> 
<h4> 제작의도 : 대전광역시 에너지 사용량과 온실가스 배출량 데이터 시각화 </h4>

![최종화면](https://github.com/user-attachments/assets/5f8d0bbb-f3db-4a09-b199-b7e53a06d26b)


## 목차
1. [핵심기능](#핵심기능)
2. [상세내용](#담당_업무_상세내용)
3. [프로젝트주요성과](#프로젝트주요성과)
4. [느낀점](#느낀점)
<hr>

- 제작기간 : 24.11.19 ~ 24.11.28
  
- 참여인원 : 5인

- 담당업무 : 백엔드, DB
    - 전국 데이터에서 대전시 데이터 추출하여 csv 파일 생성
    - csv 데이터 oracle DB 삽입
    - 패키지 및 클래스 생성
    - 쿼리 작성
    - 건물별 조회 기능 개발
    - 머신러닝 모델 학습 및 flask와 spring연동
  
- 사용기술
  - Java, Python, HTML, CSS, JavaScript, Oracle
  - STS, Sql Developer, PyCharm
  - Spring, jQuery, Bootstrap, Ajax, Scikit-learn
<hr>

## 핵심기능
[목차로 돌아가기](#목차)

- 메인화면(home.jsp) : 행정구역별(구, 동) 데이터 시각화
    1. 대전시 전체 에너지 사용 현황 차트, 테이블 제공
    2. 선택한 행정구역의 에너지 사용량과 온실가스 배출량 차트, 테이블 제공
    3. 구를 선택한 경우 대전시 5개구의 평균값을 함께 제공해 비교가 용이하게 함.
    4. 동을 선택한 경우 해당 구의 동 평균값을 함께 제공해 비교가 용이하게 함.

- 건물별 조회 화면(building_search.jsp) : 건물별 데이터 시각화 및 예측
    1. 사용자가 입력한 키워드와 일치하는 주소 리스트 출력
    2. 출력된 리스트 중 원하는 건물 클릭
    3. 선택한 건물의 에너지 사용량과 온실가스 배출량 차트, 테이블 제공.
    4. 해당 건물이 속한 동의 건물 평균 온실가스 배출량과 비교하여 게이지 차트 제공.
    5. RandomForestRegressor를 적용하여 건물의 주요 용도와 건축 면적을 바탕으로
6개월간의 전력 에너지 사용량 예측
        - 데이터의 한계로 21년까지의 데이터를 사용하여 22년 데이터를 예측.
        - 이후 22년 실제 데이터와 비교한 차트를 제공하여 예측값의 정확도를 확인할 수 있도록 함. 


## 담당 업무 상세내용
[목차로 돌아가기](#목차)

**1. 전국 데이터에서 대전시 데이터 추출**
<details>
    <summary>사용 코드(python)</summary>

        import pandas as pd

        # 파일 경로와 필요한 컬럼
        file_path = '건물에너지DB_좌표매칭_최종(15-18).csv'
        columns_to_read = ['LOTNO_ADDR', 'ROAD_NM_ADDR', 'SGNG_CD', 'STDG_CD', 'LOTNO_MNO', 'LOTNO_SNO', 'GPS_LOT', 'GPS_LAT', 'STNDD_YR', 'USE_MM', 'ELRW_USQNT', 'CTY_GAS_USQNT', 'SUM_NRG_USQNT', 'ELRW_TOE_USQNT', 'CTY_GAS_TOE_USQNT', 'SUM_NRG_TOE_USQNT', 'ELRW_GRGS_DSAMT', 'CTY_GAS_GRGS_DSAMT', 'SUM_GRGS_DSAMT']

        # CSV 파일 읽기 및 필요한 열 선택
        data = pd.read_csv(file_path, usecols=columns_to_read)


        # 30230 : 대덕구
        # 30110 : 동구
        # 30170 : 서구
        # 30200 : 유성구
        # 30140 : 중구

        # 포함하고자 하는 문자열 리스트 생성
        dj_list = ['30230', '30110', '30170', '30200', '30140']

        # 데이터프레임 생성
        df = pd.DataFrame(data)

        # join함수를 이용하여 이어주고 contains 함수에 넣기
        test = '|'.join(dj_list)

        # '대전광역시'가 포함된 데이터 필터링
        filtered_data = data[data['SGNG_CD'].astype(str).str.contains(test, na=False)]

        # 데이터 개수 확인
        row_count = len(filtered_data)
        # 대전 전체 데이터 갯수 : 1,199,696 개,  개로 출력된 코드 개수와 비교 필요
        # 추출된 데이터 개수(19-22): 1,305,175개
        # 추출된 데이터 개수(15-18): 1,710,373개
        print(f"추출된 데이터 개수: {row_count}개")


        # 결과를 새로운 CSV 파일로 저장
        filtered_data.to_csv('건물에너지DB_좌표매칭_최종(15-18)(대전).csv', index=False, encoding='utf-8-sig')


</details>
<br>

**2. csv데이터 oralce DB 삽입**
<details>
    <summary>사용 코드(python)</summary>

        import cx_Oracle
        import pandas as pd

        # Oracle DB 연결 설정
        oracle_connection = cx_Oracle.connect(
            user=[# Oracle 사용자 이름],         # Oracle 사용자 이름
            password=[# 비밀번호],     # 비밀번호
            dsn=[# Oracle DSN 정보]  # Oracle DSN 정보
        )

        # 커서 생성
        cursor = oracle_connection.cursor()

        # cursor.execute(create_table_query)

        # CSV 파일 경로 및 데이터 로드
        file_path = '건물에너지DB_좌표매칭_최종(15-18)(대전).csv'
        data = pd.read_csv(file_path, header=None, encoding='utf-8', dtype=str, low_memory=False)

        # 컬럼 이름 수동 할당
        data.columns = [
            'LOTNO_ADDR', 'ROAD_NM_ADDR', 'SGNG_CD', 'STDG_CD', 'LOTNO_MNO', 'LOTNO_SNO',
            'GPS_LOT', 'GPS_LAT', 'STNDD_YR', 'USE_MM', 'ELRW_USQNT', 'CTY_GAS_USQNT',
            'SUM_NRG_USQNT', 'ELRW_TOE_USQNT', 'CTY_GAS_TOE_USQNT', 'SUM_NRG_TOE_USQNT',
            'ELRW_GRGS_DSAMT', 'CTY_GAS_GRGS_DSAMT', 'SUM_GRGS_DSAMT'
        ]

        # 모든 데이터를 문자열로 변환 및 NaN 값 처리
        data = data.fillna('').astype(str)

        # 테이블에 삽입할 SQL 쿼리
        insert_query = """
            INSERT INTO DAEJEON_ENERGY (
                
                LOTNO_ADDR, ROAD_NM_ADDR, SGNG_CD, STDG_CD, LOTNO_MNO, LOTNO_SNO,
                GPS_LOT, GPS_LAT, STNDD_YR, USE_MM, ELRW_USQNT, CTY_GAS_USQNT,
                SUM_NRG_USQNT, ELRW_TOE_USQNT, CTY_GAS_TOE_USQNT, SUM_NRG_TOE_USQNT,
                ELRW_GRGS_DSAMT, CTY_GAS_GRGS_DSAMT, SUM_GRGS_DSAMT, PK_CD
            ) VALUES (
                :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20
            )
        """

        idx = 0
        # 데이터프레임 데이터를 테이블에 삽입
        try:
            for index, row in data.iterrows():
                idx += 1
                try:
                    cursor.execute(insert_query, (
                        row['LOTNO_ADDR'],
                        row['ROAD_NM_ADDR'],
                        row['SGNG_CD'],
                        row['STDG_CD'],
                        row['LOTNO_MNO'],
                        row['LOTNO_SNO'],
                        row['GPS_LOT'],
                        row['GPS_LAT'],
                        row['STNDD_YR'],
                        row['USE_MM'],
                        row['ELRW_USQNT'],
                        row['CTY_GAS_USQNT'],
                        row['SUM_NRG_USQNT'],
                        row['ELRW_TOE_USQNT'],
                        row['CTY_GAS_TOE_USQNT'],
                        row['SUM_NRG_TOE_USQNT'],
                        row['ELRW_GRGS_DSAMT'],
                        row['CTY_GAS_GRGS_DSAMT'],
                        row['SUM_GRGS_DSAMT'], idx
                    ))
                except Exception as row_error:
                    print(f"오류 발생 (행 {index}): {row_error}")
                    print(f"문제 데이터: {row.to_dict()}")
            # 커밋
            oracle_connection.commit()
            print(f"{len(data)}개의 행이 성공적으로 삽입되었습니다.")
        except Exception as e:
            print(f"오류 발생: {e}")
            oracle_connection.rollback()
        finally:
            # 커서 및 연결 종료
            cursor.close()
            oracle_connection.close()


</details>
<br>

**3. 쿼리 작성**
- 대전 전체 에너지 사용량 조회 쿼리
- 구별 에너지 사용량, 온실가스 배출량 조회 쿼리
- 동별 에너지 사용량, 온실가스 배출량 조회 쿼리
- 건물별 에너지사용량, 온실가스 배출량 조회 쿼리
- 이외 모든 쿼리 직접 작성 및 controller 전달
<details>
    <summary>동별 에너지 사용량 조회 쿼리 (sql)</summary>

    	<select id="getDongUsqnt" parameterType="DashBoardVO" resultType="AvgDataVO">
        
            SELECT 
                bb.STNDD_YR,
                bb.USE_MM,
                bb.SGNG_CD,
                bb.STDG_CD,
                ELRW_USQNT_avg,
                ELRW_USQNT,
                CTY_GAS_USQNT_avg,
                CTY_GAS_USQNT,
                SUM_NRG_USQNT_avg,
                SUM_NRG_USQNT
            FROM (
                    SELECT
                            STNDD_YR,
                            USE_MM,
                            SGNG_CD,
                            CEIL(AVG(ELRW_USQNT)/1000) as ELRW_USQNT_avg,  
                            CEIL(AVG(CTY_GAS_USQNT)/1000) as CTY_GAS_USQNT_avg,
                            CEIL(AVG(SUM_NRG_USQNT)/1000) as SUM_NRG_USQNT_avg 
                        FROM(
                                SELECT 
                                    STNDD_YR,
                                    USE_MM,
                                    a.SGNG_CD,
                                    a.STDG_CD,
                                    ROUND(SUM(ELRW_USQNT)) as ELRW_USQNT,  
                                    ROUND(SUM(CTY_GAS_USQNT)) as CTY_GAS_USQNT,
                                    ROUND(SUM(SUM_NRG_USQNT)) as SUM_NRG_USQNT 
                                FROM daejeon_energy1 a
                                WHERE STNDD_YR = #{stnddYr}
                                AND a.SGNG_CD = #{sgngCd}
                                GROUP BY STNDD_YR, USE_MM, a.SGNG_CD, a.STDG_CD
                                ORDER BY STNDD_YR, TO_NUMBER(USE_MM), SGNG_CD
                                )
                        GROUP BY STNDD_YR, USE_MM, SGNG_CD
                        ORDER BY STNDD_YR, TO_NUMBER(USE_MM)
                    ) aa, (
                        SELECT 
                            STNDD_YR,
                            USE_MM,
                            a.SGNG_CD,
                            STDG_CD,
                            CEIL(SUM(ELRW_USQNT)/1000) as ELRW_USQNT,  
                            CEIL(SUM(CTY_GAS_USQNT)/1000) as CTY_GAS_USQNT,
                            CEIL(SUM(SUM_NRG_USQNT)/1000) as SUM_NRG_USQNT 
                        FROM daejeon_energy1 a
                        WHERE STNDD_YR = #{stnddYr}
                        AND a.SGNG_CD = #{sgngCd}
                        AND a.STDG_CD = #{stdgCd}
                        GROUP BY STNDD_YR, USE_MM, a.SGNG_CD, STDG_CD
                        ORDER BY STNDD_YR, TO_NUMBER(USE_MM), SGNG_CD
                    ) bb
            WHERE aa.USE_MM = bb.USE_MM
        
        </select>

</details>

<details>
    <summary>건물 검색 쿼리 (sql)</summary>

        <select id="getAddtList" parameterType="string" resultType="addrDataVO">

            SELECT distinct a.LOTNO_ADDR, a.ROAD_NM_ADDR, a.sgng_cd, a.stdg_cd
            FROM daejeon_energy1 a, building_usage1 b
            WHERE ((a.ROAD_NM_ADDR LIKE '%'||#{userAddr}||'%'
            OR a.LOTNO_ADDR LIKE '%'||#{userAddr}||'%'))
            AND a.lotno_addr = b.lotno_addr
            AND b.BLDG_ARCH_AREA > 0
            AND a.ROAD_NM_ADDR != '0'
        
        </select>

</details>
<br>

**4. 건물별 조회 기능 개발**
- lsh_test.jsp 에서 테스트 후 프론트엔드 팀에게 전달
<details>
    <summary>테이스 페이지 하단 스크립트 (JS)</summary>

        <script>
            $(document).ready(function() {
                $("#userAddr").on('keydown', function(event) {
                    if (event.key === 'Enter') {
                        var addrList = [];
                        
                        const userAddr = $('#userAddr').val(); 
                        
                        $.ajax({
                            type: 'POST', // 요청 방식
                            url: '/addrSearch', // 요청을 보낼 URL
                            data: { userAddr: userAddr }, // 전송할 데이터 (key-value)
                            success: function (res) {
                                console.log("응답");
                                console.log('Response:', res); // 응답 데이터 콘솔에 출력
                                
                                let str = "";
                                
                            
                                res.forEach(function(item) {
                                    
                                    str += "<tr>";
                                    str += "<td>"+ item.lotnoAddr +"</td>";
                                    str += "<td>"+ item.roadNmAddr +"</td>";
                                    str += "</tr>";
                                    
                                });
                                
                                
                                $("#addrList").html(str);
                                
                                $("#addrList tr").click(function(){ 	

                                    var str = ""
                                    var tdArr = new Array();	// 배열 선언
                                    
                                    // 현재 클릭된 Row(<tr>)
                                    var tr = $(this);
                                    var td = tr.children();
                                    
                
                                    // 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
                                    td.each(function(i){
                                        tdArr.push(td.eq(i).text());
                                    });
                                    
                                    
                                    // td.eq(index)를 통해 값을 가져올 수도 있다.
                                    var lotnoAddr = td.eq(0).text();
                                    var roadNmAddr = td.eq(1).text();
                                    var sgngCd = td.eq(2).text();
                                    var stdgCd = td.eq(3).text();
                                    
                                    str += "<span style='font-size: 20px; color: #3D3D3D;'>"+ lotnoAddr +"</span>";
                                    str += "<span>"+ roadNmAddr +"</span>";
                                    
                                    
                                    $("#addrDetail").html(str);
                                    
                                    var year = $('#selectYr').val();
                                    getAddrDetail(year, lotnoAddr);
                                    
                                    $("#getDataBtn").on("click", function(event){
                                        var year = $('#selectYr').val();
                                        getAddrDetail(year, lotnoAddr);
                                    });
                                });

                            },
                            error: function (error) {
                                console.error('Error:', error); // 오류 콘솔에 출력
                            }
                        });
                    }
                });
            });
            // 1~ 6월간의 데이터 그룹막대차트그릴 데이터 가져오기
            function fetchMLRealData(year, addr) {
                $.ajax({
                    type: 'POST',
                    url: '/getMLRealData',
                    data: {
                        year: year, // 연도 파라미터
                        addr: addr // 주소 파라미터
                    },
                    success: function (addrList) {
                        
                        groupedBarChart(addrList);
                        var code = addrList[0]['mjrPrpsCd'];
                        getMLdata(code, addrList); // code : 예측데이터/ addrList : 실제데이터
                        
                        
                    },
                    error: function (error) {
                        console.error('데이터 가져오기 오류:', error);
                    }
                });
            }
            
            // 머신러닝 데이터
            function getMLdata(code, addrList){
                $.ajax({
                    type: 'GET', // 요청 방식
                    url: ' http://192.168.0.58:5500/predict', // 요청을 보낼 URL
                    data: { code: code,  year:2022, month:1}, // 전송할 데이터 (key-value)
                    success: function (res) {
                        console.log("응답");
                        console.log('Response:', res); // 응답 데이터 콘솔에 출력
            
                        predGroupedBarChart(res, addrList);
                    },
                    error: function (error) {
                        console.error('Error:', error); // 오류 콘솔에 출력
                    }
                });
                
            }
            
            function getAddrDetail(year, addr){
                
                $.ajax({
                    type: 'POST', // 요청 방식
                    url: '/getAddrDetail', // 요청을 보낼 URL
                    data: { year: year,  addr:addr}, // 전송할 데이터 (key-value)
                    success: function (res) {
                        console.log("응답");
                        console.log('Response:', res); // 응답 데이터 콘솔에 출력
                        // 총 합 계산
                        var sumGrgsDsamt = 0;
                        var sumGrgsDsamtAvg = 0;
                        for (var i = 0; i < res.length; i++) {
                            sumGrgsDsamt += res[i].sumGrgsDsamt ? res[i].sumGrgsDsamt : 0;
                            sumGrgsDsamtAvg += res[i].sumGrgsDsamtAvg ? res[i].sumGrgsDsamtAvg : 0;
                        }
                        sumGrgsDsamtAvg = sumGrgsDsamtAvg / res.length;
                        
                        if ($("#selectData").val()== "Usqnt"){
                            
                            let str = "";
                            
                            res.forEach(function(item) {
                                
                                str += "<tr>";
                                str += "<td style='text-align: center;'>"+ item.useMm +"</td>";
                                str += "<td style='text-align: right;'>"+ item.elrwUsqnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                                str += "<td style='text-align: right;'>"+ item.ctyGasUsqnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                                str += "<td style='text-align: right;'>"+ item.sumNrgUsqnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                                str += "</tr>";
                                
                            });
                            
                            $("#pickData").html(str);
                            
                        } else {
                            
                            let str = "";
                            
                            res.forEach(function(item) {
                                
                                str += "<tr>";
                                str += "<td style='text-align: center;'>"+ item.useMm +"</td>";
                                str += "<td style='text-align: right;'>"+ item.elrwGrgsDsamt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                                str += "<td style='text-align: right;'>"+ item.ctyGasGrgsDsamt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                                str += "<td style='text-align: right;'>"+ item.sumGrgsDsamt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); +"</td>";
                                str += "</tr>";
                                
                            });
                            
                            $("#pickData").html(str);
                            
                        }
                        
                        
                        // 왼쪽 차트 생성
                        initBuildingChart(res);
                        //오른쪽 게이지차트
                        initGaugeChart(sumGrgsDsamt, sumGrgsDsamtAvg);
                        // 밑에 그룹 막대 그래프 출력 예시
                        fetchMLRealData(year,addr);

                    },
                    error: function (error) {
                        console.error('Error:', error); // 오류 콘솔에 출력
                    }
                });
            }
        </script>

</details>
<br>

**5. 머신러닝 모델 학습 및 flask와 spring연동**
<details>
    <summary>모델 학습 (python)</summary>

        # 필요한 라이브러리 불러오기
        import cx_Oracle
        import pandas as pd
        import numpy as np
        import os
        from sklearn.preprocessing import LabelEncoder, MinMaxScaler
        from sklearn.ensemble import RandomForestRegressor
        from sklearn.model_selection import train_test_split
        from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
        import joblib

        # Oracle 데이터베이스 연결
        conn = cx_Oracle.connect("team1", "team1", "192.168.0.42:1521/xe")

        # SQL 쿼리
        query = """
        SELECT mjr_prps_cd,  -- 주요용도코드  
            BLDG_ARCH_AREA, -- 건물건축면적
            STNDD_YR,    -- 기준년도 
            USE_MM,      -- 사용월
            ROUND(AVG(ELRW_USQNT)) as ELRW_USQNT   -- 전력 에너지 사용량
        FROM ML_DATA
        WHERE STNDD_YR BETWEEN 2015 AND 2021
        GROUP BY mjr_prps_cd, STNDD_YR, USE_MM, BLDG_ARCH_AREA
        ORDER BY mjr_prps_cd, STNDD_YR, TO_NUMBER(USE_MM)
        """

        # 데이터 가져오기
        df = pd.read_sql(query, conn)

        # 연결 종료
        conn.close()

        # 모델 저장 디렉토리 생성
        model_dir = "saved_models_with_area"
        os.makedirs(model_dir, exist_ok=True)

        # 주요 용도 코드 라벨링
        label_encoder = LabelEncoder()
        df['MJR_PRPS_CD_LABEL'] = label_encoder.fit_transform(df['MJR_PRPS_CD'])
        label_mapping = dict(zip(label_encoder.classes_, label_encoder.transform(label_encoder.classes_)))

        # 라벨 매핑 저장
        label_mapping_path = os.path.join(model_dir, "label_mapping.joblib")
        joblib.dump(label_mapping, label_mapping_path)
        print(f"라벨 매핑 저장 완료: {label_mapping_path}")

        # 용도별 면적 그룹 나누기
        bins_by_usage = {}  # 용도별 그룹 경계값 저장

        for usage in df['MJR_PRPS_CD_LABEL'].unique():
            usage_data = df[df['MJR_PRPS_CD_LABEL'] == usage]  # 특정 용도 데이터만 필터링

            # 값이 중복되어 qcut 실행이 불가능한 경우 처리
            if len(usage_data['BLDG_ARCH_AREA'].unique()) < 10:
                print(f"용도 {usage}의 BLDG_ARCH_AREA 값이 중복되어 그룹화를 생략합니다.")
                continue

            # qcut으로 그룹화, duplicates='drop'을 설정하여 중복 경계값 제거
            df.loc[df['MJR_PRPS_CD_LABEL'] == usage, 'AREA_GROUP'], bins = pd.qcut(
                usage_data['BLDG_ARCH_AREA'], q=10, labels=False, retbins=True, duplicates='drop'
            )
            bins_by_usage[usage] = bins  # 용도별 그룹 경계값 저장

        # 그룹 번호를 1부터 시작하도록 조정
        df['AREA_GROUP'] = df['AREA_GROUP'] + 1

        # 용도별 그룹 경계값 저장
        bins_path = os.path.join(model_dir, "area_bins_by_usage.joblib")
        joblib.dump(bins_by_usage, bins_path)
        print(f"용도별 면적 그룹 경계값 저장 완료: {bins_path}")

        # 전력 사용량 및 건축면적 정규화
        scaler = MinMaxScaler()
        df[['ELRW_USQNT', 'BLDG_ARCH_AREA']] = scaler.fit_transform(df[['ELRW_USQNT', 'BLDG_ARCH_AREA']])

        # 스케일러 저장
        scaler_path = os.path.join(model_dir, "scaler.joblib")
        joblib.dump(scaler, scaler_path)
        print(f"스케일러 저장 완료: {scaler_path}")

        # 데이터 축소: 동일한 용도, 그룹, 연도, 월 기준으로 평균 사용량 계산
        df = df.groupby(['MJR_PRPS_CD_LABEL', 'AREA_GROUP', 'STNDD_YR', 'USE_MM']).agg({
            'ELRW_USQNT': 'mean',  # 사용량 평균
            'BLDG_ARCH_AREA': 'mean'  # 면적 평균
        }).reset_index()

        # 데이터 검증
        print(f"축소된 데이터 크기: {df.shape}")
        print(df.head())

        # AREA_GROUP별 모델 학습
        models = {}
        area_groups = df['AREA_GROUP'].unique()

        for group in area_groups:
            group_data = df[df['AREA_GROUP'] == group].reset_index(drop=True)
            unique_codes = group_data['MJR_PRPS_CD_LABEL'].unique()

            for code in unique_codes:
                code_data = group_data[group_data['MJR_PRPS_CD_LABEL'] == code].reset_index(drop=True)

                # 12개월 데이터를 입력으로 변환
                sequence_length = 12
                features = []
                targets = []

                if len(code_data) <= sequence_length:
                    print(f"AREA_GROUP {group}, CODE {code} 데이터 부족. (데이터 수: {len(code_data)})")
                    continue

                for i in range(len(code_data) - sequence_length):
                    sequence = code_data.iloc[i:i + sequence_length][['ELRW_USQNT', 'BLDG_ARCH_AREA', 'STNDD_YR', 'USE_MM']].values.flatten()
                    target = code_data['ELRW_USQNT'].iloc[i + sequence_length]
                    features.append(sequence)
                    targets.append(target)

                X = np.array(features)
                y = np.array(targets)

                if len(X) == 0 or len(y) == 0:
                    print(f"AREA_GROUP {group}, CODE {code} 데이터가 부족합니다.")
                    continue

                X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

                # RandomForestRegressor 학습
                model = RandomForestRegressor(
                    random_state=42,
                    n_estimators=200,
                    max_depth=None,
                    min_samples_leaf=4,
                    min_samples_split=2,
                    bootstrap=True
                )
                print(f"AREA_GROUP {group}, CODE {code} 모델 학습 중...")
                model.fit(X_train, y_train)

                # 모델 저장
                model_path = os.path.join(model_dir, f"model_area_{int(group)}_code_{code}.joblib")
                joblib.dump(model, model_path)

                # 테스트 데이터 예측
                y_pred = model.predict(X_test)
                rmse = np.sqrt(mean_squared_error(y_test, y_pred))
                mae = mean_absolute_error(y_test, y_pred)
                r2 = r2_score(y_test, y_pred)

                print(f"AREA_GROUP {group}, CODE {code} 평가")
                print(f"RMSE: {rmse}, MAE: {mae}, R2: {r2}")

        print("모델 학습 및 저장 완료.")

</details>

<details>
    <summary>flask-spring 연결 (JS)</summary>

        // 머신러닝 데이터
        function getMLdata(code, bldg_arch_area, addrList){
            $.ajax({
                type: 'GET', // 요청 방식
                url: ' http://192.168.0.42:5500/predict', // 요청을 보낼 URL
                data: { code: code,  bldg_arch_area:bldg_arch_area, year:2022, month:1}, // 전송할 데이터 (key-value)
                success: function (res) {
                    console.log("응답");
                    console.log('Response:', res); // 응답 데이터 콘솔에 출력
                    
                    predGroupedBarChart(res, addrList);
                },
                error: function (error) {
                    console.error('Error:', error); // 오류 콘솔에 출력
                }
            });
            
        }

</details>
<br>

## 프로젝트주요성과
[목차로 돌아가기](#목차)
- 에너지 사용량 및 온실가스 배출량 시각화
    대전광역시 행정구역과 건물 별 에너지 사용량과 온실가스 배출량을 시각화 하고, 건물 용도에 맞는 예측 모델을 적용하여 전력 에너지 사용량 예측값 제공.
- 지도 기반 데이터 시각화 
    GeoJSON과 OpenStreetMap을 활용하여 대전광역시 구별 위치 데이터를 지도에 표시하고, 관련 데이터를 조회하여 시각화.
- 시스템 안정화 및 배포
    최종 시스템 통합 후, 안정적인 서비스 제공 및 SVN을 통한 코드 관리로 협업 효율성 증대.

## 느낀점
[목차로 돌아가기](#목차)
- 한계점
    - 데이터의 한계로 현재 까지의 사용량 예측이 어려워, 2021년까지의 데이터를 기반으로 2022년의 데이터를 예측함.
    - 시간관계상 데이터 분석을 치밀하게 하지 못 해, 예상한만큼 예측이 제대로 이뤄지지 않음.
- 느낀점
    - 처음으로 팀프로젝트를 진행하면서 SVN을 활용한 협업 방식을 익힐 수 있었음.
    - 팀장으로서 프로젝트 추진 일정, 문서화 등을 함께 진행했는데, 프로젝트 마감 기한이 가까워질수록 체계적이지 못한 진행을 하게 됨. 이번 경험을 바탕으로 다음 팀프로젝트때는 보다 원활한 진행을 할 수 있도록 노력하겠음.
    - 면접으로 인하여 주어진 프로젝트 기한을 전부 쓰지 못한 나머지 시간부족으로 인하여 머신러닝 모델 정확도가 떨어지는 채로 제출하게되어 아쉬움.
