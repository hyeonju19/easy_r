2.성별에 따른 월급 차이
================
하현주
July 30, 2020

## 2\. 성별에 따른 월급 차이

데이터 분석을 통해 성별에 따라 월급차이를 파악하고자 함. 성별과 월급 두 변수를 검토하고 전처리한 후 변수 간의 관계를 분석.

### 분석 절차

1.  변수 검토 및 전처리 성별 -\> 월급

2.변수 간 관계 분석 성별 월급 평균표 만들기 -\> 그래프 만들기

### 성별 변수 검토 및 전처리

#### 1\. 변수 검토하기

``` r
class(welfare$sex)
table(welfare$sex)
```

#### 2\. 전처리

테이블 이상치 확인하여 이상치에 NA부여하여 결측처리함.

``` r
#이상치 확인
table(welfare$sex)
```

이상치 결측처리

``` r
#이상치 결측 처리
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)
#결측치 확인
table(is.na(welfare$sex))
```

    ## 
    ## FALSE 
    ## 16664

``` r
#성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex==1, "male", "female")
table(welfare$sex)
```

    ## 
    ## female   male 
    ##   9086   7578

``` r
qplot(welfare$sex)
```

![](welfare02-작업-_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

### 월급 변수 검토 및 전처리

#### 1\. 변수 검토하기

``` r
class(welfare$income)
```

    ## [1] "numeric"

``` r
summary(welfare$income)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    ##     0.0   122.0   192.5   241.6   316.6  2400.0   12030

``` r
qplot(welfare$income)
```

![](welfare02-작업-_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
qplot(welfare$income)+xlim(0,1000)
```

![](welfare02-작업-_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

#### 2\. 전처리

``` r
#이상치 확인
summary(welfare$income)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    ##     0.0   122.0   192.5   241.6   316.6  2400.0   12030

``` r
#이상치 결측 처리
welfare$income<-ifelse(welfare$income %in% c(0,9999), NA, welfare$income)
#결측치 확인
table(is.na(welfare$income))
```

    ## 
    ## FALSE  TRUE 
    ##  4620 12044

### 성별에 따른 월급 차이 분석하기

#### 1\. 성별 월급 평균표 만들기

변수 간 관계 분석

``` r
sex_income <-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

``` r
sex_income
```

    ## # A tibble: 2 x 2
    ##   sex    mean_income
    ##   <chr>        <dbl>
    ## 1 female        163.
    ## 2 male          312.

#### 2\. 그래프 만들기

분석결과 막대그래프로 표현

``` r
ggplot(data=sex_income, aes(x=sex, y=mean_income)) + geom_col()
```

![](welfare02-작업-_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->
