직업별 월급차이
================
하현주
July 31, 2020

## 6\. 직업별 월급 차이

### 분석 절차

1.  변수 검토 및 전처리 `-`직업 `-`월급

2.  변수 간 관계 분석 -직업별 월급 평균표 만들기 / 그래프 만들기

### 직업 변수 검토 및 전처리하기

#### 1\. 변수 검토하기

code\_job변수는 직업 코드를 의미함. 직업분류코드로 입력되어 있어 직업분류코드를 이용해 직업 명칭 변수를 만들어
분석해야함.

``` r
class(welfare$code_job)
table(welfare$code_job)
```

#### 2\. 전처리

직업분류코드 목록 불러오기 Koweps\_Codebook.xlsx 파일 다운로드하여 불러오기 엑셀 파일을 불러오기 위해
readxl패키지 로드 첫 행을 변수명으로 가져오도록 설정, 엑셀 파일의 두번째 시트에 있는 직업분류 코드를 목록으로 불러오도록
sheet 파라미터 2를 지정

출력결과 직업분류코드 목록이 코드와 직업명 두 변수로 구성되고, 직업이 149개로 분류됨. walfare에 직업명 결합
left\_join()활용

``` r
library(readxl)
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2)
head(list_job)
dim(list_job)
welfare <- left_join(welfare, list_job, id="code_job")
```

    ## Joining, by = "code_job"

``` r
welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)
```

### 직업별 월급 차이 분석하기

월급, 직업 변수의 전처리 해둔 상태에서 변수 간 관계 분석

#### 1\. 직업별 월급 평균표 만들기

직업이 없거나 월급이 없는 사람은 분석 대상이 아니므로 제외한 후 분석

``` r
job_income<-welfare %>% 
  filter(!is.na(job)&!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income=mean(income))
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

``` r
head(job_income)
```

#### 2\. 상위 10개 추출

``` r
top10<-job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)
top10
```

#### 3\. 그래프 만들기

``` r
ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
 geom_col() +
 coord_flip()
```

![](welfare06--2-_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

coord\_flip()을 추가해 막대를 오른쪽으로 90도 회전 ‘금속 재료 공학 기술자 및 시험원’이 평균845만원으로 가장
많은 월급을 받고, 그 다음으로는 ’의료진료 전문가’, ‘의회의원 고위공무원 및 공공단체임원’, ’보험 및 금융 관리자’의
월급이 많다는 것을 알 수 있음.

#### 4\. 하위 10위 추출

``` r
bottom10<- job_income %>% 
  arrange((mean_income)) %>% 
  head(10)
bottom10
```

#### 5\. 그래프 만들기

상위 10위 그래프와 비교할 수 있도록 y축을 0\~850까지 표현되게 설정

``` r
ggplot(data=bottom10, aes(x=reorder(job,-mean_income), y=mean_income))+
  geom_col()+
  coord_flip()+
  ylim(0, 850)
```

![](welfare06--2-_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

‘가사 및 육아 도우미’의 월급이 평균 80만 원으로 가장 적고, 그 뒤로 ’임업관련 종사자’, ‘기타 서비스관련 단순 종사원’,
’청소원 및 환경 미화원’의 월급이 적다는 것을 알 수 있음. 상\`하위 분석 결과를 비교하면 가장 많은 월급을 받는 ’금속 재료
공학 기술자 및 시험원’이 ’가사 및 육아 도우미’의 열 배가 넘는 월급을 받는다는 것을 알 수 있음.
